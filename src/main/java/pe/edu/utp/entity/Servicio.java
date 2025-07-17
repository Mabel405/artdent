package pe.edu.utp.entity;

import java.math.BigDecimal;

public class Servicio {
    private int idServicio;
    private String tipoServicio;
    private String lema;
    private String descripcion;
    private String respuesta;
    private BigDecimal costo;
    private String img;
    
    public Servicio() {}
    
    public Servicio(int idServicio, String tipoServicio, String lema, String descripcion, 
                    String respuesta, BigDecimal costo, String img) {
        this.idServicio = idServicio;
        this.tipoServicio = tipoServicio;
        this.lema = lema;
        this.descripcion = descripcion;
        this.respuesta = respuesta;
        this.costo = costo;
        this.img = img;
    }
    
    // Getters y Setters
    public int getIdServicio() {
        return idServicio;
    }
    
    public void setIdServicio(int idServicio) {
        this.idServicio = idServicio;
    }
    
    public String getTipoServicio() {
        return tipoServicio;
    }
    
    public void setTipoServicio(String tipoServicio) {
        this.tipoServicio = tipoServicio;
    }
    
    public String getLema() {
        return lema;
    }
    
    public void setLema(String lema) {
        this.lema = lema;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public String getRespuesta() {
        return respuesta;
    }
    
    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }
    
    public BigDecimal getCosto() {
        return costo;
    }
    
    public void setCosto(BigDecimal costo) {
        this.costo = costo;
    }
    
    public String getImg() {
        return img;
    }
    
    public void setImg(String img) {
        this.img = img;
    }
}
