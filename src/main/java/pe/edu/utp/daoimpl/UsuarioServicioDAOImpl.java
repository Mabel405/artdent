package pe.edu.utp.daoimpl;

import pe.edu.utp.dao.UsuarioServicioDAO;
import pe.edu.utp.entity.UsuarioServicio;
import pe.edu.utp.entity.Usuario;
import pe.edu.utp.entity.Servicio;
import pe.edu.utp.config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioServicioDAOImpl implements UsuarioServicioDAO {
    
    @Override
    public List<UsuarioServicio> listarEspecializaciones() {
        List<UsuarioServicio> especializaciones = new ArrayList<>();
        String sql = "SELECT us.*, u.Nombre, u.Apellido, s.TipoServicio FROM usuario_servicio us INNER JOIN usuario u ON us.idUsuario = u.idUsuario INNER JOIN servicio s ON us.idServicio = s.idServicio WHERE u.Rol_idRol = 3 ORDER BY u.Apellido, u.Nombre, s.TipoServicio";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                UsuarioServicio us = new UsuarioServicio();
                us.setIdUsuario(rs.getInt("idUsuario"));
                us.setIdServicio(rs.getInt("idServicio"));
                us.setDisponibilidad(rs.getBoolean("Disponibilidad"));
                us.setNombreUsuario(rs.getString("Nombre") + " " + rs.getString("Apellido"));
                us.setTipoServicio(rs.getString("TipoServicio"));
                especializaciones.add(us);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return especializaciones;
    }
    
    @Override
    public List<UsuarioServicio> listarEspecializacionesPorOdontologo(int idUsuario) {
        List<UsuarioServicio> especializaciones = new ArrayList<>();
        String sql = "SELECT us.*, s.TipoServicio, s.Costo FROM usuario_servicio us INNER JOIN servicio s ON us.idServicio = s.idServicio WHERE us.idUsuario = ? ORDER BY s.TipoServicio";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UsuarioServicio us = new UsuarioServicio();
                    us.setIdUsuario(rs.getInt("idUsuario"));
                    us.setIdServicio(rs.getInt("idServicio"));
                    us.setDisponibilidad(rs.getBoolean("Disponibilidad"));
                    us.setTipoServicio(rs.getString("TipoServicio"));
                    us.setCostoServicio(rs.getBigDecimal("Costo"));
                    especializaciones.add(us);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return especializaciones;
    }
    
    @Override
    public List<Servicio> listarServiciosPorOdontologo(int idUsuario) {
        List<Servicio> servicios = new ArrayList<>();
        String sql = "SELECT s.* FROM servicio s INNER JOIN usuario_servicio us ON s.idServicio = us.idServicio WHERE us.idUsuario = ? AND us.Disponibilidad = 1 ORDER BY s.TipoServicio";
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Servicio servicio = new Servicio();
                    servicio.setIdServicio(rs.getInt("idServicio"));
                    servicio.setTipoServicio(rs.getString("TipoServicio"));
                    servicio.setLema(rs.getString("Lema"));
                    servicio.setDescripcion(rs.getString("Descripcion"));
                    servicio.setRespuesta(rs.getString("Respuesta"));
                    servicio.setCosto(rs.getBigDecimal("Costo"));
                    servicio.setImg(rs.getString("img"));
                    servicios.add(servicio);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return servicios;
    }
    
    @Override
    public List<Usuario> listarOdontologosPorServicio(int idServicio) {
        List<Usuario> odontologos = new ArrayList<>();
        String sql = "SELECT u.* FROM usuario u INNER JOIN usuario_servicio us ON u.idUsuario = us.idUsuario WHERE us.idServicio = ? AND us.Disponibilidad = 1 AND u.Rol_idRol = 3 ORDER BY u.Apellido, u.Nombre";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idServicio);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("idUsuario"));
                    usuario.setNombre(rs.getString("Nombre"));
                    usuario.setApellido(rs.getString("Apellido"));
                    usuario.setDni(rs.getString("DNI"));
                    usuario.setTelefono(rs.getString("Telefono"));
                    usuario.setCorreoElectronico(rs.getString("CorreoElectronico"));
                    usuario.setDireccion(rs.getString("Direccion"));
                    usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    usuario.setRolIdRol(rs.getInt("Rol_idRol"));
                    odontologos.add(usuario);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return odontologos;
    }
    
    @Override
    public boolean insertarEspecializacion(UsuarioServicio usuarioServicio) {
        String sql = "INSERT INTO usuario_servicio (idUsuario, idServicio, Disponibilidad) VALUES (?, ?, ?)";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, usuarioServicio.getIdUsuario());
            ps.setInt(2, usuarioServicio.getIdServicio());
            ps.setBoolean(3, usuarioServicio.isDisponibilidad());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean actualizarDisponibilidad(int idUsuario, int idServicio, boolean disponibilidad) {
        String sql = "UPDATE usuario_servicio SET Disponibilidad = ? WHERE idUsuario = ? AND idServicio = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBoolean(1, disponibilidad);
            ps.setInt(2, idUsuario);
            ps.setInt(3, idServicio);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean eliminarEspecializacion(int idUsuario, int idServicio) {
        String sql = "DELETE FROM usuario_servicio WHERE idUsuario = ? AND idServicio = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idUsuario);
            ps.setInt(2, idServicio);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean existeEspecializacion(int idUsuario, int idServicio) {
        String sql = "SELECT COUNT(*) FROM usuario_servicio WHERE idUsuario = ? AND idServicio = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idUsuario);
            ps.setInt(2, idServicio);
            
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
}