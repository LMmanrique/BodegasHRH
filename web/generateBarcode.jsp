<%@ page contentType="image/png" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="com.google.zxing.MultiFormatWriter" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%
    // Recupera y valida el par�metro 'code'
    String codeParam = request.getParameter("code");
    if (codeParam == null || codeParam.trim().isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Par�metro 'code' requerido");
        return;
    }
    codeParam = codeParam.trim();
    
    // Configuraci�n del tama�o de la imagen del c�digo de barras
    int width = 300;  // Ancho deseado (ajusta seg�n se necesite)
    int height = 100; // Alto deseado

    try {
        // Genera el c�digo de barras utilizando ZXing
        MultiFormatWriter writer = new MultiFormatWriter();
        BitMatrix bitMatrix = writer.encode(codeParam, BarcodeFormat.CODE_128, width, height);
        
        // Crea un BufferedImage para pintar la imagen del c�digo de barras
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                // Pinta los p�xeles: negro para los bits activos, blanco para los inactivos.
                image.setRGB(x, y, bitMatrix.get(x, y) ? 0xFF000000 : 0xFFFFFFFF);
            }
        }
        // Escribe la imagen en la respuesta HTTP en formato PNG
        ImageIO.write(image, "png", response.getOutputStream());
    } catch (Exception e) {
        // Registro de error y env�o de error HTTP en caso de fallo durante la generaci�n
        e.printStackTrace();
        response.sendError(response.SC_INTERNAL_SERVER_ERROR, "Error generando el c�digo de barras");
    }
%>
