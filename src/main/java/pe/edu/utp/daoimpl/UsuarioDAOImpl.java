package pe.edu.utp.daoimpl;

import pe.edu.utp.dao.UsuarioDAO;
import pe.edu.utp.entity.Usuario;
import pe.edu.utp.config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAOImpl implements UsuarioDAO {
    
    @Override
    public List<Usuario> listarUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuario ORDER BY idUsuario";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
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
                usuario.setClave(rs.getString("Clave"));
                usuario.setRolIdRol(rs.getInt("Rol_idRol"));
                usuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarios;
    }
    
    @Override
    public List<Usuario> listarOdontologos() {
        List<Usuario> odontologos = new ArrayList<>();
        String sql = "SELECT u.* FROM usuario u INNER JOIN rol r ON u.Rol_idRol = r.idRol WHERE r.TipoRol = 'Odontologo'";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
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
                usuario.setClave(rs.getString("Clave"));
                usuario.setRolIdRol(rs.getInt("Rol_idRol"));
                odontologos.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return odontologos;
    }
    
    @Override
    public Usuario obtenerUsuarioPorId(int id) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuario WHERE idUsuario = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("idUsuario"));
                    usuario.setNombre(rs.getString("Nombre"));
                    usuario.setApellido(rs.getString("Apellido"));
                    usuario.setDni(rs.getString("DNI"));
                    usuario.setTelefono(rs.getString("Telefono"));
                    usuario.setCorreoElectronico(rs.getString("CorreoElectronico"));
                    usuario.setDireccion(rs.getString("Direccion"));
                    usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    usuario.setClave(rs.getString("Clave"));
                    usuario.setRolIdRol(rs.getInt("Rol_idRol"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }
    
    @Override
    public Usuario obtenerUsuarioPorCredenciales(String correo, String clave) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuario WHERE CorreoElectronico = ? AND Clave = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, correo);
            ps.setString(2, clave);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("idUsuario"));
                    usuario.setNombre(rs.getString("Nombre"));
                    usuario.setApellido(rs.getString("Apellido"));
                    usuario.setDni(rs.getString("DNI"));
                    usuario.setTelefono(rs.getString("Telefono"));
                    usuario.setCorreoElectronico(rs.getString("CorreoElectronico"));
                    usuario.setDireccion(rs.getString("Direccion"));
                    usuario.setFechaNacimiento(rs.getDate("FechaNacimiento"));
                    usuario.setClave(rs.getString("Clave"));
                    usuario.setRolIdRol(rs.getInt("Rol_idRol"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }
    
    @Override
    public boolean insertarUsuario(Usuario usuario) {
        String sql = "INSERT INTO usuario (Nombre, Apellido, DNI, Telefono, CorreoElectronico, Direccion, FechaNacimiento, Clave, Rol_idRol) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getDni());
            ps.setString(4, usuario.getTelefono());
            ps.setString(5, usuario.getCorreoElectronico());
            ps.setString(6, usuario.getDireccion());
            ps.setDate(7, new java.sql.Date(usuario.getFechaNacimiento().getTime()));
            ps.setString(8, usuario.getClave());
            ps.setInt(9, usuario.getRolIdRol());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean actualizarUsuario(Usuario usuario) {
        String sql = "UPDATE usuario SET Nombre=?, Apellido=?, DNI=?, Telefono=?, CorreoElectronico=?, Direccion=?, FechaNacimiento=?, Clave=?, Rol_idRol=? WHERE idUsuario=?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getDni());
            ps.setString(4, usuario.getTelefono());
            ps.setString(5, usuario.getCorreoElectronico());
            ps.setString(6, usuario.getDireccion());
            ps.setDate(7, new java.sql.Date(usuario.getFechaNacimiento().getTime()));
            ps.setString(8, usuario.getClave());
            ps.setInt(9, usuario.getRolIdRol());
            ps.setInt(10, usuario.getIdUsuario());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean eliminarUsuario(int id) {
        String sql = "DELETE FROM usuario WHERE idUsuario = ?";
        
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
