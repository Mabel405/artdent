package pe.edu.utp.entity;

public class Paciente {
    private int idPaciente;
    private String nombre;
    private String apellido;
    private String dni;
    private String telefono;
    private String correo;
    
    public Paciente() {}
    
    public Paciente(int idPaciente, String nombre, String apellido, String dni, String telefono, String correo) {
        this.idPaciente = idPaciente;
        this.nombre = nombre;
        this.apellido = apellido;
        this.dni = dni;
        this.telefono = telefono;
        this.correo = correo;
    }
    
    // Getters y Setters
    public int getIdPaciente() {
        return idPaciente;
    }
    
    public void setIdPaciente(int idPaciente) {
        this.idPaciente = idPaciente;
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
    
    public String getCorreo() {
        return correo;
    }
    
    public void setCorreo(String correo) {
        this.correo = correo;
    }
}
