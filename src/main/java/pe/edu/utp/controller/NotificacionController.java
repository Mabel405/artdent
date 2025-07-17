package pe.edu.utp.controller;

import pe.edu.utp.dao.NotificacionReservaDAO;
import pe.edu.utp.dao.ReservaDAO;
import pe.edu.utp.daoimpl.NotificacionReservaDAOImpl;
import pe.edu.utp.daoimpl.ReservaDAOImpl;
import pe.edu.utp.entity.NotificacionReserva;
import pe.edu.utp.entity.Usuario;
import pe.edu.utp.dto.ReservaDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet("/admin/notificaciones")
public class NotificacionController extends HttpServlet {
    private NotificacionReservaDAO notificacionDAO;
    private ReservaDAO reservaDAO;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        notificacionDAO = new NotificacionReservaDAOImpl();
        reservaDAO = new ReservaDAOImpl();
        gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd HH:mm:ss")
                .serializeNulls()
                .create();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("../login");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String action = request.getParameter("action");
        
        if (action == null) action = "list";
        
        switch (action) {
            case "list":
                mostrarNotificaciones(request, response, usuario);
                break;
            case "api":
                obtenerNotificacionesAPI(request, response, usuario);
                break;
            case "count":
                contarNotificaciones(request, response, usuario);
                break;
            case "urgentes":
                obtenerNotificacionesUrgentes(request, response, usuario);
                break;
            case "hoy":
                obtenerNotificacionesHoy(request, response, usuario);
                break;
            case "proximas":
                obtenerCitasProximas(request, response, usuario);
                break;
            case "estado":
                obtenerPorEstado(request, response, usuario);
                break;
            case "odontologo":
                obtenerPorOdontologo(request, response, usuario);
                break;
            case "stats":
                obtenerEstadisticas(request, response, usuario);
                break;
            case "detalle":
                obtenerDetalleReserva(request, response);
                break;
            default:
                mostrarNotificaciones(request, response, usuario);
        }
    }
    
    private void mostrarNotificaciones(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws ServletException, IOException {
        
        String tipoFiltro = request.getParameter("tipo");
        String prioridadFiltro = request.getParameter("prioridad");
        String actionParam = request.getParameter("action");
        int diasAtras = 7;
        
        try {
            String diasParam = request.getParameter("dias");
            if (diasParam != null) {
                diasAtras = Integer.parseInt(diasParam);
            }
        } catch (NumberFormatException e) {
            diasAtras = 7;
        }
        
        System.out.println("=== DEBUG CONTROLLER - mostrarNotificaciones ===");
        System.out.println("Usuario rol: " + usuario.getRolIdRol());
        System.out.println("Tipo filtro: " + tipoFiltro);
        System.out.println("Prioridad filtro: " + prioridadFiltro);
        System.out.println("Action param: " + actionParam);
        System.out.println("Días atrás: " + diasAtras);
        
        List<NotificacionReserva> notificaciones;
        
        // FORZAR CONSULTA DE URGENTES PARA TESTING
        if ("urgentes".equals(actionParam)) {
            System.out.println("EJECUTANDO CONSULTA DE URGENTES...");
            notificaciones = notificacionDAO.listarNotificacionesUrgentes();
            System.out.println("Urgentes del DAO: " + notificaciones.size());
        } else {
            // Obtener notificaciones según el rol del usuario
            if (usuario.getRolIdRol() == 3) {
                notificaciones = notificacionDAO.listarNotificacionesPorOdontologo(usuario.getIdUsuario());
            } else {
                if (tipoFiltro != null && !tipoFiltro.isEmpty()) {
                    try {
                        int estado = Integer.parseInt(tipoFiltro);
                        notificaciones = notificacionDAO.listarNotificacionesPorEstado(estado);
                    } catch (NumberFormatException e) {
                        notificaciones = notificacionDAO.listarNotificacionesRecientes(diasAtras);
                    }
                } else {
                    notificaciones = notificacionDAO.listarNotificacionesRecientes(diasAtras);
                }
            }
        }
        
        System.out.println("Notificaciones obtenidas del DAO: " + notificaciones.size());
        
        // IMPORTANTE: Calcular datos de notificación para TODAS las notificaciones
        for (NotificacionReserva notif : notificaciones) {
            System.out.println("Procesando reserva ID: " + notif.getIdReserva());
            notif.calcularDatosNotificacion(); // Esto llama a determinarUrgencia()
        }
        
        // Contar urgentes después del cálculo
        int urgentesCalculados = (int) notificaciones.stream().filter(NotificacionReserva::isEsUrgente).count();
        System.out.println("Urgentes después del cálculo Java: " + urgentesCalculados);
        
        // Si es consulta de urgentes, filtrar solo los urgentes
        if ("urgentes".equals(actionParam)) {
            notificaciones = notificaciones.stream()
                    .filter(NotificacionReserva::isEsUrgente)
                    .collect(Collectors.toList());
            System.out.println("Filtrado solo urgentes: " + notificaciones.size());
        } else if ("hoy".equals(actionParam)) {
            notificaciones = notificaciones.stream()
                    .filter(NotificacionReserva::isEsReciente)
                    .collect(Collectors.toList());
        }
        
        // Aplicar filtro de prioridad DESPUÉS del cálculo
        if (prioridadFiltro != null && !prioridadFiltro.isEmpty()) {
            final String prioridad = prioridadFiltro.toUpperCase();
            notificaciones = notificaciones.stream()
                    .filter(n -> prioridad.equals(n.getPrioridad()))
                    .collect(Collectors.toList());
        }
        
        // Contar diferentes tipos DESPUÉS del cálculo
        int totalRecientes = 0;
        int urgentes = 0;
        int hoy = 0;
        int nuevas = 0;
        int canceladas = 0;
        
        // Si no hay filtros aplicados, obtener conteos globales
        if (tipoFiltro == null && prioridadFiltro == null && actionParam == null) {
            List<NotificacionReserva> todasLasNotificaciones;
            if (usuario.getRolIdRol() == 3) {
                todasLasNotificaciones = notificacionDAO.listarNotificacionesPorOdontologo(usuario.getIdUsuario());
            } else {
                todasLasNotificaciones = notificacionDAO.listarNotificacionesRecientes(diasAtras);
            }
            
            for (NotificacionReserva notif : todasLasNotificaciones) {
                notif.calcularDatosNotificacion();
            }
            
            totalRecientes = todasLasNotificaciones.size();
            urgentes = (int) todasLasNotificaciones.stream().filter(NotificacionReserva::isEsUrgente).count();
            hoy = (int) todasLasNotificaciones.stream().filter(NotificacionReserva::isEsReciente).count();
            nuevas = (int) todasLasNotificaciones.stream().filter(n -> n.getTipoEstado() == 1).count();
            canceladas = (int) todasLasNotificaciones.stream().filter(n -> n.getTipoEstado() == 3).count();
        } else {
            totalRecientes = notificaciones.size();
            for (NotificacionReserva notif : notificaciones) {
                if (notif.isEsUrgente()) {
                    urgentes++;
                }
                if (notif.isEsReciente()) {
                    hoy++;
                }
                if (notif.getTipoEstado() == 1) {
                    nuevas++;
                }
                if (notif.getTipoEstado() == 3) {
                    canceladas++;
                }
            }
        }
        
        System.out.println("=== CONTEOS FINALES ===");
        System.out.println("Total recientes: " + totalRecientes);
        System.out.println("Urgentes: " + urgentes);
        System.out.println("Hoy: " + hoy);
        System.out.println("Nuevas: " + nuevas);
        System.out.println("Canceladas: " + canceladas);
        
        request.setAttribute("notificaciones", notificaciones);
        request.setAttribute("totalRecientes", totalRecientes);
        request.setAttribute("urgentes", urgentes);
        request.setAttribute("hoy", hoy);
        request.setAttribute("nuevas", nuevas);
        request.setAttribute("canceladas", canceladas);
        request.setAttribute("tipoFiltro", tipoFiltro);
        request.setAttribute("prioridadFiltro", prioridadFiltro);
        request.setAttribute("diasAtras", diasAtras);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/notificaciones/list.jsp").forward(request, response);
    }
    
    private void obtenerNotificacionesAPI(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        List<NotificacionReserva> notificaciones;
        
        if (usuario.getRolIdRol() == 3) {
            notificaciones = notificacionDAO.listarNotificacionesPorOdontologo(usuario.getIdUsuario());
        } else {
            notificaciones = notificacionDAO.listarNotificacionesRecientes(1);
        }
        
        // IMPORTANTE: Calcular datos de notificación
        for (NotificacionReserva notif : notificaciones) {
            notif.calcularDatosNotificacion();
        }
        
        if (notificaciones.size() > 10) {
            notificaciones = notificaciones.subList(0, 10);
        }
        
        int count = (int) notificaciones.stream().filter(NotificacionReserva::isEsReciente).count();
        int urgentes = (int) notificaciones.stream().filter(NotificacionReserva::isEsUrgente).count();
        
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("notificaciones", notificaciones);
        responseData.put("count", count);
        responseData.put("urgentes", urgentes);
        responseData.put("timestamp", System.currentTimeMillis());
        
        writeJsonResponse(response, responseData);
    }
    
    private void contarNotificaciones(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        List<NotificacionReserva> notificaciones;
        if (usuario.getRolIdRol() == 3) {
            notificaciones = notificacionDAO.listarNotificacionesPorOdontologo(usuario.getIdUsuario());
        } else {
            notificaciones = notificacionDAO.listarNotificacionesRecientes(7);
        }
        
        // Calcular datos
        for (NotificacionReserva notif : notificaciones) {
            notif.calcularDatosNotificacion();
        }
        
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("count", (int) notificaciones.stream().filter(NotificacionReserva::isEsReciente).count());
        responseData.put("urgentes", (int) notificaciones.stream().filter(NotificacionReserva::isEsUrgente).count());
        responseData.put("hoy", (int) notificaciones.stream().filter(NotificacionReserva::isEsReciente).count());
        
        writeJsonResponse(response, responseData);
    }
    
    private void obtenerNotificacionesUrgentes(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws IOException {
        
        System.out.println("=== DEBUG CONTROLLER - obtenerNotificacionesUrgentes ===");
        
        List<NotificacionReserva> urgentes = notificacionDAO.listarNotificacionesUrgentes();
        
        System.out.println("Urgentes del DAO: " + urgentes.size());
        
        // Calcular datos de notificación y filtrar solo urgentes
        urgentes = urgentes.stream()
                .peek(notif -> {
                    notif.calcularDatosNotificacion();
                    System.out.println("Procesada ID: " + notif.getIdReserva() + 
                                     ", Es urgente: " + notif.isEsUrgente());
                })
                .filter(NotificacionReserva::isEsUrgente)
                .collect(Collectors.toList());
        
        System.out.println("Urgentes finales: " + urgentes.size());
        
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("notificaciones", urgentes);
        responseData.put("count", urgentes.size());
        
        writeJsonResponse(response, responseData);
    }
    
    private void obtenerNotificacionesHoy(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws IOException {
        
        List<NotificacionReserva> hoy = notificacionDAO.listarNotificacionesHoy();
        
        // Calcular datos de notificación
        for (NotificacionReserva notif : hoy) {
            notif.calcularDatosNotificacion();
        }
        
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("notificaciones", hoy);
        responseData.put("count", hoy.size());
        
        writeJsonResponse(response, responseData);
    }
    
    private void obtenerCitasProximas(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws IOException {
        
        int dias = 3;
        try {
            String diasParam = request.getParameter("dias");
            if (diasParam != null) {
                dias = Integer.parseInt(diasParam);
            }
        } catch (NumberFormatException e) {
            dias = 3;
        }
        
        List<NotificacionReserva> proximas = notificacionDAO.listarNotificacionesProximasCitas(dias);
        
        // Calcular datos de notificación
        for (NotificacionReserva notif : proximas) {
            notif.calcularDatosNotificacion();
        }
        
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("notificaciones", proximas);
        responseData.put("count", proximas.size());
        responseData.put("dias", dias);
        
        writeJsonResponse(response, responseData);
    }
    
    private void obtenerPorEstado(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws IOException {
        
        try {
            int estado = Integer.parseInt(request.getParameter("estado"));
            List<NotificacionReserva> notificaciones = notificacionDAO.listarNotificacionesPorEstado(estado);
            
            // Calcular datos de notificación
            for (NotificacionReserva notif : notificaciones) {
                notif.calcularDatosNotificacion();
            }
            
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("notificaciones", notificaciones);
            responseData.put("count", notificaciones.size());
            responseData.put("estado", estado);
            
            writeJsonResponse(response, responseData);
        } catch (NumberFormatException e) {
            writeErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Estado inválido");
        }
    }
    
    private void obtenerPorOdontologo(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws IOException {
        
        try {
            int idOdontologo = Integer.parseInt(request.getParameter("odontologo"));
            List<NotificacionReserva> notificaciones = notificacionDAO.listarNotificacionesPorOdontologo(idOdontologo);
            
            // Calcular datos de notificación
            for (NotificacionReserva notif : notificaciones) {
                notif.calcularDatosNotificacion();
            }
            
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("notificaciones", notificaciones);
            responseData.put("count", notificaciones.size());
            responseData.put("odontologo", idOdontologo);
            
            writeJsonResponse(response, responseData);
        } catch (NumberFormatException e) {
            writeErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID de odontólogo inválido");
        }
    }
    
    private void obtenerEstadisticas(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws IOException {
        
        List<NotificacionReserva> todasLasNotificaciones;
        if (usuario.getRolIdRol() == 3) {
            todasLasNotificaciones = notificacionDAO.listarNotificacionesPorOdontologo(usuario.getIdUsuario());
        } else {
            todasLasNotificaciones = notificacionDAO.listarNotificacionesRecientes(30);
        }
        
        // Calcular datos de notificación
        for (NotificacionReserva notif : todasLasNotificaciones) {
            notif.calcularDatosNotificacion();
        }
        
        Map<String, Integer> stats = new HashMap<>();
        stats.put("recientes", (int) todasLasNotificaciones.stream().filter(NotificacionReserva::isEsReciente).count());
        stats.put("urgentes", (int) todasLasNotificaciones.stream().filter(NotificacionReserva::isEsUrgente).count());
        stats.put("hoy", (int) todasLasNotificaciones.stream().filter(NotificacionReserva::isEsReciente).count());
        stats.put("nuevas", (int) todasLasNotificaciones.stream().filter(n -> n.getTipoEstado() == 1).count());
        stats.put("confirmadas", (int) todasLasNotificaciones.stream().filter(n -> n.getTipoEstado() == 2).count());
        stats.put("canceladas", (int) todasLasNotificaciones.stream().filter(n -> n.getTipoEstado() == 3).count());
        stats.put("reprogramadas", (int) todasLasNotificaciones.stream().filter(n -> n.getTipoEstado() == 4).count());
        
        writeJsonResponse(response, stats);
    }
    
    private void obtenerDetalleReserva(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            writeErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Parámetro 'id' requerido");
            return;
        }
        
        try {
            int idReserva = Integer.parseInt(idParam.trim());
            ReservaDTO reserva = reservaDAO.obtenerDetalleCompletoParaNotificacion(idReserva);
            
            if (reserva != null) {
                writeJsonResponse(response, reserva);
            } else {
                writeErrorResponse(response, HttpServletResponse.SC_NOT_FOUND, "Reserva no encontrada");
            }
        } catch (NumberFormatException e) {
            writeErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID de reserva inválido: " + idParam);
        } catch (Exception e) {
            writeErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
        }
    }
    
    // Métodos auxiliares para manejo de respuestas JSON
    private void writeJsonResponse(HttpServletResponse response, Object data) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(data));
            out.flush();
        }
    }
    
    private void writeErrorResponse(HttpServletResponse response, int status, String message) throws IOException {
        response.setStatus(status);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Map<String, String> error = new HashMap<>();
        error.put("error", message);
        
        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(error));
            out.flush();
        }
    }
}