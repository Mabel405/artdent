package pe.edu.utp.daoimpl;

import pe.edu.utp.dao.ServicioDAO;
import pe.edu.utp.entity.Servicio;
import pe.edu.utp.config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServicioDAOImpl implements ServicioDAO {

    @Override
    public List<Servicio> listarServicios() {
        List<Servicio> servicios = new ArrayList<>();
        String sql = "SELECT * FROM servicio ORDER BY idServicio";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Servicio servicio = new Servicio();
                servicio.setIdServicio(rs.getInt("idServicio"));
                servicio.setTipoServicio(rs.getString("TipoServicio"));
                servicio.setLema(rs.getString("Lema"));
                servicio.setDescripcion(rs.getString("Descripcion"));
                servicio.setRespuesta(rs.getString("Respuesta"));
                servicio.setCosto(rs.getBigDecimal("Costo"));
                servicio.setImg(rs.getString("img"));
                servicios.add(servicio);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return servicios;
    }

    @Override
    public Servicio obtenerServicioPorId(int id) {
        Servicio servicio = null;
        String sql = "SELECT * FROM servicio WHERE idServicio = ?";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    servicio = new Servicio();
                    servicio.setIdServicio(rs.getInt("idServicio"));
                    servicio.setTipoServicio(rs.getString("TipoServicio"));
                    servicio.setLema(rs.getString("Lema"));
                    servicio.setDescripcion(rs.getString("Descripcion"));
                    servicio.setRespuesta(rs.getString("Respuesta"));
                    servicio.setCosto(rs.getBigDecimal("Costo"));
                    servicio.setImg(rs.getString("img"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return servicio;
    }

    @Override
    public boolean insertarServicio(Servicio servicio) {
        String sql = "INSERT INTO servicio (TipoServicio, Lema, Descripcion, Respuesta, Costo, img) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, servicio.getTipoServicio());
            ps.setString(2, servicio.getLema());
            ps.setString(3, servicio.getDescripcion());
            ps.setString(4, servicio.getRespuesta());
            ps.setBigDecimal(5, servicio.getCosto());
            ps.setString(6, servicio.getImg());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizarServicio(Servicio servicio) {
        String sql = "UPDATE servicio SET TipoServicio=?, Lema=?, Descripcion=?, Respuesta=?, Costo=?, img=? WHERE idServicio=?";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, servicio.getTipoServicio());
            ps.setString(2, servicio.getLema());
            ps.setString(3, servicio.getDescripcion());
            ps.setString(4, servicio.getRespuesta());
            ps.setBigDecimal(5, servicio.getCosto());
            ps.setString(6, servicio.getImg());
            ps.setInt(7, servicio.getIdServicio());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminarServicio(int id) {
        String sql = "DELETE FROM servicio WHERE idServicio = ?";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Object[]> obtenerEstadisticasServicios() {
        List<Object[]> estadisticas = new ArrayList<>();
        String sql = "SELECT s.TipoServicio, COUNT(r.idReserva) as cantidad "
                + "FROM servicio s "
                + "LEFT JOIN reserva r ON s.idServicio = r.Servicio_idServicio "
                + "WHERE r.tipoestado = 4 "
                + // Solo citas completadas
                "GROUP BY s.idServicio, s.TipoServicio "
                + "ORDER BY cantidad DESC "
                + "LIMIT 5";

        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Object[] fila = new Object[2];
                fila[0] = rs.getString("TipoServicio");
                fila[1] = rs.getInt("cantidad");
                estadisticas.add(fila);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return estadisticas;
    }
}
