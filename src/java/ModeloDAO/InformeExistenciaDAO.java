package ModeloDAO;

import Configuraciones.conexion;
import Modelo.InformeExistencia;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InformeExistenciaDAO {
    
    conexion cn = new conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    
    public List<InformeExistencia> obtenerDatosInforme() {
        List<InformeExistencia> lista = new ArrayList<>();
        
    String sql = "SELECT "
            + " e.renglon, "
            + " e.codinsumo, "
            + " CONCAT( "
            + "   COALESCE(e.nombre, ''), "
            + "   CASE WHEN e.caracteristicas IS NOT NULL AND e.caracteristicas != '' "
            + "        THEN CONCAT(' - ', e.caracteristicas) ELSE '' END, "
            + "   CASE WHEN e.npresentacion IS NOT NULL AND e.npresentacion != '' "
            + "        THEN CONCAT(' - ', e.npresentacion) ELSE '' END, "
            + "   CASE WHEN e.mpresentacion IS NOT NULL AND e.mpresentacion != '' "
            + "        THEN CONCAT(' - ', e.mpresentacion) ELSE '' END "
            + " ) AS nombre_producto, "
            + " COALESCE(v.lote, 'Sin lote') AS lote, "
            + " v.fecha_vencimiento, "
            + " e.cantidad_actual, "
            + " e.precio_unitario, "
            + " (e.cantidad_actual * e.precio_unitario) AS total "
            + "FROM existencias e "
            + "LEFT JOIN vencimientos v ON e.id = v.existencia_id "
            + "WHERE e.cantidad_actual > 0 "
            + "ORDER BY e.renglon, e.codinsumo, v.fecha_vencimiento";
        
        try {
            con = cn.conectar();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                InformeExistencia item = new InformeExistencia();
                item.setRenglon(rs.getInt("renglon"));
                item.setCodinsumo(rs.getInt("codinsumo"));
                item.setNombreProducto(rs.getString("nombre_producto"));
                item.setLote(rs.getString("lote"));
                item.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
                item.setCantidad(rs.getBigDecimal("cantidad_actual"));
                item.setPrecioUnitario(rs.getBigDecimal("precio_unitario"));
                item.setTotal(rs.getBigDecimal("total"));
                
                lista.add(item);
            }
        } catch (Exception e) {
            System.out.println("Error al obtener datos del informe: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        
        return lista;
    }
}