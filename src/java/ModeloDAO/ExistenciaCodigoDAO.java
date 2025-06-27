
package ModeloDAO;


import Modelo.ExistenciaCodigo;
import java.sql.*;
import java.util.*;

public class ExistenciaCodigoDAO {
    private Connection cn;
    public ExistenciaCodigoDAO(Connection cn) { this.cn = cn; }

    public List<ExistenciaCodigo> list(int existenciaId) throws SQLException {
        String sql = "SELECT * FROM existencia_codigos WHERE existencia_id = ?";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, existenciaId);
            ResultSet rs = ps.executeQuery();
            List<ExistenciaCodigo> list = new ArrayList<>();
            while (rs.next()) {
                ExistenciaCodigo ec = new ExistenciaCodigo();
                ec.setId(rs.getInt("id"));
                ec.setExistenciaId(rs.getInt("existencia_id"));
                ec.setCodigoBarras(rs.getString("codigo_barras"));
                ec.setMarca(rs.getString("marca"));
                list.add(ec);
            }
            return list;
        }
    }

    public boolean create(ExistenciaCodigo ec) throws SQLException {
        String sql = "INSERT INTO existencia_codigos(existencia_id,codigo_barras,marca) VALUES (?,?,?)";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, ec.getExistenciaId());
            ps.setString(2, ec.getCodigoBarras());
            ps.setString(3, ec.getMarca());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(ExistenciaCodigo ec) throws SQLException {
        String sql = "UPDATE existencia_codigos SET codigo_barras=?, marca=? WHERE id=?";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, ec.getCodigoBarras());
            ps.setString(2, ec.getMarca());
            ps.setInt(3, ec.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM existencia_codigos WHERE id = ?";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}