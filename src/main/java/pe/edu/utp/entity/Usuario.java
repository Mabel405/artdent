package pe.edu.utp.entity;

import java.util.Date;

public class Usuario {
    private int idUsuario;
    private String nombre;
    private String apellido;
    private String dni;
    private String telefono;
    private String correoElectronico;
    private String direccion;
    private Date fechaNacimiento;
    private String clave;
    private int rolIdRol;
    
    public Usuario() {}
    
    // Constructor completo
    public Usuario(int idUsuario, String nombre, String apellido, String dni, 
                   String telefono, String correoElectronico, String direccion, 
                   Date fechaNacimiento, String clave, int rolIdRol) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.apellido = apellido;
        this.dni = dni;
        this.telefono = telefono;
        this.correoElectronico = correoElectronico;
        this.direccion = direccion;
        this.fechaNacimiento = fechaNacimiento;
        this.clave = clave;
        this.rolIdRol = rolIdRol;
    }
    
    // Getters y Setters
    public int getIdUsuario() {
        return idUsuario;
    }
    
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getApellido() {
        return apellido;
    }
    
    public void setApellido(String apellido) {
        this.apellido = apellido;
    }
    
    public String getDni() {
        return dni;
    }
    
    public void setDni(String dni) {
        this.dni = dni;
    }
    
    public String getTelefono() {
        return telefono;
    }
    
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public String getCorreoElectronico() {
        return correoElectronico;
    }
    
    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }
    
    public String getDireccion() {
        return direccion;
    }
    
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }
    
    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
    
    public String getClave() {
        return clave;
    }
    
    public void setClave(String clave) {
        this.clave = clave;
    }
    
    public int getRolIdRol() {
        return rolIdRol;
    }
    
    public void setRolIdRol(int rolIdRol) {
        this.rolIdRol = rolIdRol;
    }
}
