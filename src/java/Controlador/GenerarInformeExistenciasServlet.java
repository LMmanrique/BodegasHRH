package Controlador;

import ModeloDAO.InformeExistenciaDAO;
import Modelo.InformeExistencia;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.*;

//@WebServlet("/GenerarInformeExistenciasServlet")
public class GenerarInformeExistenciasServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // 🔐 Validación de sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("authentication-login.jsp");
            return;
        }
        
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=informe_existencias.pdf");
        
        try {
            InformeExistenciaDAO dao = new InformeExistenciaDAO();
            java.util.List<InformeExistencia> datos = dao.obtenerDatosInforme();
            
            generarPDF(response, datos);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                              "Error al generar el informe: " + e.getMessage());
        }
    }
    
    private void generarPDF(HttpServletResponse response, java.util.List<InformeExistencia> datos) 
            throws DocumentException, IOException {
        
        Document document = new Document(PageSize.A4.rotate(), 20, 20, 30, 30);
        PdfWriter.getInstance(document, response.getOutputStream());
        
        document.open();
        
        // Fuentes
        Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
        Font fontSubtitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10);
        Font fontNormal = FontFactory.getFont(FontFactory.HELVETICA, 8);
        Font fontTablaHeader = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 8);
        
        // ENCABEZADO IZQUIERDA
        document.add(new Paragraph("MINISTERIO DE SALUD PÚBLICA Y ASISTENCIA SOCIAL", fontTitulo));
        document.add(new Paragraph("HOSPITAL REGIONAL DE HUEHUETENANGO \"DR. JORGE VIDES MOLINA\"", fontSubtitulo));
        //document.add(new Paragraph("ALMACÉN GENERAL", fontSubtitulo));
        document.add(new Paragraph(" "));
        
        // TÍTULO CENTRADO
        Paragraph titulo1 = new Paragraph("INFORME DE EXISTENCIAS DEL INVENTARIO", fontTitulo);
        titulo1.setAlignment(Element.ALIGN_CENTER);
        document.add(titulo1);
        
        Paragraph titulo2 = new Paragraph("ALMACÉN DE SUMINISTROS", fontSubtitulo);
        titulo2.setAlignment(Element.ALIGN_CENTER);
        document.add(titulo2);
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Paragraph fecha = new Paragraph("FECHA: " + sdf.format(new Date()), fontSubtitulo);
        fecha.setAlignment(Element.ALIGN_CENTER);
        document.add(fecha);
        
        document.add(new Paragraph(" "));

        // 🔹 Formato de moneda 
        DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
        simbolos.setGroupingSeparator(',');
        simbolos.setDecimalSeparator('.');
        DecimalFormat formatoMoneda = new DecimalFormat("#,##0.00", simbolos);
        
        // TABLA (8 columnas)
        PdfPTable tabla = new PdfPTable(8);
        tabla.setWidthPercentage(100);
        float[] anchos = {8f, 10f, 35f, 12f, 15f, 8f, 10f, 10f};
        tabla.setWidths(anchos);

        // 🔹 Encabezado — primera fila con rowspan en las primeras 5 columnas
        String[] headersFila1 = {"RENGLÓN", "CÓDIGO", "NOMBRE DEL PRODUCTO", 
                                 "LOTE", "FECHA DE VENCIMIENTO"};

        for (String header : headersFila1) {
            PdfPCell cell = new PdfPCell(new Phrase(header, fontTablaHeader));
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setRowspan(2); // ocupa 2 filas
            tabla.addCell(cell);
        }

        // Celda combinada para EXISTENCIAS
        PdfPCell existenciaCell = new PdfPCell(new Phrase("EXISTENCIAS", fontTablaHeader));
        existenciaCell.setColspan(3);
        existenciaCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        existenciaCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        existenciaCell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        tabla.addCell(existenciaCell);

        // 🔹 Segunda fila de encabezado (subcolumnas de EXISTENCIAS)
        String[] headersFila2 = {"CANTIDAD", "PRECIO UNITARIO", "TOTAL"};
        for (String header : headersFila2) {
            PdfPCell cell = new PdfPCell(new Phrase(header, fontTablaHeader));
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            tabla.addCell(cell);
        }

        // 🔹 Contenido de la tabla
        BigDecimal granTotal = BigDecimal.ZERO;
        
        for (InformeExistencia item : datos) {
            PdfPCell c1 = new PdfPCell(new Phrase(String.valueOf(item.getRenglon()), fontNormal));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tabla.addCell(c1);

            PdfPCell c2 = new PdfPCell(new Phrase(String.valueOf(item.getCodinsumo()), fontNormal));
            c2.setHorizontalAlignment(Element.ALIGN_CENTER);
            tabla.addCell(c2);

            PdfPCell c3 = new PdfPCell(new Phrase(item.getNombreProducto(), fontNormal));
            c3.setHorizontalAlignment(Element.ALIGN_LEFT);
            tabla.addCell(c3);

            PdfPCell c4 = new PdfPCell(new Phrase(item.getLote(), fontNormal));
            c4.setHorizontalAlignment(Element.ALIGN_CENTER);
            tabla.addCell(c4);

            PdfPCell c5 = new PdfPCell(new Phrase(
                item.getFechaVencimiento() != null ? sdf.format(item.getFechaVencimiento()) : "Sin fecha", 
                fontNormal));
            c5.setHorizontalAlignment(Element.ALIGN_CENTER);
            tabla.addCell(c5);

            PdfPCell c6 = new PdfPCell(new Phrase(item.getCantidad().toString(), fontNormal));
            c6.setHorizontalAlignment(Element.ALIGN_RIGHT);
            tabla.addCell(c6);

            PdfPCell c7 = new PdfPCell(new Phrase("Q " + formatoMoneda.format(item.getPrecioUnitario()), fontNormal));
            c7.setHorizontalAlignment(Element.ALIGN_RIGHT);
            tabla.addCell(c7);

            PdfPCell c8 = new PdfPCell(new Phrase("Q " + formatoMoneda.format(item.getTotal()), fontNormal));
            c8.setHorizontalAlignment(Element.ALIGN_RIGHT);
            tabla.addCell(c8);

            granTotal = granTotal.add(item.getTotal());
        }

        // 🔹 Fila gran total
        PdfPCell totalCell = new PdfPCell(new Phrase("GRAN TOTAL: Q " + formatoMoneda.format(granTotal), fontTablaHeader));
        totalCell.setColspan(8);
        totalCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        totalCell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        tabla.addCell(totalCell);
        
        document.add(tabla);
        
        document.close();
    }
}