<%@ page contentType="image/png" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="com.google.zxing.MultiFormatWriter" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%
    // Recupera y valida el parámetro 'code'
    String codeParam = request.getParameter("code");
    if (codeParam == null || codeParam.trim().isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetro 'code' requerido");
        return;
    }
    codeParam = codeParam.trim();
    
    // Configuración del tamaño de la imagen del código de barras
    int width = 300;  // Ancho deseado (ajusta según se necesite)
    int height = 100; // Alto deseado

    try {
        // Genera el código de barras utilizando ZXing
        MultiFormatWriter writer = new MultiFormatWriter();
        BitMatrix bitMatrix = writer.encode(codeParam, BarcodeFormat.CODE_128, width, height);
        
        // Crea un BufferedImage para pintar la imagen del código de barras
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                // Pinta los píxeles: negro para los bits activos, blanco para los inactivos.
                image.setRGB(x, y, bitMatrix.get(x, y) ? 0xFF000000 : 0xFFFFFFFF);
            }
        }
        // Escribe la imagen en la respuesta HTTP en formato PNG
        ImageIO.write(image, "png", response.getOutputStream());
    } catch (Exception e) {
        // Registro de error y envío de error HTTP en caso de fallo durante la generación
        e.printStackTrace();
        response.sendError(response.SC_INTERNAL_SERVER_ERROR, "Error generando el código de barras");
    }
%>
