package Controlador;

import Modelo.Insumo;
import ModeloDAO.DaoInsumo;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.apache.commons.io.input.BOMInputStream;

@MultipartConfig
public class ActualizarInsumos extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Establecer la codificación UTF-8 para la solicitud y respuesta
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // Obtener el archivo CSV del formulario (el campo debe llamarse "csvFile")
        Part filePart = request.getPart("csvFile");
        String mensaje = "";
        
        if (filePart == null || filePart.getSize() == 0) {
            mensaje = "No se seleccionó ningún archivo.";
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("actualizarinsumos.jsp").forward(request, response);
            return;
        }
        
        int registrosConError = 0;
        List<Insumo> listaInsumos = new ArrayList<>();
        
        // Usamos BOMInputStream para eliminar el BOM y que la cabecera se lea correctamente
        try (InputStream inputStream = filePart.getInputStream();
             BOMInputStream bomInputStream = new BOMInputStream(inputStream);
             Reader reader = new InputStreamReader(bomInputStream, StandardCharsets.UTF_8);
             CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT
                                            .withDelimiter(';')
                                            .withFirstRecordAsHeader()
                                            .withTrim())) {
            
            for (CSVRecord record : csvParser) {
                try {
                    Insumo insumo = new Insumo();
                    // Se asume que el CSV tiene encabezados:
                    // "renglon;codinsumo;nombre;caracteristicas;npresentacion;mpresentacion;codpresentacion"
                    insumo.setRenglon(Integer.parseInt(record.get("renglon")));
                    insumo.setCodinsumo(Integer.parseInt(record.get("codinsumo")));
                    insumo.setNombre(record.get("nombre"));
                    insumo.setCaracteristicas(record.get("caracteristicas"));
                    insumo.setNpresentacion(record.get("npresentacion"));
                    insumo.setMpresentacion(record.get("mpresentacion"));
                    insumo.setCodpresentacion(Integer.parseInt(record.get("codpresentacion")));
                    
                    listaInsumos.add(insumo);
                } catch (Exception ex) {
                    ex.printStackTrace();
                    registrosConError++;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            mensaje = "Error al procesar el archivo CSV: " + e.getMessage();
        }
        
        // Crear instancia del DAO
        DaoInsumo daoInsumo = new DaoInsumo();
        
        // Limpiar la tabla antes de insertar los nuevos registros
        daoInsumo.limpiarTabla();
        
        // Insertar todos los registros en batch
        int registrosInsertados = daoInsumo.insertarBatch(listaInsumos);
        
        mensaje = "CSV procesado. Registros insertados: " + registrosInsertados 
                  + ". Errores: " + registrosConError;
        request.setAttribute("mensaje", mensaje);
        request.getRequestDispatcher("actualizarinsumos.jsp").forward(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("actualizarinsumos.jsp");
    }
}