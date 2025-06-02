package Controlador;

import ModeloDAO.IngresosDAO;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;


public class NuevoMovimientoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IngresosDAO dao = new IngresosDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        try {
            if ("list".equals(action)) {
                // Listar todos los movimientos
                String json = dao.listarMovimientosJSON();
                resp.getWriter().write(json);
            } else if ("get".equals(action)) {
                // Obtener cabecera de un movimiento
                int id = Integer.parseInt(req.getParameter("id"));
                String json = dao.getMovimientoJSON(id);
                resp.getWriter().write(json);
            } else if ("items".equals(action)) {
                // Obtener detalle de ítems
                int id = Integer.parseInt(req.getParameter("id"));
                String json = dao.getDetalleMovimientoJSON(id);
                resp.getWriter().write(json);
            }
            else if ("especifico".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String json = dao.getEspecificoJSON(id);
                resp.getWriter().write(json);
                return;
            }
            else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción inválida");
            }
        } catch (SQLException e) {
            throw new ServletException("Error de base de datos", e);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        try {
            if ("anular".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                boolean ok = dao.anularMovimiento(id);
                JSONObject result = new JSONObject();
                result.put("success", ok);
                if (!ok) result.put("message", "No se pudo anular el movimiento");
                resp.getWriter().write(result.toString());
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción inválida");
            }
        } catch (SQLException e) {
            throw new ServletException("Error de base de datos", e);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido");
        }
    }
}
