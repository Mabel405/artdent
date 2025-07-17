package pe.edu.utp.daoimpl;

import pe.edu.utp.dao.ReservaDAO;
import pe.edu.utp.entity.Reserva;
import pe.edu.utp.dto.ReservaDTO;
import pe.edu.utp.config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class ReservaDAOImpl implements ReservaDAO {

    @Override
    public List<Reserva> listarReservas() {
        List<Reserva> reservas = new ArrayList<>();
        String sql = "SELECT * FROM reserva ORDER BY DiaReserva DESC, HoraReserva DESC";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reserva reserva = mapearReserva(rs);
                reservas.add(reserva);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservas;
    }

    @Override
    public Reserva obtenerReservaPorId(int id) {
        Reserva reserva = null;
        String sql = "SELECT * FROM reserva WHERE idReserva = ?";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reserva = mapearReserva(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reserva;
    }

    @Override
    public boolean insertarReserva(Reserva reserva) {
        String sql = "INSERT INTO reserva (DiaReserva, HoraReserva, Descripcion, tipoestado, token_cliente, Usuario_idUsuario, Paciente_idPaciente, Servicio_idServicio, Odontologo_idUsuario, comprobante_idVenta) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, reserva.getDiaReserva());
            ps.setTime(2, reserva.getHoraReserva());
            ps.setString(3, reserva.getDescripcion());
            ps.setInt(4, reserva.getTipoEstado());
            ps.setString(5, reserva.getTokenCliente());
            ps.setInt(6, reserva.getUsuarioIdUsuario());
            ps.setInt(7, reserva.getPacienteIdPaciente());
            ps.setInt(8, reserva.getServicioIdServicio());
            ps.setInt(9, reserva.getOdontologoIdUsuario());
            ps.setInt(10, reserva.getComprobanteIdVenta());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizarReserva(Reserva reserva) {
        String sql = "UPDATE reserva SET DiaReserva=?, HoraReserva=?, Descripcion=?, tipoestado=?, Servicio_idServicio=?, Odontologo_idUsuario=? WHERE idReserva=?";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, reserva.getDiaReserva());
            ps.setTime(2, reserva.getHoraReserva());
            ps.setString(3, reserva.getDescripcion());
            ps.setInt(4, reserva.getTipoEstado());
            ps.setInt(5, reserva.getServicioIdServicio());
            ps.setInt(6, reserva.getOdontologoIdUsuario());
            ps.setInt(7, reserva.getIdReserva());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminarReserva(int id) {
        String sql = "DELETE FROM reserva WHERE idReserva = ?";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<ReservaDTO> listarReservasDTO() {
        List<ReservaDTO> reservas = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, p.DNI as dniPaciente, "
                + "s.TipoServicio as nombreServicio, "
                + "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo "
                + "FROM reserva r "
                + "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente "
                + "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio "
                + "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario "
                + "ORDER BY r.DiaReserva DESC, r.HoraReserva DESC";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ReservaDTO reservaDTO = mapearReservaDTO(rs);
                reservas.add(reservaDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservas;
    }

    @Override
    public ReservaDTO obtenerReservaDTOPorId(int id) {
        ReservaDTO reservaDTO = null;
        String sql = "SELECT r.*, "
                + "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, p.DNI as dniPaciente, "
                + "s.TipoServicio as nombreServicio, "
                + "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo "
                + "FROM reserva r "
                + "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente "
                + "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio "
                + "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario "
                + "WHERE r.idReserva = ?";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reservaDTO = mapearReservaDTO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservaDTO;
    }

    @Override
    public List<ReservaDTO> obtenerReservasPorFecha(Date fecha) {
        List<ReservaDTO> reservas = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, p.DNI as dniPaciente, "
                + "s.TipoServicio as nombreServicio, "
                + "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo "
                + "FROM reserva r "
                + "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente "
                + "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio "
                + "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario "
                + "WHERE r.DiaReserva = ? "
                + "ORDER BY r.HoraReserva";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, fecha);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReservaDTO reservaDTO = mapearReservaDTO(rs);
                    reservas.add(reservaDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservas;
    }

    // NUEVO: Método para obtener reservas por fecha y doctor específico
    @Override
    public List<ReservaDTO> obtenerReservasPorFechaYDoctor(Date fecha, int doctorId) {
        List<ReservaDTO> reservas = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, p.DNI as dniPaciente, "
                + "s.TipoServicio as nombreServicio, "
                + "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo "
                + "FROM reserva r "
                + "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente "
                + "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio "
                + "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario "
                + "WHERE r.DiaReserva = ? AND r.Odontologo_idUsuario = ? "
                + "ORDER BY r.HoraReserva";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, fecha);
            ps.setInt(2, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReservaDTO reservaDTO = mapearReservaDTO(rs);
                    reservas.add(reservaDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservas;
    }

    // NUEVO: Método para obtener reservas por rango de fechas y doctor
    @Override
    public List<ReservaDTO> obtenerReservasPorRangoFechaYDoctor(Date fechaInicio, Date fechaFin, int doctorId) {
        List<ReservaDTO> reservas = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, p.DNI as dniPaciente, "
                + "s.TipoServicio as nombreServicio, "
                + "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo "
                + "FROM reserva r "
                + "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente "
                + "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio "
                + "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario "
                + "WHERE r.DiaReserva BETWEEN ? AND ? AND r.Odontologo_idUsuario = ? "
                + "ORDER BY r.DiaReserva, r.HoraReserva";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, fechaInicio);
            ps.setDate(2, fechaFin);
            ps.setInt(3, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReservaDTO reservaDTO = mapearReservaDTO(rs);
                    reservas.add(reservaDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservas;
    }

    @Override
    public List<ReservaDTO> obtenerReservasPorPaciente(int pacienteId) {
        List<ReservaDTO> reservas = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, p.DNI as dniPaciente, "
                + "s.TipoServicio as nombreServicio, "
                + "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo "
                + "FROM reserva r "
                + "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente "
                + "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio "
                + "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario "
                + "WHERE r.Paciente_idPaciente = ? "
                + "ORDER BY r.DiaReserva DESC, r.HoraReserva DESC";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, pacienteId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReservaDTO reservaDTO = mapearReservaDTO(rs);
                    reservas.add(reservaDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservas;
    }

    @Override
    public List<ReservaDTO> obtenerReservasPorToken(String token) {
        List<ReservaDTO> reservas = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, p.DNI as dniPaciente, "
                + "s.TipoServicio as nombreServicio, "
                + "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo "
                + "FROM reserva r "
                + "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente "
                + "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio "
                + "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario "
                + "WHERE LOWER(r.token_cliente) = LOWER(?) "
                + "ORDER BY r.DiaReserva DESC, r.HoraReserva DESC";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReservaDTO reservaDTO = mapearReservaDTO(rs);
                    reservas.add(reservaDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservas;
    }

    @Override
    public boolean confirmarReserva(int id) {
        return cambiarEstadoReserva(id, 2);
    }

    @Override
    public boolean cancelarReserva(int id) {
        return cambiarEstadoReserva(id, 3);
    }

    @Override
    public boolean cambiarEstadoReserva(int id, int nuevoEstado) {
        String sql = "UPDATE reserva SET tipoestado = ? WHERE idReserva = ?";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, nuevoEstado);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean existeReservaEnHorario(Date fecha, Time hora, int odontologoId) {
        String sql = "SELECT COUNT(*) FROM reserva WHERE DiaReserva = ? AND HoraReserva = ? AND Odontologo_idUsuario = ? AND tipoestado IN (1, 2)";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, fecha);
            ps.setTime(2, hora);
            ps.setInt(3, odontologoId);

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
    public boolean pacienteTieneReservaActiva(int pacienteId) {
        String sql = "SELECT COUNT(*) FROM reserva WHERE Paciente_idPaciente = ? AND tipoestado IN (1, 2)";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, pacienteId);
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
    public String generarTokenCliente() {
        return UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    @Override
    public List<ReservaDTO> obtenerReservasPendientes() {
        return obtenerReservasPorEstado(1);
    }

    @Override
    public List<ReservaDTO> obtenerReservasConfirmadas() {
        return obtenerReservasPorEstado(2);
    }

    @Override
    public int contarReservasPorEstado(int estado) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM reserva WHERE tipoestado = ?";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, estado);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public int contarReservasPendientes() {
        String sql = "SELECT COUNT(*) FROM reserva WHERE tipoestado = 1";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

    private List<ReservaDTO> obtenerReservasPorEstado(int estado) {
        List<ReservaDTO> reservas = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, p.DNI as dniPaciente, "
                + "s.TipoServicio as nombreServicio, "
                + "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo "
                + "FROM reserva r "
                + "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente "
                + "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio "
                + "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario "
                + "WHERE r.tipoestado = ? "
                + "ORDER BY r.DiaReserva DESC, r.HoraReserva DESC";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, estado);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReservaDTO reservaDTO = mapearReservaDTO(rs);
                    reservas.add(reservaDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservas;
    }

    private Reserva mapearReserva(ResultSet rs) throws SQLException {
        Reserva reserva = new Reserva();
        reserva.setIdReserva(rs.getInt("idReserva"));
        reserva.setDiaReserva(rs.getDate("DiaReserva"));
        reserva.setHoraReserva(rs.getTime("HoraReserva"));
        reserva.setDescripcion(rs.getString("Descripcion"));
        reserva.setDiaSemana(rs.getString("dia_semana"));
        reserva.setTipoEstado(rs.getInt("tipoestado"));
        reserva.setTokenCliente(rs.getString("token_cliente"));
        reserva.setUsuarioIdUsuario(rs.getInt("Usuario_idUsuario"));
        reserva.setPacienteIdPaciente(rs.getInt("Paciente_idPaciente"));
        reserva.setServicioIdServicio(rs.getInt("Servicio_idServicio"));
        reserva.setOdontologoIdUsuario(rs.getInt("Odontologo_idUsuario"));
        reserva.setComprobanteIdVenta(rs.getInt("comprobante_idVenta"));
        return reserva;
    }

    private ReservaDTO mapearReservaDTO(ResultSet rs) throws SQLException {
        ReservaDTO reservaDTO = new ReservaDTO();

        // Datos básicos de la reserva
        reservaDTO.setIdReserva(rs.getInt("idReserva"));
        reservaDTO.setDiaReserva(rs.getDate("DiaReserva"));
        reservaDTO.setHoraReserva(rs.getTime("HoraReserva"));
        reservaDTO.setDescripcion(rs.getString("Descripcion"));
        reservaDTO.setTipoEstado(rs.getInt("tipoestado"));
        reservaDTO.setTokenCliente(rs.getString("token_cliente"));
        reservaDTO.setUsuarioIdUsuario(rs.getInt("Usuario_idUsuario"));
        reservaDTO.setPacienteIdPaciente(rs.getInt("Paciente_idPaciente"));
        reservaDTO.setServicioIdServicio(rs.getInt("Servicio_idServicio"));
        reservaDTO.setOdontologoIdUsuario(rs.getInt("Odontologo_idUsuario"));
        reservaDTO.setComprobanteIdVenta(rs.getInt("comprobante_idVenta"));

        // Datos de las entidades relacionadas
        reservaDTO.setNombrePaciente(rs.getString("nombrePaciente"));
        reservaDTO.setApellidoPaciente(rs.getString("apellidoPaciente"));
        reservaDTO.setNombreServicio(rs.getString("nombreServicio"));
        reservaDTO.setNombreOdontologo(rs.getString("nombreOdontologo"));
        reservaDTO.setApellidoOdontologo(rs.getString("apellidoOdontologo"));

        // Campos calculados
        reservaDTO.setNombreCompletoPaciente(rs.getString("nombrePaciente") + " " + rs.getString("apellidoPaciente"));
        reservaDTO.setNombreCompletoOdontologo("Dr. " + rs.getString("nombreOdontologo") + " " + rs.getString("apellidoOdontologo"));
        reservaDTO.setEstadoTexto(obtenerTextoEstadoReserva(rs.getInt("tipoestado")));

        return reservaDTO;
    }

    private String obtenerTextoEstadoReserva(int estado) {
        switch (estado) {
            case 1:
                return "Pendiente";
            case 2:
                return "Confirmada";
            case 3:
                return "Cancelada";
            case 4:
                return "Completada";
            case 5:
                return "En Proceso";
            default:
                return "Desconocido";
        }
    }

    @Override
    public ReservaDTO obtenerDetalleCompletoParaNotificacion(int id) {
        ReservaDTO reservaDTO = null;
        String sql = "SELECT r.*, "
                + "p.Nombre as nombrePaciente, p.Apellido as apellidoPaciente, p.DNI as dniPaciente, "
                + "p.Telefono as telefonoPaciente, p.Correo as correoPaciente, "
                + "s.TipoServicio as tipoServicio, s.Costo as costoServicio, "
                + "u.Nombre as nombreOdontologo, u.Apellido as apellidoOdontologo, "
                + "ur.Nombre as nombreUsuarioRegistro, ur.Apellido as apellidoUsuarioRegistro, "
                + "r.fecha_registro, r.fecha_actualizacion "
                + "FROM reserva r "
                + "INNER JOIN paciente p ON r.Paciente_idPaciente = p.idPaciente "
                + "INNER JOIN servicio s ON r.Servicio_idServicio = s.idServicio "
                + "INNER JOIN usuario u ON r.Odontologo_idUsuario = u.idUsuario "
                + "LEFT JOIN usuario ur ON r.Usuario_idUsuario = ur.idUsuario "
                + "WHERE r.idReserva = ?";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reservaDTO = mapearReservaDTOCompleto(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservaDTO;
    }

    private ReservaDTO mapearReservaDTOCompleto(ResultSet rs) throws SQLException {
        ReservaDTO reservaDTO = new ReservaDTO();

        // Datos básicos de la reserva
        reservaDTO.setIdReserva(rs.getInt("idReserva"));
        reservaDTO.setDiaReserva(rs.getDate("DiaReserva"));
        reservaDTO.setHoraReserva(rs.getTime("HoraReserva"));
        reservaDTO.setDescripcion(rs.getString("Descripcion"));
        reservaDTO.setDiaSemana(rs.getString("dia_semana"));
        reservaDTO.setTipoEstado(rs.getInt("tipoestado"));
        reservaDTO.setTokenCliente(rs.getString("token_cliente"));
        reservaDTO.setUsuarioIdUsuario(rs.getInt("Usuario_idUsuario"));
        reservaDTO.setPacienteIdPaciente(rs.getInt("Paciente_idPaciente"));
        reservaDTO.setServicioIdServicio(rs.getInt("Servicio_idServicio"));
        reservaDTO.setOdontologoIdUsuario(rs.getInt("Odontologo_idUsuario"));
        reservaDTO.setComprobanteIdVenta(rs.getInt("comprobante_idVenta"));

        // Datos del paciente
        reservaDTO.setNombrePaciente(rs.getString("nombrePaciente"));
        reservaDTO.setApellidoPaciente(rs.getString("apellidoPaciente"));
        reservaDTO.setDniPaciente(rs.getString("dniPaciente"));
        reservaDTO.setTelefonoPaciente(rs.getString("telefonoPaciente"));
        reservaDTO.setCorreoPaciente(rs.getString("correoPaciente"));

        // Datos del servicio
        reservaDTO.setTipoServicio(rs.getString("tipoServicio"));
        reservaDTO.setCostoServicio(rs.getDouble("costoServicio"));

        // Datos del odontólogo
        reservaDTO.setNombreOdontologo(rs.getString("nombreOdontologo"));
        reservaDTO.setApellidoOdontologo(rs.getString("apellidoOdontologo"));

        // Usuario que registró
        String nombreUsuario = rs.getString("nombreUsuarioRegistro");
        String apellidoUsuario = rs.getString("apellidoUsuarioRegistro");
        reservaDTO.setNombreUsuarioRegistro(nombreUsuario != null ? nombreUsuario + " " + (apellidoUsuario != null ? apellidoUsuario : "") : "Sistema");

        // Fechas
        reservaDTO.setFechaRegistro(rs.getTimestamp("fecha_registro"));
        reservaDTO.setFechaActualizacion(rs.getTimestamp("fecha_actualizacion"));

        // Campos calculados
        reservaDTO.setNombreCompletoPaciente(rs.getString("nombrePaciente") + " " + rs.getString("apellidoPaciente"));
        reservaDTO.setNombreCompletoOdontologo("Dr. " + rs.getString("nombreOdontologo") + " " + rs.getString("apellidoOdontologo"));
        reservaDTO.setEstadoTexto(obtenerTextoEstadoReserva(rs.getInt("tipoestado")));

        // Campos para notificaciones
        int tipoEstado = rs.getInt("tipoestado");
        reservaDTO.setColor(obtenerColorEstado(tipoEstado));
        reservaDTO.setIcono(obtenerIconoEstado(tipoEstado));
        reservaDTO.setPrioridad(obtenerPrioridadEstado(tipoEstado));
        reservaDTO.setTipoNotificacion(obtenerTextoEstadoReserva(tipoEstado));

        // Calcular día de la semana si no existe
        if (reservaDTO.getDiaSemana() == null || reservaDTO.getDiaSemana().isEmpty()) {
            reservaDTO.setDiaSemana(calcularDiaSemana(rs.getDate("DiaReserva")));
        }

        return reservaDTO;
    }

    private String obtenerColorEstado(int estado) {
        switch (estado) {
            case 1:
                return "success";  // Nueva
            case 2:
                return "info";     // Confirmada
            case 3:
                return "danger";   // Cancelada
            case 4:
                return "warning";  // Reprogramada
            default:
                return "secondary";
        }
    }

    private String obtenerIconoEstado(int estado) {
        switch (estado) {
            case 1:
                return "fas fa-calendar-plus";
            case 2:
                return "fas fa-calendar-check";
            case 3:
                return "fas fa-calendar-times";
            case 4:
                return "fas fa-calendar-alt";
            default:
                return "fas fa-calendar";
        }
    }

    private String obtenerPrioridadEstado(int estado) {
        switch (estado) {
            case 1:
                return "ALTA";     // Nueva reserva
            case 3:
                return "URGENTE";  // Cancelada
            case 4:
                return "ALTA";     // Reprogramada
            default:
                return "NORMAL";
        }
    }

    private String calcularDiaSemana(Date fecha) {
        if (fecha == null) {
            return "";
        }

        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(fecha);

        String[] dias = {"", "Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"};
        return dias[cal.get(java.util.Calendar.DAY_OF_WEEK)];
    }

}
