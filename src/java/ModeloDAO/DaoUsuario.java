package ModeloDAO;
import Modelo.cargo;
import Configuraciones.conexion;
import Modelo.usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DaoUsuario extends conexion {

    public usuario identificar(usuario user) throws SQLException {
        String sql = 
            "SELECT U.IDUSUARIO, C.NOMBRECARGO, E.NOMBRE, E.CUI, E.COLEGIADO " +
            "FROM USUARIO U " +
            "JOIN CARGO C ON U.IDCARGO = C.IDCARGO " +
            "JOIN EMPLEADO E ON U.IDUSUARIO = E.IDUSUARIO " +
            "WHERE U.ESTADO = 1 " +
            "  AND U.NOMBREUSUARIO = ? " +
            "  AND U.CLAVE = ?";

        // try-with-resources cierra automáticamente rs, ps y cn
        try (Connection cn = this.conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, user.getNombreUsuario());
            ps.setString(2, user.getClave());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario usu = new usuario();
                    usu.setId_usuario(rs.getInt("IDUSUARIO"));
                    usu.setNombreUsuario(user.getNombreUsuario());
                    
                    usu.setCargo(rs.getString("NOMBRECARGO"));
                    usu.setEstado(true);
                    usu.setNombrecompleto(rs.getString("NOMBRE"));
                    usu.setCUI(rs.getString("CUI"));
                    usu.setColegiado(rs.getString("COLEGIADO"));
                    return usu;
                } else {
                    return null;  // o lanza una excepción si prefieres
                }
            }
        } catch (SQLException e) {
            // mejor loguear la pila o usar un logger
            e.printStackTrace();
            throw e;  // o envuelve en una excepción de tu capa DAO
        }
    }
}
