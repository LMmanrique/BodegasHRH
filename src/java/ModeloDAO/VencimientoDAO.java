package ModeloDAO;

import Configuraciones.conexion;
import Modelo.Vencimiento;
import java.sql.*;
import java.util.*;

public class VencimientoDAO {
    private static final String SQL =
      "SELECT v.id, e.nombre AS insumo, e.caracteristicas, " +
      "       v.fecha_vencimiento, v.lote, v.cantidad, " +
      "       u.NOMBREUSUARIO AS usuario, v.creado_en " +
      "FROM vencimientos v " +
      "JOIN detalle_movimiento dm ON v.detalle_id = dm.id " +
      "JOIN existencias e         ON v.existencia_id = e.id " +
      "JOIN movimientos m         ON dm.movimiento_id = m.id " +
      "JOIN usuario u             ON m.usuario_id = u.IDUSUARIO " +
      "WHERE v.cantidad > 0";

    public List<Vencimiento> listar() throws SQLException {
        List<Vencimiento> lista = new ArrayList<>();
        conexion cx = new conexion();
        try (Connection conn = cx.conectar();
             PreparedStatement ps = conn.prepareStatement(SQL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Vencimiento v = new Vencimiento();
                v.setId(rs.getInt("id"));
                v.setInsumo(rs.getString("insumo"));
                v.setCaracteristicas(rs.getString("caracteristicas"));
                v.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
                v.setLote(rs.getString("lote"));
                v.setCantidad(rs.getBigDecimal("cantidad"));
                v.setUsuario(rs.getString("usuario"));
                v.setCreadoEn(rs.getTimestamp("creado_en"));
                lista.add(v);
            }
        }
        return lista;
    }
}