package Controlador;

import Modelo.Insumo;
import ModeloDAO.DaoInsumo;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class ListarInsumosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Recoger filtros desde la solicitud (parámetros GET)
        String renglon = request.getParameter("renglon");
        String codinsumo = request.getParameter("codinsumo");
        String nombre = request.getParameter("nombre");
        String caracteristicas = request.getParameter("caracteristicas");
        String npresentacion = request.getParameter("npresentacion");
        String mpresentacion = request.getParameter("mpresentacion");
        String codpresentacion = request.getParameter("codpresentacion");
        
        DaoInsumo dao = new DaoInsumo();
        List<Insumo> lista = dao.buscarInsumos(renglon, codinsumo, nombre, caracteristicas, npresentacion, mpresentacion, codpresentacion);
        System.out.println("Cantidad de insumos: " + lista.size());
        request.setAttribute("listaInsumos", lista);
        request.getRequestDispatcher("consultarinsumos.jsp").forward(request, response);
    }
}
