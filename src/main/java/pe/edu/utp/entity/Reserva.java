package pe.edu.utp.entity;

import java.sql.Date;
import java.sql.Time;

public class Reserva {
    private int idReserva;
    private Date diaReserva;
    private Time horaReserva;
    private String descripcion;
    private String diaSemana;
    private int tipoEstado;
    private String tokenCliente;
    private int usuarioIdUsuario;
    private int pacienteIdPaciente;
    private int servicioIdServicio;
    private int odontologoIdUsuario;
    private int comprobanteIdVenta;
    
    public Reserva() {}
    
    // Constructor completo
    public Reserva(int idReserva, Date diaReserva, Time horaReserva, String descripcion,
                   String diaSemana, int tipoEstado, String tokenCliente, int usuarioIdUsuario,
                   int pacienteIdPaciente, int servicioIdServicio, int odontologoIdUsuario,
                   int comprobanteIdVenta) {
        this.idReserva = idReserva;
        this.diaReserva = diaReserva;
        this.horaReserva = horaReserva;
        this.descripcion = descripcion;
        this.diaSemana = diaSemana;
        this.tipoEstado = tipoEstado;
        this.tokenCliente = tokenCliente;
        this.usuarioIdUsuario = usuarioIdUsuario;
        this.pacienteIdPaciente = pacienteIdPaciente;
        this.servicioIdServicio = servicioIdServicio;
        this.odontologoIdUsuario = odontologoIdUsuario;
        this.comprobanteIdVenta = comprobanteIdVenta;
    }
    
    // Getters y Setters
    public int getIdReserva() {
        return idReserva;
    }
    
    public void setIdReserva(int idReserva) {
        this.idReserva = idReserva;
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
    
    public String getDescripcion() {
        return descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public String getDiaSemana() {
        return diaSemana;
    }
    
    public void setDiaSemana(String diaSemana) {
        this.diaSemana = diaSemana;
    }
    
    public int getTipoEstado() {
        return tipoEstado;
    }
    
    public void setTipoEstado(int tipoEstado) {
        this.tipoEstado = tipoEstado;
    }
    
    public String getTokenCliente() {
        return tokenCliente;
    }
    
    public void setTokenCliente(String tokenCliente) {
        this.tokenCliente = tokenCliente;
    }
    
    public int getUsuarioIdUsuario() {
        return usuarioIdUsuario;
    }
    
    public void setUsuarioIdUsuario(int usuarioIdUsuario) {
        this.usuarioIdUsuario = usuarioIdUsuario;
    }
    
    public int getPacienteIdPaciente() {
        return pacienteIdPaciente;
    }
    
    public void setPacienteIdPaciente(int pacienteIdPaciente) {
        this.pacienteIdPaciente = pacienteIdPaciente;
    }
    
    public int getServicioIdServicio() {
        return servicioIdServicio;
    }
    
    public void setServicioIdServicio(int servicioIdServicio) {
        this.servicioIdServicio = servicioIdServicio;
    }
    
    public int getOdontologoIdUsuario() {
        return odontologoIdUsuario;
    }
    
    public void setOdontologoIdUsuario(int odontologoIdUsuario) {
        this.odontologoIdUsuario = odontologoIdUsuario;
    }
    
    public int getComprobanteIdVenta() {
        return comprobanteIdVenta;
    }
    
    public void setComprobanteIdVenta(int comprobanteIdVenta) {
        this.comprobanteIdVenta = comprobanteIdVenta;
    }
}
