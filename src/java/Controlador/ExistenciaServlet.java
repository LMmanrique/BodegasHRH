package Controlador;

import Configuraciones.conexion;
import Modelo.Existencia;
import ModeloDAO.DaoExistencia;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;
import java.io.PrintWriter;
import java.sql.SQLIntegrityConstraintViolationException;
import com.google.gson.Gson;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.json.JSONArray;


public class ExistenciaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        DaoExistencia dao = new DaoExistencia();
        if ("buscarPorCodigoJSON".equals(accion)) {
        buscarPorCodigoJSON(request, response);
        return;  // cortamos aquí para que no siga con el resto de ramas
        }
        else if (accion == null || accion.equals("listar")) {
            List<Existencia> lista = dao.listar();
            request.setAttribute("listaExistencias", lista);
            request.getRequestDispatcher("consultarexistencia.jsp").forward(request, response);
        }
        else if (accion.equals("buscar")) {
            // Recupera los parámetros de filtro
            String codbarras = request.getParameter("codbarras");
            String renglon = request.getParameter("renglon");
            String codinsumo = request.getParameter("codinsumo");
            String nombre = request.getParameter("nombre");
            String caracteristicas = request.getParameter("caracteristicas");
            String npresentacion = request.getParameter("npresentacion");
            String mpresentacion = request.getParameter("mpresentacion");
            String codpresentacion = request.getParameter("codpresentacion");

            // Llama al método de búsqueda en el DAO
            List<Existencia> lista = dao.buscarExistencias(codbarras,renglon, codinsumo, nombre, caracteristicas, npresentacion, mpresentacion, codpresentacion);
            request.setAttribute("listaExistencias", lista);
            System.out.println("Cantidad de elementos filtrados: " + lista.size());
            request.getRequestDispatcher("consultarexistencia.jsp").forward(request, response);
        }
        else if ("buscarajax".equals(accion)) {
            String codbarras       = request.getParameter("codbarras");
            String renglon         = null;
            String codinsumo       = null;
            String nombre          = null;
            String caracteristicas = null;
            String npresentacion   = null;
            String mpresentacion   = null;
            String codpresentacion = null;

            List<Existencia> lista = dao.buscarExistencias(
                codbarras,
                renglon, codinsumo, nombre,
                caracteristicas, npresentacion,
                mpresentacion, codpresentacion
            );
            String json = new Gson().toJson(lista);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(json);
            return;
        }
        else if (accion.equals("buscarmodal")) {
            // Recupera los parámetros de filtro
            String codbarras = request.getParameter("codbarras");
            String renglon = request.getParameter("renglon");
            String codinsumo = request.getParameter("codinsumo");
            String nombre = request.getParameter("nombre");
            String caracteristicas = request.getParameter("caracteristicas");
            String npresentacion = request.getParameter("npresentacion");
            String mpresentacion = request.getParameter("mpresentacion");
            String codpresentacion = request.getParameter("codpresentacion");

            // Llama al método de búsqueda en el DAO
            List<Existencia> lista = dao.buscarExistencias(codbarras, renglon, codinsumo, nombre, caracteristicas, npresentacion, mpresentacion, codpresentacion);
            request.setAttribute("listaExistencias", lista);
            System.out.println("Cantidad de elementos filtrados: " + lista.size());
            request.getRequestDispatcher("consultarexistenciamodal.jsp").forward(request, response);
        }
        else if (accion.equals("editar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Existencia ex = dao.getExistencia(id);
            request.setAttribute("existencia", ex);
            request.getRequestDispatcher("editarExistencia.jsp").forward(request, response);
        } else if (accion.equals("eliminar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(id);
            response.sendRedirect("ExistenciaServlet?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        DaoExistencia dao = new DaoExistencia();
        if (accion.equals("insertar")) {
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject json = new JSONObject();

            try {
                Existencia ex = new Existencia();
                ex.setCodbarras(request.getParameter("codbarras"));
                ex.setRenglon(Integer.parseInt(request.getParameter("renglon")));
                ex.setCodinsumo(Integer.parseInt(request.getParameter("codinsumo")));
                ex.setNombre(request.getParameter("nombre"));
                ex.setCaracteristicas(request.getParameter("caracteristicas"));
                ex.setNpresentacion(request.getParameter("npresentacion"));
                ex.setMpresentacion(request.getParameter("mpresentacion"));
                ex.setCodpresentacion(Integer.parseInt(request.getParameter("codpresentacion")));
                ex.setCantidad_actual(Double.parseDouble(request.getParameter("cantidad_actual")));
                ex.setPrecio_unitario(Double.parseDouble(request.getParameter("precio_unitario")));

                dao.insertar(ex);

                json.put("success", true);
                json.put("message", "Existencia agregada correctamente.");

            } catch (SQLIntegrityConstraintViolationException ex) {
                json.put("success", false);
                json.put("message", "El registro ya existe (duplicado).");
            } catch (Exception e) {
                json.put("success", false);
                json.put("message", "Error del servidor: " + e.getMessage());
            }

            out.print(json.toString());
            out.flush();
            } 
        else if (accion.equals("actualizar")) {
            Existencia ex = new Existencia();
            ex.setId(Integer.parseInt(request.getParameter("id")));
            ex.setRenglon(Integer.parseInt(request.getParameter("renglon")));
            ex.setCodinsumo(Integer.parseInt(request.getParameter("codinsumo")));
            ex.setNombre(request.getParameter("nombre"));
            ex.setCaracteristicas(request.getParameter("caracteristicas"));
            ex.setNpresentacion(request.getParameter("npresentacion"));
            ex.setMpresentacion(request.getParameter("mpresentacion"));
            ex.setCodpresentacion(Integer.parseInt(request.getParameter("codpresentacion")));
            ex.setCantidad_actual(Double.parseDouble(request.getParameter("cantidad_actual")));
            ex.setPrecio_unitario(Double.parseDouble(request.getParameter("precio_unitario")));
            dao.actualizar(ex);
            response.sendRedirect("ExistenciaServlet?accion=listar");
        }
    }
            private void buscarPorCodigoJSON(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String codbarras = request.getParameter("codbarras");
        response.setContentType("application/json");
        JSONObject json = new JSONObject();
        try {
            conexion conector = new conexion();
            try (Connection cn = conector.conectar()) {
                String sqlExist = "SELECT id, nombre, caracteristicas, cantidad_actual, precio_unitario " +
                                  "FROM existencias WHERE codbarras = ?";
                try (PreparedStatement ps = cn.prepareStatement(sqlExist)) {
                    ps.setString(1, codbarras);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            int id = rs.getInt("id");
                            json.put("id", id);
                            json.put("nombre", rs.getString("nombre"));
                            json.put("caracteristicas", rs.getString("caracteristicas"));
                            json.put("cantidad_actual", rs.getDouble("cantidad_actual"));
                            json.put("precio_unitario", rs.getDouble("precio_unitario"));

                            JSONArray lotesArr = new JSONArray();
                            String sqlLotes = "SELECT fecha_vencimiento, lote, cantidad " +
                                              "FROM vencimientos WHERE existencia_id = ?";
                            try (PreparedStatement ps2 = cn.prepareStatement(sqlLotes)) {
                                ps2.setInt(1, id);
                                try (ResultSet rs2 = ps2.executeQuery()) {
                                    while (rs2.next()) {
                                        JSONObject loteObj = new JSONObject();
                                        loteObj.put("fecha_vencimiento", rs2.getDate("fecha_vencimiento").toString());
                                        loteObj.put("lote", rs2.getString("lote"));
                                        loteObj.put("cantidad", rs2.getDouble("cantidad"));
                                        lotesArr.put(loteObj);
                                    }
                                }
                            }
                            json.put("lotes", lotesArr);
                        }
                    }
                }
            }
        } catch (Exception e) {
            json.put("error", e.getMessage());
        }
        response.getWriter().print(json.toString());
    }
}
