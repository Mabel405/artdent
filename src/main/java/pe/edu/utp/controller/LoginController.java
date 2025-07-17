package pe.edu.utp.controller;

import pe.edu.utp.dto.LoginDTO;
import pe.edu.utp.entity.Usuario;
import pe.edu.utp.service.AuthService;
import pe.edu.utp.service.impl.AuthServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(LoginController.class.getName());
    private AuthService authService;
    
    @Override
    public void init() throws ServletException {
        this.authService = new AuthServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            logout(request, response);
        } else {
            // Verificar si ya está logueado
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("usuario") != null) {
                Usuario usuario = (Usuario) session.getAttribute("usuario");
                String ruta = authService.obtenerRutaSegunRol(usuario.getRolIdRol());
                response.sendRedirect(request.getContextPath() + "/" + ruta);
            } else {
                // Verificar si viene de un logout exitoso
                String logoutParam = request.getParameter("logout");
                if ("success".equals(logoutParam)) {
                    request.setAttribute("logoutSuccess", true);
                }
                
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");
        
        LoginDTO loginResult = authService.autenticar(correo, clave);
        
        if (loginResult.isExitoso()) {
            // Login exitoso - crear sesión
            HttpSession session = request.getSession(true);
            
            // Obtener el usuario completo para la sesión
            pe.edu.utp.dao.UsuarioDAO usuarioDAO = new pe.edu.utp.daoimpl.UsuarioDAOImpl();
            Usuario usuario = usuarioDAO.obtenerUsuarioPorCredenciales(correo.trim(), clave.trim());
            
            // Establecer atributos de sesión
            session.setAttribute("usuario", usuario);
            session.setAttribute("nombreCompleto", loginResult.getNombreCompleto());
            session.setAttribute("rolId", loginResult.getRolId());
            
            // Log del login exitoso
            logger.info("Login exitoso para usuario: " + correo + " - Rol: " + loginResult.getRolId());
            
            // Determinar la ruta de redirección
            String ruta = authService.obtenerRutaSegunRol(loginResult.getRolId());
            
            // Redirigir con parámetro de éxito
            response.sendRedirect(request.getContextPath() + "/" + ruta + "?login=success");
        } else {
            // Login fallido
            logger.warning("Login fallido para usuario: " + correo + " - Motivo: " + loginResult.getMensaje());
            
            request.setAttribute("error", loginResult.getMensaje());
            request.setAttribute("correo", correo); // Mantener el correo en el formulario
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession(false);
        String usuarioEmail = null;
        
        if (session != null) {
            // Obtener información del usuario antes de invalidar la sesión
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            if (usuario != null) {
                usuarioEmail = usuario.getCorreoElectronico();
            }
            
            // Invalidar la sesión
            session.invalidate();
        }
        
        // Llamar al servicio de autenticación
        authService.cerrarSesion();
        
        // Log del logout
        if (usuarioEmail != null) {
            logger.info("Logout exitoso para usuario: " + usuarioEmail);
        }
        
        // Redirigir a inicio con mensaje de logout exitoso
        response.sendRedirect(request.getContextPath() + "/inicio?logout=success");
    }
}