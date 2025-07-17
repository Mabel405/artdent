
package pe.edu.utp.entity;

import java.math.BigDecimal;

public class UsuarioServicio {
    private int idUsuario;
    private int idServicio;
    private boolean disponibilidad;
    
    // Campos adicionales para joins
    private String nombreUsuario;
    private String tipoServicio;
    private BigDecimal costoServicio;
    
    public UsuarioServicio() {}
    
    public UsuarioServicio(int idUsuario, int idServicio, boolean disponibilidad) {
        this.idUsuario = idUsuario;
        this.idServicio = idServicio;
        this.disponibilidad = disponibilidad;
    }
    
    // Getters y Setters
    public int getIdUsuario() {
        return idUsuario;
    }
    
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public int getIdServicio() {
        return idServicio;
    }
    
    public void setIdServicio(int idServicio) {
        this.idServicio = idServicio;
    }
    
    public boolean isDisponibilidad() {
        return disponibilidad;
    }
    
    public void setDisponibilidad(boolean disponibilidad) {
        this.disponibilidad = disponibilidad;
    }
    
    public String getNombreUsuario() {
        return nombreUsuario;
    }
    
    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }
    
    public String getTipoServicio() {
        return tipoServicio;
    }
    
    public void setTipoServicio(String tipoServicio) {
        this.tipoServicio = tipoServicio;
    }
    
    public BigDecimal getCostoServicio() {
        return costoServicio;
    }
    
    public void setCostoServicio(BigDecimal costoServicio) {
        this.costoServicio = costoServicio;
    }
}