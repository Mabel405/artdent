package pe.edu.utp.dto;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class CitaDTO {
    // Datos básicos de la cita
    private int idCita;
    private Timestamp fechaHoraEntrada;
    private Timestamp fechaHoraSalida;
    private String diagnostico;
    private String observaciones;
    private String tratamiento;
    private int reservaIdReserva;
    private Integer duracionMinutos;
    
    // Datos de la reserva asociada
    private Date diaReserva;
    private Time horaReserva;
    private int tipoEstado;
    
    // Datos de las entidades relacionadas
    private String nombrePaciente;
    private String apellidoPaciente;
    private String nombreServicio;
    private String nombreOdontologo;
    private String apellidoOdontologo;
    
    // Campos calculados
    private String nombreCompletoPaciente;
    private String nombreCompletoOdontologo;
    private String estadoTexto;
    
    // Constructor vacío
    public CitaDTO() {}
    
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
    
    public String getObservaciones() {
        return observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    
    public String getTratamiento() {
        return tratamiento;
    }
    
    public void setTratamiento(String tratamiento) {
        this.tratamiento = tratamiento;
    }
    
    public int getReservaIdReserva() {
        return reservaIdReserva;
    }
    
    public void setReservaIdReserva(int reservaIdReserva) {
        this.reservaIdReserva = reservaIdReserva;
    }
    
    public Integer getDuracionMinutos() {
        return duracionMinutos;
    }
    
    public void setDuracionMinutos(Integer duracionMinutos) {
        this.duracionMinutos = duracionMinutos;
    }
    
    public Date getDiaReserva() {
        return diaReserva;
    }
    
    public void setDiaReserva(Date diaReserva) {
        this.diaReserva = diaReserva;
    }
    
    public Time getHoraReserva() {
        return horaReserva;
    }
    
    public void setHoraReserva(Time horaReserva) {
        this.horaReserva = horaReserva;
    }
    
    public int getTipoEstado() {
        return tipoEstado;
    }
    
    public void setTipoEstado(int tipoEstado) {
        this.tipoEstado = tipoEstado;
    }
    
    public String getNombrePaciente() {
        return nombrePaciente;
    }
    
    public void setNombrePaciente(String nombrePaciente) {
        this.nombrePaciente = nombrePaciente;
    }
    
    public String getApellidoPaciente() {
        return apellidoPaciente;
    }
    
    public void setApellidoPaciente(String apellidoPaciente) {
        this.apellidoPaciente = apellidoPaciente;
    }
    
    public String getNombreServicio() {
        return nombreServicio;
    }
    
    public void setNombreServicio(String nombreServicio) {
        this.nombreServicio = nombreServicio;
    }
    
    public String getNombreOdontologo() {
        return nombreOdontologo;
    }
    
    public void setNombreOdontologo(String nombreOdontologo) {
        this.nombreOdontologo = nombreOdontologo;
    }
    
    public String getApellidoOdontologo() {
        return apellidoOdontologo;
    }
    
    public void setApellidoOdontologo(String apellidoOdontologo) {
        this.apellidoOdontologo = apellidoOdontologo;
    }
    
    public String getNombreCompletoPaciente() {
        return nombreCompletoPaciente;
    }
    
    public void setNombreCompletoPaciente(String nombreCompletoPaciente) {
        this.nombreCompletoPaciente = nombreCompletoPaciente;
    }
    
    public String getNombreCompletoOdontologo() {
        return nombreCompletoOdontologo;
    }
    
    public void setNombreCompletoOdontologo(String nombreCompletoOdontologo) {
        this.nombreCompletoOdontologo = nombreCompletoOdontologo;
    }
    
    public String getEstadoTexto() {
        return estadoTexto;
    }
    
    public void setEstadoTexto(String estadoTexto) {
        this.estadoTexto = estadoTexto;
    }
    
    // Métodos de utilidad
    public boolean isCompletada() {
        return fechaHoraSalida != null;
    }
    
    public boolean isEnProceso() {
        return fechaHoraEntrada != null && fechaHoraSalida == null;
    }
    
    public String getDuracionTexto() {
        if (duracionMinutos != null && duracionMinutos > 0) {
            int horas = duracionMinutos / 60;
            int minutos = duracionMinutos % 60;
            if (horas > 0) {
                return horas + "h " + minutos + "m";
            } else {
                return minutos + "m";
            }
        }
        return "N/A";
    }
}
