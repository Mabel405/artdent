package pe.edu.utp.controller;

import pe.edu.utp.dao.ReservaDAO;
import pe.edu.utp.dao.PacienteDAO;
import pe.edu.utp.dao.CitaDAO;
import pe.edu.utp.dao.UsuarioDAO;
import pe.edu.utp.dao.ServicioDAO;
import pe.edu.utp.daoimpl.ReservaDAOImpl;
import pe.edu.utp.daoimpl.PacienteDAOImpl;
import pe.edu.utp.daoimpl.CitaDAOImpl;
import pe.edu.utp.daoimpl.UsuarioDAOImpl;
import pe.edu.utp.daoimpl.ServicioDAOImpl;
import pe.edu.utp.entity.Reserva;
import pe.edu.utp.entity.Usuario;
import pe.edu.utp.entity.Servicio;
import pe.edu.utp.dto.ReservaDTO;
import pe.edu.utp.dto.CitaDTO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.servlet.annotation.WebServlet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

@WebServlet("/secretaria")
public class SecretariaController extends HttpServlet {

    private ReservaDAO reservaDAO;
    private PacienteDAO pacienteDAO;
    private CitaDAO citaDAO;
    private UsuarioDAO usuarioDAO;
    private ServicioDAO servicioDAO;

    @Override
    public void init() throws ServletException {
        this.reservaDAO = new ReservaDAOImpl();
        this.pacienteDAO = new PacienteDAOImpl();
        this.citaDAO = new CitaDAOImpl();
        this.usuarioDAO = new UsuarioDAOImpl();
        this.servicioDAO = new ServicioDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar autenticación
        if (!verificarAutenticacion(request, response)) {
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            mostrarDashboard(request, response);
        } else {
            switch (action) {
                case "solicitudes":
                    mostrarSolicitudes(request, response);
                    break;
                case "detalle":
                    mostrarDetalleSolicitud(request, response);
                    break;
                case "detalle-cita":
                    mostrarDetalleCita(request, response);
                    break;
                case "calendario":
                    mostrarCalendario(request, response);
                    break;
                case "calendario-doctor":
                    mostrarCalendarioDoctor(request, response);
                    break;
                case "historial":
                    mostrarHistorial(request, response);
                    break;
                case "reportes":
                    mostrarReportes(request, response);
                    break;
                case "exportar-historial":
                    exportarHistorial(request, response);
                    break;
                case "citas-hoy":
                    mostrarCitasHoy(request, response);
                    break;
                case "checkin":
                    mostrarCheckin(request, response);
                    break;
                case "reprogramar":
                    mostrarReprogramacion(request, response);
                    break;
                case "notificaciones":
                    mostrarNotificaciones(request, response);
                    break;
                case "estadisticas-servicios":
                    obtenerEstadisticasServicios(request, response);
                    break;
                default:
                    mostrarDashboard(request, response);
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!verificarAutenticacion(request, response)) {
            return;
        }

        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "confirmar-reserva":
                    confirmarReserva(request, response);
                    break;
                case "cancelar-reserva":
                    cancelarReserva(request, response);
                    break;
                case "reprogramar-reserva":
                    reprogramarReserva(request, response);
                    break;
                case "checkin-paciente":
                    registrarCheckin(request, response);
                    break;
                case "checkout-paciente":
                    registrarCheckout(request, response);
                    break;
                default:
                    response.sendRedirect("secretaria");
                    break;
            }
        }
    }

    private boolean verificarAutenticacion(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return false;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario.getRolIdRol() != 2) { // 2 = Secretaria
            response.sendRedirect("inicio");
            return false;
        }

        return true;
    }

    private void mostrarDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Obtener estadísticas básicas
            int reservasPendientes = reservaDAO.contarReservasPorEstado(1);
            int reservasConfirmadas = reservaDAO.contarReservasPorEstado(2);
            int reservasCompletadas = reservaDAO.contarReservasPorEstado(4);
            int reservasCanceladas = reservaDAO.contarReservasPorEstado(3);

            // Crear mapa de estadísticas del mes
            Map<String, Integer> estadisticasMes = new HashMap<>();
            estadisticasMes.put("Pendientes", reservasPendientes);
            estadisticasMes.put("Confirmadas", reservasConfirmadas);
            estadisticasMes.put("Completadas", reservasCompletadas);
            estadisticasMes.put("Canceladas", reservasCanceladas);

            // Obtener reservas de hoy
            Date hoy = new Date(System.currentTimeMillis());
            List<ReservaDTO> reservasHoy = reservaDAO.obtenerReservasPorFecha(hoy);
            
            // Obtener solicitudes pendientes (máximo 5 para el dashboard)
            List<ReservaDTO> reservasPendientesList = reservaDAO.obtenerReservasPendientes();
            if (reservasPendientesList.size() > 5) {
                reservasPendientesList = reservasPendientesList.subList(0, 5);
            }

            // Obtener lista de odontólogos para el selector
            List<Usuario> odontologos = usuarioDAO.listarOdontologos();

            // Establecer atributos
            request.setAttribute("reservasPendientes", reservasPendientes);
            request.setAttribute("estadisticasMes", estadisticasMes);
            request.setAttribute("reservasHoy", reservasHoy);
            request.setAttribute("reservasPendientesList", reservasPendientesList);
            request.setAttribute("fechaHoy", hoy);
            request.setAttribute("odontologos", odontologos);
            
            System.out.println("Dashboard - Reservas pendientes: " + reservasPendientes);
            System.out.println("Dashboard - Reservas de hoy: " + reservasHoy.size());
            System.out.println("Dashboard - Lista pendientes: " + reservasPendientesList.size());
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar el dashboard: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/WEB-INF/views/secretaria/dashboard.jsp").forward(request, response);
    }

    private void mostrarSolicitudes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Obtener parámetros de filtro
            String fecha = request.getParameter("fecha");
            String servicio = request.getParameter("servicio");
            String paciente = request.getParameter("paciente");

            List<ReservaDTO> reservasPendientes = reservaDAO.obtenerReservasPendientes();
            
            System.out.println("Solicitudes - Total reservas pendientes: " + reservasPendientes.size());

            request.setAttribute("reservasPendientes", reservasPendientes);
            request.setAttribute("filtroFecha", fecha);
            request.setAttribute("filtroServicio", servicio);
            request.setAttribute("filtroPaciente", paciente);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar las solicitudes: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/views/secretaria/solicitudes.jsp").forward(request, response);
    }

    private void mostrarDetalleSolicitud(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idReservaParam = request.getParameter("idReserva");
        if (idReservaParam != null) {
            try {
                int idReserva = Integer.parseInt(idReservaParam);
                ReservaDTO reservaDetalle = reservaDAO.obtenerReservaDTOPorId(idReserva);
                
                if (reservaDetalle != null) {
                    request.setAttribute("reservaDetalle", reservaDetalle);
                    request.getRequestDispatcher("/WEB-INF/views/secretaria/detalle-solicitud.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Reserva no encontrada");
                    mostrarSolicitudes(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID de reserva inválido");
                mostrarSolicitudes(request, response);
            }
        } else {
            response.sendRedirect("secretaria?action=solicitudes");
        }
    }

    private void mostrarDetalleCita(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idCitaParam = request.getParameter("idCita");
        if (idCitaParam != null) {
            try {
                int idCita = Integer.parseInt(idCitaParam);
                CitaDTO citaDetalle = citaDAO.obtenerCitaDTOPorId(idCita);
                
                if (citaDetalle != null) {
                    request.setAttribute("citaDetalle", citaDetalle);
                    request.getRequestDispatcher("/WEB-INF/views/secretaria/detalle-cita.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Cita no encontrada");
                    mostrarHistorial(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID de cita inválido");
                mostrarHistorial(request, response);
            }
        } else {
            response.sendRedirect("secretaria?action=historial");
        }
    }

    private void mostrarCalendario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fechaParam = request.getParameter("fecha");
        Date fecha;

        if (fechaParam != null && !fechaParam.isEmpty()) {
            try {
                fecha = Date.valueOf(fechaParam);
            } catch (IllegalArgumentException e) {
                fecha = new Date(System.currentTimeMillis());
            }
        } else {
            fecha = new Date(System.currentTimeMillis());
        }

        List<ReservaDTO> reservasFecha = reservaDAO.obtenerReservasPorFecha(fecha);
        List<Usuario> odontologos = usuarioDAO.listarOdontologos();

        request.setAttribute("reservasFecha", reservasFecha);
        request.setAttribute("fechaSeleccionada", fecha);
        request.setAttribute("odontologos", odontologos);

        request.getRequestDispatcher("/WEB-INF/views/secretaria/calendario.jsp").forward(request, response);
    }

    private void mostrarCalendarioDoctor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fechaParam = request.getParameter("fecha");
        String doctorIdParam = request.getParameter("doctorId");
        
        Date fecha;
        int doctorId = 0;

        // Validar fecha
        if (fechaParam != null && !fechaParam.isEmpty()) {
            try {
                fecha = Date.valueOf(fechaParam);
            } catch (IllegalArgumentException e) {
                fecha = new Date(System.currentTimeMillis());
            }
        } else {
            fecha = new Date(System.currentTimeMillis());
        }

        // Validar doctor ID
        if (doctorIdParam != null && !doctorIdParam.isEmpty()) {
            try {
                doctorId = Integer.parseInt(doctorIdParam);
            } catch (NumberFormatException e) {
                doctorId = 0;
            }
        }

        List<ReservaDTO> reservasDoctor = new ArrayList<>();
        Usuario doctorSeleccionado = null;
        
        if (doctorId > 0) {
            // Obtener información del doctor
            doctorSeleccionado = usuarioDAO.obtenerUsuarioPorId(doctorId);
            
            // Obtener reservas del doctor para la fecha específica
            reservasDoctor = reservaDAO.obtenerReservasPorFechaYDoctor(fecha, doctorId);
        }

        // Obtener lista completa de odontólogos para el selector
        List<Usuario> odontologos = usuarioDAO.listarOdontologos();

        // Calcular fechas para navegación
        Calendar cal = Calendar.getInstance();
        cal.setTime(fecha);
        
        cal.add(Calendar.DAY_OF_MONTH, -1);
        Date fechaAnterior = new Date(cal.getTimeInMillis());
        
        cal.add(Calendar.DAY_OF_MONTH, 2);
        Date fechaSiguiente = new Date(cal.getTimeInMillis());
        
        Date fechaHoy = new Date(System.currentTimeMillis());

        // Establecer atributos
        request.setAttribute("reservasDoctor", reservasDoctor);
        request.setAttribute("doctorSeleccionado", doctorSeleccionado);
        request.setAttribute("doctorId", doctorId);
        request.setAttribute("fechaSeleccionada", fecha);
        request.setAttribute("odontologos", odontologos);
        request.setAttribute("fechaAnterior", fechaAnterior);
        request.setAttribute("fechaSiguiente", fechaSiguiente);
        request.setAttribute("fechaHoy", fechaHoy);

        System.out.println("=== DEBUG CALENDARIO DOCTOR ===");
        System.out.println("Doctor ID: " + doctorId);
        System.out.println("Fecha: " + fecha);
        System.out.println("Total odontólogos: " + odontologos.size());
        System.out.println("Reservas encontradas: " + reservasDoctor.size());
        System.out.println("Doctor seleccionado: " + (doctorSeleccionado != null ? doctorSeleccionado.getNombre() : "null"));

        request.getRequestDispatcher("/WEB-INF/views/secretaria/calendario-doctor-simple.jsp").forward(request, response);
    }

    // ACTUALIZADO: Método para mostrar historial con filtros
    private void mostrarHistorial(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Obtener parámetros de filtro
            String fechaDesdeParam = request.getParameter("fechaDesde");
            String fechaHastaParam = request.getParameter("fechaHasta");
            String pacienteBuscar = request.getParameter("paciente");
            String doctorIdParam = request.getParameter("doctorId");
            String servicioIdParam = request.getParameter("servicioId");
            String duracionFiltro = request.getParameter("duracion");

            // Procesar filtros
            Date fechaDesde = null;
            Date fechaHasta = null;
            int doctorIdFiltro = 0;
            int servicioIdFiltro = 0;

            if (fechaDesdeParam != null && !fechaDesdeParam.isEmpty()) {
                try {
                    fechaDesde = Date.valueOf(fechaDesdeParam);
                } catch (IllegalArgumentException e) {
                    fechaDesde = null;
                }
            }

            if (fechaHastaParam != null && !fechaHastaParam.isEmpty()) {
                try {
                    fechaHasta = Date.valueOf(fechaHastaParam);
                } catch (IllegalArgumentException e) {
                    fechaHasta = null;
                }
            }

            if (doctorIdParam != null && !doctorIdParam.isEmpty()) {
                try {
                    doctorIdFiltro = Integer.parseInt(doctorIdParam);
                } catch (NumberFormatException e) {
                    doctorIdFiltro = 0;
                }
            }

            if (servicioIdParam != null && !servicioIdParam.isEmpty()) {
                try {
                    servicioIdFiltro = Integer.parseInt(servicioIdParam);
                } catch (NumberFormatException e) {
                    servicioIdFiltro = 0;
                }
            }

            // Obtener todas las citas completadas
            List<CitaDTO> citasCompletadas = citaDAO.obtenerCitasCompletadas();
        
            // Aplicar filtros
            citasCompletadas = aplicarFiltrosHistorial(citasCompletadas, fechaDesde, fechaHasta, 
                                        pacienteBuscar, doctorIdFiltro, servicioIdFiltro, duracionFiltro);
        
            // Calcular estadísticas
            int totalCitas = citasCompletadas.size();
            int tiempoPromedio = calcularTiempoPromedio(citasCompletadas);
        
            // Obtener listas para filtros
            List<Usuario> odontologos = usuarioDAO.listarOdontologos();
            List<Servicio> servicios = servicioDAO.listarServicios();
        
            // Establecer atributos
            request.setAttribute("citasCompletadas", citasCompletadas);
            request.setAttribute("totalCitas", totalCitas);
            request.setAttribute("tiempoPromedio", tiempoPromedio);
            request.setAttribute("odontologos", odontologos);
            request.setAttribute("servicios", servicios);
        
            // Mantener valores de filtros
            request.setAttribute("fechaDesde", fechaDesdeParam);
            request.setAttribute("fechaHasta", fechaHastaParam);
            request.setAttribute("pacienteBuscar", pacienteBuscar);
            request.setAttribute("doctorIdFiltro", doctorIdFiltro);
            request.setAttribute("servicioIdFiltro", servicioIdFiltro);
            request.setAttribute("duracionFiltro", duracionFiltro);
        
            System.out.println("=== DEBUG HISTORIAL ===");
            System.out.println("Total citas completadas: " + totalCitas);
            System.out.println("Tiempo promedio: " + tiempoPromedio + " minutos");
            System.out.println("Filtros aplicados - Paciente: " + pacienteBuscar + ", Doctor: " + doctorIdFiltro + ", Servicio: " + servicioIdFiltro);
        
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar el historial: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/views/secretaria/historial.jsp").forward(request, response);
    }

    // CORREGIDO: Método auxiliar para aplicar filtros (renombrado y mejorado)
    private List<CitaDTO> aplicarFiltrosHistorial(List<CitaDTO> citas, Date fechaDesde, Date fechaHasta, 
                                   String paciente, int doctorId, int servicioId, String duracion) {
        List<CitaDTO> citasFiltradas = new ArrayList<>();
    
        for (CitaDTO cita : citas) {
            boolean cumpleFiltros = true;
        
            // Filtro por fecha desde
            if (fechaDesde != null && cita.getDiaReserva().before(fechaDesde)) {
                cumpleFiltros = false;
            }
        
            // Filtro por fecha hasta
            if (fechaHasta != null && cita.getDiaReserva().after(fechaHasta)) {
                cumpleFiltros = false;
            }
        
            // Filtro por paciente
            if (paciente != null && !paciente.isEmpty()) {
                if (!cita.getNombreCompletoPaciente().toLowerCase().contains(paciente.toLowerCase())) {
                    cumpleFiltros = false;
                }
            }
        
            // CORREGIDO: Filtro por doctor - usar el campo correcto del CitaDTO
            if (doctorId > 0) {
                // Necesitamos comparar con el nombre del odontólogo ya que CitaDTO tiene nombreCompletoOdontologo
                // Obtener el doctor seleccionado para comparar
                try {
                    Usuario doctorSeleccionado = usuarioDAO.obtenerUsuarioPorId(doctorId);
                    if (doctorSeleccionado != null) {
                        String nombreCompletoDoctor = "Dr. " + doctorSeleccionado.getNombre() + " " + doctorSeleccionado.getApellido();
                        if (!cita.getNombreCompletoOdontologo().equals(nombreCompletoDoctor)) {
                            cumpleFiltros = false;
                        }
                    }
                } catch (Exception e) {
                    System.out.println("Error al filtrar por doctor: " + e.getMessage());
                }
            }
        
            // CORREGIDO: Filtro por servicio - usar el campo correcto del CitaDTO
            if (servicioId > 0) {
                // Necesitamos comparar con el nombre del servicio ya que CitaDTO tiene nombreServicio
                try {
                    Servicio servicioSeleccionado = servicioDAO.obtenerServicioPorId(servicioId);
                    if (servicioSeleccionado != null) {
                        if (!cita.getNombreServicio().equals(servicioSeleccionado.getTipoServicio())) {
                            cumpleFiltros = false;
                        }
                    }
                } catch (Exception e) {
                    System.out.println("Error al filtrar por servicio: " + e.getMessage());
                }
            }
        
            // Filtro por duración
            if (duracion != null && !duracion.isEmpty() && cita.getDuracionMinutos() != null) {
                switch (duracion) {
                    case "corta":
                        if (cita.getDuracionMinutos() > 30) cumpleFiltros = false;
                        break;
                    case "normal":
                        if (cita.getDuracionMinutos() <= 30 || cita.getDuracionMinutos() > 60) cumpleFiltros = false;
                        break;
                    case "larga":
                        if (cita.getDuracionMinutos() <= 60) cumpleFiltros = false;
                        break;
                }
            }
        
            if (cumpleFiltros) {
                citasFiltradas.add(cita);
            }
        }
    
        System.out.println("Filtros aplicados: " + citas.size() + " -> " + citasFiltradas.size() + " citas");
        return citasFiltradas;
    }

    // NUEVO: Método para mostrar reportes con cálculos más precisos
    private void mostrarReportes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Obtener estadísticas básicas reales
            int pendientes = reservaDAO.contarReservasPorEstado(1);
            int confirmadas = reservaDAO.contarReservasPorEstado(2);
            int canceladas = reservaDAO.contarReservasPorEstado(3);
            int completadas = reservaDAO.contarReservasPorEstado(4);
            int enProceso = reservaDAO.contarReservasPorEstado(5);
        
            // Calcular total real
            int totalCitas = pendientes + confirmadas + canceladas + completadas + enProceso;
        
            // Calcular tasa de completadas más precisa
            double tasaCompletadas = totalCitas > 0 ? (double) completadas * 100 / totalCitas : 0;
        
            // Obtener todas las reservas para análisis detallado
            List<ReservaDTO> todasReservas = reservaDAO.listarReservasDTO();
        
            // Crear mapa de estadísticas actualizado
            Map<String, Integer> estadisticasMes = new HashMap<>();
            estadisticasMes.put("Pendientes", pendientes);
            estadisticasMes.put("Confirmadas", confirmadas);
            estadisticasMes.put("Completadas", completadas);
            estadisticasMes.put("Canceladas", canceladas);
            estadisticasMes.put("EnProceso", enProceso);
        
            // Calcular ingresos estimados basado en servicios reales
            double ingresosTotales = calcularIngresosEstimados(completadas);
        
            // Calcular pacientes únicos (estimación mejorada)
            int pacientesNuevos = calcularPacientesNuevos(todasReservas);
        
            // Obtener fecha actual
            Date fechaHoy = new Date(System.currentTimeMillis());
        
            // Establecer atributos
            request.setAttribute("totalCitas", totalCitas);
            request.setAttribute("tasaCompletadas", Math.round(tasaCompletadas));
            request.setAttribute("ingresosTotales", ingresosTotales);
            request.setAttribute("pacientesNuevos", pacientesNuevos);
            request.setAttribute("estadisticasMes", estadisticasMes);
            request.setAttribute("todasReservas", todasReservas);
            request.setAttribute("fechaHoy", fechaHoy);
        
            System.out.println("=== DEBUG REPORTES MEJORADOS ===");
            System.out.println("Total citas: " + totalCitas);
            System.out.println("Pendientes: " + pendientes + ", Confirmadas: " + confirmadas);
            System.out.println("Completadas: " + completadas + ", Canceladas: " + canceladas);
            System.out.println("En proceso: " + enProceso);
            System.out.println("Tasa completadas: " + tasaCompletadas + "%");
            System.out.println("Ingresos estimados: S/. " + ingresosTotales);
            System.out.println("Pacientes nuevos estimados: " + pacientesNuevos);
        
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar los reportes: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/views/secretaria/reportes.jsp").forward(request, response);
    }

    // En el método calcularIngresosEstimados, reemplazar todo el método con:

    // ACTUALIZADO: Método para calcular ingresos estimados usando datos reales
    private double calcularIngresosEstimados(int citasCompletadas) {
        try {
            // Obtener servicios reales de la base de datos
            List<Servicio> servicios = servicioDAO.listarServicios();
            
            if (servicios.isEmpty()) {
                // Fallback si no hay servicios en la BD
                return citasCompletadas * 120.0; // Promedio estimado
            }
            
            // Calcular promedio real de costos
            double costoPromedio = 0.0;
            int serviciosConCosto = 0;
            
            for (Servicio servicio : servicios) {
                if (servicio.getCosto() != null && servicio.getCosto().doubleValue() > 0) {
                    costoPromedio += servicio.getCosto().doubleValue();
                    serviciosConCosto++;
                }
            }
            
            if (serviciosConCosto > 0) {
                costoPromedio = costoPromedio / serviciosConCosto;
            } else {
                costoPromedio = 120.0; // Fallback
            }
            
            double ingresosTotales = citasCompletadas * costoPromedio;
            
            System.out.println("=== CÁLCULO DE INGRESOS ===");
            System.out.println("Servicios encontrados: " + servicios.size());
            System.out.println("Servicios con costo: " + serviciosConCosto);
            System.out.println("Costo promedio: S/. " + costoPromedio);
            System.out.println("Citas completadas: " + citasCompletadas);
            System.out.println("Ingresos totales: S/. " + ingresosTotales);
            
            return Math.round(ingresosTotales * 100.0) / 100.0;
            
        } catch (Exception e) {
            System.out.println("Error al calcular ingresos: " + e.getMessage());
            // Fallback en caso de error
            return citasCompletadas * 120.0;
        }
    }

    // NUEVO: Método para calcular pacientes nuevos estimados
    private int calcularPacientesNuevos(List<ReservaDTO> reservas) {
        // Usar un Set para contar pacientes únicos por nombre
        Set<String> pacientesUnicos = new HashSet<>();
    
        for (ReservaDTO reserva : reservas) {
            if (reserva.getNombreCompletoPaciente() != null) {
                pacientesUnicos.add(reserva.getNombreCompletoPaciente().toLowerCase().trim());
            }
        }
    
        // Estimar que el 30% son pacientes nuevos
        int totalPacientesUnicos = pacientesUnicos.size();
        return Math.max(1, (int) (totalPacientesUnicos * 0.30));
    }

    // NUEVO: Método para exportar historial
    private void exportarHistorial(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String formato = request.getParameter("formato");
        
        if ("excel".equals(formato)) {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=historial_citas.xls");
            
            // Aquí implementarías la generación del Excel
            response.getWriter().println("Historial de Citas Completadas - Formato Excel");
            response.getWriter().println("Esta funcionalidad se implementará con Apache POI");
            
        } else {
            response.sendRedirect("secretaria?action=historial");
        }
    }

    // Método auxiliar para calcular tiempo promedio
    private int calcularTiempoPromedio(List<CitaDTO> citas) {
        if (citas.isEmpty()) return 0;
        
        int totalMinutos = 0;
        int citasConDuracion = 0;
        
        for (CitaDTO cita : citas) {
            if (cita.getDuracionMinutos() != null && cita.getDuracionMinutos() > 0) {
                totalMinutos += cita.getDuracionMinutos();
                citasConDuracion++;
            }
        }
        
        return citasConDuracion > 0 ? totalMinutos / citasConDuracion : 0;
    }

    private void mostrarCheckin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Date hoy = new Date(System.currentTimeMillis());
        List<ReservaDTO> reservasHoy = reservaDAO.obtenerReservasPorFecha(hoy);

        request.setAttribute("reservasHoy", reservasHoy);
        request.getRequestDispatcher("/WEB-INF/views/secretaria/checkin.jsp").forward(request, response);
    }

    private void mostrarReprogramacion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idReservaParam = request.getParameter("idReserva");
        if (idReservaParam != null) {
            try {
                int idReserva = Integer.parseInt(idReservaParam);
                Reserva reserva = reservaDAO.obtenerReservaPorId(idReserva);
                request.setAttribute("reservaReprogramar", reserva);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID de reserva inválido");
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/secretaria/reprogramar.jsp").forward(request, response);
    }

    private void mostrarNotificaciones(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/secretaria/notificaciones.jsp").forward(request, response);
    }

    private void confirmarReserva(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String idReservaParam = request.getParameter("idReserva");
        if (idReservaParam != null) {
            try {
                int idReserva = Integer.parseInt(idReservaParam);
                boolean success = reservaDAO.confirmarReserva(idReserva);
                
                if (success) {
                    System.out.println("Reserva confirmada exitosamente: " + idReserva);
                } else {
                    System.out.println("Error al confirmar la reserva: " + idReserva);
                }
            } catch (NumberFormatException e) {
                System.out.println("Error al convertir idReserva a entero: " + e.getMessage());
            }
        }

        response.sendRedirect("secretaria?action=solicitudes");
    }

    private void cancelarReserva(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String idReservaParam = request.getParameter("idReserva");
        if (idReservaParam != null) {
            try {
                int idReserva = Integer.parseInt(idReservaParam);
                boolean success = reservaDAO.cancelarReserva(idReserva);
                
                if (success) {
                    System.out.println("Reserva cancelada exitosamente: " + idReserva);
                } else {
                    System.out.println("Error al cancelar la reserva: " + idReserva);
                }
            } catch (NumberFormatException e) {
                System.out.println("Error al convertir idReserva a entero: " + e.getMessage());
            }
        }

        response.sendRedirect("secretaria?action=solicitudes");
    }

    private void reprogramarReserva(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String idReservaParam = request.getParameter("idReserva");
        String nuevaFechaParam = request.getParameter("nuevaFecha");
        String nuevaHoraParam = request.getParameter("nuevaHora");

        if (idReservaParam != null && nuevaFechaParam != null && nuevaHoraParam != null) {
            try {
                int idReserva = Integer.parseInt(idReservaParam);
                Date nuevaFecha = Date.valueOf(nuevaFechaParam);
                Time nuevaHora = Time.valueOf(nuevaHoraParam + ":00");

                // Actualizar la reserva directamente
                Reserva reserva = reservaDAO.obtenerReservaPorId(idReserva);
                if (reserva != null) {
                    reserva.setDiaReserva(nuevaFecha);
                    reserva.setHoraReserva(nuevaHora);
                    boolean exito = reservaDAO.actualizarReserva(reserva);
                    
                    if (exito) {
                        response.sendRedirect("secretaria?action=calendario&mensaje=Reserva reprogramada exitosamente");
                    } else {
                        response.sendRedirect("secretaria?action=reprogramar&error=Error al reprogramar");
                    }
                } else {
                    response.sendRedirect("secretaria?action=reprogramar&error=Reserva no encontrada");
                }
            } catch (Exception e) {
                response.sendRedirect("secretaria?action=reprogramar&error=Datos inválidos");
            }
        } else {
            response.sendRedirect("secretaria?action=reprogramar&error=Faltan datos");
        }
    }

    private void registrarCheckin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String idReservaParam = request.getParameter("idReserva");
        if (idReservaParam != null) {
            try {
                int idReserva = Integer.parseInt(idReservaParam);
            
                // Registrar entrada en la tabla cita
                boolean citaCreada = citaDAO.registrarEntrada(idReserva);
            
                if (citaCreada) {
                    // Cambiar estado de la reserva a "En proceso" (estado 5)
                    boolean estadoActualizado = reservaDAO.cambiarEstadoReserva(idReserva, 5);
                    if (!estadoActualizado) {
                        System.out.println("Error al actualizar estado de reserva a 'En proceso'");
                    }
                }
            } catch (NumberFormatException e) {
                System.out.println("Error al procesar check-in: " + e.getMessage());
            }
        }

        response.sendRedirect("secretaria?action=citas-hoy");
    }

    private void registrarCheckout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String idReservaParam = request.getParameter("idReserva");
        String observaciones = request.getParameter("observaciones");
        String diagnostico = request.getParameter("diagnostico");
        String tratamiento = request.getParameter("tratamiento");
    
        if (idReservaParam != null) {
            try {
                int idReserva = Integer.parseInt(idReservaParam);
            
                // Registrar salida en la tabla cita
                boolean citaActualizada = citaDAO.registrarSalida(idReserva, observaciones, diagnostico, tratamiento);
            
                if (citaActualizada) {
                    // Cambiar estado de la reserva a "Completada" (estado 4)
                    boolean estadoActualizado = reservaDAO.cambiarEstadoReserva(idReserva, 4);
                    if (!estadoActualizado) {
                        System.out.println("Error al actualizar estado de reserva a 'Completada'");
                    }
                }
            } catch (NumberFormatException e) {
                System.out.println("Error al procesar check-out: " + e.getMessage());
            }
        }

        response.sendRedirect("secretaria?action=citas-hoy");
    }

    private void mostrarCitasHoy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        try {
            Date hoy = new Date(System.currentTimeMillis());
            List<ReservaDTO> reservasHoy = reservaDAO.obtenerReservasPorFecha(hoy);
        
            // Separar por estado para mejor organización
            List<ReservaDTO> confirmadas = new ArrayList<>();
            List<ReservaDTO> enProceso = new ArrayList<>();
            List<ReservaDTO> completadas = new ArrayList<>();
        
            for (ReservaDTO reserva : reservasHoy) {
                switch (reserva.getTipoEstado()) {
                    case 2: // Confirmadas
                        confirmadas.add(reserva);
                        break;
                    case 5: // En proceso
                        enProceso.add(reserva);
                        break;
                    case 4: // Completadas
                        completadas.add(reserva);
                        break;
                }
            }
            
            System.out.println("Citas Hoy - Total reservas: " + reservasHoy.size());
            System.out.println("Citas Hoy - Confirmadas: " + confirmadas.size());
            System.out.println("Citas Hoy - En proceso: " + enProceso.size());
            System.out.println("Citas Hoy - Completadas: " + completadas.size());
        
            request.setAttribute("reservasConfirmadas", confirmadas);
            request.setAttribute("reservasEnProceso", enProceso);
            request.setAttribute("reservasCompletadas", completadas);
            request.setAttribute("fechaHoy", hoy);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar las citas de hoy: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/WEB-INF/views/secretaria/citas-hoy.jsp").forward(request, response);
    }
    // NUEVO: Método para obtener estadísticas de servicios


    // NUEVO: Método para obtener estadísticas de servicios en formato JSON
    private void obtenerEstadisticasServicios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            List<Object[]> estadisticas = ((ServicioDAOImpl) servicioDAO).obtenerEstadisticasServicios();
            
            StringBuilder json = new StringBuilder();
            json.append("[");
            
            for (int i = 0; i < estadisticas.size(); i++) {
                Object[] fila = estadisticas.get(i);
                json.append("{");
                json.append("\"servicio\":\"").append(fila[0]).append("\",");
                json.append("\"cantidad\":").append(fila[1]);
                json.append("}");
                
                if (i < estadisticas.size() - 1) {
                    json.append(",");
                }
            }
            
            json.append("]");
            
            response.getWriter().write(json.toString());
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("[]"); // JSON vacío en caso de error
        }
    }
}
