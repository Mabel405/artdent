package pe.edu.utp.dao;

import pe.edu.utp.entity.NotificacionReserva;
import java.util.List;

public interface NotificacionReservaDAO {
    
    // Métodos principales de consulta
    List<NotificacionReserva> listarNotificacionesRecientes(int diasAtras);
    List<NotificacionReserva> listarNotificacionesPorEstado(int tipoEstado);
    List<NotificacionReserva> listarNotificacionesPorOdontologo(int idOdontologo);
    List<NotificacionReserva> listarNotificacionesUrgentes();
    List<NotificacionReserva> listarNotificacionesHoy();
    List<NotificacionReserva> listarNotificacionesProximasCitas(int diasAdelante);
    
    // Métodos específicos por tipo
    List<NotificacionReserva> listarReservasCanceladas(int diasAtras);
    List<NotificacionReserva> listarReservasNuevas(int horasAtras);
    List<NotificacionReserva> listarRecordatoriosCitas(int horasAdelante);
    
    // Métodos de consulta individual
    NotificacionReserva obtenerNotificacionPorReserva(int idReserva);
    
    // Métodos de conteo
    int contarNotificacionesRecientes();
    int contarNotificacionesPorEstado(int tipoEstado);
    int contarNotificacionesUrgentes();
    int contarNotificacionesHoy();
    
    // Métodos de estadísticas
    List<NotificacionReserva> obtenerEstadisticasNotificaciones();
}