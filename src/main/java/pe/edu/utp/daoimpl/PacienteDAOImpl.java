package pe.edu.utp.daoimpl;

import pe.edu.utp.dao.PacienteDAO;
import pe.edu.utp.entity.Paciente;
import pe.edu.utp.config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PacienteDAOImpl implements PacienteDAO {
    
    @Override
    public List<Paciente> listarPacientes() {
        List<Paciente> pacientes = new ArrayList<>();
        String sql = "SELECT * FROM paciente ORDER BY idPaciente";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Paciente paciente = new Paciente();
                paciente.setIdPaciente(rs.getInt("idPaciente"));
                paciente.setNombre(rs.getString("Nombre"));
                paciente.setApellido(rs.getString("Apellido"));
                paciente.setDni(rs.getString("DNI"));
                paciente.setTelefono(rs.getString("Telefono"));
                paciente.setCorreo(rs.getString("Correo"));
                pacientes.add(paciente);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pacientes;
    }
    
    @Override
    public Paciente obtenerPacientePorId(int id) {
        Paciente paciente = null;
        String sql = "SELECT * FROM paciente WHERE idPaciente = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    paciente = new Paciente();
                    paciente.setIdPaciente(rs.getInt("idPaciente"));
                    paciente.setNombre(rs.getString("Nombre"));
                    paciente.setApellido(rs.getString("Apellido"));
                    paciente.setDni(rs.getString("DNI"));
                    paciente.setTelefono(rs.getString("Telefono"));
                    paciente.setCorreo(rs.getString("Correo"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paciente;
    }
    
    @Override
    public Paciente obtenerPacientePorDni(String dni) {
        Paciente paciente = null;
        String sql = "SELECT * FROM paciente WHERE DNI = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, dni);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    paciente = new Paciente();
                    paciente.setIdPaciente(rs.getInt("idPaciente"));
                    paciente.setNombre(rs.getString("Nombre"));
                    paciente.setApellido(rs.getString("Apellido"));
                    paciente.setDni(rs.getString("DNI"));
                    paciente.setTelefono(rs.getString("Telefono"));
                    paciente.setCorreo(rs.getString("Correo"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paciente;
    }
    
    @Override
    public boolean insertarPaciente(Paciente paciente) {
        String sql = "INSERT INTO paciente (Nombre, Apellido, DNI, Telefono, Correo) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, paciente.getNombre());
            ps.setString(2, paciente.getApellido());
            ps.setString(3, paciente.getDni());
            ps.setString(4, paciente.getTelefono());
            ps.setString(5, paciente.getCorreo());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean actualizarPaciente(Paciente paciente) {
        String sql = "UPDATE paciente SET Nombre=?, Apellido=?, DNI=?, Telefono=?, Correo=? WHERE idPaciente=?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, paciente.getNombre());
            ps.setString(2, paciente.getApellido());
            ps.setString(3, paciente.getDni());
            ps.setString(4, paciente.getTelefono());
            ps.setString(5, paciente.getCorreo());
            ps.setInt(6, paciente.getIdPaciente());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean eliminarPaciente(int id) {
        String sql = "DELETE FROM paciente WHERE idPaciente = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
