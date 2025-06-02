package ModeloDAO;

import Configuraciones.conexion;
import Modelo.Existencia;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class DaoExistencia {

    // Listar todas las existencias
    public List<Existencia> listar() {
        List<Existencia> lista = new ArrayList<>();
        String sql = "SELECT * FROM existencias ORDER BY timestamp DESC";
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()){
                Existencia ex = new Existencia();
                ex.setId(rs.getInt("id"));
                ex.setCodbarras(rs.getString("codbarras"));
                ex.setRenglon(rs.getInt("renglon"));
                ex.setCodinsumo(rs.getInt("codinsumo"));
                ex.setNombre(rs.getString("nombre"));
                ex.setCaracteristicas(rs.getString("caracteristicas"));
                ex.setNpresentacion(rs.getString("npresentacion"));
                ex.setMpresentacion(rs.getString("mpresentacion"));
                ex.setCodpresentacion(rs.getInt("codpresentacion"));
                ex.setCantidad_actual(rs.getDouble("cantidad_actual"));
                ex.setPrecio_unitario(rs.getDouble("precio_unitario"));
                lista.add(ex);
            }
        } catch (SQLException e) {
            System.out.println("Error en listar: " + e.getMessage());
        }
        return lista;
    }
    
    // Obtener existencia por id
    public Existencia getExistencia(int id) {
        Existencia ex = null;
        String sql = "SELECT * FROM existencias WHERE id = ?";
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try(ResultSet rs = ps.executeQuery()){
                if(rs.next()){
                    ex = new Existencia();
                    ex.setId(rs.getInt("id"));
                    ex.setCodbarras(rs.getString("codbarras"));
                    ex.setRenglon(rs.getInt("renglon"));
                    ex.setCodinsumo(rs.getInt("codinsumo"));
                    ex.setNombre(rs.getString("nombre"));
                    ex.setCaracteristicas(rs.getString("caracteristicas"));
                    ex.setNpresentacion(rs.getString("npresentacion"));
                    ex.setMpresentacion(rs.getString("mpresentacion"));
                    ex.setCodpresentacion(rs.getInt("codpresentacion"));
                    ex.setCantidad_actual(rs.getDouble("cantidad_actual"));
                    ex.setPrecio_unitario(rs.getDouble("precio_unitario"));
                }
            }
        } catch(SQLException e) {
            System.out.println("Error en getExistencia: " + e.getMessage());
        }
        return ex;
    }
    
    // Insertar una nueva existencia
        public int insertar(Existencia ex) throws SQLException {
            int result = 0;
            String sql = "INSERT INTO existencias (codbarras, renglon, codinsumo, nombre, caracteristicas, npresentacion, mpresentacion, codpresentacion, cantidad_actual, precio_unitario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection cn = new conexion().conectar();
                 PreparedStatement ps = cn.prepareStatement(sql)) {
                ps.setString(1, ex.getCodbarras());
                ps.setInt(2, ex.getRenglon());
                ps.setInt(3, ex.getCodinsumo());
                ps.setString(4, ex.getNombre());
                ps.setString(5, ex.getCaracteristicas());
                ps.setString(6, ex.getNpresentacion());
                ps.setString(7, ex.getMpresentacion());
                ps.setInt(8, ex.getCodpresentacion());
                ps.setDouble(9, ex.getCantidad_actual());
                ps.setDouble(10, ex.getPrecio_unitario());
                result = ps.executeUpdate();
            } catch(SQLException e) {
                System.out.println("Error en insertar: " + e.getMessage());
                throw e;
            }
            return result;
        }

    
    // Actualizar una existencia
    public int actualizar(Existencia ex) {
        int result = 0;
        String sql = "UPDATE existencias SET renglon=?, codinsumo=?, nombre=?, caracteristicas=?, npresentacion=?, mpresentacion=?, codpresentacion=?, cantidad_actual=?, precio_unitario=? WHERE id=?";
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, ex.getRenglon());
            ps.setInt(2, ex.getCodinsumo());
            ps.setString(3, ex.getNombre());
            ps.setString(4, ex.getCaracteristicas());
            ps.setString(5, ex.getNpresentacion());
            ps.setString(6, ex.getMpresentacion());
            ps.setInt(7, ex.getCodpresentacion());
            ps.setDouble(8, ex.getCantidad_actual());
            ps.setDouble(9, ex.getPrecio_unitario());
            ps.setInt(10, ex.getId());
            result = ps.executeUpdate();
        } catch(SQLException e) {
            System.out.println("Error en actualizar: " + e.getMessage());
        }
        return result;
    }
    
    // Eliminar una existencia
    public int eliminar(int id) {
        int result = 0;
        String sql = "DELETE FROM existencias WHERE id = ?";
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            result = ps.executeUpdate();
        } catch(SQLException e) {
            System.out.println("Error en eliminar: " + e.getMessage());
        }
        return result;
    }
    
    public List<Existencia> buscarExistencias(String codbarras, String renglon, String codinsumo, String nombre, String caracteristicas,
                                          String npresentacion, String mpresentacion, String codpresentacion) {
    List<Existencia> lista = new ArrayList<>();
    String sql = "SELECT * FROM existencias WHERE 1=1";
    List<Object> parametros = new ArrayList<>();
    if (codbarras != null && !codbarras.trim().isEmpty()) {
        sql += " AND codbarras LIKE ?";
        parametros.add("%" + codbarras + "%");
    }
    if (renglon != null && !renglon.trim().isEmpty()) {
        sql += " AND renglon = ?";
        parametros.add(Integer.parseInt(renglon));
    }
    if (codinsumo != null && !codinsumo.trim().isEmpty()) {
        sql += " AND codinsumo = ?";
        parametros.add(Integer.parseInt(codinsumo));
    }
    if (nombre != null && !nombre.trim().isEmpty()) {
        sql += " AND nombre LIKE ?";
        parametros.add("%" + nombre + "%");
    }
    if (caracteristicas != null && !caracteristicas.trim().isEmpty()) {
        sql += " AND caracteristicas LIKE ?";
        parametros.add("%" + caracteristicas + "%");
    }
    if (npresentacion != null && !npresentacion.trim().isEmpty()) {
        sql += " AND npresentacion LIKE ?";
        parametros.add("%" + npresentacion + "%");
    }
    if (mpresentacion != null && !mpresentacion.trim().isEmpty()) {
        sql += " AND mpresentacion LIKE ?";
        parametros.add("%" + mpresentacion + "%");
    }
    if (codpresentacion != null && !codpresentacion.trim().isEmpty()) {
        sql += " AND codpresentacion = ?";
        parametros.add(Integer.parseInt(codpresentacion));
    }
    
    sql += " ORDER BY timestamp DESC LIMIT 1000";
    
    try (Connection cn = new conexion().conectar();
         PreparedStatement ps = cn.prepareStatement(sql)) {
        
        // Asignar parámetros dinámicos
        for (int i = 0; i < parametros.size(); i++) {
            ps.setObject(i + 1, parametros.get(i));
        }
        
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Existencia ex = new Existencia();
            ex.setId(rs.getInt("id"));
            ex.setCodbarras(rs.getString("codbarras"));
            ex.setRenglon(rs.getInt("renglon"));
            ex.setCodinsumo(rs.getInt("codinsumo"));
            ex.setNombre(rs.getString("nombre"));
            ex.setCaracteristicas(rs.getString("caracteristicas"));
            ex.setNpresentacion(rs.getString("npresentacion"));
            ex.setMpresentacion(rs.getString("mpresentacion"));
            ex.setCodpresentacion(rs.getInt("codpresentacion"));
            ex.setCantidad_actual(rs.getDouble("cantidad_actual"));
            ex.setPrecio_unitario(rs.getDouble("precio_unitario"));
            lista.add(ex);
        }
    } catch (SQLException e) {
        System.out.println("Error en DaoExistencia.buscarExistencias: " + e.getMessage());
    }
    return lista;
}
}