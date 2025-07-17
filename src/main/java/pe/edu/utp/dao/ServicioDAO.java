package pe.edu.utp.dao;

import pe.edu.utp.entity.Servicio;
import java.util.List;

public interface ServicioDAO {

    List<Servicio> listarServicios();

    Servicio obtenerServicioPorId(int id);

    boolean insertarServicio(Servicio servicio);

    boolean actualizarServicio(Servicio servicio);

    boolean eliminarServicio(int id);

    List<Object[]> obtenerEstadisticasServicios();
}
