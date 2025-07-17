package pe.edu.utp.dto;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class ReservaDTO {
    // Campos básicos de reserva
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
    
    // Campos del paciente
    private String nombrePaciente;
    private String apellidoPaciente;
    private String dniPaciente;
    private String telefonoPaciente;
    private String correoPaciente;
    private String nombreCompletoPaciente;
    
    // Campos del servicio
    private String nombreServicio;
    private String tipoServicio;
    private double costoServicio;
    
    // Campos del odontólogo
    private String nombreOdontologo;
    private String apellidoOdontologo;
    private String nombreCompletoOdontologo;
    
    // Campos de usuario que registró
    private String nombreUsuarioRegistro;
    private String apellidoUsuarioRegistro;
    
    // Campos de fechas
    private Timestamp fechaRegistro;
    private Timestamp fechaActualizacion;
    
    // Campos calculados
    private String estadoTexto;
    
    // Campos para notificaciones
    private String color;
    private String icono;
    private String prioridad;
    private String tipoNotificacion;
    
    // Constructor vacío
    public ReservaDTO() {}
    
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
    
    public String getDniPaciente() {
        return dniPaciente;
    }
    
    public void setDniPaciente(String dniPaciente) {
        this.dniPaciente = dniPaciente;
    }
    
    public String getTelefonoPaciente() {
        return telefonoPaciente;
    }
    
    public void setTelefonoPaciente(String telefonoPaciente) {
        this.telefonoPaciente = telefonoPaciente;
    }
    
    public String getCorreoPaciente() {
        return correoPaciente;
    }
    
    public void setCorreoPaciente(String correoPaciente) {
        this.correoPaciente = correoPaciente;
    }
    
    public String getNombreCompletoPaciente() {
        return nombreCompletoPaciente;
    }
    
    public void setNombreCompletoPaciente(String nombreCompletoPaciente) {
        this.nombreCompletoPaciente = nombreCompletoPaciente;
    }
    
    public String getNombreServicio() {
        return nombreServicio;
    }
    
    public void setNombreServicio(String nombreServicio) {
        this.nombreServicio = nombreServicio;
    }
    
    public String getTipoServicio() {
        return tipoServicio;
    }
    
    public void setTipoServicio(String tipoServicio) {
        this.tipoServicio = tipoServicio;
    }
    
    public double getCostoServicio() {
        return costoServicio;
    }
    
    public void setCostoServicio(double costoServicio) {
        this.costoServicio = costoServicio;
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
    
    public String getNombreCompletoOdontologo() {
        return nombreCompletoOdontologo;
    }
    
    public void setNombreCompletoOdontologo(String nombreCompletoOdontologo) {
        this.nombreCompletoOdontologo = nombreCompletoOdontologo;
    }
    
    public String getNombreUsuarioRegistro() {
        return nombreUsuarioRegistro;
    }
    
    public void setNombreUsuarioRegistro(String nombreUsuarioRegistro) {
        this.nombreUsuarioRegistro = nombreUsuarioRegistro;
    }
    
    public String getApellidoUsuarioRegistro() {
        return apellidoUsuarioRegistro;
    }
    
    public void setApellidoUsuarioRegistro(String apellidoUsuarioRegistro) {
        this.apellidoUsuarioRegistro = apellidoUsuarioRegistro;
    }
    
    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }
    
    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
    
    public Timestamp getFechaActualizacion() {
        return fechaActualizacion;
    }
    
    public void setFechaActualizacion(Timestamp fechaActualizacion) {
        this.fechaActualizacion = fechaActualizacion;
    }
    
    public String getEstadoTexto() {
        return estadoTexto;
    }
    
    public void setEstadoTexto(String estadoTexto) {
        this.estadoTexto = estadoTexto;
    }
    
    public String getColor() {
        return color;
    }
    
    public void setColor(String color) {
        this.color = color;
    }
    
    public String getIcono() {
        return icono;
    }
    
    public void setIcono(String icono) {
        this.icono = icono;
    }
    
    public String getPrioridad() {
        return prioridad;
    }
    
    public void setPrioridad(String prioridad) {
        this.prioridad = prioridad;
    }
    
    public String getTipoNotificacion() {
        return tipoNotificacion;
    }
    
    public void setTipoNotificacion(String tipoNotificacion) {
        this.tipoNotificacion = tipoNotificacion;
    }
}