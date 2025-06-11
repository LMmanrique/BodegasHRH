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
    
public List<Existencia> buscarExistencias(
            String codbarras,
            String renglon,
            String codinsumo,
            String nombre,
            String caracteristicas,
            String npresentacion,
            String mpresentacion,
            String codpresentacion) {

        List<Existencia> lista = new ArrayList<>();

        // 1) Construcción del SQL con LEFT JOIN para incluir existencia_codigos
        String sql =
            "SELECT " +
            "  e.id, " +
            "  COALESCE(e.codbarras, ec.codigo_barras) AS codbarras, " +
            "  e.renglon, " +
            "  e.codinsumo, " +
            "  e.nombre, " +
            "  e.caracteristicas, " +
            "  e.npresentacion, " +
            "  e.mpresentacion, " +
            "  e.codpresentacion, " +
            "  e.cantidad_actual, " +
            "  e.precio_unitario " +
            "FROM existencias e " +
            "LEFT JOIN existencia_codigos ec ON ec.existencia_id = e.id " +
            "WHERE 1=1";

        List<Object> parametros = new ArrayList<>();

        // 2) Filtros dinámicos
        if (codbarras != null && !codbarras.trim().isEmpty()) {
            sql += " AND ( e.codbarras LIKE ? OR ec.codigo_barras LIKE ? )";
            String patron = "%" + codbarras.trim() + "%";
            parametros.add(patron);
            parametros.add(patron);
        }
        if (renglon != null && !renglon.trim().isEmpty()) {
            sql += " AND e.renglon = ?";
            parametros.add(Integer.parseInt(renglon.trim()));
        }
        if (codinsumo != null && !codinsumo.trim().isEmpty()) {
            sql += " AND e.codinsumo = ?";
            parametros.add(Integer.parseInt(codinsumo.trim()));
        }
        if (nombre != null && !nombre.trim().isEmpty()) {
            sql += " AND e.nombre LIKE ?";
            parametros.add("%" + nombre.trim() + "%");
        }
        if (caracteristicas != null && !caracteristicas.trim().isEmpty()) {
            sql += " AND e.caracteristicas LIKE ?";
            parametros.add("%" + caracteristicas.trim() + "%");
        }
        if (npresentacion != null && !npresentacion.trim().isEmpty()) {
            sql += " AND e.npresentacion LIKE ?";
            parametros.add("%" + npresentacion.trim() + "%");
        }
        if (mpresentacion != null && !mpresentacion.trim().isEmpty()) {
            sql += " AND e.mpresentacion LIKE ?";
            parametros.add("%" + mpresentacion.trim() + "%");
        }
        if (codpresentacion != null && !codpresentacion.trim().isEmpty()) {
            sql += " AND e.codpresentacion = ?";
            parametros.add(Integer.parseInt(codpresentacion.trim()));
        }

        // 3) Orden y límite
        sql += " ORDER BY e.timestamp DESC LIMIT 1000";

        // 4) Ejecución y mapeo
        try (
            Connection cn = new conexion().conectar();
            PreparedStatement ps = cn.prepareStatement(sql)
        ) {
            // Asignar parámetros
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
            System.err.println("Error en DaoExistencia.buscarExistencias: " + e.getMessage());
        }

        return lista;
    }
}