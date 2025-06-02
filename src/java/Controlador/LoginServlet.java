/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelo.usuario;
import ModeloDAO.DaoUsuario;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


public class LoginServlet extends HttpServlet {

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // Obtener los datos del formulario
    String usernameForm = request.getParameter("txtUsuario");
    String passwordForm = request.getParameter("txtPassword");

    // Validar que los campos no estén vacíos
    if (usernameForm == null || usernameForm.trim().isEmpty() ||
        passwordForm == null || passwordForm.trim().isEmpty()) {
        request.setAttribute("error", "Ambos campos son obligatorios.");
        request.getRequestDispatcher("authentication-login.jsp").forward(request, response);
        return;
    }

    // Crear el objeto Usuario con los datos ingresados
    usuario usu = new usuario();
    usu.setNombreUsuario(usernameForm);
    usu.setClave(passwordForm);

    // Consultar el DAO: si las credenciales son correctas, retorna el objeto usuario; si no, retorna null.
    DaoUsuario daoUsuario = new DaoUsuario();
    usuario usuIdentificado = null;
    try {
        usuIdentificado = daoUsuario.identificar(usu);
    } catch (Exception ex) {
        Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        request.setAttribute("error", "Base de datos fuera de linea, contacte a soporte.");
        request.getRequestDispatcher("authentication-login.jsp").forward(request, response);
        return;
    }

    // Si el DAO retornó un usuario, las credenciales son correctas
    if (usuIdentificado != null) {
        HttpSession session = request.getSession();
        session.setAttribute("usuario", usuIdentificado);
        response.sendRedirect("index.jsp"); // Redirige a la página principal
    } else {
        // Si el objeto es null, las credenciales son incorrectas
        request.setAttribute("error", "Usuario o contraseña incorrectos.");
        request.getRequestDispatcher("authentication-login.jsp").forward(request, response);
    }
}

    // Procesar solicitudes GET redirigiendo al login
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("authentication-login.jsp");
    }
}