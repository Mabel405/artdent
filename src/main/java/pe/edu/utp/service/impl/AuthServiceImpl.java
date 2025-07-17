package pe.edu.utp.service.impl;

import pe.edu.utp.service.AuthService;
import pe.edu.utp.dto.LoginDTO;
import pe.edu.utp.entity.Usuario;
import pe.edu.utp.dao.UsuarioDAO;
import pe.edu.utp.daoimpl.UsuarioDAOImpl;

public class AuthServiceImpl implements AuthService {
    private final UsuarioDAO usuarioDAO;
    
    public AuthServiceImpl() {
        this.usuarioDAO = new UsuarioDAOImpl();
    }
    
    // Constructor para inyección de dependencias (principio SOLID)
    public AuthServiceImpl(UsuarioDAO usuarioDAO) {
        this.usuarioDAO = usuarioDAO;
    }
    
    @Override
    public LoginDTO autenticar(String correo, String clave) {
        if (!validarCredenciales(correo, clave)) {
            return new LoginDTO(correo, false, "Por favor ingrese correo y contraseña válidos");
        }
        
        Usuario usuario = usuarioDAO.obtenerUsuarioPorCredenciales(correo.trim(), clave.trim());
        
        if (usuario != null) {
            String nombreCompleto = usuario.getNombre() + " " + usuario.getApellido();
            return new LoginDTO(correo, true, usuario.getRolIdRol(), nombreCompleto);
        } else {
            return new LoginDTO(correo, false, "Credenciales incorrectas");
        }
    }
    
    @Override
    public boolean validarCredenciales(String correo, String clave) {
        return correo != null && clave != null && 
               !correo.trim().isEmpty() && !clave.trim().isEmpty();
    }
    
    @Override
    public String obtenerRutaSegunRol(int rolId) {
        switch (rolId) {
            case 1: // Administrador
                return "admin/admin";
            case 2: // Secretaria
                return "secretaria";
            default:
                return "inicio";
        }
    }
    
    @Override
    public void cerrarSesion() {
        // Lógica adicional si es necesaria para el cierre de sesión
    }
}
