package ModeloDAO;

import Configuraciones.conexion;
import Modelo.InsumoNew;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InsumoNewDAO {
    
    private conexion cn = new conexion();
    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    
    // Obtener total de registros sin filtro
    public int getCountAll() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM insumo";
        try {
            con = cn.conectar();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error al contar registros: " + e.getMessage());
        } finally {
            cerrarConexiones();
        }
        return total;
    }
    
    // Obtener total de registros con filtro de búsqueda
    public int getCountFiltered(String search) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM insumo WHERE 1=1";
        
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (nombre LIKE ? OR caracteristicas LIKE ? OR npresentacion LIKE ? OR mpresentacion LIKE ? OR codinsumo LIKE ? OR renglon LIKE ?)";
        }
        
        try {
            con = cn.conectar();
            ps = con.prepareStatement(sql);
            
            if (search != null && !search.trim().isEmpty()) {
                String searchParam = "%" + search + "%";
                ps.setString(1, searchParam);
                ps.setString(2, searchParam);
                ps.setString(3, searchParam);
                ps.setString(4, searchParam);
                ps.setString(5, searchParam);
                ps.setString(6, searchParam);
            }
            
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error al contar registros filtrados: " + e.getMessage());
        } finally {
            cerrarConexiones();
        }
        return total;
    }
    
    // Listar insumos con paginación, filtro y ordenamiento
    public List<InsumoNew> listar(int start, int length, String search, String orderColumn, String orderDir) {
        List<InsumoNew> lista = new ArrayList<>();
        String sql = "SELECT id, renglon, codinsumo, nombre, caracteristicas, npresentacion, mpresentacion, codpresentacion FROM insumo WHERE 1=1";
        
        // Agregar filtro de búsqueda
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (nombre LIKE ? OR caracteristicas LIKE ? OR npresentacion LIKE ? OR mpresentacion LIKE ? OR codinsumo LIKE ? OR renglon LIKE ?)";
        }
        
        // Agregar ordenamiento
        String[] columnas = {"id", "renglon", "codinsumo", "nombre", "caracteristicas", "npresentacion", "mpresentacion", "codpresentacion"};
        int columnIndex = 0;
        try {
            columnIndex = Integer.parseInt(orderColumn);
            if (columnIndex >= 0 && columnIndex < columnas.length) {
                sql += " ORDER BY " + columnas[columnIndex] + " " + (orderDir.equalsIgnoreCase("desc") ? "DESC" : "ASC");
            } else {
                sql += " ORDER BY id ASC";
            }
        } catch (NumberFormatException e) {
            sql += " ORDER BY id ASC";
        }
        
        // Agregar paginación
        sql += " LIMIT ? OFFSET ?";
        
        try {
            con = cn.conectar();
            ps = con.prepareStatement(sql);
            
            int paramIndex = 1;
            
            // Parámetros de búsqueda
            if (search != null && !search.trim().isEmpty()) {
                String searchParam = "%" + search + "%";
                ps.setString(paramIndex++, searchParam);
                ps.setString(paramIndex++, searchParam);
                ps.setString(paramIndex++, searchParam);
                ps.setString(paramIndex++, searchParam);
                ps.setString(paramIndex++, searchParam);
                ps.setString(paramIndex++, searchParam);
            }
            
            // Parámetros de paginación
            ps.setInt(paramIndex++, length);
            ps.setInt(paramIndex, start);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                InsumoNew insumo = new InsumoNew();
                insumo.setId(rs.getInt("id"));
                insumo.setRenglon(rs.getInt("renglon"));
                insumo.setCodinsumo(rs.getInt("codinsumo"));
                insumo.setNombre(rs.getString("nombre"));
                insumo.setCaracteristicas(rs.getString("caracteristicas"));
                insumo.setNpresentacion(rs.getString("npresentacion"));
                insumo.setMpresentacion(rs.getString("mpresentacion"));
                insumo.setCodpresentacion(rs.getInt("codpresentacion"));
                lista.add(insumo);
            }
            
        } catch (SQLException e) {
            System.out.println("Error al listar insumos: " + e.getMessage());
        } finally {
            cerrarConexiones();
        }
        
        return lista;
    }
    
    private void cerrarConexiones() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            System.out.println("Error al cerrar conexiones: " + e.getMessage());
        }
    }
}