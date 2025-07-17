package pe.edu.utp.dao;

import pe.edu.utp.entity.Comprobante;
import java.util.List;

public interface ComprobanteDAO {
    
    /**
     * Insertar un nuevo comprobante
     */
    boolean insertarComprobante(Comprobante comprobante);
    
    /**
     * Obtener comprobante por ID
     */
    Comprobante obtenerComprobantePorId(int id);
    
    /**
     * Listar todos los comprobantes
     */
    List<Comprobante> listarComprobantes();
    
    /**
     * Actualizar comprobante
     */
    boolean actualizarComprobante(Comprobante comprobante);
    
    /**
     * Eliminar comprobante
     */
    boolean eliminarComprobante(int id);
    
    /**
     * Obtener comprobantes por paciente
     */
    List<Comprobante> obtenerComprobantesPorPaciente(int pacienteId);
    
    /**
     * Generar número correlativo para el comprobante
     */
    String generarNumeroCorrelativo();
    
    /**
     * Generar serie para el comprobante
     */
    String generarSerie();
}