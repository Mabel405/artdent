package pe.edu.utp.dao;

import pe.edu.utp.entity.UsuarioServicio;
import pe.edu.utp.entity.Usuario;
import pe.edu.utp.entity.Servicio;
import java.util.List;

public interface UsuarioServicioDAO {
    List<UsuarioServicio> listarEspecializaciones();
    List<UsuarioServicio> listarEspecializacionesPorOdontologo(int idUsuario);
    List<Servicio> listarServiciosPorOdontologo(int idUsuario);
    List<Usuario> listarOdontologosPorServicio(int idServicio);
    boolean insertarEspecializacion(UsuarioServicio usuarioServicio);
    boolean actualizarDisponibilidad(int idUsuario, int idServicio, boolean disponibilidad);
    boolean eliminarEspecializacion(int idUsuario, int idServicio);
    boolean existeEspecializacion(int idUsuario, int idServicio);
}