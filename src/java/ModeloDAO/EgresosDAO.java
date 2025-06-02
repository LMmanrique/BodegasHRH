package ModeloDAO;

import Configuraciones.conexion;
import Modelo.DetalleDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object para gestionar egresos.
 */
public class EgresosDAO {
    /**
     * Lista un resumen de egresos para mostrar en la tabla.
     */
    public List<EgresoResumen> listarEgresos() throws Exception {
        String sql =
            "SELECT m.id, tm.descripcion AS tipo, m.fecha, u.NOMBREUSUARIO AS usuario, " +
            "SUM(dm.cantidad * dm.precio_unitario) AS total " +
            "FROM movimientos m " +
            "JOIN tipos_movimiento tm ON tm.id = m.tipo_id " +
            "JOIN usuario u ON u.IDUSUARIO = m.usuario_id " +
            "JOIN detalle_movimiento dm ON dm.movimiento_id = m.id " +
            "WHERE tm.codigo='EGRESO' AND m.anulado = 0 " +
            "GROUP BY m.id, tm.descripcion, m.fecha, u.NOMBREUSUARIO " +
            "ORDER BY m.fecha DESC";
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<EgresoResumen> lista = new ArrayList<>();
            while (rs.next()) {
                EgresoResumen e = new EgresoResumen();
                e.setId(rs.getInt("id"));
                e.setTipo(rs.getString("tipo"));
                e.setFecha(rs.getDate("fecha"));
                e.setUsuario(rs.getString("usuario"));
                e.setTotal(rs.getDouble("total"));
                lista.add(e);
            }
            return lista;
        }
    }

    /**
     * Obtiene la cabecera de detalle de un egreso.
     */
    public EgresoDetalle getDetalleCabecera(int id) throws Exception {
        String sql =
            "SELECT tm.descripcion AS tipo, m.fecha, m.hora " +
            "FROM movimientos m " +
            "JOIN tipos_movimiento tm ON tm.id = m.tipo_id " +
            "WHERE m.id = ?";
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    EgresoDetalle d = new EgresoDetalle();
                    d.setTipo(rs.getString("tipo"));
                    d.setFecha(rs.getDate("fecha"));
                    d.setHora(rs.getTime("hora"));
                    return d;
                }
            }
        }
        return null;
    }

    /**
     * Obtiene datos específicos del registro en tabla egresos.
     */
    public EgresoEspecifico getDatosEspecificos(int id) throws Exception {
        String sql =
            "SELECT no_requisicion, servicio, observaciones " +
            "FROM egresos WHERE movimiento_id = ?";
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    EgresoEspecifico e = new EgresoEspecifico();
                    e.setNoRequisicion(rs.getString("no_requisicion"));
                    e.setServicio(rs.getString("servicio"));
                    e.setObservaciones(rs.getString("observaciones"));
                    return e;
                }
            }
        }
        return null;
    }

    /**
     * Lista los items del detalle_movimiento para un egreso.
     */
    public List<DetalleItem> listarDetalleItems(int id) throws Exception {
        String sql =
            "SELECT ex.nombre AS insumo, dm.cantidad, dm.precio_unitario " +
            "FROM detalle_movimiento dm " +
            "JOIN existencias ex ON ex.id = dm.existencia_id " +
            "WHERE dm.movimiento_id = ?";
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                List<DetalleItem> list = new ArrayList<>();
                while (rs.next()) {
                    DetalleItem it = new DetalleItem();
                    it.setInsumo(rs.getString("insumo"));
                    it.setCantidad(rs.getDouble("cantidad"));
                    it.setPrecioUnitario(rs.getDouble("precio_unitario"));
                    list.add(it);
                }
                return list;
            }
        }
    }

    /**
     * Anula un egreso (marca anulado=1).
     */
    public boolean anularEgreso(int id) throws Exception {
        String sql = "UPDATE movimientos SET anulado = 1 WHERE id = ?";
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Guarda un egreso con sus detalles en una transacción.
     */
    public void guardarEgresoCompleto(
            Date fecha,
            String noRequisicion,
            String servicio,
            String observaciones,
            int usuarioId,
            List<DetalleDTO> detalles
    ) throws Exception {
        conexion cc = new conexion();
        try (Connection cn = cc.conectar()) {
            cn.setAutoCommit(false);
            try {
                // Insertar movimiento
                String sqlMov =
                    "INSERT INTO movimientos (tipo_id, usuario_id, fecha, hora, observaciones) " +
                    "VALUES ((SELECT id FROM tipos_movimiento WHERE codigo='EGRESO'), ?, ?, CURTIME(), ?)";
                int movId;
                try (PreparedStatement ps = cn.prepareStatement(sqlMov, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, usuarioId);
                    ps.setDate(2, fecha);
                    ps.setString(3, observaciones);
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) movId = rs.getInt(1);
                        else throw new Exception("No se pudo recuperar ID de movimiento");
                    }
                }

                // Insertar egreso
                String sqlEgr =
                    "INSERT INTO egresos (movimiento_id, no_requisicion, servicio, observaciones) VALUES (?,?,?,?)";
                try (PreparedStatement ps = cn.prepareStatement(sqlEgr)) {
                    ps.setInt(1, movId);
                    ps.setString(2, noRequisicion);
                    ps.setString(3, servicio);
                    ps.setString(4, observaciones);
                    ps.executeUpdate();
                }

                // Insertar detalles con nulos si aplica
                String sqlDet =
                    "INSERT INTO detalle_movimiento (movimiento_id, existencia_id, cantidad, precio_unitario, fecha_vencimiento, lote) " +
                    "VALUES (?,?,?,?,?,?)";
                try (PreparedStatement ps = cn.prepareStatement(sqlDet)) {
                    for (DetalleDTO d : detalles) {
                        ps.setInt(1, movId);
                        ps.setInt(2, d.getExistencia_id());
                        ps.setDouble(3, d.getCantidad());
                        ps.setDouble(4, d.getPrecio_unitario());
                        // fecha_vencimiento
                        if (d.getFecha_vencimiento() != null && !d.getFecha_vencimiento().isEmpty()) {
                            ps.setDate(5, Date.valueOf(d.getFecha_vencimiento()));
                        } else {
                            ps.setNull(5, Types.DATE);
                        }
                        // lote
                        if (d.getLote() != null && !d.getLote().isEmpty()) {
                            ps.setString(6, d.getLote());
                        } else {
                            ps.setNull(6, Types.VARCHAR);
                        }
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }

                cn.commit();
            } catch (Exception e) {
                cn.rollback();
                throw e;
            } finally {
                cn.setAutoCommit(true);
            }
        }
    }
}

// Clases auxiliares para JSON y tablas
class EgresoResumen {
    private int id;
    private String tipo;
    private Date fecha;
    private String usuario;
    private double total;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
}

class EgresoDetalle {
    private String tipo;
    private Date fecha;
    private Time hora;

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public Time getHora() { return hora; }
    public void setHora(Time hora) { this.hora = hora; }
}

class EgresoEspecifico {
    private String noRequisicion;
    private String servicio;
    private String observaciones;

    public String getNoRequisicion() { return noRequisicion; }
    public void setNoRequisicion(String noRequisicion) { this.noRequisicion = noRequisicion; }

    public String getServicio() { return servicio; }
    public void setServicio(String servicio) { this.servicio = servicio; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }
}

class DetalleItem {
    private String insumo;
    private double cantidad;
    private double precioUnitario;

    public String getInsumo() { return insumo; }
    public void setInsumo(String insumo) { this.insumo = insumo; }

    public double getCantidad() { return cantidad; }
    public void setCantidad(double cantidad) { this.cantidad = cantidad; }

    public double getPrecioUnitario() { return precioUnitario; }
    public void setPrecioUnitario(double precioUnitario) { this.precioUnitario = precioUnitario; }
}
