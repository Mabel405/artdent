package pe.edu.utp.daoimpl;

import pe.edu.utp.dao.NotificacionReservaDAO;
import pe.edu.utp.entity.NotificacionReserva;
import pe.edu.utp.config.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificacionReservaDAOImpl implements NotificacionReservaDAO {

    private static final String SQL_BASE_SELECT = "SELECT r.*," +
            "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente," +
            "p.Telefono as telefonoPaciente, p.Correo as correoPaciente," +
            "od.Nombre as nombreOdontologo, od.Apellido as apellidoOdontologo," +
            "s.TipoServicio as tipoServicio, s.Costo as costoServicio," +
            "ur.Nombre as nombreUsuarioRegistro " +
            "FROM reserva r " +
            "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente " +
            "INNER JOIN usuario od ON r.Odontologo_idUsuario = od.idUsuario " +
            "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio " +
            "INNER JOIN usuario ur ON r.Usuario_idUsuario = ur.idUsuario";

    @Override
    public List<NotificacionReserva> listarNotificacionesRecientes(int diasAtras) {
        List<NotificacionReserva> notificaciones = new ArrayList<>();
        String sql = SQL_BASE_SELECT + " WHERE r.fecha_actualizacion >= DATE_SUB(NOW(), INTERVAL ? DAY) " +
                     "ORDER BY r.fecha_actualizacion DESC, r.tipoestado DESC LIMIT 50";
        
        System.out.println("=== DEBUG DAO - listarNotificacionesRecientes ===");
        System.out.println("SQL: " + sql);
        System.out.println("Días atrás: " + diasAtras);
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, diasAtras);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NotificacionReserva notif = mapearNotificacion(rs);
                    notificaciones.add(notif);
                    System.out.println("Cargada reserva ID: " + notif.getIdReserva() + 
                                     ", Estado: " + notif.getTipoEstado() + 
                                     ", Fecha Act: " + notif.getFechaActualizacion());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        System.out.println("Total notificaciones cargadas: " + notificaciones.size());
        return notificaciones;
    }
    
    @Override
    public List<NotificacionReserva> listarNotificacionesPorEstado(int tipoEstado) {
        List<NotificacionReserva> notificaciones = new ArrayList<>();
        String sql = SQL_BASE_SELECT + " WHERE r.tipoestado = ? AND r.fecha_actualizacion >= DATE_SUB(NOW(), INTERVAL 7 DAY) " +
                     "ORDER BY r.fecha_actualizacion DESC LIMIT 30";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, tipoEstado);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NotificacionReserva notif = mapearNotificacion(rs);
                    notificaciones.add(notif);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notificaciones;
    }
    
    @Override
    public List<NotificacionReserva> listarNotificacionesPorOdontologo(int idOdontologo) {
        List<NotificacionReserva> notificaciones = new ArrayList<>();
        String sql = SQL_BASE_SELECT + " WHERE r.Odontologo_idUsuario = ? AND r.fecha_actualizacion >= DATE_SUB(NOW(), INTERVAL 3 DAY) " +
                     "ORDER BY r.fecha_actualizacion DESC LIMIT 20";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idOdontologo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NotificacionReserva notif = mapearNotificacion(rs);
                    notificaciones.add(notif);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notificaciones;
    }
    
    @Override
    public List<NotificacionReserva> listarNotificacionesUrgentes() {
        List<NotificacionReserva> notificaciones = new ArrayList<>();
        String sql = SQL_BASE_SELECT + " WHERE (" +
            // Caso 1: Estados 3 o 4 (cancelada/reprogramada) - LÓGICA EXACTA
            " ((r.tipoestado = 3 OR r.tipoestado = 4) AND r.fecha_actualizacion >= DATE_SUB(NOW(), INTERVAL 1 DAY)) " +
            " OR " +
            // Caso 2: Estado 1 (nueva reserva) - LÓGICA EXACTA
            " (r.tipoestado = 1 AND " +
            "  TIMESTAMPDIFF(MINUTE, NOW(), TIMESTAMP(r.DiaReserva, r.HoraReserva)) <= 120 " +
            "  AND TIMESTAMPDIFF(MINUTE, NOW(), TIMESTAMP(r.DiaReserva, r.HoraReserva)) >= 0)" +
            ") " +
            "ORDER BY " +
            "  CASE " +
            "    WHEN r.tipoestado = 1 THEN 1 " +
            "    WHEN r.tipoestado = 3 THEN 2 " +
            "    WHEN r.tipoestado = 4 THEN 3 " +
            "    ELSE 4 " +
            "  END, " +
            "  r.DiaReserva ASC, r.HoraReserva ASC";

        System.out.println("=== DEBUG DAO - listarNotificacionesUrgentes ===");
        System.out.println("SQL: " + sql);

        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                NotificacionReserva notif = mapearNotificacion(rs);
                notificaciones.add(notif);
                System.out.println("Urgente encontrada - ID: " + notif.getIdReserva() + 
                                 ", Estado: " + notif.getTipoEstado() + 
                                 ", Fecha Act: " + notif.getFechaActualizacion() +
                                 ", Día Reserva: " + notif.getDiaReserva() +
                                 ", Hora: " + notif.getHoraReserva());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        System.out.println("Total urgentes encontradas en SQL: " + notificaciones.size());
        return notificaciones;
    }
    
    @Override
    public List<NotificacionReserva> listarNotificacionesHoy() {
        List<NotificacionReserva> notificaciones = new ArrayList<>();
        String sql = SQL_BASE_SELECT + " WHERE DATE(r.fecha_actualizacion) = CURDATE() OR r.DiaReserva = CURDATE() " +
                     "ORDER BY r.fecha_actualizacion DESC, r.HoraReserva ASC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                NotificacionReserva notif = mapearNotificacion(rs);
                notificaciones.add(notif);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notificaciones;
    }
    
    @Override
    public List<NotificacionReserva> listarNotificacionesProximasCitas(int diasAdelante) {
        List<NotificacionReserva> notificaciones = new ArrayList<>();
        String sql = SQL_BASE_SELECT + " WHERE r.DiaReserva BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL ? DAY) " +
                     "AND r.tipoestado IN (1, 2) ORDER BY r.DiaReserva ASC, r.HoraReserva ASC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, diasAdelante);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NotificacionReserva notif = mapearNotificacion(rs);
                    notificaciones.add(notif);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notificaciones;
    }
    
    @Override
    public List<NotificacionReserva> listarReservasCanceladas(int diasAtras) {
        return listarNotificacionesPorEstado(3);
    }
    
    @Override
    public List<NotificacionReserva> listarReservasNuevas(int horasAtras) {
        List<NotificacionReserva> notificaciones = new ArrayList<>();
        String sql = SQL_BASE_SELECT + " WHERE r.tipoestado = 1 AND r.fecha_registro >= DATE_SUB(NOW(), INTERVAL ? HOUR) " +
                     "ORDER BY r.fecha_registro DESC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, horasAtras);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NotificacionReserva notif = mapearNotificacion(rs);
                    notificaciones.add(notif);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notificaciones;
    }
    
    @Override
    public List<NotificacionReserva> listarRecordatoriosCitas(int horasAdelante) {
        List<NotificacionReserva> notificaciones = new ArrayList<>();
        String sql = SQL_BASE_SELECT + " WHERE r.tipoestado = 2 AND " +
                     "TIMESTAMPDIFF(HOUR, NOW(), CONCAT(r.DiaReserva, ' ', r.HoraReserva)) BETWEEN 0 AND ? " +
                     "ORDER BY r.DiaReserva ASC, r.HoraReserva ASC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, horasAdelante);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NotificacionReserva notif = mapearNotificacion(rs);
                    notif.setTipoNotificacion("Recordatorio de Cita");
                    notif.setTitulo("Recordatorio: Cita Próxima");
                    notif.setIcono("fas fa-clock");
                    notif.setColor("warning");
                    notif.setPrioridad("ALTA");
                    notificaciones.add(notif);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notificaciones;
    }
    
    @Override
    public NotificacionReserva obtenerNotificacionPorReserva(int idReserva) {
        String sql = SQL_BASE_SELECT + " WHERE r.idReserva = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idReserva);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    NotificacionReserva notif = mapearNotificacion(rs);
                    return notif;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public int contarNotificacionesRecientes() {
        String sql = "SELECT COUNT(*) FROM reserva WHERE fecha_actualizacion >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
        return ejecutarConteo(sql);
    }
    
    @Override
    public int contarNotificacionesPorEstado(int tipoEstado) {
        String sql = "SELECT COUNT(*) FROM reserva WHERE tipoestado = ? AND fecha_actualizacion >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
        return ejecutarConteo(sql, tipoEstado);
    }
    
    @Override
    public int contarNotificacionesUrgentes() {
        String sql = "SELECT COUNT(*) FROM reserva WHERE (" +
            " ((tipoestado = 3 OR tipoestado = 4) AND fecha_actualizacion >= DATE_SUB(NOW(), INTERVAL 1 DAY)) " +
            " OR " +
            " (tipoestado = 1 AND " +
            "  TIMESTAMPDIFF(MINUTE, NOW(), TIMESTAMP(DiaReserva, HoraReserva)) <= 120 " +
            "  AND TIMESTAMPDIFF(MINUTE, NOW(), TIMESTAMP(DiaReserva, HoraReserva)) >= 0)" +
            ")";
        
        System.out.println("=== DEBUG DAO - contarNotificacionesUrgentes ===");
        System.out.println("SQL: " + sql);
        int count = ejecutarConteo(sql);
        System.out.println("Conteo urgentes SQL: " + count);
        return count;
    }
    
    @Override
    public int contarNotificacionesHoy() {
        String sql = "SELECT COUNT(*) FROM reserva WHERE DATE(fecha_actualizacion) = CURDATE() OR DiaReserva = CURDATE()";
        return ejecutarConteo(sql);
    }
    
    @Override
    public List<NotificacionReserva> obtenerEstadisticasNotificaciones() {
        return new ArrayList<>();
    }
    
    // Métodos auxiliares
    private int ejecutarConteo(String sql, Object... params) {
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    private NotificacionReserva mapearNotificacion(ResultSet rs) throws SQLException {
        NotificacionReserva notif = new NotificacionReserva();
        
        // Campos de reserva
        notif.setIdReserva(rs.getInt("idReserva"));
        notif.setDiaReserva(rs.getDate("DiaReserva"));
        notif.setHoraReserva(rs.getString("HoraReserva"));
        notif.setDescripcion(rs.getString("Descripcion"));
        notif.setDiaSemana(rs.getString("dia_semana"));
        notif.setTipoEstado(rs.getInt("tipoestado"));
        notif.setFechaRegistro(rs.getTimestamp("fecha_registro"));
        notif.setFechaActualizacion(rs.getTimestamp("fecha_actualizacion"));
        
        // Campos relacionados
        notif.setNombrePaciente(rs.getString("nombrePaciente"));
        notif.setApellidoPaciente(rs.getString("apellidoPaciente"));
        notif.setTelefonoPaciente(rs.getString("telefonoPaciente"));
        notif.setCorreoPaciente(rs.getString("correoPaciente"));
        notif.setNombreOdontologo(rs.getString("nombreOdontologo"));
        notif.setApellidoOdontologo(rs.getString("apellidoOdontologo"));
        notif.setTipoServicio(rs.getString("tipoServicio"));
        notif.setCostoServicio(rs.getDouble("costoServicio"));
        notif.setNombreUsuarioRegistro(rs.getString("nombreUsuarioRegistro"));
        
        return notif;
    }
}