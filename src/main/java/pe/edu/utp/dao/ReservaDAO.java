package pe.edu.utp.dao;

import pe.edu.utp.entity.Reserva;
import pe.edu.utp.dto.ReservaDTO;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

public interface ReservaDAO {
    // Operaciones CRUD básicas
    List<Reserva> listarReservas();
    Reserva obtenerReservaPorId(int id);
    boolean insertarReserva(Reserva reserva);
    boolean actualizarReserva(Reserva reserva);
    boolean eliminarReserva(int id);
    int contarReservasPendientes(); 
   
    // Operaciones con DTO
    List<ReservaDTO> listarReservasDTO();
    ReservaDTO obtenerReservaDTOPorId(int id);
    List<ReservaDTO> obtenerReservasPorFecha(Date fecha);
    List<ReservaDTO> obtenerReservasPorPaciente(int pacienteId);
    List<ReservaDTO> obtenerReservasPorToken(String token);
    
    // Nuevos métodos para calendario por doctor
    List<ReservaDTO> obtenerReservasPorFechaYDoctor(Date fecha, int doctorId);
    List<ReservaDTO> obtenerReservasPorRangoFechaYDoctor(Date fechaInicio, Date fechaFin, int doctorId);
    
    // NUEVO: Método específico para detalles completos de notificaciones
    ReservaDTO obtenerDetalleCompletoParaNotificacion(int id);
    
    // Operaciones de estado
    boolean confirmarReserva(int id);
    boolean cancelarReserva(int id);
    boolean cambiarEstadoReserva(int id, int nuevoEstado);
    
    // Validaciones
    boolean existeReservaEnHorario(Date fecha, Time hora, int odontologoId);
    boolean pacienteTieneReservaActiva(int pacienteId);
    
    // Utilidades
    String generarTokenCliente();
    List<ReservaDTO> obtenerReservasPendientes();
    List<ReservaDTO> obtenerReservasConfirmadas();
    int contarReservasPorEstado(int estado);
}