package pe.edu.utp.entity;

public class Rol {
    private int idRol;
    private String tipoRol;
    
    public Rol() {}
    
    public Rol(int idRol, String tipoRol) {
        this.idRol = idRol;
        this.tipoRol = tipoRol;
    }
    
    // Getters y Setters
    public int getIdRol() {
        return idRol;
    }
    
    public void setIdRol(int idRol) {
        this.idRol = idRol;
    }
    
    public String getTipoRol() {
        return tipoRol;
    }
    
    public void setTipoRol(String tipoRol) {
        this.tipoRol = tipoRol;
    }
}
