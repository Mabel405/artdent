package pe.edu.utp.daoimpl;

import pe.edu.utp.dao.ComprobanteDAO;
import pe.edu.utp.entity.Comprobante;
import pe.edu.utp.config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class ComprobanteDAOImpl implements ComprobanteDAO {
    
    @Override
    public boolean insertarComprobante(Comprobante comprobante) {
        String sql = "INSERT INTO comprobante (Importe, TipodeDoc, RUC_Empresa, paciente_idPaciente, " +
                    "serie, numeroCorrelativo, tipopago, igv, subtotal, observaciones) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = Conexion.getConection(); 
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setBigDecimal(1, BigDecimal.valueOf(comprobante.getImporte()));
            ps.setString(2, comprobante.getTipoDoc());
            ps.setString(3, comprobante.getRucEmpresa());
            ps.setInt(4, comprobante.getPacienteIdPaciente());
            ps.setString(5, comprobante.getSerie());
            ps.setString(6, comprobante.getNumeroCorrelativo());
            ps.setInt(7, comprobante.getTipoPago());
            ps.setBigDecimal(8, BigDecimal.valueOf(comprobante.getIgv()));
            ps.setBigDecimal(9, BigDecimal.valueOf(comprobante.getSubtotal()));
            ps.setString(10, comprobante.getObservaciones());
            
            int filasAfectadas = ps.executeUpdate();
            
            if (filasAfectadas > 0) {
                // Obtener el ID generado
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        comprobante.setIdVenta(rs.getInt(1));
                    }
                }
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("Error al insertar comprobante: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public Comprobante obtenerComprobantePorId(int id) {
        Comprobante comprobante = null;
        String sql = "SELECT * FROM comprobante WHERE idVenta = ?";
        
        try (Connection conn = Conexion.getConection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    comprobante = mapearComprobante(rs);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener comprobante: " + e.getMessage());
            e.printStackTrace();
        }
        
        return comprobante;
    }
    
    @Override
    public List<Comprobante> listarComprobantes() {
        List<Comprobante> comprobantes = new ArrayList<>();
        String sql = "SELECT * FROM comprobante ORDER BY fecha_horaEmision DESC";
        
        try (Connection conn = Conexion.getConection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Comprobante comprobante = mapearComprobante(rs);
                comprobantes.add(comprobante);
            }
            
        } catch (SQLException e) {
            System.err.println("Error al listar comprobantes: " + e.getMessage());
            e.printStackTrace();
        }
        
        return comprobantes;
    }
    
    @Override
    public boolean actualizarComprobante(Comprobante comprobante) {
        String sql = "UPDATE comprobante SET Importe=?, TipodeDoc=?, RUC_Empresa=?, " +
                    "tipopago=?, igv=?, subtotal=?, observaciones=? WHERE idVenta=?";
        
        try (Connection conn = Conexion.getConection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBigDecimal(1, BigDecimal.valueOf(comprobante.getImporte()));
            ps.setString(2, comprobante.getTipoDoc());
            ps.setString(3, comprobante.getRucEmpresa());
            ps.setInt(4, comprobante.getTipoPago());
            ps.setBigDecimal(5, BigDecimal.valueOf(comprobante.getIgv()));
            ps.setBigDecimal(6, BigDecimal.valueOf(comprobante.getSubtotal()));
            ps.setString(7, comprobante.getObservaciones());
            ps.setInt(8, comprobante.getIdVenta());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al actualizar comprobante: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean eliminarComprobante(int id) {
        String sql = "DELETE FROM comprobante WHERE idVenta = ?";
        
        try (Connection conn = Conexion.getConection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al eliminar comprobante: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public List<Comprobante> obtenerComprobantesPorPaciente(int pacienteId) {
        List<Comprobante> comprobantes = new ArrayList<>();
        String sql = "SELECT * FROM comprobante WHERE paciente_idPaciente = ? ORDER BY fecha_horaEmision DESC";
        
        try (Connection conn = Conexion.getConection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, pacienteId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Comprobante comprobante = mapearComprobante(rs);
                    comprobantes.add(comprobante);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener comprobantes por paciente: " + e.getMessage());
            e.printStackTrace();
        }
        
        return comprobantes;
    }
    
    @Override
    public String generarNumeroCorrelativo() {
        String serie = generarSerie();
        String sql = "SELECT LPAD(COALESCE(MAX(CAST(numeroCorrelativo AS UNSIGNED)), 0) + 1, 4, '0') as siguiente " +
                    "FROM comprobante WHERE serie = ?";
        
        try (Connection conn = Conexion.getConection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, serie);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("siguiente");
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al generar número correlativo: " + e.getMessage());
            e.printStackTrace();
        }
        
        return "0001"; // Valor por defecto
    }
    
    @Override
    public String generarSerie() {
        // Generar serie basada en el año actual
        int año = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
        return "F" + String.valueOf(año).substring(2); // Ejemplo: F24 para 2024
    }
    
    private Comprobante mapearComprobante(ResultSet rs) throws SQLException {
        Comprobante comprobante = new Comprobante();
        
        comprobante.setIdVenta(rs.getInt("idVenta"));
        comprobante.setImporte(rs.getBigDecimal("Importe") != null ? rs.getBigDecimal("Importe").doubleValue() : 0.0);
        comprobante.setTipoDoc(rs.getString("TipodeDoc"));
        comprobante.setRucEmpresa(rs.getString("RUC_Empresa"));
        comprobante.setPacienteIdPaciente(rs.getInt("paciente_idPaciente"));
        comprobante.setSerie(rs.getString("serie"));
        comprobante.setNumeroCorrelativo(rs.getString("numeroCorrelativo"));
        comprobante.setFechaHoraEmision(rs.getTimestamp("fecha_horaEmision"));
        comprobante.setTipoPago(rs.getInt("tipopago"));
        comprobante.setIgv(rs.getBigDecimal("igv") != null ? rs.getBigDecimal("igv").doubleValue() : 0.0);
        comprobante.setSubtotal(rs.getBigDecimal("subtotal") != null ? rs.getBigDecimal("subtotal").doubleValue() : 0.0);
        comprobante.setObservaciones(rs.getString("observaciones"));
        
        return comprobante;
    }
}