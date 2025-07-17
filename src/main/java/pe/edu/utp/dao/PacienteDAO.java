package pe.edu.utp.dao;

import pe.edu.utp.entity.Paciente;
import java.util.List;

public interface PacienteDAO {
    List<Paciente> listarPacientes();
    Paciente obtenerPacientePorId(int id);
    Paciente obtenerPacientePorDni(String dni);
    boolean insertarPaciente(Paciente paciente);
    boolean actualizarPaciente(Paciente paciente);
    boolean eliminarPaciente(int id);
}
