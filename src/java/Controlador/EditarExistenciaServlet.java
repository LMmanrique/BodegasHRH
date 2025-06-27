
package Controlador;
import ModeloDAO.DaoExistencia;
import Modelo.Existencia;
import util.JSONUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet para obtener y actualizar cantidad/precio de una existencia,
 * y para comprobar si hay movimientos asociados.
 */
//@WebServlet("/EditarExistenciaServlet")
public class EditarExistenciaServlet extends HttpServlet {

    private DaoExistencia dao;

    @Override
    public void init() throws ServletException {
        super.init();
        dao = new DaoExistencia(); // tu DAO no necesita pasar Connection
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        int id = Integer.parseInt(req.getParameter("id"));

        try {
            if ("get".equals(action)) {
                Existencia e = dao.getExistencia(id);
                JSONUtil.writeJson(resp, e);
            } 
            else if ("checkMovimientos".equals(action)) {
                boolean has = dao.hasMovimientos(id);
                JSONUtil.JsonResponse jr = new JSONUtil.JsonResponse();
                jr.success = has;
                jr.message = has ? "Tiene movimientos" : "No tiene movimientos";
                // Nota: aquí jr.success indica si hay movimientos
                JSONUtil.writeJson(resp, jr);
            } 
            else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción inválida");
            }
        } catch (Exception ex) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        JSONUtil.JsonResponse jr = new JSONUtil.JsonResponse();

        try {
            if ("update".equals(action)) {
                Existencia e = new Existencia();
                e.setId(Integer.parseInt(req.getParameter("id")));
                e.setCantidad_actual(Double.parseDouble(req.getParameter("cantidad_actual")));
                e.setPrecio_unitario(Double.parseDouble(req.getParameter("precio_unitario")));
                int rows = dao.actualizarCantidadPrecio(e);
                jr.success = (rows > 0);
                jr.message = jr.success ? "Existencia actualizada" : "No se pudo actualizar";
            } 
            else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción inválida");
                return;
            }
            JSONUtil.writeJson(resp, jr);
        } catch (Exception ex) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }
}