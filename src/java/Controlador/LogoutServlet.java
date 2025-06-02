
package Controlador;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

//@WebServlet("/logout") // Mapea el servlet a la URL /logout
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener la sesión actual (si existe) y invalidarla
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        // Redirigir al usuario a la página de login
        response.sendRedirect("authentication-login.jsp");
    }
}