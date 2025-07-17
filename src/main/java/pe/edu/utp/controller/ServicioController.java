package pe.edu.utp.controller;

import pe.edu.utp.dao.ServicioDAO;
import pe.edu.utp.daoimpl.ServicioDAOImpl;
import pe.edu.utp.entity.Servicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/servicios")
public class ServicioController extends HttpServlet {
    private ServicioDAO servicioDAO;
    
    @Override
    public void init() throws ServletException {
        servicioDAO = new ServicioDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("detalle".equals(action)) {
            mostrarDetalleServicio(request, response);
        } else {
            listarServicios(request, response);
        }
    }
    
    private void listarServicios(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Servicio> servicios = servicioDAO.listarServicios();
        request.setAttribute("servicios", servicios);
        request.getRequestDispatcher("/WEB-INF/views/servicios.jsp").forward(request, response);
    }
    
    private void mostrarDetalleServicio(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Servicio servicio = servicioDAO.obtenerServicioPorId(id);
            
            if (servicio != null) {
                request.setAttribute("servicio", servicio);
                request.getRequestDispatcher("/WEB-INF/views/detalle-servicio.jsp").forward(request, response);
            } else {
                response.sendRedirect("servicios");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("servicios");
        }
    }
}
