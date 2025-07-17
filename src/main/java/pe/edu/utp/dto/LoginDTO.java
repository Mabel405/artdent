package pe.edu.utp.dto;

public class LoginDTO {
    private String correo;
    private String clave;
    private String mensaje;
    private boolean exitoso;
    private int rolId;
    private String nombreCompleto;
    
    // Constructor vacío
    public LoginDTO() {}
    
    // Constructor para login exitoso
    public LoginDTO(String correo, boolean exitoso, int rolId, String nombreCompleto) {
        this.correo = correo;
        this.exitoso = exitoso;
        this.rolId = rolId;
        this.nombreCompleto = nombreCompleto;
    }
    
    // Constructor para login fallido
    public LoginDTO(String correo, boolean exitoso, String mensaje) {
        this.correo = correo;
        this.exitoso = exitoso;
        this.mensaje = mensaje;
    }
    
    // Getters y Setters
    public String getCorreo() {
        return correo;
    }
    
    public void setCorreo(String correo) {
        this.correo = correo;
    }
    
    public String getClave() {
        return clave;
    }
    
    public void setClave(String clave) {
        this.clave = clave;
    }
    
    public String getMensaje() {
        return mensaje;
    }
    
    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
    
    public boolean isExitoso() {
        return exitoso;
    }
    
    public void setExitoso(boolean exitoso) {
        this.exitoso = exitoso;
    }
    
    public int getRolId() {
        return rolId;
    }
    
    public void setRolId(int rolId) {
        this.rolId = rolId;
    }
    
    public String getNombreCompleto() {
        return nombreCompleto;
    }
    
    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }
}
