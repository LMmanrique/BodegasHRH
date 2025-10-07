
package ModeloDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import Configuraciones.conexion;
import Modelo.MovimientoInsumo;

public class MovimientoInsumoDAO {
    
    public List<MovimientoInsumo> obtenerMovimientosPorInsumo(int existenciaId, Date fechaHasta) {
        List<MovimientoInsumo> movimientos = new ArrayList<MovimientoInsumo>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        conexion con = new conexion();
        
        String sql = "SELECT " +
                    "    m.id AS movimiento, " +
                    "    m.fecha, " +
                    "    c.numero_factura, " +
                    "    c.proveedor, " +
                    "    e.no_requisicion, " +
                    "    e.servicio, " +
                    "    dm.cantidad, " +
                    "    dm.precio_unitario, " +
                    "    dm.fecha_vencimiento, " +
                    "    dm.lote, " +
                    "    tm.codigo AS tipo_movimiento " +
                    "FROM detalle_movimiento dm " +
                    "INNER JOIN movimientos m ON dm.movimiento_id = m.id " +
                    "INNER JOIN tipos_movimiento tm ON m.tipo_id = tm.id " +
                    "LEFT JOIN compras c ON c.movimiento_id = m.id " +
                    "LEFT JOIN egresos e ON e.movimiento_id = m.id " +
                    "WHERE dm.existencia_id = ? " +
                    "  AND m.fecha <= ? " +
                    "  AND m.anulado = 0 " +
                    "ORDER BY m.fecha ASC";
        
        try {
            conn = con.conectar();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, existenciaId);
            ps.setDate(2, fechaHasta);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                MovimientoInsumo movimiento = new MovimientoInsumo();
                movimiento.setMovimiento(rs.getInt("movimiento"));
                movimiento.setFecha(rs.getDate("fecha"));
                movimiento.setNumeroFactura(rs.getString("numero_factura"));
                movimiento.setProveedor(rs.getString("proveedor"));
                movimiento.setNoRequisicion(rs.getString("no_requisicion"));
                movimiento.setServicio(rs.getString("servicio"));
                movimiento.setCantidad(rs.getBigDecimal("cantidad"));
                movimiento.setPrecioUnitario(rs.getBigDecimal("precio_unitario"));
                movimiento.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
                movimiento.setLote(rs.getString("lote"));
                movimiento.setTipoMovimiento(rs.getString("tipo_movimiento"));
                
                movimientos.add(movimiento);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return movimientos;
    }
    
    public String obtenerDescripcionInsumo(int existenciaId) {
        String descripcion = "";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        conexion con = new conexion();
        
        String sql = "SELECT nombre FROM existencias WHERE id = ?";
        
        try {
            conn = con.conectar();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, existenciaId);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                descripcion = rs.getString("nombre");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return descripcion;
    }
}