package pe.edu.utp.entity;

import java.sql.Timestamp;

public class Comprobante {
    private int idVenta;
    private double importe;
    private String tipoDoc;
    private String rucEmpresa;
    private int pacienteIdPaciente;
    private String serie;
    private String numeroCorrelativo;
    private Timestamp fechaHoraEmision;
    private int tipoPago;
    private double igv;
    private double subtotal;
    private String observaciones;
    
    // Constructores
    public Comprobante() {}
    
    public Comprobante(double importe, String tipoDoc, String rucEmpresa, int pacienteIdPaciente, 
                      String serie, String numeroCorrelativo, int tipoPago, double igv, 
                      double subtotal, String observaciones) {
        this.importe = importe;
        this.tipoDoc = tipoDoc;
        this.rucEmpresa = rucEmpresa;
        this.pacienteIdPaciente = pacienteIdPaciente;
        this.serie = serie;
        this.numeroCorrelativo = numeroCorrelativo;
        this.tipoPago = tipoPago;
        this.igv = igv;
        this.subtotal = subtotal;
        this.observaciones = observaciones;
    }
    
    // Getters y Setters
    public int getIdVenta() {
        return idVenta;
    }
    
    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }
    
    public double getImporte() {
        return importe;
    }
    
    public void setImporte(double importe) {
        this.importe = importe;
    }
    
    public String getTipoDoc() {
        return tipoDoc;
    }
    
    public void setTipoDoc(String tipoDoc) {
        this.tipoDoc = tipoDoc;
    }
    
    public String getRucEmpresa() {
        return rucEmpresa;
    }
    
    public void setRucEmpresa(String rucEmpresa) {
        this.rucEmpresa = rucEmpresa;
    }
    
    public int getPacienteIdPaciente() {
        return pacienteIdPaciente;
    }
    
    public void setPacienteIdPaciente(int pacienteIdPaciente) {
        this.pacienteIdPaciente = pacienteIdPaciente;
    }
    
    public String getSerie() {
        return serie;
    }
    
    public void setSerie(String serie) {
        this.serie = serie;
    }
    
    public String getNumeroCorrelativo() {
        return numeroCorrelativo;
    }
    
    public void setNumeroCorrelativo(String numeroCorrelativo) {
        this.numeroCorrelativo = numeroCorrelativo;
    }
    
    public Timestamp getFechaHoraEmision() {
        return fechaHoraEmision;
    }
    
    public void setFechaHoraEmision(Timestamp fechaHoraEmision) {
        this.fechaHoraEmision = fechaHoraEmision;
    }
    
    public int getTipoPago() {
        return tipoPago;
    }
    
    public void setTipoPago(int tipoPago) {
        this.tipoPago = tipoPago;
    }
    
    public double getIgv() {
        return igv;
    }
    
    public void setIgv(double igv) {
        this.igv = igv;
    }
    
    public double getSubtotal() {
        return subtotal;
    }
    
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
    public String getObservaciones() {
        return observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    
    // Métodos de utilidad
    public String getNumeroCompleto() {
        return serie + "-" + numeroCorrelativo;
    }
    
    public boolean esFacturaEmpresa() {
        return rucEmpresa != null && !rucEmpresa.trim().isEmpty();
    }
    
    @Override
    public String toString() {
        return "Comprobante{" +
                "idVenta=" + idVenta +
                ", importe=" + importe +
                ", tipoDoc='" + tipoDoc + '\'' +
                ", rucEmpresa='" + rucEmpresa + '\'' +
                ", serie='" + serie + '\'' +
                ", numeroCorrelativo='" + numeroCorrelativo + '\'' +
                ", fechaHoraEmision=" + fechaHoraEmision +
                '}';
    }
}