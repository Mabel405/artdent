package pe.edu.utp.entity;

import java.util.Date;
import java.util.Calendar;

public class NotificacionReserva {
    // Campos de la reserva
    private int idReserva;
    private Date diaReserva;
    private String horaReserva;
    private String descripcion;
    private String diaSemana;
    private int tipoEstado;
    private Date fechaRegistro;
    private Date fechaActualizacion;
    
    // Campos relacionados (joins)
    private String nombrePaciente;
    private String apellidoPaciente;
    private String telefonoPaciente;
    private String correoPaciente;
    private String nombreOdontologo;
    private String apellidoOdontologo;
    private String tipoServicio;
    private double costoServicio;
    private String nombreUsuarioRegistro;
    
    // Campos calculados para notificación
    private String tipoNotificacion;
    private String titulo;
    private String mensaje;
    private String prioridad;
    private String icono;
    private String color;
    private boolean esReciente;
    private boolean esUrgente;
    private String tiempoTranscurrido;
    
    public enum TipoEstado {
        NUEVA(1, "Nueva Reserva", "fas fa-calendar-plus", "success", "NORMAL"),
        CONFIRMADA(2, "Reserva Confirmada", "fas fa-check-circle", "info", "NORMAL"),
        CANCELADA(3, "Reserva Cancelada", "fas fa-times-circle", "danger", "ALTA"),
        REPROGRAMADA(4, "Reserva Reprogramada", "fas fa-calendar-alt", "warning", "NORMAL");
        
        private final int codigo;
        private final String nombre;
        private final String icono;
        private final String color;
        private final String prioridad;
        
        TipoEstado(int codigo, String nombre, String icono, String color, String prioridad) {
            this.codigo = codigo;
            this.nombre = nombre;
            this.icono = icono;
            this.color = color;
            this.prioridad = prioridad;
        }
        
        public static TipoEstado fromCodigo(int codigo) {
            for (TipoEstado tipo : values()) {
                if (tipo.codigo == codigo) {
                    return tipo;
                }
            }
            return NUEVA;
        }
        
        // Getters
        public int getCodigo() { return codigo; }
        public String getNombre() { return nombre; }
        public String getIcono() { return icono; }
        public String getColor() { return color; }
        public String getPrioridad() { return prioridad; }
    }
    
    // Constructor
    public NotificacionReserva() {
        this.esReciente = false;
        this.esUrgente = false;
    }
    
    // Métodos de utilidad
    public void calcularDatosNotificacion() {
        TipoEstado estado = TipoEstado.fromCodigo(this.tipoEstado);
        this.tipoNotificacion = estado.getNombre();
        this.icono = estado.getIcono();
        this.color = estado.getColor();
        this.prioridad = estado.getPrioridad();
        
        // Generar título y mensaje
        generarTituloYMensaje();
        
        // Calcular si es reciente (últimas 24 horas)
        if (fechaActualizacion != null) {
            long diff = System.currentTimeMillis() - fechaActualizacion.getTime();
            this.esReciente = diff < (24 * 60 * 60 * 1000);
        }
        
        // Determinar si es urgente - LÓGICA CORREGIDA
        determinarUrgencia();
        
        // Calcular tiempo transcurrido
        this.tiempoTranscurrido = calcularTiempoTranscurrido();
    }
    
    private void generarTituloYMensaje() {
        String nombreCompleto = (nombrePaciente != null && apellidoPaciente != null) 
            ? nombrePaciente + " " + apellidoPaciente : "Paciente";
        
        switch (tipoEstado) {
            case 1: // Nueva
                this.titulo = "Nueva Reserva Registrada";
                this.mensaje = String.format("Nueva cita registrada para %s el %s a las %s - %s", 
                    nombreCompleto, 
                    formatearFecha(diaReserva), 
                    horaReserva,
                    tipoServicio != null ? tipoServicio : "Servicio");
                break;
                
            case 2: // Confirmada
                this.titulo = "Reserva Confirmada";
                this.mensaje = String.format("La cita de %s del %s ha sido confirmada", 
                    nombreCompleto, formatearFecha(diaReserva));
                break;
                
            case 3: // Cancelada
                this.titulo = "Reserva Cancelada";
                this.mensaje = String.format("La cita de %s del %s ha sido cancelada", 
                    nombreCompleto, formatearFecha(diaReserva));
                break;
                
            case 4: // Reprogramada
                this.titulo = "Reserva Reprogramada";
                this.mensaje = String.format("La cita de %s ha sido reprogramada para el %s", 
                    nombreCompleto, formatearFecha(diaReserva));
                break;
                
            default:
                this.titulo = "Actualización de Reserva";
                this.mensaje = String.format("Se ha actualizado la cita de %s", nombreCompleto);
        }
    }
    
    /**
     * LÓGICA DE URGENCIA CORREGIDA - Coincide EXACTAMENTE con la consulta SQL
     */
    private void determinarUrgencia() {
        this.esUrgente = false;
        
        System.out.println("=== DEBUG URGENCIA - Reserva ID: " + this.idReserva + " ===");
        System.out.println("Tipo Estado: " + this.tipoEstado);
        System.out.println("Fecha Actualización: " + this.fechaActualizacion);
        System.out.println("Día Reserva: " + this.diaReserva);
        System.out.println("Hora Reserva: " + this.horaReserva);
        
        // Caso 1: Estados 3 o 4 (cancelada/reprogramada)
        if (tipoEstado == 3 || tipoEstado == 4) {
            if (fechaActualizacion != null) {
                long unDiaEnMillis = 24 * 60 * 60 * 1000L;
                long fechaLimite = System.currentTimeMillis() - unDiaEnMillis;
                boolean cumpleCondicion = fechaActualizacion.getTime() >= fechaLimite;
                
                System.out.println("Condición 1 (Estados 3/4):");
                System.out.println("  Fecha límite: " + new Date(fechaLimite));
                System.out.println("  Fecha actualización >= fecha límite: " + cumpleCondicion);
                
                if (cumpleCondicion) {
                    this.esUrgente = true;
                    this.prioridad = "URGENTE";
                    System.out.println("  RESULTADO: URGENTE por estado " + tipoEstado);
                    return;
                }
            }
        }
        
        // Caso 2: Estado 1 (nueva reserva) - LÓGICA CORREGIDA
        if (tipoEstado == 1) {
            if (diaReserva != null && horaReserva != null && !horaReserva.trim().isEmpty()) {
                try {
                    Date fechaHoraCita = combinarFechaYHora(diaReserva, horaReserva);
                    
                    if (fechaHoraCita != null) {
                        long ahora = System.currentTimeMillis();
                        long diffMillis = fechaHoraCita.getTime() - ahora;
                        long diffMinutes = diffMillis / (1000 * 60);
                        
                        System.out.println("Condición 2 (Estado 1):");
                        System.out.println("  Ahora: " + new Date(ahora));
                        System.out.println("  Fecha/Hora cita: " + fechaHoraCita);
                        System.out.println("  Diferencia en millis: " + diffMillis);
                        System.out.println("  Diferencia en minutos: " + diffMinutes);
                        
                        // CONDICIÓN EXACTA: <= 120 minutos Y >= 0 (cita futura)
                        boolean cumpleCondicion = (diffMinutes <= 120 && diffMinutes >= 0);
                        System.out.println("  Es urgente (<=120 y >=0): " + cumpleCondicion);
                        
                        if (cumpleCondicion) {
                            this.esUrgente = true;
                            this.prioridad = "URGENTE";
                            System.out.println("  RESULTADO: URGENTE por nueva reserva próxima (" + diffMinutes + " min)");
                            return;
                        }
                    } else {
                        System.out.println("  ERROR: No se pudo combinar fecha y hora");
                    }
                } catch (Exception e) {
                    System.err.println("Error al determinar urgencia para reserva " + idReserva + ": " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                System.out.println("  ERROR: Fecha o hora nula/vacía");
            }
        }
        
        // Si no es urgente, establecer prioridad según el estado
        if (!this.esUrgente) {
            switch (tipoEstado) {
                case 3: this.prioridad = "ALTA"; break;
                case 1: this.prioridad = "ALTA"; break;
                case 4: this.prioridad = "NORMAL"; break;
                case 2: this.prioridad = "NORMAL"; break;
                default: this.prioridad = "BAJA";
            }
        }
        
        System.out.println("RESULTADO FINAL - Es Urgente: " + this.esUrgente + ", Prioridad: " + this.prioridad);
        System.out.println("=== FIN DEBUG URGENCIA ===");
    }
    
    /**
     * Método mejorado para combinar fecha y hora - CORREGIDO
     */
    private Date combinarFechaYHora(Date fecha, String hora) {
        if (fecha == null || hora == null || hora.trim().isEmpty()) {
            System.out.println("  DEBUG: Fecha o hora nula - Fecha: " + fecha + ", Hora: '" + hora + "'");
            return null;
        }
        
        try {
            String horaLimpia = hora.trim();
            System.out.println("  DEBUG: Procesando hora: '" + horaLimpia + "'");
            
            String[] horaParts;
            
            if (horaLimpia.contains(":")) {
                // Formato HH:MM:SS o HH:MM
                horaParts = horaLimpia.split(":");
            } else if (horaLimpia.length() == 4) {
                // Formato HHMM
                horaParts = new String[]{horaLimpia.substring(0, 2), horaLimpia.substring(2, 4)};
            } else {
                System.out.println("  ERROR: Formato de hora no reconocido: " + horaLimpia);
                return null;
            }
            
            if (horaParts.length < 2) {
                System.out.println("  ERROR: No se pudieron extraer horas y minutos de: " + horaLimpia);
                return null;
            }
            
            int horas = Integer.parseInt(horaParts[0]);
            int minutos = Integer.parseInt(horaParts[1]);
            
            System.out.println("  DEBUG: Horas: " + horas + ", Minutos: " + minutos);
            
            // Validar rangos
            if (horas < 0 || horas > 23 || minutos < 0 || minutos > 59) {
                System.out.println("  ERROR: Hora fuera de rango - H:" + horas + " M:" + minutos);
                return null;
            }
            
            // Usar Calendar para combinar fecha y hora
            Calendar cal = Calendar.getInstance();
            cal.setTime(fecha);
            cal.set(Calendar.HOUR_OF_DAY, horas);
            cal.set(Calendar.MINUTE, minutos);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);
            
            Date resultado = cal.getTime();
            System.out.println("  DEBUG: Fecha/hora combinada: " + resultado);
            return resultado;
            
        } catch (NumberFormatException e) {
            System.err.println("  ERROR: Error al parsear hora '" + hora + "': " + e.getMessage());
            return null;
        } catch (Exception e) {
            System.err.println("  ERROR: Error general al combinar fecha/hora: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    private String calcularTiempoTranscurrido() {
        if (fechaActualizacion == null) return "";
        
        long diff = System.currentTimeMillis() - fechaActualizacion.getTime();
        long minutos = diff / (60 * 1000);
        long horas = diff / (60 * 60 * 1000);
        long dias = diff / (24 * 60 * 60 * 1000);
        
        if (dias > 0) return dias + " día" + (dias > 1 ? "s" : "");
        if (horas > 0) return horas + " hora" + (horas > 1 ? "s" : "");
        if (minutos > 0) return minutos + " minuto" + (minutos > 1 ? "s" : "");
        return "Ahora";
    }
    
    private String formatearFecha(Date fecha) {
        if (fecha == null) return "";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
        return sdf.format(fecha);
    }
    
    public String getNombreCompletoOdontologo() {
        if (nombreOdontologo != null && apellidoOdontologo != null) {
            return "Dr. " + nombreOdontologo + " " + apellidoOdontologo;
        }
        return null;
    }
    
    public String getNombreCompletoPaciente() {
        if (nombrePaciente != null && apellidoPaciente != null) {
            return nombrePaciente + " " + apellidoPaciente;
        }
        return null;
    }
    
    public boolean esCitaProxima() {
        if (diaReserva == null) return false;
        long diff = diaReserva.getTime() - System.currentTimeMillis();
        long dias = diff / (24 * 60 * 60 * 1000);
        return dias >= 0 && dias <= 2;
    }
    
    public String getEstadoTexto() {
        return TipoEstado.fromCodigo(tipoEstado).getNombre();
    }
    
    // Getters y Setters completos
    public int getIdReserva() { return idReserva; }
    public void setIdReserva(int idReserva) { this.idReserva = idReserva; }
    
    public Date getDiaReserva() { return diaReserva; }
    public void setDiaReserva(Date diaReserva) { this.diaReserva = diaReserva; }
    
    public String getHoraReserva() { return horaReserva; }
    public void setHoraReserva(String horaReserva) { this.horaReserva = horaReserva; }
    
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    
    public String getDiaSemana() { return diaSemana; }
    public void setDiaSemana(String diaSemana) { this.diaSemana = diaSemana; }
    
    public int getTipoEstado() { return tipoEstado; }
    public void setTipoEstado(int tipoEstado) { this.tipoEstado = tipoEstado; }
    
    public Date getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(Date fechaRegistro) { this.fechaRegistro = fechaRegistro; }
    
    public Date getFechaActualizacion() { return fechaActualizacion; }
    public void setFechaActualizacion(Date fechaActualizacion) { this.fechaActualizacion = fechaActualizacion; }
    
    public String getNombrePaciente() { return nombrePaciente; }
    public void setNombrePaciente(String nombrePaciente) { this.nombrePaciente = nombrePaciente; }
    
    public String getApellidoPaciente() { return apellidoPaciente; }
    public void setApellidoPaciente(String apellidoPaciente) { this.apellidoPaciente = apellidoPaciente; }
    
    public String getTelefonoPaciente() { return telefonoPaciente; }
    public void setTelefonoPaciente(String telefonoPaciente) { this.telefonoPaciente = telefonoPaciente; }
    
    public String getCorreoPaciente() { return correoPaciente; }
    public void setCorreoPaciente(String correoPaciente) { this.correoPaciente = correoPaciente; }
    
    public String getNombreOdontologo() { return nombreOdontologo; }
    public void setNombreOdontologo(String nombreOdontologo) { this.nombreOdontologo = nombreOdontologo; }
    
    public String getApellidoOdontologo() { return apellidoOdontologo; }
    public void setApellidoOdontologo(String apellidoOdontologo) { this.apellidoOdontologo = apellidoOdontologo; }
    
    public String getTipoServicio() { return tipoServicio; }
    public void setTipoServicio(String tipoServicio) { this.tipoServicio = tipoServicio; }
    
    public double getCostoServicio() { return costoServicio; }
    public void setCostoServicio(double costoServicio) { this.costoServicio = costoServicio; }
    
    public String getNombreUsuarioRegistro() { return nombreUsuarioRegistro; }
    public void setNombreUsuarioRegistro(String nombreUsuarioRegistro) { this.nombreUsuarioRegistro = nombreUsuarioRegistro; }
    
    public String getTipoNotificacion() { return tipoNotificacion; }
    public void setTipoNotificacion(String tipoNotificacion) { this.tipoNotificacion = tipoNotificacion; }
    
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    
    public String getMensaje() { return mensaje; }
    public void setMensaje(String mensaje) { this.mensaje = mensaje; }
    
    public String getPrioridad() { return prioridad; }
    public void setPrioridad(String prioridad) { this.prioridad = prioridad; }
    
    public String getIcono() { return icono; }
    public void setIcono(String icono) { this.icono = icono; }
    
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    
    public boolean isEsReciente() { return esReciente; }
    public void setEsReciente(boolean esReciente) { this.esReciente = esReciente; }
    
    public boolean isEsUrgente() { return esUrgente; }
    public void setEsUrgente(boolean esUrgente) { this.esUrgente = esUrgente; }
    
    public String getTiempoTranscurrido() { return tiempoTranscurrido; }
    public void setTiempoTranscurrido(String tiempoTranscurrido) { this.tiempoTranscurrido = tiempoTranscurrido; }
}