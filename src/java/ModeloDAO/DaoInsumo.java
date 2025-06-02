package ModeloDAO;

import Configuraciones.conexion;
import Modelo.Insumo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DaoInsumo {

    public int insertarBatch(List<Insumo> insumos) {
        int registrosInsertados = 0;
        String sql = "INSERT INTO insumo (renglon, codinsumo, nombre, caracteristicas, npresentacion, mpresentacion, codpresentacion) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {
             
            // Asegura que la sesión use UTF-8
            cn.createStatement().execute("SET NAMES 'utf8'");
            
            // Deshabilitar autocommit para la transacción
            cn.setAutoCommit(false);
            int batchSize = 10000; 
            int count = 0;
            
            for (Insumo insumo : insumos) {
                ps.setInt(1, insumo.getRenglon());
                ps.setInt(2, insumo.getCodinsumo());
                ps.setString(3, insumo.getNombre());
                ps.setString(4, insumo.getCaracteristicas());
                ps.setString(5, insumo.getNpresentacion());
                ps.setString(6, insumo.getMpresentacion());
                ps.setInt(7, insumo.getCodpresentacion());
                ps.addBatch();
                count++;
                
                if (count % batchSize == 0) {
                    int[] resultados = ps.executeBatch();
                    for (int r : resultados) {
                        registrosInsertados += r;
                    }
                    cn.commit();
                }
            }
            // Ejecutar el resto del batch
            int[] resultados = ps.executeBatch();
            for (int r : resultados) {
                registrosInsertados += r;
            }
            cn.commit();
            
        } catch (SQLException e) {
            System.out.println("Error en DaoInsumo.insertarBatch: " + e.getMessage());
        }
        return registrosInsertados;
    }
         public void limpiarTabla() {
        try (Connection cn = new conexion().conectar();
             Statement stmt = cn.createStatement()) {
            // Puedes usar TRUNCATE para vaciar la tabla de forma rápida,
            // o DELETE FROM insumo si necesitas ejecutar triggers o mantener las relaciones.
            stmt.executeUpdate("TRUNCATE TABLE insumo");
        } catch (SQLException e) {
            System.out.println("Error en DaoInsumo.limpiarTabla: " + e.getMessage());
        }
    }
        
    public int contarTotalInsumos() {
    int total = 0;
    String sql = "SELECT COUNT(*) FROM insumo";
    try (Connection cn = new conexion().conectar();
         PreparedStatement ps = cn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if(rs.next()){
            total = rs.getInt(1);
        }
    } catch (SQLException e) {
        System.out.println("Error en DaoInsumo.contarTotalInsumos: " + e.getMessage());
    }
    return total;
}
 public List<Insumo> buscarInsumos(String renglon, String codinsumo, String nombre, String caracteristicas,
                                       String npresentacion, String mpresentacion, String codpresentacion) {
        List<Insumo> lista = new ArrayList<>();
        String sql = "SELECT * FROM insumo WHERE 1=1";
        List<Object> parametros = new ArrayList<>();
        
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
        
        sql += " LIMIT 1000";
        
        try (Connection cn = new conexion().conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {
             
            // Asignar parámetros dinámicos
            for (int i = 0; i < parametros.size(); i++) {
                ps.setObject(i + 1, parametros.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Insumo insumo = new Insumo();
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
            System.out.println("Error en DaoInsumo.buscarInsumos: " + e.getMessage());
        }
        return lista;
    }

}