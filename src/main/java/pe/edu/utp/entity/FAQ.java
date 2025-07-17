package pe.edu.utp.entity;

import java.util.Date;

public class FAQ {
    private int idFaq;
    private String pregunta;
    private String respuesta;
    private int prioridad;
    private boolean activo;
    private Date fechaCreacion;
    private Date fechaActualizacion;
    private Integer servicioIdServicio;
    private int usuarioIdUsuario;
    
    public FAQ() {}
    
    public FAQ(int idFaq, String pregunta, String respuesta, int prioridad, 
               boolean activo, Date fechaCreacion, Date fechaActualizacion,
               Integer servicioIdServicio, int usuarioIdUsuario) {
        this.idFaq = idFaq;
        this.pregunta = pregunta;
        this.respuesta = respuesta;
        this.prioridad = prioridad;
        this.activo = activo;
        this.fechaCreacion = fechaCreacion;
        this.fechaActualizacion = fechaActualizacion;
        this.servicioIdServicio = servicioIdServicio;
        this.usuarioIdUsuario = usuarioIdUsuario;
    }
    
    // Getters y Setters
    public int getIdFaq() {
        return idFaq;
    }
    
    public void setIdFaq(int idFaq) {
        this.idFaq = idFaq;
    }
    
    public String getPregunta() {
        return pregunta;
    }
    
    public void setPregunta(String pregunta) {
        this.pregunta = pregunta;
    }
    
    public String getRespuesta() {
        return respuesta;
    }
    
    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }
    
    public int getPrioridad() {
        return prioridad;
    }
    
    public void setPrioridad(int prioridad) {
        this.prioridad = prioridad;
    }
    
    public boolean isActivo() {
        return activo;
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    public Date getFechaCreacion() {
        return fechaCreacion;
    }
    
    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    public Date getFechaActualizacion() {
        return fechaActualizacion;
    }
    
    public void setFechaActualizacion(Date fechaActualizacion) {
        this.fechaActualizacion = fechaActualizacion;
    }
    
    public Integer getServicioIdServicio() {
        return servicioIdServicio;
    }
    
    public void setServicioIdServicio(Integer servicioIdServicio) {
        this.servicioIdServicio = servicioIdServicio;
    }
    
    public int getUsuarioIdUsuario() {
        return usuarioIdUsuario;
    }
    
    public void setUsuarioIdUsuario(int usuarioIdUsuario) {
        this.usuarioIdUsuario = usuarioIdUsuario;
    }
}
