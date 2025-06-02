// ------------------------------------------------------
// File: Controlador/EgresosServlet.java
// ------------------------------------------------------
package Controlador;

import Modelo.EgresoPayload;
import Modelo.DetalleDTO;
import ModeloDAO.EgresosDAO;
import com.google.gson.Gson;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "EgresosServlet", urlPatterns = {"/EgresosServlet"})
public class EgresosServlet extends HttpServlet {
    private EgresosDAO dao;
    private Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        dao = new EgresosDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            switch (action) {
                case "list":
                    out.print(gson.toJson(dao.listarEgresos()));
                    break;
                case "get":
                    int idGet = Integer.parseInt(request.getParameter("id"));
                    out.print(gson.toJson(dao.getDetalleCabecera(idGet)));
                    break;
                case "especifico":
                    int idEsp = Integer.parseInt(request.getParameter("id"));
                    out.print(gson.toJson(dao.getDatosEspecificos(idEsp)));
                    break;
                case "items":
                    int idItems = Integer.parseInt(request.getParameter("id"));
                    out.print(gson.toJson(dao.listarDetalleItems(idItems)));
                    break;
                default:
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"error\":\"Acción no reconocida\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Leer payload JSON
            EgresoPayload payload = gson.fromJson(request.getReader(), EgresoPayload.class);
            if (payload == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"error\":\"JSON inválido\"}");
                return;
            }
            // Validaciones de campos obligatorios (excepto observaciones)
            if (payload.getUsuario() == null || payload.getUsuario().trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"error\":\"Usuario es obligatorio\"}");
                return;
            }
            if (payload.getFecha() == null || payload.getFecha().trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"error\":\"Fecha es obligatoria\"}");
                return;
            }
            if (payload.getProveedor() == null || payload.getProveedor().trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"error\":\"Número de requisición es obligatorio\"}");
                return;
            }
            if (payload.getServicio_devuelve() == null || payload.getServicio_devuelve().trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"error\":\"Servicio es obligatorio\"}");
                return;
            }
            List<DetalleDTO> detalles = payload.getDetalles();
            if (detalles == null || detalles.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"error\":\"Debe agregar al menos un insumo\"}");
                return;
            }
            // Validar que cada detalle tenga cantidad y precio válidos
            for (DetalleDTO d : detalles) {
                if (d.getCantidad() <= 0) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"success\":false,\"error\":\"Cantidad en detalle debe ser mayor que 0\"}");
                    return;
                }
                if (d.getPrecio_unitario() <= 0) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"success\":false,\"error\":\"Precio unitario en detalle debe ser mayor que 0\"}");
                    return;
                }
            }

            // Parseo de valores
            int usuarioId = Integer.parseInt(payload.getUsuario().trim());
            Date fecha = Date.valueOf(payload.getFecha().trim());
            String noReq = payload.getProveedor().trim();
            String servicio = payload.getServicio_devuelve().trim();
            String obs = payload.getObservaciones_compra() != null
                         ? payload.getObservaciones_compra().trim()
                         : "";

            // Guardar en BD
            dao.guardarEgresoCompleto(fecha, noReq, servicio, obs, usuarioId, detalles);
            out.print("{\"success\":true}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try (PrintWriter out = response.getWriter()) {
                String msg = e.getMessage().replace("\n", "\\n");
                out.print("{\"success\":false,\"error\":\"" + msg + "\"}");
            }
        }
    }
}
