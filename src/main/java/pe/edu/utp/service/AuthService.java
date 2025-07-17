package pe.edu.utp.service;

import pe.edu.utp.dto.LoginDTO;
import pe.edu.utp.entity.Usuario;

public interface AuthService {
    LoginDTO autenticar(String correo, String clave);
    boolean validarCredenciales(String correo, String clave);
    String obtenerRutaSegunRol(int rolId);
    void cerrarSesion();
}
