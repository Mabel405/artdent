package pe.edu.utp.dao;

import pe.edu.utp.entity.Cita;
import pe.edu.utp.dto.CitaDTO;
import java.util.List;

public interface CitaDAO {
    // Operaciones CRUD básicas
    List<Cita> listarCitas();
    Cita obtenerCitaPorId(int id);
    boolean insertarCita(Cita cita);
    boolean actualizarCita(Cita cita);
    boolean eliminarCita(int id);
    
    // Operaciones específicas para el flujo de citas
    boolean registrarEntrada(int idReserva);
    boolean registrarSalida(int idReserva, String observaciones, String diagnostico, String tratamiento);
    
    // Consultas con DTO
    List<CitaDTO> listarCitasDTO();
    CitaDTO obtenerCitaDTOPorId(int id);
    List<CitaDTO> obtenerCitasPorReserva(int idReserva);
    List<CitaDTO> obtenerCitasCompletadas();
    
    // Consultas de apoyo
    boolean existeCitaParaReserva(int idReserva);
    Cita obtenerCitaPorReserva(int idReserva);
}
