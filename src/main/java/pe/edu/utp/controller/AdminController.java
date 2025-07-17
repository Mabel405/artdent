package pe.edu.utp.controller;

import pe.edu.utp.dao.*;
import pe.edu.utp.daoimpl.*;
import pe.edu.utp.entity.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/admin/admin")
public class AdminController extends HttpServlet {

    private UsuarioDAO usuarioDAO;
    private PacienteDAO pacienteDAO;
    private ServicioDAO servicioDAO;
    private FAQDAO faqDAO;
    private ReservaDAO reservaDAO;
    private UsuarioServicioDAO usuarioServicioDAO;

    @Override
    public void init() throws ServletException {
        usuarioDAO = new UsuarioDAOImpl();
        pacienteDAO = new PacienteDAOImpl();
        servicioDAO = new ServicioDAOImpl();
        faqDAO = new FAQDAOImpl();
        reservaDAO = new ReservaDAOImpl();
        usuarioServicioDAO = new UsuarioServicioDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar autenticación y permisos de administrador
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("../login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario.getRolIdRol() != 1) { // Solo administradores
            response.sendRedirect("../inicio");
            return;
        }

        String action = request.getParameter("action");
        String section = request.getParameter("section");

        if (action == null) {
            action = "dashboard";
        }

        switch (action) {
            case "dashboard":
                mostrarDashboard(request, response);
                break;
            case "list":
                listarEntidades(request, response, section);
                break;
            case "new":
                mostrarFormularioNuevo(request, response, section);
                break;
            case "edit":
                mostrarFormularioEditar(request, response, section);
                break;
            case "delete":
                eliminarEntidad(request, response, section);
                break;
            case "toggle":
                toggleEstadoEntidad(request, response, section);
                break;
            default:
                mostrarDashboard(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String section = request.getParameter("section");

        switch (action) {
            case "create":
                crearEntidad(request, response, section);
                break;
            case "update":
                actualizarEntidad(request, response, section);
                break;
            default:
                doGet(request, response);
        }
    }

    private void mostrarDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Estadísticas generales
        int totalUsuarios = usuarioDAO.listarUsuarios().size();
        int totalPacientes = pacienteDAO.listarPacientes().size();
        int totalServicios = servicioDAO.listarServicios().size();
        int totalFAQs = faqDAO.listarFAQsActivos().size();
        int totalReservas = reservaDAO.listarReservas().size();
        int reservasPendientes = reservaDAO.contarReservasPendientes();

        request.setAttribute("totalUsuarios", totalUsuarios);
        request.setAttribute("totalPacientes", totalPacientes);
        request.setAttribute("totalServicios", totalServicios);
        request.setAttribute("totalFAQs", totalFAQs);
        request.setAttribute("totalReservas", totalReservas);
        request.setAttribute("reservasPendientes", reservasPendientes);

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    private void listarEntidades(HttpServletRequest request, HttpServletResponse response, String section)
            throws ServletException, IOException {

        switch (section) {
            case "usuarios":
                List<Usuario> usuarios = usuarioDAO.listarUsuarios();
                request.setAttribute("usuarios", usuarios);
                request.getRequestDispatcher("/WEB-INF/views/admin/usuarios/list.jsp").forward(request, response);
                break;
            case "pacientes":
                List<Paciente> pacientes = pacienteDAO.listarPacientes();
                request.setAttribute("pacientes", pacientes);
                request.getRequestDispatcher("/WEB-INF/views/admin/pacientes/list.jsp").forward(request, response);
                break;
            case "servicios":
                List<Servicio> servicios = servicioDAO.listarServicios();
                request.setAttribute("servicios", servicios);
                request.getRequestDispatcher("/WEB-INF/views/admin/servicios/list.jsp").forward(request, response);
                break;
            case "faq":
                List<FAQ> faqs = faqDAO.listarFAQs();
                List<Servicio> serviciosForFAQ = servicioDAO.listarServicios();
                request.setAttribute("faqs", faqs);
                request.setAttribute("servicios", serviciosForFAQ);
                request.getRequestDispatcher("/WEB-INF/views/admin/faq/list.jsp").forward(request, response);
                break;
            case "especializaciones":
                List<UsuarioServicio> especializaciones = usuarioServicioDAO.listarEspecializaciones();
                List<Usuario> odontologos = usuarioDAO.listarOdontologos();
                List<Servicio> serviciosEsp = servicioDAO.listarServicios();
                request.setAttribute("especializaciones", especializaciones);
                request.setAttribute("odontologos", odontologos);
                request.setAttribute("servicios", serviciosEsp);
                
                request.getRequestDispatcher("/WEB-INF/views/admin/especializaciones/list.jsp").forward(request, response);
                break;
        }
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response, String section)
            throws ServletException, IOException {
        List<Servicio> servicios = servicioDAO.listarServicios();
        switch (section) {
            case "usuarios":
                request.getRequestDispatcher("/WEB-INF/views/admin/usuarios/form.jsp").forward(request, response);
                break;
            case "pacientes":
                request.getRequestDispatcher("/WEB-INF/views/admin/pacientes/form.jsp").forward(request, response);
                break;
            case "servicios":
                request.getRequestDispatcher("/WEB-INF/views/admin/servicios/form.jsp").forward(request, response);
                break;
            case "faq":
                request.setAttribute("servicios", servicios);
                request.getRequestDispatcher("/WEB-INF/views/admin/faq/form.jsp").forward(request, response);
                break;
            case "especializaciones":
                List<Usuario> odontologos = usuarioDAO.listarOdontologos();
                request.setAttribute("odontologos", odontologos);
                request.setAttribute("servicios", servicios);
                request.getRequestDispatcher("/WEB-INF/views/admin/especializaciones/form.jsp").forward(request, response);
                break;
        }
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response, String section)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        switch (section) {
            case "usuarios":
                Usuario usuario = usuarioDAO.obtenerUsuarioPorId(id);
                request.setAttribute("usuario", usuario);
                request.setAttribute("isEdit", true);
                request.getRequestDispatcher("/WEB-INF/views/admin/usuarios/form.jsp").forward(request, response);
                break;
            case "pacientes":
                Paciente paciente = pacienteDAO.obtenerPacientePorId(id);
                request.setAttribute("paciente", paciente);
                request.setAttribute("isEdit", true);
                request.getRequestDispatcher("/WEB-INF/views/admin/pacientes/form.jsp").forward(request, response);
                break;
            case "servicios":
                Servicio servicio = servicioDAO.obtenerServicioPorId(id);
                request.setAttribute("servicio", servicio);
                request.setAttribute("isEdit", true);
                request.getRequestDispatcher("/WEB-INF/views/admin/servicios/form.jsp").forward(request, response);
                break;
            case "faq":
                FAQ faq = faqDAO.obtenerFAQPorId(id);
                List<Servicio> servicios = servicioDAO.listarServicios();
                request.setAttribute("faq", faq);
                request.setAttribute("servicios", servicios);
                request.setAttribute("isEdit", true);
                request.getRequestDispatcher("/WEB-INF/views/admin/faq/form.jsp").forward(request, response);
                break;
        }
    }

    private void crearEntidad(HttpServletRequest request, HttpServletResponse response, String section)
            throws ServletException, IOException {

        boolean success = false;

        switch (section) {
            case "usuarios":
                success = crearUsuario(request);
                break;
            case "pacientes":
                success = crearPaciente(request);
                break;
            case "servicios":
                success = crearServicio(request);
                break;
            case "faq":
                success = crearFAQ(request);
                break;
            case "especializaciones":
                success = crearEspecializacion(request);
                break;
        }

        if (success) {
            request.getSession().setAttribute("mensaje", "Registro creado exitosamente");
            request.getSession().setAttribute("tipoMensaje", "success");
        } else {
            request.getSession().setAttribute("mensaje", "Error al crear el registro");
            request.getSession().setAttribute("tipoMensaje", "error");
        }

        response.sendRedirect("admin?action=list&section=" + section);
    }

    private void actualizarEntidad(HttpServletRequest request, HttpServletResponse response, String section)
            throws ServletException, IOException {

        boolean success = false;

        switch (section) {
            case "usuarios":
                success = actualizarUsuario(request);
                break;
            case "pacientes":
                success = actualizarPaciente(request);
                break;
            case "servicios":
                success = actualizarServicio(request);
                break;
            case "faq":
                success = actualizarFAQ(request);
                break;
        }

        if (success) {
            request.getSession().setAttribute("mensaje", "Registro actualizado exitosamente");
            request.getSession().setAttribute("tipoMensaje", "success");
        } else {
            request.getSession().setAttribute("mensaje", "Error al actualizar el registro");
            request.getSession().setAttribute("tipoMensaje", "error");
        }

        response.sendRedirect("admin?action=list&section=" + section);
    }

    private void eliminarEntidad(HttpServletRequest request, HttpServletResponse response, String section)
            throws IOException {

        int id;
        boolean success = false;

        switch (section) {
            case "usuarios":
                id = Integer.parseInt(request.getParameter("id"));
                success = usuarioDAO.eliminarUsuario(id);
                break;
            case "pacientes":
                id = Integer.parseInt(request.getParameter("id"));
                success = pacienteDAO.eliminarPaciente(id);
                break;
            case "servicios":
                id = Integer.parseInt(request.getParameter("id"));
                success = servicioDAO.eliminarServicio(id);
                break;
            case "faq":
                id = Integer.parseInt(request.getParameter("id"));
                success = faqDAO.eliminarFAQ(id);
                break;
            case "especializaciones":
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                int idServicio = Integer.parseInt(request.getParameter("idServicio"));
                success = usuarioServicioDAO.eliminarEspecializacion(idUsuario, idServicio);
                break;
        }

        if (success) {
            request.getSession().setAttribute("mensaje", "Registro eliminado exitosamente");
            request.getSession().setAttribute("tipoMensaje", "success");
        } else {
            request.getSession().setAttribute("mensaje", "Error al eliminar el registro");
            request.getSession().setAttribute("tipoMensaje", "error");
        }

        response.sendRedirect("admin?action=list&section=" + section);
    }

    // Métodos auxiliares para crear entidades
    private boolean crearUsuario(HttpServletRequest request) {
        try {
            Usuario usuario = new Usuario();
            usuario.setNombre(request.getParameter("nombre"));
            usuario.setApellido(request.getParameter("apellido"));
            usuario.setDni(request.getParameter("dni"));
            usuario.setTelefono(request.getParameter("telefono"));
            usuario.setCorreoElectronico(request.getParameter("correo"));
            usuario.setDireccion(request.getParameter("direccion"));

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaNacimiento = sdf.parse(request.getParameter("fechaNacimiento"));
            usuario.setFechaNacimiento(fechaNacimiento);

            usuario.setClave(request.getParameter("clave"));
            usuario.setRolIdRol(Integer.parseInt(request.getParameter("rol")));

            return usuarioDAO.insertarUsuario(usuario);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean actualizarUsuario(HttpServletRequest request) {
        try {
            Usuario usuario = new Usuario();
            usuario.setIdUsuario(Integer.parseInt(request.getParameter("id")));
            usuario.setNombre(request.getParameter("nombre"));
            usuario.setApellido(request.getParameter("apellido"));
            usuario.setDni(request.getParameter("dni"));
            usuario.setTelefono(request.getParameter("telefono"));
            usuario.setCorreoElectronico(request.getParameter("correo"));
            usuario.setDireccion(request.getParameter("direccion"));

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaNacimiento = sdf.parse(request.getParameter("fechaNacimiento"));
            usuario.setFechaNacimiento(fechaNacimiento);

            usuario.setClave(request.getParameter("clave"));
            usuario.setRolIdRol(Integer.parseInt(request.getParameter("rol")));

            return usuarioDAO.actualizarUsuario(usuario);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean crearPaciente(HttpServletRequest request) {
        try {
            Paciente paciente = new Paciente();
            paciente.setNombre(request.getParameter("nombre"));
            paciente.setApellido(request.getParameter("apellido"));
            paciente.setDni(request.getParameter("dni"));
            paciente.setTelefono(request.getParameter("telefono"));
            paciente.setCorreo(request.getParameter("correo"));

            return pacienteDAO.insertarPaciente(paciente);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean actualizarPaciente(HttpServletRequest request) {
        try {
            Paciente paciente = new Paciente();
            paciente.setIdPaciente(Integer.parseInt(request.getParameter("id")));
            paciente.setNombre(request.getParameter("nombre"));
            paciente.setApellido(request.getParameter("apellido"));
            paciente.setDni(request.getParameter("dni"));
            paciente.setTelefono(request.getParameter("telefono"));
            paciente.setCorreo(request.getParameter("correo"));

            return pacienteDAO.actualizarPaciente(paciente);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean crearServicio(HttpServletRequest request) {
        try {
            Servicio servicio = new Servicio();
            servicio.setTipoServicio(request.getParameter("tipoServicio"));
            servicio.setLema(request.getParameter("lema"));
            servicio.setDescripcion(request.getParameter("descripcion"));
            servicio.setRespuesta(request.getParameter("respuesta"));
            servicio.setCosto(new BigDecimal(request.getParameter("costo")));
            servicio.setImg(request.getParameter("img"));

            return servicioDAO.insertarServicio(servicio);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean actualizarServicio(HttpServletRequest request) {
        try {
            Servicio servicio = new Servicio();
            servicio.setIdServicio(Integer.parseInt(request.getParameter("id")));
            servicio.setTipoServicio(request.getParameter("tipoServicio"));
            servicio.setLema(request.getParameter("lema"));
            servicio.setDescripcion(request.getParameter("descripcion"));
            servicio.setRespuesta(request.getParameter("respuesta"));
            servicio.setCosto(new BigDecimal(request.getParameter("costo")));
            servicio.setImg(request.getParameter("img"));

            return servicioDAO.actualizarServicio(servicio);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean crearFAQ(HttpServletRequest request) {
        try {
            FAQ faq = new FAQ();
            faq.setPregunta(request.getParameter("pregunta"));
            faq.setRespuesta(request.getParameter("respuesta"));
            faq.setPrioridad(Integer.parseInt(request.getParameter("prioridad")));
            faq.setActivo(request.getParameter("activo") != null);

            String servicioId = request.getParameter("servicioId");
            if (servicioId != null && !servicioId.isEmpty()) {
                faq.setServicioIdServicio(Integer.parseInt(servicioId));
            }

            HttpSession session = request.getSession();
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            faq.setUsuarioIdUsuario(usuario.getIdUsuario());

            return faqDAO.insertarFAQ(faq);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean actualizarFAQ(HttpServletRequest request) {
        try {
            FAQ faq = new FAQ();
            faq.setIdFaq(Integer.parseInt(request.getParameter("id")));
            faq.setPregunta(request.getParameter("pregunta"));
            faq.setRespuesta(request.getParameter("respuesta"));
            faq.setPrioridad(Integer.parseInt(request.getParameter("prioridad")));
            faq.setActivo(request.getParameter("activo") != null);

            return faqDAO.actualizarFAQ(faq);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    // Nuevo método para toggle de estado

    private void toggleEstadoEntidad(HttpServletRequest request, HttpServletResponse response, String section)
            throws IOException {

        boolean success = false;

        switch (section) {
            case "faq":
                int id = Integer.parseInt(request.getParameter("id"));
                success = toggleEstadoFAQ(id);
                break;
            case "especializaciones":
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                int idServicio = Integer.parseInt(request.getParameter("idServicio"));
                boolean disponibilidad = Boolean.parseBoolean(request.getParameter("disponibilidad"));
                success = usuarioServicioDAO.actualizarDisponibilidad(idUsuario, idServicio, !disponibilidad);
                break;
        }

        if (success) {
            request.getSession().setAttribute("mensaje", "Estado actualizado exitosamente");
            request.getSession().setAttribute("tipoMensaje", "success");
        } else {
            request.getSession().setAttribute("mensaje", "Error al actualizar el estado");
            request.getSession().setAttribute("tipoMensaje", "error");
        }

        response.sendRedirect("admin?action=list&section=" + section);
    }

// Método auxiliar para toggle FAQ
    private boolean toggleEstadoFAQ(int id) {
        try {
            FAQ faq = faqDAO.obtenerFAQPorId(id);
            if (faq != null) {
                faq.setActivo(!faq.isActivo()); // Cambiar el estado
                return faqDAO.actualizarFAQ(faq);
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean crearEspecializacion(HttpServletRequest request) {
        try {
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            int idServicio = Integer.parseInt(request.getParameter("idServicio"));
            boolean disponibilidad = request.getParameter("disponibilidad") != null;

            // Verificar si ya existe la especialización
            if (usuarioServicioDAO.existeEspecializacion(idUsuario, idServicio)) {
                return false; // Ya existe
            }

            UsuarioServicio usuarioServicio = new UsuarioServicio();
            usuarioServicio.setIdUsuario(idUsuario);
            usuarioServicio.setIdServicio(idServicio);
            usuarioServicio.setDisponibilidad(disponibilidad);

            return usuarioServicioDAO.insertarEspecializacion(usuarioServicio);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
