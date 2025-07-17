package pe.edu.utp.entity;

import java.sql.Date;
import java.sql.Timestamp;

public class Cita {
    private int idCita;
    private Timestamp fechaHoraEntrada;
    private Timestamp fechaHoraSalida;
    private String diagnostico;
    private String recomendaciones;
    private String observaciones;
    private boolean seguimientoRequerido;
    private Date fechaSeguimiento;
    private Integer duracionMinutos;
    private int servicioIdServicio;
    private int reservaIdReserva;
    
    // Constructor vacío
    public Cita() {}
    
    // Constructor completo
    public Cita(int idCita, Timestamp fechaHoraEntrada, Timestamp fechaHoraSalida, 
                String diagnostico, String recomendaciones, String observaciones, 
                boolean seguimientoRequerido, Date fechaSeguimiento, Integer duracionMinutos,
                int servicioIdServicio, int reservaIdReserva) {
        this.idCita = idCita;
        this.fechaHoraEntrada = fechaHoraEntrada;
        this.fechaHoraSalida = fechaHoraSalida;
        this.diagnostico = diagnostico;
        this.recomendaciones = recomendaciones;
        this.observaciones = observaciones;
        this.seguimientoRequerido = seguimientoRequerido;
        this.fechaSeguimiento = fechaSeguimiento;
        this.duracionMinutos = duracionMinutos;
        this.servicioIdServicio = servicioIdServicio;
        this.reservaIdReserva = reservaIdReserva;
    }
    
    // Getters y Setters
    public int getIdCita() {
        return idCita;
    }
    
    public void setIdCita(int idCita) {
        this.idCita = idCita;
    }
    
    public Timestamp getFechaHoraEntrada() {
        return fechaHoraEntrada;
    }
    
    public void setFechaHoraEntrada(Timestamp fechaHoraEntrada) {
        this.fechaHoraEntrada = fechaHoraEntrada;
    }
    
    public Timestamp getFechaHoraSalida() {
        return fechaHoraSalida;
    }
    
    public void setFechaHoraSalida(Timestamp fechaHoraSalida) {
        this.fechaHoraSalida = fechaHoraSalida;
    }
    
    public String getDiagnostico() {
        return diagnostico;
    }
    
    public void setDiagnostico(String diagnostico) {
        this.diagnostico = diagnostico;
    }
    
    public String getRecomendaciones() {
        return recomendaciones;
    }
    
    public void setRecomendaciones(String recomendaciones) {
        this.recomendaciones = recomendaciones;
    }
    
    public String getObservaciones() {
        return observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    
    public boolean isSeguimientoRequerido() {
        return seguimientoRequerido;
    }
    
    public void setSeguimientoRequerido(boolean seguimientoRequerido) {
        this.seguimientoRequerido = seguimientoRequerido;
    }
    
    public Date getFechaSeguimiento() {
        return fechaSeguimiento;
    }
    
    public void setFechaSeguimiento(Date fechaSeguimiento) {
        this.fechaSeguimiento = fechaSeguimiento;
    }
    
    public Integer getDuracionMinutos() {
        return duracionMinutos;
    }
    
    public void setDuracionMinutos(Integer duracionMinutos) {
        this.duracionMinutos = duracionMinutos;
    }
    
    public int getServicioIdServicio() {
        return servicioIdServicio;
    }
    
    public void setServicioIdServicio(int servicioIdServicio) {
        this.servicioIdServicio = servicioIdServicio;
    }
    
    public int getReservaIdReserva() {
        return reservaIdReserva;
    }
    
    public void setReservaIdReserva(int reservaIdReserva) {
        this.reservaIdReserva = reservaIdReserva;
    }
}
