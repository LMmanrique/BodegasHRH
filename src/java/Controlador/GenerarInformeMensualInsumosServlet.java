package Controlador;
import Modelo.MovimientoInsumo;
import ModeloDAO.MovimientoInsumoDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@WebServlet("/GenerarInformeMensualInsumosServlet")
public class GenerarInformeMensualInsumosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Validar sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Obtener parámetros
            int existenciaId = Integer.parseInt(request.getParameter("existenciaId"));
            int mes = Integer.parseInt(request.getParameter("mes"));
            int anio = Integer.parseInt(request.getParameter("anio"));
            
            // Calcular fechas
            LocalDate fechaInicial = LocalDate.of(anio, mes, 1);
            LocalDate fechaFinal = fechaInicial.with(TemporalAdjusters.lastDayOfMonth());
            
            // Obtener datos
            MovimientoInsumoDAO dao = new MovimientoInsumoDAO();
            String descripcionInsumo = dao.obtenerDescripcionInsumo(existenciaId);
            List<MovimientoInsumo> todosMovimientos = dao.obtenerMovimientosPorInsumo(
                existenciaId, Date.valueOf(fechaFinal));
            
            // Separar movimientos por periodo
            List<MovimientoInsumo> movimientosDelMes = new ArrayList<MovimientoInsumo>();
            BigDecimal saldoAnterior = BigDecimal.ZERO;
            BigDecimal entradasMes = BigDecimal.ZERO;
            BigDecimal salidasMes = BigDecimal.ZERO;
            
            for (MovimientoInsumo mov : todosMovimientos) {
                LocalDate fechaMovimiento = new java.sql.Date(mov.getFecha().getTime()).toLocalDate();
                
                if (fechaMovimiento.isBefore(fechaInicial)) {
                    // Movimiento anterior al mes - calcular saldo anterior
                    if ("EGRESO".equals(mov.getTipoMovimiento())) {
                        saldoAnterior = saldoAnterior.subtract(mov.getCantidad());
                    } else {
                        saldoAnterior = saldoAnterior.add(mov.getCantidad());
                    }
                } else {
                    // Movimiento del mes actual
                    movimientosDelMes.add(mov);
                    if ("EGRESO".equals(mov.getTipoMovimiento())) {
                        salidasMes = salidasMes.add(mov.getCantidad());
                    } else {
                        entradasMes = entradasMes.add(mov.getCantidad());
                    }
                }
            }
            
            BigDecimal saldoFinal = saldoAnterior.add(entradasMes).subtract(salidasMes);
            
            // Generar PDF
            generarPDF(response, descripcionInsumo, movimientosDelMes, 
                      saldoAnterior, entradasMes, salidasMes, saldoFinal, mes, anio);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                             "Error al generar el informe: " + e.getMessage());
        }
    }
    
    private void generarPDF(HttpServletResponse response, String descripcionInsumo,
                           List<MovimientoInsumo> movimientos, BigDecimal saldoAnterior,
                           BigDecimal entradas, BigDecimal salidas, BigDecimal saldoFinal,
                           int mes, int anio) throws DocumentException, IOException {
        
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", 
                          "attachment; filename=informe_mensual_insumos_" + mes + "_" + anio + ".pdf");
        
        Document document = new Document(PageSize.A4.rotate(), 20, 20, 30, 30);
        PdfWriter.getInstance(document, response.getOutputStream());
        
        document.open();
        
        // Formatear números
        DecimalFormat formatoNumero = new DecimalFormat("#,##0.00");
        DecimalFormat formatoCantidad = new DecimalFormat("#,##0.00");
        
        // Header
        Font fontHeader = FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL);
        Paragraph header1 = new Paragraph("MINISTERIO DE SALUD PÚBLICA Y ASISTENCIA SOCIAL", fontHeader);
        header1.setAlignment(Element.ALIGN_LEFT);
        document.add(header1);
        
        Paragraph header2 = new Paragraph("HOSPITAL REGIONAL DE HUEHUETENANGO", fontHeader);
        header2.setAlignment(Element.ALIGN_LEFT);
        document.add(header2);
        
        document.add(new Paragraph(" "));
        
        // Título
        Font fontTitle = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, Font.BOLD);
        String[] meses = {"", "ENERO", "FEBRERO", "MARZO", "ABRIL", "MAYO", "JUNIO",
                         "JULIO", "AGOSTO", "SEPTIEMBRE", "OCTUBRE", "NOVIEMBRE", "DICIEMBRE"};
        Paragraph title = new Paragraph("INFORME MENSUAL DE INSUMOS - " + meses[mes] + " " + anio, fontTitle);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        
        document.add(new Paragraph(" "));
        
        // Descripción del insumo
        Font fontBold = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, Font.BOLD);
        Paragraph insumoDesc = new Paragraph("INSUMO: " + descripcionInsumo, fontBold);
        document.add(insumoDesc);
        
        document.add(new Paragraph(" "));
        
        // Resumen
        PdfPTable resumenTable = new PdfPTable(4);
        resumenTable.setWidthPercentage(60);
        resumenTable.setWidths(new float[]{3f, 2f, 2f, 2f});
        
        // Headers del resumen
        Font fontTableHeader = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, Font.BOLD);
        PdfPCell cellHeader;
        
        cellHeader = new PdfPCell(new Phrase("CONCEPTO", fontTableHeader));
        cellHeader.setHorizontalAlignment(Element.ALIGN_CENTER);
        cellHeader.setBackgroundColor(BaseColor.LIGHT_GRAY);
        resumenTable.addCell(cellHeader);
        
        cellHeader = new PdfPCell(new Phrase("SALDO ANTERIOR", fontTableHeader));
        cellHeader.setHorizontalAlignment(Element.ALIGN_CENTER);
        cellHeader.setBackgroundColor(BaseColor.LIGHT_GRAY);
        resumenTable.addCell(cellHeader);
        
        cellHeader = new PdfPCell(new Phrase("ENTRADAS", fontTableHeader));
        cellHeader.setHorizontalAlignment(Element.ALIGN_CENTER);
        cellHeader.setBackgroundColor(BaseColor.LIGHT_GRAY);
        resumenTable.addCell(cellHeader);
        
        cellHeader = new PdfPCell(new Phrase("SALIDAS", fontTableHeader));
        cellHeader.setHorizontalAlignment(Element.ALIGN_CENTER);
        cellHeader.setBackgroundColor(BaseColor.LIGHT_GRAY);
        resumenTable.addCell(cellHeader);
        
        // Datos del resumen
        Font fontTableData = FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL);
        
        resumenTable.addCell(new PdfPCell(new Phrase("CANTIDAD", fontTableData)));
        
        PdfPCell cellSaldo = new PdfPCell(new Phrase(formatoCantidad.format(saldoAnterior), fontTableData));
        cellSaldo.setHorizontalAlignment(Element.ALIGN_RIGHT);
        resumenTable.addCell(cellSaldo);
        
        PdfPCell cellEntradas = new PdfPCell(new Phrase(formatoCantidad.format(entradas), fontTableData));
        cellEntradas.setHorizontalAlignment(Element.ALIGN_RIGHT);
        resumenTable.addCell(cellEntradas);
        
        PdfPCell cellSalidas = new PdfPCell(new Phrase(formatoCantidad.format(salidas), fontTableData));
        cellSalidas.setHorizontalAlignment(Element.ALIGN_RIGHT);
        resumenTable.addCell(cellSalidas);
        
        document.add(resumenTable);
        
        document.add(new Paragraph(" "));
        
        // Saldo final
        Paragraph saldoFinalP = new Paragraph("SALDO FINAL: " + formatoCantidad.format(saldoFinal), fontBold);
        document.add(saldoFinalP);
        
        document.add(new Paragraph(" "));
        
        // Tabla de movimientos del mes
        if (!movimientos.isEmpty()) {
            Paragraph movimientosTitle = new Paragraph("MOVIMIENTOS DEL MES:", fontBold);
            document.add(movimientosTitle);
            
            document.add(new Paragraph(" "));
            
            PdfPTable table = new PdfPTable(10);
            table.setWidthPercentage(100);
            table.setWidths(new float[]{1f, 1.5f, 2f, 2f, 2f, 2f, 1.5f, 1.5f, 1.5f, 1.5f});
            
            // Headers de la tabla
            String[] headers = {"FECHA", "TIPO", "No. FACTURA", "PROVEEDOR", 
                               "No. REQUISICIÓN", "SERVICIO", "CANTIDAD", "PRECIO UNIT.", "F. VENCIMIENTO", "LOTE"};
            
            for (String header : headers) {
                cellHeader = new PdfPCell(new Phrase(header, fontTableHeader));
                cellHeader.setHorizontalAlignment(Element.ALIGN_CENTER);
                cellHeader.setBackgroundColor(BaseColor.LIGHT_GRAY);
                table.addCell(cellHeader);
            }
            
            // Datos de la tabla
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            
            for (MovimientoInsumo mov : movimientos) {
                // Fecha
                table.addCell(new PdfPCell(new Phrase(sdf.format(mov.getFecha()), fontTableData)));
                
                // Tipo
                String tipo = "EGRESO".equals(mov.getTipoMovimiento()) ? "SALIDA" : "ENTRADA";
                table.addCell(new PdfPCell(new Phrase(tipo, fontTableData)));
                
                // No. Factura
                table.addCell(new PdfPCell(new Phrase(mov.getNumeroFactura() != null ? mov.getNumeroFactura() : "", fontTableData)));
                
                // Proveedor
                table.addCell(new PdfPCell(new Phrase(mov.getProveedor() != null ? mov.getProveedor() : "", fontTableData)));
                
                // No. Requisición
                table.addCell(new PdfPCell(new Phrase(mov.getNoRequisicion() != null ? mov.getNoRequisicion() : "", fontTableData)));
                
                // Servicio
                table.addCell(new PdfPCell(new Phrase(mov.getServicio() != null ? mov.getServicio() : "", fontTableData)));
                
                // Cantidad
                PdfPCell cellCantidad = new PdfPCell(new Phrase(formatoCantidad.format(mov.getCantidad()), fontTableData));
                cellCantidad.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cellCantidad);
                
                // Precio Unitario
                PdfPCell cellPrecio = new PdfPCell(new Phrase(formatoNumero.format(mov.getPrecioUnitario()), fontTableData));
                cellPrecio.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cellPrecio);
                
                // Fecha Vencimiento
                String fechaVenc = mov.getFechaVencimiento() != null ? sdf.format(mov.getFechaVencimiento()) : "";
                table.addCell(new PdfPCell(new Phrase(fechaVenc, fontTableData)));
                
                // Lote
                table.addCell(new PdfPCell(new Phrase(mov.getLote() != null ? mov.getLote() : "", fontTableData)));
            }
            
            document.add(table);
        } else {
            Paragraph noMovimientos = new Paragraph("No se registraron movimientos en este mes.", fontTableData);
            document.add(noMovimientos);
        }
        
        document.close();
    }
}