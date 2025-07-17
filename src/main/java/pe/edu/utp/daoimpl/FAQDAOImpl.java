package pe.edu.utp.daoimpl;

import pe.edu.utp.dao.FAQDAO;
import pe.edu.utp.entity.FAQ;
import pe.edu.utp.config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FAQDAOImpl implements FAQDAO {
    @Override
    public List<FAQ> listarFAQs() {
        List<FAQ> faqs = new ArrayList<>();
        String sql = "SELECT * FROM faq ORDER BY Prioridad DESC, FechaCreacion DESC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                FAQ faq = new FAQ();
                faq.setIdFaq(rs.getInt("idFaq"));
                faq.setPregunta(rs.getString("Pregunta"));
                faq.setRespuesta(rs.getString("Respuesta"));
                faq.setPrioridad(rs.getInt("Prioridad"));
                faq.setActivo(rs.getBoolean("Activo"));
                faq.setFechaCreacion(rs.getTimestamp("FechaCreacion"));
                faq.setFechaActualizacion(rs.getTimestamp("FechaActualizacion"));
                faq.setServicioIdServicio(rs.getObject("Servicio_idServicio", Integer.class));
                faq.setUsuarioIdUsuario(rs.getInt("Usuario_idUsuario"));
                faqs.add(faq);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return faqs;
    }
    @Override
    public List<FAQ> listarFAQsActivos() {
        List<FAQ> faqs = new ArrayList<>();
        String sql = "SELECT * FROM faq WHERE Activo = 1 ORDER BY Prioridad DESC, FechaCreacion DESC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                FAQ faq = new FAQ();
                faq.setIdFaq(rs.getInt("idFaq"));
                faq.setPregunta(rs.getString("Pregunta"));
                faq.setRespuesta(rs.getString("Respuesta"));
                faq.setPrioridad(rs.getInt("Prioridad"));
                faq.setActivo(rs.getBoolean("Activo"));
                faq.setFechaCreacion(rs.getTimestamp("FechaCreacion"));
                faq.setFechaActualizacion(rs.getTimestamp("FechaActualizacion"));
                faq.setServicioIdServicio(rs.getObject("Servicio_idServicio", Integer.class));
                faq.setUsuarioIdUsuario(rs.getInt("Usuario_idUsuario"));
                faqs.add(faq);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return faqs;
    }
    
    @Override
    public List<FAQ> listarFAQsPorServicio(int idServicio) {
        List<FAQ> faqs = new ArrayList<>();
        String sql = "SELECT * FROM faq WHERE Servicio_idServicio = ? AND Activo = 1 ORDER BY Prioridad DESC";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idServicio);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FAQ faq = new FAQ();
                    faq.setIdFaq(rs.getInt("idFaq"));
                    faq.setPregunta(rs.getString("Pregunta"));
                    faq.setRespuesta(rs.getString("Respuesta"));
                    faq.setPrioridad(rs.getInt("Prioridad"));
                    faq.setActivo(rs.getBoolean("Activo"));
                    faq.setFechaCreacion(rs.getTimestamp("FechaCreacion"));
                    faq.setFechaActualizacion(rs.getTimestamp("FechaActualizacion"));
                    faq.setServicioIdServicio(rs.getObject("Servicio_idServicio", Integer.class));
                    faq.setUsuarioIdUsuario(rs.getInt("Usuario_idUsuario"));
                    faqs.add(faq);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return faqs;
    }
    
    @Override
    public FAQ obtenerFAQPorId(int id) {
        FAQ faq = null;
        String sql = "SELECT * FROM faq WHERE idFaq = ?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    faq = new FAQ();
                    faq.setIdFaq(rs.getInt("idFaq"));
                    faq.setPregunta(rs.getString("Pregunta"));
                    faq.setRespuesta(rs.getString("Respuesta"));
                    faq.setPrioridad(rs.getInt("Prioridad"));
                    faq.setActivo(rs.getBoolean("Activo"));
                    faq.setFechaCreacion(rs.getTimestamp("FechaCreacion"));
                    faq.setFechaActualizacion(rs.getTimestamp("FechaActualizacion"));
                    faq.setServicioIdServicio(rs.getObject("Servicio_idServicio", Integer.class));
                    faq.setUsuarioIdUsuario(rs.getInt("Usuario_idUsuario"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return faq;
    }
    
    @Override
    public boolean insertarFAQ(FAQ faq) {
        String sql = "INSERT INTO faq (Pregunta, Respuesta, Prioridad, Activo, Servicio_idServicio, Usuario_idUsuario) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, faq.getPregunta());
            ps.setString(2, faq.getRespuesta());
            ps.setInt(3, faq.getPrioridad());
            ps.setBoolean(4, faq.isActivo());
            if (faq.getServicioIdServicio() != null) {
                ps.setInt(5, faq.getServicioIdServicio());
            } else {
                ps.setNull(5, Types.INTEGER);
            }
            ps.setInt(6, faq.getUsuarioIdUsuario());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean actualizarFAQ(FAQ faq) {
        String sql = "UPDATE faq SET Pregunta=?, Respuesta=?, Prioridad=?, Activo=?, FechaActualizacion=CURRENT_TIMESTAMP WHERE idFaq=?";
        
        try (Connection conn = Conexion.getConection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, faq.getPregunta());
            ps.setString(2, faq.getRespuesta());
            ps.setInt(3, faq.getPrioridad());
            ps.setBoolean(4, faq.isActivo());
            ps.setInt(5, faq.getIdFaq());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean eliminarFAQ(int id) {
        String sql = "UPDATE faq SET Activo = 0 WHERE idFaq = ?";
        
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
