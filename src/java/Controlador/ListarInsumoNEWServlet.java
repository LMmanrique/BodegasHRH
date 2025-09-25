package Controlador;

import ModeloDAO.InsumoNewDAO;
import Modelo.InsumoNew;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ListarInsumoNEWServlet", urlPatterns = {"/ListarInsumoNEWServlet"})
public class ListarInsumoNEWServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            // Parámetros enviados por DataTables
            String draw = request.getParameter("draw");
            String start = request.getParameter("start");
            String length = request.getParameter("length");
            String searchValue = request.getParameter("search[value]");
            String orderColumn = request.getParameter("order[0][column]");
            String orderDir = request.getParameter("order[0][dir]");
            
            // Valores por defecto
            int startInt = (start != null) ? Integer.parseInt(start) : 0;
            int lengthInt = (length != null) ? Integer.parseInt(length) : 50;
            String search = (searchValue != null && !searchValue.trim().isEmpty()) ? searchValue.trim() : null;
            String orderCol = (orderColumn != null) ? orderColumn : "0";
            String orderDirection = (orderDir != null) ? orderDir : "asc";
            
            // Instanciar DAO
            InsumoNewDAO dao = new InsumoNewDAO();
            
            // Obtener datos
            int recordsTotal = dao.getCountAll();
            int recordsFiltered = dao.getCountFiltered(search);
            List<InsumoNew> insumos = dao.listar(startInt, lengthInt, search, orderCol, orderDirection);
            
            // Convertir a array de arrays para DataTables
            String[][] data = new String[insumos.size()][8];
            for (int i = 0; i < insumos.size(); i++) {
                InsumoNew insumo = insumos.get(i);
                data[i][0] = String.valueOf(insumo.getId());
                data[i][1] = String.valueOf(insumo.getRenglon());
                data[i][2] = String.valueOf(insumo.getCodinsumo());
                data[i][3] = (insumo.getNombre() != null) ? insumo.getNombre() : "";
                data[i][4] = (insumo.getCaracteristicas() != null) ? insumo.getCaracteristicas() : "";
                data[i][5] = (insumo.getNpresentacion() != null) ? insumo.getNpresentacion() : "";
                data[i][6] = (insumo.getMpresentacion() != null) ? insumo.getMpresentacion() : "";
                data[i][7] = String.valueOf(insumo.getCodpresentacion());
            }
            
            // Crear respuesta JSON para DataTables
            Map<String, Object> jsonResponse = new HashMap<>();
            jsonResponse.put("draw", Integer.parseInt(draw));
            jsonResponse.put("recordsTotal", recordsTotal);
            jsonResponse.put("recordsFiltered", recordsFiltered);
            jsonResponse.put("data", data);
            
            // Convertir a JSON y enviar respuesta
            Gson gson = new Gson();
            String json = gson.toJson(jsonResponse);
            out.print(json);
            out.flush();
            
        } catch (Exception e) {
            System.out.println("Error en ListarInsumoNEWServlet: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para listar insumos con DataTables server-side";
    }
}