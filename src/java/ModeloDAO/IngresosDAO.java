package ModeloDAO;

import Configuraciones.conexion;
import Modelo.DetalleMovimiento;
import Modelo.Ingreso;
import Modelo.Vencimiento;
import org.json.JSONArray;
import org.json.JSONObject;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class IngresosDAO {
    private final conexion cfg = new conexion();

    // ------------------- Operaciones de Inserción Existentes -------------------
    public int insertarCompra(Ingreso ingreso) throws SQLException {
        String sqlMov = "INSERT INTO movimientos(tipo_id, usuario_id, fecha, documento, nit_proveedor, observaciones) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlComp = "INSERT INTO compras(movimiento_id, nosolicitud, orden_compra, proveedor, serie_factura, numero_factura, nit_proveedor, observaciones) VALUES(?,?,?,?,?,?,?,?)";
        try (Connection conn = cfg.conectar()) {
            conn.createStatement().execute("SET NAMES 'utf8'");
            conn.setAutoCommit(false);
            try (PreparedStatement psMov = conn.prepareStatement(sqlMov, Statement.RETURN_GENERATED_KEYS)) {
                psMov.setInt(1, ingreso.getTipoId());
                psMov.setInt(2, ingreso.getUsuarioId());
                psMov.setDate(3, new java.sql.Date(ingreso.getFecha().getTime()));
                psMov.setString(4, ingreso.getDocumento());
                psMov.setString(5, ingreso.getNitProveedor());
                psMov.setString(6, ingreso.getObservaciones());
                psMov.executeUpdate();
                try (ResultSet rs = psMov.getGeneratedKeys()) {
                    if (rs.next()) ingreso.setId(rs.getInt(1));
                }
            }
            try (PreparedStatement ps = conn.prepareStatement(sqlComp)) {
                ps.setInt(1, ingreso.getId());
                ps.setString(2, ingreso.getNoSolicitud());
                ps.setString(3, ingreso.getOrdenCompra());
                ps.setString(4, ingreso.getProveedor());
                ps.setString(5, ingreso.getSerieFactura());
                ps.setString(6, ingreso.getNumeroFactura());
                ps.setString(7, ingreso.getNitProveedor());
                ps.setString(8, ingreso.getObservacionesCompra());
                ps.executeUpdate();
            }
            insertarDetalle(ingreso, conn);
            conn.commit();
        }
        return ingreso.getId();
    }

    public int insertarTraslado(Ingreso ingreso) throws SQLException {
        String sqlMov = "INSERT INTO movimientos(tipo_id, usuario_id, fecha, documento, nit_proveedor, observaciones) VALUES (?, ?, ?, NULL, NULL, ?)";
        String sqlTrans = "INSERT INTO traslados(movimiento_id, unidad_solicitante, unidad_otorga, tipo_movimiento, observaciones) VALUES(?,?,?,?,?)";
        try (Connection conn = cfg.conectar()) {
            conn.createStatement().execute("SET NAMES 'utf8'");
            conn.setAutoCommit(false);
            try (PreparedStatement psMov = conn.prepareStatement(sqlMov, Statement.RETURN_GENERATED_KEYS)) {
                psMov.setInt(1, ingreso.getTipoId());
                psMov.setInt(2, ingreso.getUsuarioId());
                psMov.setDate(3, new java.sql.Date(ingreso.getFecha().getTime()));
                psMov.setString(4, ingreso.getObservacionesTraslado());
                psMov.executeUpdate();
                try (ResultSet rs = psMov.getGeneratedKeys()) {
                    if (rs.next()) ingreso.setId(rs.getInt(1));
                }
            }
            try (PreparedStatement ps = conn.prepareStatement(sqlTrans)) {
                ps.setInt(1, ingreso.getId());
                ps.setString(2, ingreso.getUnidadSolicitante());
                ps.setString(3, ingreso.getUnidadOtorga());
                ps.setString(4, ingreso.getTipoMovimiento());
                ps.setString(5, ingreso.getObservacionesTraslado());
                ps.executeUpdate();
            }
            insertarDetalle(ingreso, conn);
            conn.commit();
        }
        return ingreso.getId();
    }

    public int insertarCambioVencimiento(Ingreso ingreso) throws SQLException {
        String sqlMov = "INSERT INTO movimientos(tipo_id, usuario_id, fecha, documento, nit_proveedor, observaciones) VALUES (?, ?, ?, NULL, NULL, ?)";
        String sqlCV = "INSERT INTO cambios_vencimiento(movimiento_id, proveedor_cambio, observaciones) VALUES(?,?,?)";
        try (Connection conn = cfg.conectar()) {
            conn.createStatement().execute("SET NAMES 'utf8'");
            conn.setAutoCommit(false);
            try (PreparedStatement psMov = conn.prepareStatement(sqlMov, Statement.RETURN_GENERATED_KEYS)) {
                psMov.setInt(1, ingreso.getTipoId());
                psMov.setInt(2, ingreso.getUsuarioId());
                psMov.setDate(3, new java.sql.Date(ingreso.getFecha().getTime()));
                psMov.setString(4, ingreso.getObservacionesCambio());
                psMov.executeUpdate();
                try (ResultSet rs = psMov.getGeneratedKeys()) {
                    if (rs.next()) ingreso.setId(rs.getInt(1));
                }
            }
            try (PreparedStatement ps = conn.prepareStatement(sqlCV)) {
                ps.setInt(1, ingreso.getId());
                ps.setString(2, ingreso.getProveedorCambio());
                ps.setString(3, ingreso.getObservacionesCambio());
                ps.executeUpdate();
            }
            insertarDetalle(ingreso, conn);
            conn.commit();
        }
        return ingreso.getId();
    }

    public int insertarDevolucion(Ingreso ingreso) throws SQLException {
        String sqlMov = "INSERT INTO movimientos(tipo_id, usuario_id, fecha, documento, nit_proveedor, observaciones) VALUES (?, ?, ?, NULL, NULL, ?)";
        String sqlDel = "INSERT INTO devoluciones(movimiento_id, servicio_devuelve, observaciones) VALUES(?,?,?)";
        try (Connection conn = cfg.conectar()) {
            conn.createStatement().execute("SET NAMES 'utf8'");
            conn.setAutoCommit(false);
            try (PreparedStatement psMov = conn.prepareStatement(sqlMov, Statement.RETURN_GENERATED_KEYS)) {
                psMov.setInt(1, ingreso.getTipoId());
                psMov.setInt(2, ingreso.getUsuarioId());
                psMov.setDate(3, new java.sql.Date(ingreso.getFecha().getTime()));
                psMov.setString(4, ingreso.getObservacionesDevolucion());
                psMov.executeUpdate();
                try (ResultSet rs = psMov.getGeneratedKeys()) {
                    if (rs.next()) ingreso.setId(rs.getInt(1));
                }
            }
            try (PreparedStatement ps = conn.prepareStatement(sqlDel)) {
                ps.setInt(1, ingreso.getId());
                ps.setString(2, ingreso.getServicioDevuelve());
                ps.setString(3, ingreso.getObservacionesDevolucion());
                ps.executeUpdate();
            }
            insertarDetalle(ingreso, conn);
            conn.commit();
        }
        return ingreso.getId();
    }

    public int insertarDonacion(Ingreso ingreso) throws SQLException {
        String sqlMov = "INSERT INTO movimientos(tipo_id, usuario_id, fecha, documento, nit_proveedor, observaciones) VALUES (?, ?, ?, NULL, NULL, ?)";
        String sqlDon = "INSERT INTO donaciones(movimiento_id, procedencia, donante, socio_implementador, pais_procedencia, codigo_identificacion, numero_identificacion_tributaria, referencia_donante, direccion_donante, nombre_proyecto, doc_soporte, fecha_suscripcion, finalidad_cooperacion, monto_original, tipo_donacion, tipo_moneda, monto_total_original, comentarios_generales, entidad_ejecutora, unidad_ejecutora, unidad_beneficiaria, representante_responsable, direccion_notificaciones, fecha_firma) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = cfg.conectar()) {
            conn.createStatement().execute("SET NAMES 'utf8'");
            conn.setAutoCommit(false);
            try (PreparedStatement psMov = conn.prepareStatement(sqlMov, Statement.RETURN_GENERATED_KEYS)) {
                psMov.setInt(1, ingreso.getTipoId());
                psMov.setInt(2, ingreso.getUsuarioId());
                psMov.setDate(3, new java.sql.Date(ingreso.getFecha().getTime()));
                psMov.setString(4, ingreso.getObservaciones());
                psMov.executeUpdate();
                try (ResultSet rs = psMov.getGeneratedKeys()) {
                    if (rs.next()) ingreso.setId(rs.getInt(1));
                }
            }
            try (PreparedStatement ps = conn.prepareStatement(sqlDon)) {
                ps.setInt(1, ingreso.getId());
                ps.setString(2, ingreso.getProcedencia());
                ps.setString(3, ingreso.getDonante());
                ps.setString(4, ingreso.getSocioImplementador());
                ps.setString(5, ingreso.getPaisProcedencia());
                ps.setString(6, ingreso.getCodigoIdentificacion());
                ps.setString(7, ingreso.getNumeroIdentificacionTributaria());
                ps.setString(8, ingreso.getReferenciaDonante());
                ps.setString(9, ingreso.getDireccionDonante());
                ps.setString(10, ingreso.getNombreProyecto());
                ps.setString(11, ingreso.getDocSoporte());
                ps.setDate(12, new java.sql.Date(ingreso.getFechaSuscripcion().getTime()));
                ps.setString(13, ingreso.getFinalidadCooperacion());
                ps.setBigDecimal(14, ingreso.getMontoOriginal());
                ps.setString(15, ingreso.getTipoDonacion());
                ps.setString(16, ingreso.getTipoMoneda());
                ps.setBigDecimal(17, ingreso.getMontoTotalOriginal());
                ps.setString(18, ingreso.getComentariosGenerales());
                ps.setString(19, ingreso.getEntidadEjecutora());
                ps.setString(20, ingreso.getUnidadEjecutora());
                ps.setString(21, ingreso.getUnidadBeneficiaria());
                ps.setString(22, ingreso.getRepresentanteResponsable());
                ps.setString(23, ingreso.getDireccionNotificaciones());
                ps.setString(24, ingreso.getFechaFirma());
                ps.executeUpdate();
            }
            insertarDetalle(ingreso, conn);
            conn.commit();
        }
        return ingreso.getId();
    }

private void insertarDetalle(Ingreso ingreso, Connection conn) throws SQLException {
    // Ahora incluimos fecha_vencimiento y lote en el INSERT de detalle_movimiento
    String sqlDet =
      "INSERT INTO detalle_movimiento " +
      "(movimiento_id, existencia_id, cantidad, precio_unitario, fecha_vencimiento, lote) " +
      "VALUES (?, ?, ?, ?, ?, ?)";
    
    // Tu SQL de vencimientos se mantiene igual
    String sqlVen =
      "INSERT INTO vencimientos " +
      "(detalle_id, existencia_id, fecha_vencimiento, lote, cantidad) " +
      "VALUES (?, ?, ?, ?, ?) " +
      "ON DUPLICATE KEY UPDATE cantidad = cantidad + VALUES(cantidad)";

    for (DetalleMovimiento d : ingreso.getDetalles()) {
        Vencimiento v = d.getVencimiento();

        // 1) Insertar detalle_movimiento y capturar su id
        try (PreparedStatement ps = conn.prepareStatement(sqlDet, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt       (1, ingreso.getId());
            ps.setInt       (2, d.getExistenciaId());
            ps.setBigDecimal(3, d.getCantidad());
            ps.setBigDecimal(4, d.getPrecioUnitario());
            // Parám. 5: fecha_vencimiento en detalle_movimiento
            if (v != null && v.getFechaVencimiento() != null) {
                ps.setDate(5, new java.sql.Date(v.getFechaVencimiento().getTime()));
            } else {
                ps.setNull(5, Types.DATE);
            }
            // Parám. 6: lote en detalle_movimiento
            if (v != null && v.getLote() != null && !v.getLote().isEmpty()) {
                ps.setString(6, v.getLote());
            } else {
                ps.setNull(6, Types.VARCHAR);
            }
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    d.setId(rs.getInt(1));
                }
            }
        }

        // 2) Si no hay fecha ni lote, saltamos el INSERT en vencimientos
        if (v == null
            || (v.getFechaVencimiento() == null && (v.getLote() == null || v.getLote().isEmpty()))) {
            continue;
        }

        // 3) Insertar o sumar en vencimientos como antes
        try (PreparedStatement ps2 = conn.prepareStatement(sqlVen)) {
            ps2.setInt       (1, d.getId());
            ps2.setInt       (2, d.getExistenciaId());
            if (v.getFechaVencimiento() != null) {
                ps2.setDate(3, new java.sql.Date(v.getFechaVencimiento().getTime()));
            } else {
                ps2.setNull(3, Types.DATE);
            }
            if (v.getLote() != null && !v.getLote().isEmpty()) {
                ps2.setString(4, v.getLote());
            } else {
                ps2.setNull(4, Types.VARCHAR);
            }
            ps2.setBigDecimal(5, d.getCantidad());
            ps2.executeUpdate();
        }
    }
}

    // ------------------- Métodos JSON para JSP -------------------

    public String listarMovimientosJSON() throws SQLException {
        String sql = "SELECT m.id, tm.descripcion AS tipo, u.NOMBREUSUARIO AS usuario, m.fecha, " +
                     "SUM(dm.cantidad*dm.precio_unitario) AS total " +
                     "FROM movimientos m " +
                     "JOIN tipos_movimiento tm ON m.tipo_id=tm.id " +
                     "JOIN usuario u ON m.usuario_id=u.IDUSUARIO " +
                     "LEFT JOIN detalle_movimiento dm ON m.id=dm.movimiento_id " +
                     "WHERE m.anulado=0 " +
                     "GROUP BY m.id, tm.descripcion, u.NOMBREUSUARIO, m.fecha " +
                     "ORDER BY m.fecha DESC";
        JSONArray arr = new JSONArray();
        try (Connection conn = cfg.conectar(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
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

    public String getMovimientoJSON(int movimientoId) throws SQLException {
        String sql = "SELECT tm.descripcion AS tipo, u.NOMBREUSUARIO AS usuario, m.fecha, m.hora, m.documento, m.nit_proveedor, m.observaciones " +
                     "FROM movimientos m " +
                     "JOIN tipos_movimiento tm ON m.tipo_id=tm.id " +
                     "JOIN usuario u ON m.usuario_id=u.IDUSUARIO " +
                     "WHERE m.id=?";
        JSONObject obj = new JSONObject();
        try (Connection conn = cfg.conectar(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movimientoId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    obj.put("tipo", rs.getString("tipo"));
                    obj.put("usuario", rs.getString("usuario"));
                    obj.put("fecha", rs.getDate("fecha").toString());
                    obj.put("hora", rs.getTime("hora").toString());
                    obj.put("documento", rs.getString("documento"));
                    obj.put("nit_proveedor", rs.getString("nit_proveedor"));
                    obj.put("observaciones", rs.getString("observaciones"));
                }
            }
        }
        return obj.toString();
    }

    public String getDetalleMovimientoJSON(int movimientoId) throws SQLException {
        String sql = "SELECT e.nombre AS insumo, dm.cantidad, dm.precio_unitario " +
                     "FROM detalle_movimiento dm " +
                     "JOIN existencias e ON dm.existencia_id=e.id " +
                     "WHERE dm.movimiento_id=?";
        JSONArray arr = new JSONArray();
        try (Connection conn = cfg.conectar(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movimientoId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
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

    public boolean anularMovimiento(int movimientoId) throws SQLException {
    // 1) Marca el movimiento como anulado
    String sql = "UPDATE movimientos SET anulado=1 WHERE id=?";
    boolean updated;
    try (Connection conn = cfg.conectar();
         Statement st = conn.createStatement();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        st.execute("SET NAMES 'utf8'");
        ps.setInt(1, movimientoId);
        updated = ps.executeUpdate() > 0;
    }
    // 2) Si se actualizó, reconstruye existencias y precios
    if (updated) {
        try (Connection conn = cfg.conectar();
             Statement st = conn.createStatement();
             CallableStatement cs1 = conn.prepareCall("CALL sp_reconstruir_existencias()");
             CallableStatement cs2 = conn.prepareCall("CALL sp_reconstruir_precios()")) {
            st.execute("SET NAMES 'utf8'");
            cs1.execute();
            cs2.execute();
        }
    }
    return updated;
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
                     "SELECT procedencia, donante, socio_implementador, pais_procedencia," +
                     " codigo_identificacion, numero_identificacion_tributaria," +
                     " referencia_donante, direccion_donante, nombre_proyecto," +
                     " doc_soporte, fecha_suscripcion, finalidad_cooperacion," +
                     " monto_original, tipo_donacion, tipo_moneda, monto_total_original," +
                     " comentarios_generales, entidad_ejecutora, unidad_ejecutora," +
                     " unidad_beneficiaria, representante_responsable," +
                     " direccion_notificaciones, fecha_firma" +
                     " FROM donaciones WHERE movimiento_id=?");
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
