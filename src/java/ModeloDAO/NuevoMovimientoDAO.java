package ModeloDAO;

import Configuraciones.conexion;
import org.json.JSONArray;
import org.json.JSONObject;
import java.sql.*;

public class NuevoMovimientoDAO {
    private final conexion cfg = new conexion();

    public String listarMovimientosJSON() throws SQLException {
        JSONArray arr = new JSONArray();
        String sql = "SELECT m.id, tm.descripcion AS tipo, u.NOMBREUSUARIO AS usuario, m.fecha, " +
                     "SUM(dm.cantidad*dm.precio_unitario) AS total " +
                     "FROM movimientos m " +
                     "JOIN tipos_movimiento tm ON m.tipo_id=tm.id " +
                     "JOIN usuario u ON m.usuario_id=u.IDUSUARIO " +
                     "LEFT JOIN detalle_movimiento dm ON m.id=dm.movimiento_id " +
                     "WHERE m.anulado=0 " +
                     "GROUP BY m.id ORDER BY m.fecha DESC";
        try(Connection conn = cfg.conectar();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                JSONObject o = new JSONObject();
                o.put("id", rs.getInt("id"));
                o.put("tipo", rs.getString("tipo"));
                o.put("usuario", rs.getString("usuario"));
                o.put("fecha", rs.getDate("fecha").toString());
                o.put("total", rs.getBigDecimal("total"));
                arr.put(o);
            }
        }
        return arr.toString();
    }

    public String obtenerMovimientoJSON(int id) throws SQLException {
        JSONObject o = new JSONObject();
        String sql = "SELECT tm.descripcion AS tipo, u.NOMBREUSUARIO AS usuario, m.fecha, m.observaciones " +
                     "FROM movimientos m " +
                     "JOIN tipos_movimiento tm ON m.tipo_id=tm.id " +
                     "JOIN usuario u ON m.usuario_id=u.IDUSUARIO " +
                     "WHERE m.id=?";
        try(Connection conn = cfg.conectar();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try(ResultSet rs = ps.executeQuery()) {
                if(rs.next()) {
                    o.put("tipo", rs.getString("tipo"));
                    o.put("usuario", rs.getString("usuario"));
                    o.put("fecha", rs.getDate("fecha").toString());
                    o.put("observaciones", rs.getString("observaciones"));
                }
            }
        }
        return o.toString();
    }

    public String obtenerDetalleJSON(int id) throws SQLException {
        JSONArray arr = new JSONArray();
        String sql = "SELECT e.nombre AS insumo, dm.cantidad, dm.precio_unitario " +
                     "FROM detalle_movimiento dm " +
                     "JOIN existencias e ON dm.existencia_id=e.id " +
                     "WHERE dm.movimiento_id=?";
        try(Connection conn = cfg.conectar();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try(ResultSet rs = ps.executeQuery()) {
                while(rs.next()) {
                    JSONObject o = new JSONObject();
                    o.put("insumo", rs.getString("insumo"));
                    o.put("cantidad", rs.getBigDecimal("cantidad"));
                    o.put("precioUnitario", rs.getBigDecimal("precio_unitario"));
                    arr.put(o);
                }
            }
        }
        return arr.toString();
    }

    public String listarTiposJSON() throws SQLException {
        JSONArray arr = new JSONArray();
        String sql = "SELECT id, descripcion FROM tipos_movimiento ORDER BY id";
        try(Connection conn = cfg.conectar();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                JSONObject o = new JSONObject();
                o.put("id", rs.getInt("id"));
                o.put("descripcion", rs.getString("descripcion"));
                arr.put(o);
            }
        }
        return arr.toString();
    }

    public boolean anularMovimiento(int id) throws SQLException {
        String sql = "UPDATE movimientos SET anulado=1 WHERE id=?";
        try(Connection conn = cfg.conectar();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
    public String getEspecificoJSON(int movimientoId) throws SQLException {
    // 1) Averigua el tipo de movimiento
        String tipoSql = 
          "SELECT tm.descripcion FROM movimientos m " +
          " JOIN tipos_movimiento tm ON m.tipo_id=tm.id " +
          " WHERE m.id=?";
        String tipo;
        try (Connection conn = cfg.conectar();
             PreparedStatement ps = conn.prepareStatement(tipoSql)) {
            ps.setInt(1, movimientoId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return "{}";
                tipo = rs.getString("descripcion");
            }
        }

        JSONObject root = new JSONObject();
        root.put("tipo", tipo);
        JSONObject datos = new JSONObject();

        try (Connection conn = cfg.conectar()) {
            PreparedStatement ps;
            switch (tipo) {
                case "Compra":
                    ps = conn.prepareStatement(
                      "SELECT nosolicitud, orden_compra, proveedor, serie_factura, numero_factura, nit_proveedor, observaciones " +
                      "FROM compras WHERE movimiento_id=?");
                    break;
                case "Donación":
                case "Donacion":
                    ps = conn.prepareStatement(
                      "SELECT procedencia, donante, socio_implementador, pais_procedencia, monto_original, tipo_donacion, tipo_moneda " +
                      "FROM donaciones WHERE movimiento_id=?");
                    break;
                case "Traslado":
                    ps = conn.prepareStatement(
                      "SELECT unidad_solicitante, unidad_otorga, tipo_movimiento, observaciones " +
                      "FROM traslados WHERE movimiento_id=?");
                    break;
                case "Devolución":
                case "Devolucion":
                    ps = conn.prepareStatement(
                      "SELECT servicio_devuelve, observaciones FROM devoluciones WHERE movimiento_id=?");
                    break;
                case "Cambio por Vencimiento":
                    ps = conn.prepareStatement(
                      "SELECT proveedor_cambio, observaciones FROM cambios_vencimiento WHERE movimiento_id=?");
                    break;
                default:
                    ps = null;
            }

            if (ps != null) {
                ps.setInt(1, movimientoId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        ResultSetMetaData md = rs.getMetaData();
                        for (int i = 1; i <= md.getColumnCount(); i++) {
                            String col = md.getColumnLabel(i);
                            Object val = rs.getObject(i);
                            datos.put(col, val);
                        }
                    }
                }
                ps.close();
            }
        }

        root.put("datos", datos);
        return root.toString();
    }
}