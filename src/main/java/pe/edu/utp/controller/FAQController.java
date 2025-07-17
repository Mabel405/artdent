package pe.edu.utp.controller;

import pe.edu.utp.dao.FAQDAO;
import pe.edu.utp.dao.ServicioDAO;
import pe.edu.utp.daoimpl.FAQDAOImpl;
import pe.edu.utp.daoimpl.ServicioDAOImpl;
import pe.edu.utp.entity.FAQ;
import pe.edu.utp.entity.Servicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/faq")
public class FAQController extends HttpServlet {
    private FAQDAO faqDAO;
    private ServicioDAO servicioDAO;
    
    @Override
    public void init() throws ServletException {
        faqDAO = new FAQDAOImpl();
        servicioDAO = new ServicioDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String servicioParam = request.getParameter("servicio");
        
        List<FAQ> faqs;
        List<Servicio> servicios = servicioDAO.listarServicios();
        
        if (servicioParam != null && !servicioParam.isEmpty()) {
            try {
                int servicioId = Integer.parseInt(servicioParam);
                faqs = faqDAO.listarFAQsPorServicio(servicioId);
            request.setAttribute("servicioSeleccionado", servicioId);
            } catch (NumberFormatException e) {
                faqs = faqDAO.listarFAQsActivos();
            }
        } else {
            faqs = faqDAO.listarFAQsActivos();
        }
        
        request.setAttribute("faqs", faqs);
        request.setAttribute("servicios", servicios);
        request.getRequestDispatcher("/WEB-INF/views/faq.jsp").forward(request, response);
    }
}
