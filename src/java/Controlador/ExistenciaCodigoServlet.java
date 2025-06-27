package Controlador;

import Configuraciones.conexion;
import ModeloDAO.ExistenciaCodigoDAO;
import Modelo.ExistenciaCodigo;
import util.JSONUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

//@WebServlet("/ExistenciaCodigoServlet")
public class ExistenciaCodigoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("list".equals(action)) {
                int existenciaId = Integer.parseInt(req.getParameter("id"));
                
                // ← Aquí obtenemos la conexión directamente
                Connection cn = new conexion().conectar();
                ExistenciaCodigoDAO dao = new ExistenciaCodigoDAO(cn);
                
                List<ExistenciaCodigo> list = dao.list(existenciaId);
                JSONUtil.writeJson(resp, list);
                
                // Cerramos la conexión
                cn.close();
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción inválida: " + action);
            }
        } catch (Exception e) {
            e.printStackTrace();  // para ver la traza completa en tu log
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        JSONUtil.JsonResponse jr = new JSONUtil.JsonResponse();
        try {
            Connection cn = new conexion().conectar();
            ExistenciaCodigoDAO dao = new ExistenciaCodigoDAO(cn);

            if ("create".equals(action)) {
                ExistenciaCodigo ec = new ExistenciaCodigo();
                ec.setExistenciaId(Integer.parseInt(req.getParameter("existencia_id")));
                ec.setCodigoBarras(req.getParameter("codigo_barras"));
                ec.setMarca(req.getParameter("marca"));
                jr.success = dao.create(ec);
                jr.message = jr.success ? "Marca agregada" : "Error al agregar";

            } else if ("update".equals(action)) {
                ExistenciaCodigo ec = new ExistenciaCodigo();
                ec.setId(Integer.parseInt(req.getParameter("id")));
                ec.setCodigoBarras(req.getParameter("codigo_barras"));
                ec.setMarca(req.getParameter("marca"));
                jr.success = dao.update(ec);
                jr.message = jr.success ? "Marca actualizada" : "Error al actualizar";

            } else if ("delete".equals(action)) {
                int idc = Integer.parseInt(req.getParameter("id"));
                jr.success = dao.delete(idc);
                jr.message = jr.success ? "Marca eliminada" : "Error al eliminar";

            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción inválida: " + action);
                return;
            }

            cn.close();
            JSONUtil.writeJson(resp, jr);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
