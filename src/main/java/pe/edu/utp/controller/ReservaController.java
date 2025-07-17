package pe.edu.utp.controller;

import pe.edu.utp.dao.ReservaDAO;
import pe.edu.utp.dao.PacienteDAO;
import pe.edu.utp.dao.ServicioDAO;
import pe.edu.utp.dao.UsuarioDAO;
import pe.edu.utp.dao.ComprobanteDAO;
import pe.edu.utp.daoimpl.ReservaDAOImpl;
import pe.edu.utp.daoimpl.PacienteDAOImpl;
import pe.edu.utp.daoimpl.ServicioDAOImpl;
import pe.edu.utp.daoimpl.UsuarioDAOImpl;
import pe.edu.utp.daoimpl.ComprobanteDAOImpl;
import pe.edu.utp.entity.Reserva;
import pe.edu.utp.entity.Paciente;
import pe.edu.utp.entity.Servicio;
import pe.edu.utp.entity.Usuario;
import pe.edu.utp.entity.Comprobante;
import pe.edu.utp.dto.ReservaDTO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Date;
import java.sql.Time;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/reserva")
public class ReservaController extends HttpServlet {
    private ReservaDAO reservaDAO;
    private PacienteDAO pacienteDAO;
    private ServicioDAO servicioDAO;
    private UsuarioDAO usuarioDAO;
    private ComprobanteDAO comprobanteDAO;
    
    // Constantes para cálculos
    private static final BigDecimal IGV_RATE = new BigDecimal("0.18"); // 18% IGV
    
    @Override
    public void init() throws ServletException {
        reservaDAO = new ReservaDAOImpl();
        pacienteDAO = new PacienteDAOImpl();
        servicioDAO = new ServicioDAOImpl();
        usuarioDAO = new UsuarioDAOImpl();
        comprobanteDAO = new ComprobanteDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("nueva".equals(action)) {
            mostrarFormularioReserva(request, response);
        } else if ("consultar".equals(action)) {
            mostrarConsultaReserva(request, response);
        } else {
            response.sendRedirect("inicio");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("crear".equals(action)) {
            crearReserva(request, response);
        } else if ("buscar".equals(action)) {
            buscarReserva(request, response);
        }
    }
    
    private void mostrarFormularioReserva(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Servicio> servicios = servicioDAO.listarServicios();
        List<Usuario> odontologos = usuarioDAO.listarOdontologos();
        
        request.setAttribute("servicios", servicios);
        request.setAttribute("odontologos", odontologos);
        request.getRequestDispatcher("/WEB-INF/views/nueva-reserva.jsp").forward(request, response);
    }
    
    private void mostrarConsultaReserva(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/consultar-reserva.jsp").forward(request, response);
    }
    
    private void crearReserva(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
        try {
            // Datos del paciente
            String nombrePaciente = request.getParameter("nombrePaciente");
            String apellidoPaciente = request.getParameter("apellidoPaciente");
            String dniPaciente = request.getParameter("dniPaciente");
            String telefonoPaciente = request.getParameter("telefonoPaciente");
            String correoPaciente = request.getParameter("correoPaciente");
            
            // Datos de la reserva
            String fechaReserva = request.getParameter("fechaReserva");
            String horaReserva = request.getParameter("horaReserva");
            String descripcion = request.getParameter("descripcion");
            int servicioId = Integer.parseInt(request.getParameter("servicioId"));
            int odontologoId = Integer.parseInt(request.getParameter("odontologoId"));
            
            // Datos de facturación empresarial
            String facturarEmpresa = request.getParameter("facturarEmpresa");
            String rucEmpresa = request.getParameter("rucEmpresa");
            String nombreEmpresa = request.getParameter("nombreEmpresa");
            
            // Tipo de pago y datos de PayPal
            int tipoPago = Integer.parseInt(request.getParameter("tipoPago"));
            String paypalOrderId = request.getParameter("paypalOrderId");
            String paypalPayerId = request.getParameter("paypalPayerId");
            
            // Validar tipo de pago
            if (tipoPago < 1 || tipoPago > 3) {
                request.setAttribute("error", "Tipo de pago no válido");
                mostrarFormularioReserva(request, response);
                return;
            }
            
            // Verificar sesión para tipos de pago restringidos
            HttpSession session = request.getSession(false);
            Usuario usuarioLogueado = null;
            if (session != null) {
                usuarioLogueado = (Usuario) session.getAttribute("usuario");
            }
            
            // Si no hay usuario logueado, solo permitir PayPal/Tarjeta
            if (usuarioLogueado == null && tipoPago != 1) {
                request.setAttribute("error", "Los clientes solo pueden pagar con PayPal/Tarjeta");
                mostrarFormularioReserva(request, response);
                return;
            }
            
            // Si es pago con PayPal, validar que se haya completado
            if (tipoPago == 1 && usuarioLogueado == null) {
                if (paypalOrderId == null || paypalOrderId.trim().isEmpty()) {
                    request.setAttribute("error", "Error: No se completó el pago con PayPal");
                    mostrarFormularioReserva(request, response);
                    return;
                }
                System.out.println("Pago PayPal completado - Order ID: " + paypalOrderId + ", Payer ID: " + paypalPayerId);
            }
            
            Date fecha = Date.valueOf(fechaReserva);
            Time hora = Time.valueOf(horaReserva + ":00");
            
            // Validar disponibilidad de horario
            if (reservaDAO.existeReservaEnHorario(fecha, hora, odontologoId)) {
                request.setAttribute("error", "Lo sentimos, ese horario ya está ocupado. Por favor selecciona otro horario.");
                mostrarFormularioReserva(request, response);
                return;
            }
            
            // Verificar si el paciente ya existe
            Paciente paciente = pacienteDAO.obtenerPacientePorDni(dniPaciente);
            if (paciente == null) {
                // Crear nuevo paciente
                paciente = new Paciente();
                paciente.setNombre(nombrePaciente);
                paciente.setApellido(apellidoPaciente);
                paciente.setDni(dniPaciente);
                paciente.setTelefono(telefonoPaciente);
                paciente.setCorreo(correoPaciente);
                
                if (!pacienteDAO.insertarPaciente(paciente)) {
                    request.setAttribute("error", "Error al registrar el paciente");
                    mostrarFormularioReserva(request, response);
                    return;
                }
                
                // Obtener el paciente recién creado
                paciente = pacienteDAO.obtenerPacientePorDni(dniPaciente);
            } else {
                // Validar que el paciente no tenga una reserva activa
                if (reservaDAO.pacienteTieneReservaActiva(paciente.getIdPaciente())) {
                    request.setAttribute("error", "Ya tienes una cita pendiente o confirmada. Solo puedes tener una reserva activa a la vez.");
                    mostrarFormularioReserva(request, response);
                    return;
                }
            }
            
            // Obtener el servicio para calcular el costo
            Servicio servicio = servicioDAO.obtenerServicioPorId(servicioId);
            if (servicio == null) {
                request.setAttribute("error", "Servicio no encontrado");
                mostrarFormularioReserva(request, response);
                return;
            }
            
            // Calcular montos - el costo ya incluye IGV
            BigDecimal costoTotal = servicio.getCosto();
            BigDecimal subtotal = costoTotal.divide(new BigDecimal("1.18"), 2, RoundingMode.HALF_UP);
            BigDecimal igv = costoTotal.subtract(subtotal);
            
            // Crear el comprobante
            Comprobante comprobante = new Comprobante();
            comprobante.setPacienteIdPaciente(paciente.getIdPaciente());
            comprobante.setSubtotal(subtotal.doubleValue());
            comprobante.setIgv(igv.doubleValue());
            comprobante.setImporte(costoTotal.doubleValue());
            comprobante.setTipoPago(tipoPago);
            comprobante.setSerie(comprobanteDAO.generarSerie());
            comprobante.setNumeroCorrelativo(comprobanteDAO.generarNumeroCorrelativo());
            
            // Verificar si es factura a empresa
            boolean esFacturaEmpresa = "true".equals(facturarEmpresa) && 
                                     rucEmpresa != null && 
                                     !rucEmpresa.trim().isEmpty();
            
            if (esFacturaEmpresa) {
                // Validar RUC
                if (!validarRUC(rucEmpresa.trim())) {
                    request.setAttribute("error", "El RUC proporcionado no es válido");
                    mostrarFormularioReserva(request, response);
                    return;
                }
                
                comprobante.setTipoDoc("FACTURA");
                comprobante.setRucEmpresa(rucEmpresa.trim());
                
                String observaciones = "Factura a empresa";
                if (nombreEmpresa != null && !nombreEmpresa.trim().isEmpty()) {
                    observaciones += ": " + nombreEmpresa.trim();
                }
                observaciones += " - Servicio: " + servicio.getTipoServicio();
                
                // Agregar información del tipo de pago
                observaciones += " - " + obtenerDescripcionTipoPago(tipoPago);
                if (tipoPago == 1 && paypalOrderId != null) {
                    observaciones += " (PayPal Order: " + paypalOrderId + ")";
                }
                
                comprobante.setObservaciones(observaciones);
            } else {
                comprobante.setTipoDoc("BOLETA");
                comprobante.setRucEmpresa(null);
                
                String observaciones = "Boleta de venta - Servicio: " + servicio.getTipoServicio();
                observaciones += " - " + obtenerDescripcionTipoPago(tipoPago);
                if (tipoPago == 1 && paypalOrderId != null) {
                    observaciones += " (PayPal Order: " + paypalOrderId + ")";
                }
                
                comprobante.setObservaciones(observaciones);
            }
            
            // Insertar el comprobante
            if (!comprobanteDAO.insertarComprobante(comprobante)) {
                request.setAttribute("error", "Error al generar el comprobante");
                mostrarFormularioReserva(request, response);
                return;
            }
            
            // Crear la reserva
            Reserva reserva = new Reserva();
            reserva.setDiaReserva(fecha);
            reserva.setHoraReserva(hora);
            reserva.setDescripcion(descripcion != null ? descripcion : "");
            reserva.setTipoEstado(1); // Estado pendiente
            reserva.setTokenCliente(reservaDAO.generarTokenCliente());
            reserva.setUsuarioIdUsuario(usuarioLogueado != null ? usuarioLogueado.getIdUsuario() : 1);
            reserva.setPacienteIdPaciente(paciente.getIdPaciente());
            reserva.setServicioIdServicio(servicioId);
            reserva.setOdontologoIdUsuario(odontologoId);
            reserva.setComprobanteIdVenta(comprobante.getIdVenta());
            
            if (reservaDAO.insertarReserva(reserva)) {
                StringBuilder mensajeExito = new StringBuilder();
                mensajeExito.append("¡Reserva creada exitosamente!")
                           .append("\n\nToken de consulta: ").append(reserva.getTokenCliente())
                           .append("\nServicio: ").append(servicio.getTipoServicio())
                           .append("\nCosto: S/ ").append(String.format("%.2f", costoTotal));
                
                // Información del tipo de pago
                mensajeExito.append("\n\n💳 MÉTODO DE PAGO")
                           .append("\nTipo: ").append(obtenerDescripcionTipoPago(tipoPago));
                
                if (tipoPago == 1 && paypalOrderId != null) {
                    mensajeExito.append("\n✅ Pago procesado con PayPal")
                               .append("\nID de transacción: ").append(paypalOrderId);
                }
                
                if (esFacturaEmpresa) {
                    mensajeExito.append("\n\n📄 FACTURA EMPRESARIAL")
                               .append("\nRUC: ").append(rucEmpresa)
                               .append("\nEmpresa: ").append(nombreEmpresa != null ? nombreEmpresa : "")
                               .append("\nComprobante: ").append(comprobante.getNumeroCompleto())
                               .append("\nSubtotal: S/ ").append(String.format("%.2f", subtotal))
                               .append("\nIGV (18%): S/ ").append(String.format("%.2f", igv))
                               .append("\nTotal: S/ ").append(String.format("%.2f", costoTotal));
                } else {
                    mensajeExito.append("\n\n🧾 BOLETA DE VENTA")
                               .append("\nComprobante: ").append(comprobante.getNumeroCompleto())
                               .append("\nSubtotal: S/ ").append(String.format("%.2f", subtotal))
                               .append("\nIGV (18%): S/ ").append(String.format("%.2f", igv))
                               .append("\nTotal: S/ ").append(String.format("%.2f", costoTotal));
                }
                
                request.setAttribute("success", mensajeExito.toString());
                request.setAttribute("token", reserva.getTokenCliente());
                request.setAttribute("comprobante", comprobante);
                request.setAttribute("servicio", servicio);
                request.setAttribute("esFacturaEmpresa", esFacturaEmpresa);
                request.setAttribute("tipoPago", tipoPago);
                request.setAttribute("paypalOrderId", paypalOrderId);
                
                // Log para debugging
                System.out.println("Reserva creada exitosamente:");
                System.out.println("- ID Reserva: " + reserva.getIdReserva());
                System.out.println("- Token: " + reserva.getTokenCliente());
                System.out.println("- Comprobante: " + comprobante.getNumeroCompleto());
                System.out.println("- Tipo: " + comprobante.getTipoDoc());
                System.out.println("- Tipo Pago: " + obtenerDescripcionTipoPago(tipoPago));
                System.out.println("- PayPal Order ID: " + paypalOrderId);
                System.out.println("- Total: S/ " + costoTotal);
                
            } else {
                request.setAttribute("error", "Error al crear la reserva. Por favor intente nuevamente.");
            }
            
            mostrarFormularioReserva(request, response);
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en el formato de los datos numéricos proporcionados");
            mostrarFormularioReserva(request, response);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en el formato de fecha u hora proporcionados");
            mostrarFormularioReserva(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error inesperado: " + e.getMessage());
            mostrarFormularioReserva(request, response);
        }
    }
    
    private void buscarReserva(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String token = request.getParameter("token");
        String dni = request.getParameter("dni");
        
        if (token != null && !token.trim().isEmpty()) {
            // Buscar por token
            List<ReservaDTO> reservas = reservaDAO.obtenerReservasPorToken(token.trim());
            request.setAttribute("reservas", reservas);
            
            if (reservas.isEmpty()) {
                request.setAttribute("mensaje", "No se encontraron reservas con el token proporcionado");
            }
        } else if (dni != null && !dni.trim().isEmpty()) {
            // Buscar por DNI del paciente
            Paciente paciente = pacienteDAO.obtenerPacientePorDni(dni.trim());
            if (paciente != null) {
                List<ReservaDTO> reservas = reservaDAO.obtenerReservasPorPaciente(paciente.getIdPaciente());
                request.setAttribute("reservas", reservas);
                request.setAttribute("paciente", paciente);
                
                if (reservas.isEmpty()) {
                    request.setAttribute("mensaje", "No se encontraron reservas para este paciente");
                }
            } else {
                request.setAttribute("mensaje", "No se encontró un paciente con el DNI proporcionado");
            }
        } else {
            request.setAttribute("mensaje", "Debe proporcionar un token o DNI para buscar");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/consultar-reserva.jsp").forward(request, response);
    }
    
    /**
     * Obtener descripción del tipo de pago
     */
    private String obtenerDescripcionTipoPago(int tipoPago) {
        switch (tipoPago) {
            case 1: return "PayPal / Tarjeta";
            case 2: return "Efectivo";
            case 3: return "Yape / Plin";
            default: return "Desconocido";
        }
    }
    
    /**
     * Validar RUC peruano
     */
    private boolean validarRUC(String ruc) {
        if (ruc == null || ruc.length() != 11) {
            return false;
        }
        
        // Verificar que solo contenga números
        if (!ruc.matches("\\d{11}")) {
            return false;
        }
        
        // Los primeros dos dígitos deben ser válidos
        String prefijo = ruc.substring(0, 2);
        String[] prefijosValidos = {"10", "15", "17", "20"};
        boolean prefijoValido = false;
        for (String p : prefijosValidos) {
            if (prefijo.equals(p)) {
                prefijoValido = true;
                break;
            }
        }
        
        if (!prefijoValido) {
            return false;
        }
        
        // Validación del dígito verificador
        int[] factores = {5, 4, 3, 2, 7, 6, 5, 4, 3, 2};
        int suma = 0;
        
        for (int i = 0; i < 10; i++) {
            suma += Character.getNumericValue(ruc.charAt(i)) * factores[i];
        }
        
        int resto = suma % 11;
        int digitoVerificador = resto < 2 ? resto : 11 - resto;
        
        return digitoVerificador == Character.getNumericValue(ruc.charAt(10));
    }
}
