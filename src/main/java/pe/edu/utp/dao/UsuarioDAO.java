package pe.edu.utp.dao;

import pe.edu.utp.entity.Usuario;
import java.util.List;

public interface UsuarioDAO {
    List<Usuario> listarUsuarios();
    List<Usuario> listarOdontologos();
    Usuario obtenerUsuarioPorId(int id);
    Usuario obtenerUsuarioPorCredenciales(String correo, String clave);
    boolean insertarUsuario(Usuario usuario);
    boolean actualizarUsuario(Usuario usuario);
    boolean eliminarUsuario(int id);
}
