package pe.edu.utp.daoimpl;

import pe.edu.utp.dao.CitaDAO;
import pe.edu.utp.entity.Cita;
import pe.edu.utp.dto.CitaDTO;
import pe.edu.utp.config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CitaDAOImpl implements CitaDAO {
    
    @Override
    public List<Cita> listarCitas() {
        List<Cita> citas = new ArrayList<>();
        String sql = "SELECT * FROM cita ORDER BY FechaHoraEntrada DESC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Cita cita = mapearCita(rs);
                citas.add(cita);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return citas;
    }
    
    @Override
    public Cita obtenerCitaPorId(int id) {
        Cita cita = null;
        String sql = "SELECT * FROM cita WHERE idCita = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cita = mapearCita(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cita;
    }
    
    @Override
    public boolean insertarCita(Cita cita) {
        String sql = "INSERT INTO cita (FechaHoraEntrada, FechaHoraSalida, Diagnostico, Recomendaciones, Observaciones, seguimiento_requerido, fechaSeguimiento, duracionMinutos, Servicio_idServicio, reserva_idReserva) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setTimestamp(1, cita.getFechaHoraEntrada());
            ps.setTimestamp(2, cita.getFechaHoraSalida());
            ps.setString(3, cita.getDiagnostico());
            ps.setString(4, cita.getRecomendaciones());
            ps.setString(5, cita.getObservaciones());
            ps.setBoolean(6, cita.isSeguimientoRequerido());
            ps.setDate(7, cita.getFechaSeguimiento());
            ps.setInt(8, cita.getDuracionMinutos());
            ps.setInt(9, cita.getServicioIdServicio());
            ps.setInt(10, cita.getReservaIdReserva());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean actualizarCita(Cita cita) {
        String sql = "UPDATE cita SET FechaHoraEntrada=?, FechaHoraSalida=?, Diagnostico=?, Recomendaciones=?, Observaciones=?, seguimiento_requerido=?, fechaSeguimiento=?, duracionMinutos=? WHERE idCita=?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setTimestamp(1, cita.getFechaHoraEntrada());
            ps.setTimestamp(2, cita.getFechaHoraSalida());
            ps.setString(3, cita.getDiagnostico());
            ps.setString(4, cita.getRecomendaciones());
            ps.setString(5, cita.getObservaciones());
            ps.setBoolean(6, cita.isSeguimientoRequerido());
            ps.setDate(7, cita.getFechaSeguimiento());
            ps.setInt(8, cita.getDuracionMinutos());
            ps.setInt(9, cita.getIdCita());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean eliminarCita(int id) {
        String sql = "DELETE FROM cita WHERE idCita = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean registrarEntrada(int idReserva) {
        // Primero verificar si ya existe una cita para esta reserva
        if (existeCitaParaReserva(idReserva)) {
            // Si ya existe, solo actualizar la fecha de entrada
            String sql = "UPDATE cita SET FechaHoraEntrada = NOW() WHERE reserva_idReserva = ? AND FechaHoraEntrada IS NULL";
            
            try (Connection conn = Conexion.getConection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                
                ps.setInt(1, idReserva);
                return ps.executeUpdate() > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        } else {
            // Si no existe, crear una nueva cita con FechaHoraSalida como NULL explícitamente
            String sql = "INSERT INTO cita (FechaHoraEntrada, FechaHoraSalida, Diagnostico, Recomendaciones, Observaciones, seguimiento_requerido, fechaSeguimiento, duracionMinutos, Servicio_idServicio, reserva_idReserva) " +
                        "SELECT NOW(), NULL, '', '', '', 0, NULL, NULL, r.Servicio_idServicio, r.idReserva " +
                        "FROM reserva r WHERE r.idReserva = ?";
            
            try (Connection conn = Conexion.getConection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                
                ps.setInt(1, idReserva);
                return ps.executeUpdate() > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }
    }
    
    @Override
    public boolean registrarSalida(int idReserva, String observaciones, String diagnostico, String tratamiento) {
        String sql = "UPDATE cita SET FechaHoraSalida=NOW(), Observaciones=?, Diagnostico=?, Recomendaciones=?, " +
                    "duracionMinutos=TIMESTAMPDIFF(MINUTE, FechaHoraEntrada, NOW()) " +
                    "WHERE reserva_idReserva=? AND FechaHoraSalida IS NULL";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, observaciones != null ? observaciones : "");
            ps.setString(2, diagnostico != null ? diagnostico : "");
            ps.setString(3, tratamiento != null ? tratamiento : "");
            ps.setInt(4, idReserva);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public List<CitaDTO> listarCitasDTO() {
        List<CitaDTO> citas = new ArrayList<>();
        String sql = "SELECT c.*, r.DiaReserva, r.HoraReserva, " +
                    "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, " +
                    "s.TipoServicio as nombreServicio, " +
                    "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo " +
                    "FROM cita c " +
                    "INNER JOIN reserva r ON c.reserva_idReserva = r.idReserva " +
                    "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente " +
                    "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio " +
                    "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario " +
                    "ORDER BY c.FechaHoraEntrada DESC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                CitaDTO citaDTO = mapearCitaDTO(rs);
                citas.add(citaDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return citas;
    }
    
    @Override
    public CitaDTO obtenerCitaDTOPorId(int id) {
        CitaDTO citaDTO = null;
        String sql = "SELECT c.*, r.DiaReserva, r.HoraReserva, " +
                    "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, " +
                    "s.TipoServicio as nombreServicio, " +
                    "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo " +
                    "FROM cita c " +
                    "INNER JOIN reserva r ON c.reserva_idReserva = r.idReserva " +
                    "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente " +
                    "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio " +
                    "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario " +
                    "WHERE c.idCita = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    citaDTO = mapearCitaDTO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return citaDTO;
    }
    
    @Override
    public List<CitaDTO> obtenerCitasPorReserva(int idReserva) {
        List<CitaDTO> citas = new ArrayList<>();
        String sql = "SELECT c.*, r.DiaReserva, r.HoraReserva, " +
                    "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, " +
                    "s.TipoServicio as nombreServicio, " +
                    "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo " +
                    "FROM cita c " +
                    "INNER JOIN reserva r ON c.reserva_idReserva = r.idReserva " +
                    "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente " +
                    "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio " +
                    "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario " +
                    "WHERE c.reserva_idReserva = ? " +
                    "ORDER BY c.FechaHoraEntrada DESC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idReserva);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CitaDTO citaDTO = mapearCitaDTO(rs);
                    citas.add(citaDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return citas;
    }
    
    @Override
    public List<CitaDTO> obtenerCitasCompletadas() {
        List<CitaDTO> citas = new ArrayList<>();
        String sql = "SELECT c.*, r.DiaReserva, r.HoraReserva, " +
                    "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, " +
                    "s.TipoServicio as nombreServicio, " +
                    "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo " +
                    "FROM cita c " +
                    "INNER JOIN reserva r ON c.reserva_idReserva = r.idReserva " +
                    "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente " +
                    "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio " +
                    "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario " +
                    "WHERE c.FechaHoraSalida IS NOT NULL " +
                    "ORDER BY c.FechaHoraSalida DESC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                CitaDTO citaDTO = mapearCitaDTO(rs);
                citas.add(citaDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return citas;
    }
    
    @Override
    public boolean existeCitaParaReserva(int idReserva) {
        String sql = "SELECT COUNT(*) FROM cita WHERE reserva_idReserva = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idReserva);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public Cita obtenerCitaPorReserva(int idReserva) {
        Cita cita = null;
        String sql = "SELECT * FROM cita WHERE reserva_idReserva = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idReserva);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cita = mapearCita(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cita;
    }
    
    private Cita mapearCita(ResultSet rs) throws SQLException {
        Cita cita = new Cita();
        cita.setIdCita(rs.getInt("idCita"));
        cita.setFechaHoraEntrada(rs.getTimestamp("FechaHoraEntrada"));
        cita.setFechaHoraSalida(rs.getTimestamp("FechaHoraSalida"));
        cita.setDiagnostico(rs.getString("Diagnostico"));
        cita.setRecomendaciones(rs.getString("Recomendaciones"));
        cita.setObservaciones(rs.getString("Observaciones"));
        cita.setSeguimientoRequerido(rs.getBoolean("seguimiento_requerido"));
        cita.setFechaSeguimiento(rs.getDate("fechaSeguimiento"));
        cita.setDuracionMinutos(rs.getInt("duracionMinutos"));
        cita.setServicioIdServicio(rs.getInt("Servicio_idServicio"));
        cita.setReservaIdReserva(rs.getInt("reserva_idReserva"));
        return cita;
    }
    
    private CitaDTO mapearCitaDTO(ResultSet rs) throws SQLException {
        CitaDTO citaDTO = new CitaDTO();
        
        // Datos básicos de la cita
        citaDTO.setIdCita(rs.getInt("idCita"));
        citaDTO.setFechaHoraEntrada(rs.getTimestamp("FechaHoraEntrada"));
        citaDTO.setFechaHoraSalida(rs.getTimestamp("FechaHoraSalida"));
        citaDTO.setDiagnostico(rs.getString("Diagnostico"));
        citaDTO.setObservaciones(rs.getString("Observaciones"));
        citaDTO.setReservaIdReserva(rs.getInt("reserva_idReserva"));
        citaDTO.setDuracionMinutos(rs.getInt("duracionMinutos"));
        
        // Datos de la reserva asociada
        citaDTO.setDiaReserva(rs.getDate("DiaReserva"));
        citaDTO.setHoraReserva(rs.getTime("HoraReserva"));
        
        // Datos de las entidades relacionadas
        citaDTO.setNombrePaciente(rs.getString("nombrePaciente"));
        citaDTO.setApellidoPaciente(rs.getString("apellidoPaciente"));
        citaDTO.setNombreServicio(rs.getString("nombreServicio"));
        citaDTO.setNombreOdontologo(rs.getString("nombreOdontologo"));
        citaDTO.setApellidoOdontologo(rs.getString("apellidoOdontologo"));
        
        // Campos calculados
        citaDTO.setNombreCompletoPaciente(rs.getString("nombrePaciente") + " " + rs.getString("apellidoPaciente"));
        citaDTO.setNombreCompletoOdontologo("Dr. " + rs.getString("nombreOdontologo") + " " + rs.getString("apellidoOdontologo"));
        
        return citaDTO;
    }
}
