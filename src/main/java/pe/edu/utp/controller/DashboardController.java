package pe.edu.utp.controller;

import pe.edu.utp.dao.ReservaDAO;
import pe.edu.utp.dao.PacienteDAO;
import pe.edu.utp.dao.ServicioDAO;
import pe.edu.utp.dao.UsuarioDAO;
import pe.edu.utp.daoimpl.ReservaDAOImpl;
import pe.edu.utp.daoimpl.PacienteDAOImpl;
import pe.edu.utp.daoimpl.ServicioDAOImpl;
import pe.edu.utp.daoimpl.UsuarioDAOImpl;
import pe.edu.utp.entity.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/admin-dashboard")
public class DashboardController extends HttpServlet {
    private ReservaDAO reservaDAO;
    private PacienteDAO pacienteDAO;
    private ServicioDAO servicioDAO;
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() throws ServletException {
        reservaDAO = new ReservaDAOImpl();
        pacienteDAO = new PacienteDAOImpl();
        servicioDAO = new ServicioDAOImpl();
        usuarioDAO = new UsuarioDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Verificar autenticación
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("../login");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Verificar permisos (solo admin, recepcionista y odontólogo)
        if (usuario.getRolIdRol() != 1 && usuario.getRolIdRol() != 2 && usuario.getRolIdRol() != 3) {
            response.sendRedirect("../inicio");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("reservas".equals(action)) {
            mostrarReservas(request, response);
        } else if ("confirmar".equals(action)) {
            confirmarReserva(request, response);
        } else if ("cancelar".equals(action)) {
            cancelarReserva(request, response);
        } else {
            mostrarDashboard(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void mostrarDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Estadísticas generales
        int totalReservasPendientes = reservaDAO.contarReservasPorEstado(1);
        int totalPacientes = pacienteDAO.listarPacientes().size();
        int totalServicios = servicioDAO.listarServicios().size();
        int totalOdontologos = usuarioDAO.listarOdontologos().size();
        
        // Reservas pendientes recientes
        var reservasPendientes = reservaDAO.obtenerReservasPendientes();
        if (reservasPendientes.size() > 5) {
            reservasPendientes = reservasPendientes.subList(0, 5);
        }
        
        request.setAttribute("totalReservasPendientes", totalReservasPendientes);
        request.setAttribute("totalPacientes", totalPacientes);
        request.setAttribute("totalServicios", totalServicios);
        request.setAttribute("totalOdontologos", totalOdontologos);
        request.setAttribute("reservasPendientes", reservasPendientes);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
    
    private void mostrarReservas(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        var todasLasReservas = reservaDAO.listarReservasDTO();
        request.setAttribute("reservas", todasLasReservas);
        request.getRequestDispatcher("/WEB-INF/views/admin/reservas.jsp").forward(request, response);
    }
    
    private void confirmarReserva(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("id"));
            boolean success = reservaDAO.confirmarReserva(idReserva);
            if (!success) {
                System.out.println("Error al confirmar reserva: " + idReserva);
            }
        } catch (NumberFormatException e) {
            System.out.println("Error al procesar confirmación: " + e.getMessage());
        }
        response.sendRedirect("admin-dashboard?action=reservas");
    }
    
    private void cancelarReserva(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("id"));
            boolean success = reservaDAO.cancelarReserva(idReserva);
            if (!success) {
                System.out.println("Error al cancelar reserva: " + idReserva);
            }
        } catch (NumberFormatException e) {
            System.out.println("Error al procesar cancelación: " + e.getMessage());
        }
        response.sendRedirect("admin-dashboard?action=reservas");
    }
}
