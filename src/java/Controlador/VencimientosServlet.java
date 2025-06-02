package Controlador;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import Modelo.Vencimiento;
import ModeloDAO.VencimientoDAO;
import ModeloDAO.VencimientoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class VencimientosServlet extends HttpServlet {
    private final VencimientoDAO dao = new VencimientoDAO();
    private final Gson gson = new GsonBuilder()
        .setDateFormat("yyyy-MM-dd")
        .create();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        try {
            List<Vencimiento> lista = dao.listar();
            String json = gson.toJson(lista);
            resp.getWriter().write(json);
        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter()
                .write(gson.toJson(Collections.singletonMap("error", e.getMessage())));
        }
    }
}
