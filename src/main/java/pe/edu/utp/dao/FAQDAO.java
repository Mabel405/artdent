package pe.edu.utp.dao;

import pe.edu.utp.entity.FAQ;
import java.util.List;

public interface FAQDAO {
    List<FAQ> listarFAQs();
    List<FAQ> listarFAQsActivos();
    List<FAQ> listarFAQsPorServicio(int idServicio);
    FAQ obtenerFAQPorId(int id);
    boolean insertarFAQ(FAQ faq);
    boolean actualizarFAQ(FAQ faq);
    boolean eliminarFAQ(int id);
}
