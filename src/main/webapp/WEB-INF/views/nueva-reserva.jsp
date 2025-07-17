<%@ include file="layout/header.jsp" %>

<!-- Estilos específicos para el formulario de reserva -->
<style>
    /* Todos los estilos existentes se mantienen igual... */
    .reserva-container {
        padding-top: 2rem;
        padding-bottom: 2rem;
    }
    
    .reserva-card {
        box-shadow: 0 0.5rem rgba(0, 0, 0, 0.15);
        border: none;
        border-radius: 1rem;
        overflow: hidden;
    }
    
    .reserva-card .card-header {
        background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
        color: white;
        border-bottom: none;
        padding: 1.5rem;
    }
    
    .reserva-form-section {
        background: #f8f9fa;
        border-radius: 0.75rem;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        border-left: 4px solid #007bff;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
    
    .reserva-section-title {
        color: #007bff;
        font-weight: 600;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        font-size: 1.1rem;
    }
    
    .reserva-section-title i {
        margin-right: 0.5rem;
        font-size: 1.2rem;
    }
    
    .reserva-form-control:focus, 
    .reserva-form-select:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }
    
    .reserva-btn-primary {
        background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
        border: none;
        padding: 0.75rem 2rem;
        font-weight: 600;
        border-radius: 0.5rem;
        transition: all 0.3s ease;
    }
    
    .reserva-btn-primary:hover {
        background: linear-gradient(135deg, #0056b3 0%, #004085 100%);
        transform: translateY(-2px);
        box-shadow: 0 0.5rem 1rem rgba(0, 123, 255, 0.3);
    }
    
    .empresa-fields {
        display: none;
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        border: 2px solid #dee2e6;
        border-radius: 0.75rem;
        padding: 1.5rem;
        margin-top: 1rem;
        transition: all 0.3s ease;
    }
    
    .empresa-fields.show {
        display: block;
        animation: slideDown 0.3s ease;
    }
    
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .loading {
        display: none;
        color: #007bff;
        font-weight: 500;
    }
    
    .ruc-info {
        margin-top: 0.75rem;
        padding: 0.75rem;
        border-radius: 0.5rem;
        font-weight: 500;
        animation: fadeIn 0.3s ease;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    
    .ruc-info.success {
        background: linear-gradient(135deg, #d1edff 0%, #b3d9ff 100%);
        border: 2px solid #0ea5e9;
        color: #0369a1;
    }
    
    .ruc-info.error {
        background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
        border: 2px solid #ef4444;
        color: #dc2626;
    }
    
    .resumen-costos {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 1rem;
        padding: 1.5rem;
        margin-top: 1.5rem;
        display: none;
        box-shadow: 0 0.5rem 1rem rgba(102, 126, 234, 0.3);
    }
    
    .resumen-costos.show {
        display: block;
        animation: slideUp 0.4s ease;
    }
    
    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .costo-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.5rem 0;
        border-bottom: 1px solid rgba(255,255,255,0.2);
    }
    
    .costo-item:last-child {
        border-bottom: none;
        font-weight: bold;
        font-size: 1.2rem;
        margin-top: 0.5rem;
        padding-top: 1rem;
        border-top: 2px solid rgba(255,255,255,0.3);
    }
    
    /* Estilos mejorados para el monto en letras usando SOAP */
    .monto-en-letras {
        background: linear-gradient(135deg, rgba(40, 167, 69, 0.15) 0%, rgba(25, 135, 84, 0.15) 100%);
        border: 2px solid rgba(40, 167, 69, 0.3);
        border-radius: 0.75rem;
        padding: 1.25rem;
        margin-top: 1.5rem;
        font-style: normal;
        text-align: left;
        min-height: 70px;
        display: flex;
        align-items: center;
        justify-content: flex-start;
        position: relative;
        transition: all 0.3s ease;
        box-shadow: 0 0.25rem 0.5rem rgba(40, 167, 69, 0.1);
    }
    
    .monto-en-letras.loading {
        background: linear-gradient(135deg, rgba(0, 123, 255, 0.15) 0%, rgba(0, 86, 179, 0.15) 100%);
        border-color: rgba(0, 123, 255, 0.3);
        justify-content: center;
    }
    
    .monto-en-letras .spinner-border {
        width: 1.25rem;
        height: 1.25rem;
        margin-right: 0.75rem;
        color: #007bff;
    }
    
    .monto-en-letras.soap-success {
        background: linear-gradient(135deg, rgba(40, 167, 69, 0.2) 0%, rgba(25, 135, 84, 0.2) 100%);
        border-color: rgba(40, 167, 69, 0.5);
        color: #ffffff;
        font-weight: 500;
    }
    
    .monto-en-letras.soap-error {
        background: linear-gradient(135deg, rgba(220, 53, 69, 0.2) 0%, rgba(176, 42, 55, 0.2) 100%);
        border-color: rgba(220, 53, 69, 0.5);
        color: #ffffff;
        justify-content: center;
    }
    
    .soap-indicator {
        position: absolute;
        top: 8px;
        right: 12px;
        font-size: 0.7rem;
        font-weight: 600;
        opacity: 0.8;
        background: rgba(255,255,255,0.25);
        color: rgba(255,255,255,0.9);
        padding: 3px 8px;
        border-radius: 12px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .monto-en-letras #montoEnLetrasTexto {
        font-size: 1rem;
        line-height: 1.4;
        flex: 1;
        padding-right: 3rem;
    }
    
    .monto-en-letras #montoEnLetrasTexto i {
        color: rgba(255,255,255,0.9);
        margin-right: 0.5rem;
    }
    
    .monto-en-letras #montoEnLetrasTexto strong {
        color: rgba(255,255,255,0.95);
        margin-right: 0.5rem;
    }
    
    .reserva-form-check-input:checked {
        background-color: #007bff;
        border-color: #007bff;
    }
    
    .reserva-input-group .btn {
        border-color: #007bff;
        color: #007bff;
    }
    
    .reserva-input-group .btn:hover {
        background-color: #007bff;
        color: white;
    }
    
    .reserva-alert {
        border-radius: 0.75rem;
        border: none;
        box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.1);
    }
    
    .reserva-form-label {
        font-weight: 600;
        color: #495057;
        margin-bottom: 0.5rem;
    }
    
    .reserva-form-text {
        color: #6c757d;
        font-size: 0.875rem;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .reserva-container {
            padding-top: 1rem;
        }
        
        .reserva-form-section {
            padding: 1rem;
            margin-bottom: 1rem;
        }
        
        .reserva-card .card-header {
            padding: 1rem;
        }
        
        .monto-en-letras {
            padding: 1rem;
            text-align: center;
        }
        
        .monto-en-letras #montoEnLetrasTexto {
            font-size: 0.9rem;
            padding-right: 2rem;
        }
    }
    
    /* Estilos para PayPal */
    #paypal-button-container {
        min-width: 300px;
        min-height: 50px;
        width: 100%;
        max-width: 400px;
        margin: 0 auto;
        display: block;
    }
    
    #paypal-button-container.hidden {
        display: none !important;
    }
    
    #loading-payment {
        min-width: 300px;
        min-height: 100px;
        padding: 20px;
        border: 2px dashed #007bff;
        border-radius: 10px;
        background: #f8f9fa;
    }
    
    .paypal-container-wrapper {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 10px;
        min-height: 80px;
    }
    
    /* Asegurar que PayPal sea visible */
    .paypal-buttons {
        width: 100% !important;
        min-height: 50px !important;
    }

    /* Estilos para el panel de logs */
    .debug-panel {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 300px;
        max-height: 200px;
        background: rgba(0, 0, 0, 0.9);
        color: #00ff00;
        font-family: 'Courier New', monospace;
        font-size: 11px;
        border-radius: 8px;
        padding: 10px;
        overflow-y: auto;
        z-index: 9999;
        display: none;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
    }
    
    .debug-panel.show {
        display: block;
    }
    
    .debug-toggle {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: #007bff;
        color: white;
        border: none;
        border-radius: 50%;
        width: 50px;
        height: 50px;
        font-size: 16px;
        cursor: pointer;
        z-index: 10000;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    }
    
    .debug-toggle:hover {
        background: #0056b3;
    }
</style>

<!-- PayPal SDK -->
<script src="https://www.paypal.com/sdk/js?client-id=Ab76YGp-Kv0PL6XzfwP4zH0OJN4oMfbk4CCxw84dyOsfEGAUWl6JRdgE0r3kUAxkyA45rsjaby4DkcDj&currency=USD&locale=es_ES" data-sdk-integration-source="button-factory"></script>

<div class="container reserva-container">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card reserva-card">
                <div class="card-header text-center">
                    <h4 class="mb-0">
                        <i class="fas fa-calendar-plus me-2"></i>
                        Nueva Reserva - Clínica Dental
                    </h4>
                    <p class="mb-0 mt-2 opacity-75">Complete el formulario para agendar su cita</p>
                </div>
                <div class="card-body p-4">
                    <!-- Mensajes de éxito o error -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show reserva-alert" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            <pre style="white-space: pre-wrap; margin: 0; font-family: inherit;">${success}</pre>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show reserva-alert" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="reserva" method="post" id="reservaForm">
                        <input type="hidden" name="action" value="crear">
                        
                        <!-- Datos del Paciente -->
                        <div class="reserva-form-section">
                            <h5 class="reserva-section-title">
                                <i class="fas fa-user"></i>
                                Datos del Paciente
                            </h5>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="nombrePaciente" class="form-label reserva-form-label">
                                        <i class="fas fa-user me-1"></i>
                                        Nombre *
                                    </label>
                                    <input type="text" class="form-control reserva-form-control" id="nombrePaciente" 
                                           name="nombrePaciente" required 
                                           placeholder="Ingrese el nombre del paciente">
                                </div>
                                <div class="col-md-6">
                                    <label for="apellidoPaciente" class="form-label reserva-form-label">
                                        <i class="fas fa-user me-1"></i>
                                        Apellido *
                                    </label>
                                    <input type="text" class="form-control reserva-form-control" id="apellidoPaciente" 
                                           name="apellidoPaciente" required
                                           placeholder="Ingrese el apellido del paciente">
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="dniPaciente" class="form-label reserva-form-label">
                                        <i class="fas fa-id-card me-1"></i>
                                        DNI *
                                    </label>
                                    <input type="text" class="form-control reserva-form-control" id="dniPaciente" 
                                           name="dniPaciente" pattern="[0-9]{8}" maxlength="8" required
                                           placeholder="12345678">
                                </div>
                                <div class="col-md-4">
                                    <label for="telefonoPaciente" class="form-label reserva-form-label">
                                        <i class="fas fa-phone me-1"></i>
                                        Teléfono
                                    </label>
                                    <input type="tel" class="form-control reserva-form-control" id="telefonoPaciente" 
                                           name="telefonoPaciente" pattern="[0-9]{9}" maxlength="9"
                                           placeholder="987654321">
                                </div>
                                <div class="col-md-4">
                                    <label for="correoPaciente" class="form-label reserva-form-label">
                                        <i class="fas fa-envelope me-1"></i>
                                        Correo Electrónico
                                    </label>
                                    <input type="email" class="form-control reserva-form-control" id="correoPaciente" 
                                           name="correoPaciente"
                                           placeholder="ejemplo@correo.com">
                                </div>
                            </div>
                        </div>

                        <!-- Datos de la Reserva -->
                        <div class="reserva-form-section">
                            <h5 class="reserva-section-title">
                                <i class="fas fa-calendar-alt"></i>
                                Datos de la Reserva
                            </h5>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="fechaReserva" class="form-label reserva-form-label">
                                        <i class="fas fa-calendar me-1"></i>
                                        Fecha de la Cita *
                                    </label>
                                    <input type="date" class="form-control reserva-form-control" id="fechaReserva" 
                                           name="fechaReserva" required 
                                           min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                                </div>
                                <div class="col-md-6">
                                    <label for="horaReserva" class="form-label reserva-form-label">
                                        <i class="fas fa-clock me-1"></i>
                                        Hora de la Cita *
                                    </label>
                                    <select class="form-select reserva-form-select" id="horaReserva" name="horaReserva" required>
                                        <option value="">Seleccione una hora</option>
                                        <optgroup label="Mañana">
                                            <option value="08:00">08:00 AM</option>
                                            <option value="08:30">08:30 AM</option>
                                            <option value="09:00">09:00 AM</option>
                                            <option value="09:30">09:30 AM</option>
                                            <option value="10:00">10:00 AM</option>
                                            <option value="10:30">10:30 AM</option>
                                            <option value="11:00">11:00 AM</option>
                                            <option value="11:30">11:30 AM</option>
                                        </optgroup>
                                        <optgroup label="Tarde">
                                            <option value="14:00">02:00 PM</option>
                                            <option value="14:30">02:30 PM</option>
                                            <option value="15:00">03:00 PM</option>
                                            <option value="15:30">03:30 PM</option>
                                            <option value="16:00">04:00 PM</option>
                                            <option value="16:30">04:30 PM</option>
                                            <option value="17:00">05:00 PM</option>
                                            <option value="17:30">05:30 PM</option>
                                        </optgroup>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="servicioId" class="form-label reserva-form-label">
                                        <i class="fas fa-tooth me-1"></i>
                                        Servicio Dental *
                                    </label>
                                    <select class="form-select reserva-form-select" id="servicioId" name="servicioId" required>
                                        <option value="">Seleccione un servicio</option>
                                        <c:forEach var="servicio" items="${servicios}">
                                            <option value="${servicio.idServicio}" data-costo="${servicio.costo}">
                                                ${servicio.tipoServicio} - S/ <fmt:formatNumber value="${servicio.costo}" pattern="#,##0.00"/>
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="odontologoId" class="form-label reserva-form-label">
                                        <i class="fas fa-user-md me-1"></i>
                                        Odontólogo *
                                    </label>
                                    <select class="form-select reserva-form-select" id="odontologoId" name="odontologoId" required>
                                        <option value="">Seleccione un odontólogo</option>
                                        <c:forEach var="odontologo" items="${odontologos}">
                                            <option value="${odontologo.idUsuario}">
                                                Dr(a). ${odontologo.nombre} ${odontologo.apellido}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="descripcion" class="form-label reserva-form-label">
                                    <i class="fas fa-comment-medical me-1"></i>
                                    Descripción / Motivo de la Consulta
                                </label>
                                <textarea class="form-control reserva-form-control" id="descripcion" name="descripcion" 
                                          rows="3" placeholder="Describa brevemente el motivo de su consulta, síntomas o tratamiento requerido..."></textarea>
                            </div>
                        </div>

                        <!-- Tipo de Pago (solo para usuarios logueados) -->
                        <c:if test="${not empty sessionScope.usuario}">
                            <div class="mb-3">
                                <label for="tipoPago" class="form-label reserva-form-label">
                                    <i class="fas fa-credit-card me-1"></i>
                                    Tipo de Pago *
                                </label>
                                <select class="form-select reserva-form-select" id="tipoPago" name="tipoPago" required>
                                    <option value="2">? Efectivo</option>
                                    <option value="3">? Yape / Plin</option>
                                    <option value="1">? Tarjeta / PayPal</option>
                                </select>
                                <div class="form-text reserva-form-text">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Seleccione el método de pago que utilizará el paciente
                                </div>
                            </div>
                        </c:if>

                        <!-- Campo oculto para tipo de pago cuando no hay usuario logueado -->
                        <c:if test="${empty sessionScope.usuario}">
                            <input type="hidden" id="tipoPago" name="tipoPago" value="1">
                        </c:if>

                        <!-- Facturación Empresarial -->
                        <div class="reserva-form-section">
                            <h5 class="reserva-section-title">
                                <i class="fas fa-building"></i>
                                Facturación
                            </h5>
                            
                            <div class="mb-3">
                                <div class="form-check form-switch">
                                    <input class="form-check-input reserva-form-check-input" type="checkbox" id="facturarEmpresa" 
                                           name="facturarEmpresa" value="true">
                                    <label class="form-check-label reserva-form-label" for="facturarEmpresa">
                                        <i class="fas fa-receipt me-2"></i>
                                        <strong>Facturar a empresa</strong> (Requiere RUC válido)
                                    </label>
                                </div>
                                <small class="text-muted reserva-form-text">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Active esta opción si la empresa pagará por el servicio y necesita factura
                                </small>
                            </div>
                            
                            <div id="empresaFields" class="empresa-fields">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="rucEmpresa" class="form-label reserva-form-label">
                                            <i class="fas fa-building me-1"></i>
                                            RUC de la Empresa *
                                        </label>
                                        <div class="input-group reserva-input-group">
                                            <input type="text" class="form-control reserva-form-control" id="rucEmpresa" 
                                                   name="rucEmpresa" pattern="[0-9]{11}" maxlength="11"
                                                   placeholder="Ingrese RUC de 11 dígitos">
                                            <button type="button" class="btn btn-outline-primary" id="buscarRuc">
                                                <i class="fas fa-search"></i>
                                                Buscar
                                            </button>
                                        </div>
                                        <div class="form-text reserva-form-text">
                                            <i class="fas fa-keyboard me-1"></i>
                                            Presione Enter o haga clic en "Buscar" para consultar
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="nombreEmpresa" class="form-label reserva-form-label">
                                            <i class="fas fa-building me-1"></i>
                                            Nombre de la Empresa
                                        </label>
                                        <input type="text" class="form-control reserva-form-control" id="nombreEmpresa" 
                                               name="nombreEmpresa" readonly
                                               placeholder="Se completará automáticamente">
                                        <div class="loading text-primary">
                                            <i class="fas fa-spinner fa-spin me-1"></i> 
                                            Consultando RUC en SUNAT...
                                        </div>
                                    </div>
                                </div>
                                
                                <div id="rucInfo" class="ruc-info" style="display: none;">
                                    <i class="fas fa-info-circle me-2"></i>
                                    <span id="rucMessage"></span>
                                </div>
                            </div>
                        </div>

                        <!-- Resumen de Costos -->
                        <div id="resumenCostos" class="resumen-costos">
                            <h6 class="mb-3">
                                <i class="fas fa-calculator me-2"></i>
                                Resumen de Costos
                            </h6>
                            <div class="costo-item">
                                <span>Subtotal (sin IGV):</span>
                                <span>S/ <span id="subtotal">0.00</span></span>
                            </div>
                            <div class="costo-item" id="igvRow">
                                <span>IGV (18%):</span>
                                <span>S/ <span id="igv">0.00</span></span>
                            </div>
                            <div class="costo-item">
                                <span>Total a Pagar:</span>
                                <span>S/ <span id="total">0.00</span></span>
                            </div>
                            
                            <!-- Monto en letras usando SOAP (como en prueba.java) -->
                            <div class="monto-en-letras" id="montoEnLetras">
                                <div class="soap-indicator">SOAP</div>
                                <i class="fas fa-spell-check me-2"></i>
                                <span id="montoEnLetrasTexto">Seleccione un servicio para ver el monto en letras</span>
                            </div>
                            
                            <div class="mt-2 text-center">
                                <small class="opacity-75">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Los precios incluyen IGV. Conversión a letras vía servicio SOAP.
                                </small>
                            </div>
                        </div>

                        <!-- Botones de Acción -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                            <button type="button" class="btn btn-secondary me-md-2" onclick="history.back()">
                                <i class="fas fa-arrow-left me-2"></i>
                                Volver
                            </button>
                            <button type="reset" class="btn btn-outline-warning me-md-2">
                                <i class="fas fa-eraser me-2"></i>
                                Limpiar
                            </button>
                            
                            <!-- Botón normal para usuarios logueados -->
                            <c:if test="${not empty sessionScope.usuario}">
                                <button type="submit" class="btn reserva-btn-primary btn-lg" id="btnGuardarReserva">
                                    <i class="fas fa-save me-2"></i>
                                    Crear Reserva
                                </button>
                            </c:if>
                            
                            <!-- PayPal para usuarios no logueados -->
                            <c:if test="${empty sessionScope.usuario}">
                                <div class="paypal-container-wrapper">
                                    <div class="alert alert-info text-center" id="paypal-info" style="display: none;">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <strong>Seleccione un servicio</strong> para proceder con el pago
                                    </div>
                                    <div id="paypal-button-container" class="hidden"></div>
                                    <div id="loading-payment" style="display: none;" class="text-center">
                                        <div class="spinner-border text-primary" role="status">
                                            <span class="visually-hidden">Procesando pago...</span>
                                        </div>
                                        <p class="mt-2 text-primary">Procesando pago con PayPal...</p>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Panel de Debug -->
<button class="debug-toggle" onclick="toggleDebugPanel()" title="Ver logs de APIs">
    <i class="fas fa-bug"></i>
</button>
<div id="debugPanel" class="debug-panel">
    <div style="color: #ffff00; font-weight: bold; margin-bottom: 5px;">? API LOGS</div>
    <div id="debugContent"></div>
</div>

<script>
    // Sistema de logging simplificado y corregido
    let debugLogs = [];
    let debugPanelVisible = false;
    let loggingEnabled = true;

    function updateDebugPanel() {
        try {
            const debugContent = document.getElementById('debugContent');
            if (debugContent && debugPanelVisible) {
                debugContent.innerHTML = debugLogs.map(log => `<div style="margin-bottom: 2px;">${log}</div>`).join('');
                debugContent.scrollTop = debugContent.scrollHeight;
            }
        } catch (error) {
            console.error('Error actualizando panel:', error);
        }
    }

    function toggleDebugPanel() {
        try {
            const panel = document.getElementById('debugPanel');
            debugPanelVisible = !debugPanelVisible;
            
            if (debugPanelVisible) {
                panel.classList.add('show');
                console.log('Panel de debug activado', 'system');
                updateDebugPanel();
            } else {
                panel.classList.remove('show');
            }
        } catch (error) {
            console.error('Error toggle panel:', error);
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        console.log('Sistema ArtDent iniciado correctamente', 'system');
        
        const facturarEmpresaCheckbox = document.getElementById('facturarEmpresa');
        const empresaFields = document.getElementById('empresaFields');
        const rucInput = document.getElementById('rucEmpresa');
        const nombreEmpresaInput = document.getElementById('nombreEmpresa');
        const buscarRucBtn = document.getElementById('buscarRuc');
        const rucInfo = document.getElementById('rucInfo');
        const rucMessage = document.getElementById('rucMessage');
        const loading = document.querySelector('.loading');
        const servicioSelect = document.getElementById('servicioId');
        const resumenCostos = document.getElementById('resumenCostos');
        const igvRow = document.getElementById('igvRow');
        const montoEnLetras = document.getElementById('montoEnLetras');
        const montoEnLetrasTexto = document.getElementById('montoEnLetrasTexto');

        // Toggle campos de empresa
        facturarEmpresaCheckbox.addEventListener('change', function() {
            if (this.checked) {
                empresaFields.classList.add('show');
                rucInput.required = true;
                console.log('Facturación empresarial activada', 'ui');
            } else {
                empresaFields.classList.remove('show');
                rucInput.required = false;
                rucInput.value = '';
                nombreEmpresaInput.value = '';
                nombreEmpresaInput.readOnly = true;
                hideRucInfo();
                console.log('Facturación empresarial desactivada', 'ui');
            }
        });

        // Buscar RUC al presionar Enter
        rucInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                buscarRUC();
            }
        });

        // Buscar RUC al hacer clic en el botón
        buscarRucBtn.addEventListener('click', function() {
            buscarRUC();
        });

        // Actualizar costos cuando cambie el servicio
        servicioSelect.addEventListener('change', function() {
            actualizarResumenCostos();
        });

        function buscarRUC() {
            const ruc = rucInput.value.trim();
            
            console.log('Iniciando búsqueda de RUC: ' + ruc, 'ruc');
            
            if (!ruc) {
                showRucInfo('Por favor ingrese un RUC', 'error');
                console.log('Error: RUC vacío', 'ruc');
                return;
            }
            
            if (ruc.length !== 11 || !/^\d{11}$/.test(ruc)) {
                showRucInfo('El RUC debe tener exactamente 11 dígitos', 'error');
                console.log('Error: Formato de RUC inválido', 'ruc');
                return;
            }

            // Mostrar loading
            loading.style.display = 'block';
            nombreEmpresaInput.value = '';
            hideRucInfo();
            buscarRucBtn.disabled = true;

            const apiUrl = './api/ruc?numero=' + ruc;
            console.log('Consultando API RUC: ' + apiUrl, 'ruc');

            fetch(apiUrl)
                .then(response => {
                    console.log('API RUC respondió con status: ' + response.status, 'ruc');
                    
                    if (!response.ok) {
                        throw new Error('HTTP error! status: ' + response.status);
                    }
                    
                    const contentType = response.headers.get('content-type');
                    console.log('Content-Type de respuesta RUC: ' + contentType, 'ruc');
                    
                    if (!contentType || !contentType.includes('application/json')) {
                        return response.text().then(text => {
                            console.log('Respuesta no JSON: ' + text.substring(0, 100) + '...', 'ruc');
                            throw new Error('La respuesta no es JSON válido');
                        });
                    }
                    
                    return response.json();
                })
                .then(data => {
                    console.log('Datos recibidos de API RUC: ' + JSON.stringify(data), 'ruc');
                    
                    loading.style.display = 'none';
                    buscarRucBtn.disabled = false;
                    
                    if (data.success && data.nombre) {
                        nombreEmpresaInput.value = data.nombre;
                        showRucInfo('? Empresa encontrada: ' + data.nombre, 'success');
                        nombreEmpresaInput.readOnly = true;
                        console.log('RUC encontrado exitosamente: ' + data.nombre, 'ruc');
                    } else {
                        showRucInfo(data.error || 'No se encontró información para este RUC', 'error');
                        nombreEmpresaInput.readOnly = true;
                        console.log('RUC no encontrado: ' + (data.error || 'Sin error específico'), 'ruc');
                    }
                })
                .catch(error => {
                    console.log('Error en consulta RUC: ' + error.message, 'error');
                    
                    loading.style.display = 'none';
                    buscarRucBtn.disabled = false;
                    showRucInfo('?? Error al consultar el RUC. Puede ingresar el nombre manualmente.', 'error');
                    nombreEmpresaInput.readOnly = false;
                });
        }

        function showRucInfo(message, type) {
            rucMessage.textContent = message;
            rucInfo.className = 'ruc-info ' + type;
            rucInfo.style.display = 'block';
        }

        function hideRucInfo() {
            rucInfo.style.display = 'none';
        }

        // Función para convertir monto a letras usando SOAP
        function convertirMontoALetrasSOAP(monto) {
            const montoEnLetrasDiv = document.getElementById('montoEnLetras');
            const montoEnLetrasSpan = document.getElementById('montoEnLetrasTexto');
            
            console.log('Iniciando conversión SOAP para monto: S/ ' + monto.toFixed(2), 'soap');
            
            if (!montoEnLetrasDiv || !montoEnLetrasSpan) {
                console.log('Error: Elementos de monto en letras no encontrados', 'soap');
                return;
            }
            
            // Estado de carga
            montoEnLetrasDiv.classList.add('loading');
            montoEnLetrasDiv.classList.remove('soap-success', 'soap-error');
            montoEnLetrasSpan.innerHTML = '<div class="spinner-border spinner-border-sm me-2" role="status"></div>Convirtiendo monto a letras vía SOAP...';
            
            const apiUrl = './api/numberToWords?amount=' + monto.toFixed(2);
            console.log('Consultando API SOAP: ' + apiUrl, 'soap');
            
            fetch(apiUrl)
                .then(response => {
                    console.log('API SOAP respondió con status: ' + response.status, 'soap');
                    
                    if (!response.ok) {
                        throw new Error('HTTP error! status: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Datos recibidos de API SOAP: ' + JSON.stringify(data), 'soap');
                    
                    // Remover estado de carga
                    montoEnLetrasDiv.classList.remove('loading');
                    
                    if (data.success && data.words && data.words.trim() !== '') {
                        montoEnLetrasDiv.classList.add('soap-success');
                        
                        const palabras = data.words.trim();
                        const htmlCompleto = '<i class="fas fa-spell-check me-2"></i><strong>Son:</strong> ' + palabras;
                        
                        montoEnLetrasSpan.innerHTML = htmlCompleto;
                        console.log('Conversión SOAP exitosa: ' + palabras, 'soap');
                        
                    } else {
                        montoEnLetrasDiv.classList.add('soap-error');
                        const errorMsg = data.error || 'Respuesta vacía del servicio';
                        montoEnLetrasSpan.innerHTML = '<i class="fas fa-exclamation-triangle me-2"></i>Error SOAP: ' + errorMsg;
                        console.log('Error en conversión SOAP: ' + errorMsg, 'soap');
                    }
                })
                .catch(error => {
                    console.log('Error de conexión SOAP: ' + error.message, 'error');
                    
                    montoEnLetrasDiv.classList.remove('loading');
                    montoEnLetrasDiv.classList.add('soap-error');
                    montoEnLetrasSpan.innerHTML = '<i class="fas fa-exclamation-triangle me-2"></i>Error de conexión: ' + error.message;
                });
        }

        function actualizarResumenCostos() {
            const servicioOption = servicioSelect.options[servicioSelect.selectedIndex];
            const paypalContainer = document.getElementById('paypal-button-container');
            const paypalInfo = document.getElementById('paypal-info');
            
            if (servicioOption && servicioOption.value) {
                const costoTotal = parseFloat(servicioOption.dataset.costo) || 0;
                
                console.log('Actualizando costos para servicio: ' + servicioOption.text + ' - S/ ' + costoTotal, 'ui');
                
                // El costo ya incluye IGV del 18%
                const subtotal = costoTotal / 1.18;
                const igv = costoTotal - subtotal;
                const total = costoTotal;
                
                document.getElementById('subtotal').textContent = subtotal.toFixed(2);
                document.getElementById('igv').textContent = igv.toFixed(2);
                document.getElementById('total').textContent = total.toFixed(2);
                
                igvRow.style.display = 'flex';
                resumenCostos.classList.add('show');
                
                // Convertir monto a letras usando SOAP
                convertirMontoALetrasSOAP(total);
                
                // Mostrar PayPal si no hay usuario logueado
                if (paypalContainer && document.querySelector('input[name="tipoPago"][value="1"]')) {
                    paypalInfo.style.display = 'none';
                    paypalContainer.classList.remove('hidden');
                    
                    if (!paypalButtonsRendered) {
                        setTimeout(() => {
                            inicializarPayPal();
                        }, 500);
                    }
                }
            } else {
                resumenCostos.classList.remove('show');
                montoEnLetras.classList.remove('soap-success', 'soap-error');
                montoEnLetrasTexto.innerHTML = '<i class="fas fa-spell-check me-2"></i>Seleccione un servicio para ver el monto en letras';
                
                if (paypalContainer && document.querySelector('input[name="tipoPago"][value="1"]')) {
                    paypalContainer.classList.add('hidden');
                    if (paypalInfo) {
                        paypalInfo.style.display = 'block';
                    }
                }
            }
        }

        // Variables globales para PayPal
        let tasaCambioUSD = 3.75;
        let paypalButtonsRendered = false;

        // Obtener tasa de cambio y inicializar PayPal
        function inicializarPayPal() {
            const tipoPagoInput = document.querySelector('input[name="tipoPago"][value="1"]');
            if (!tipoPagoInput) {
                console.log('PayPal no necesario - usuario logueado', 'paypal');
                return;
            }
            
            console.log('Iniciando configuración de PayPal', 'paypal');
            console.log('Consultando tasa de cambio USD/PEN', 'exchange');
            
            fetch('https://api.exchangerate-api.com/v4/latest/USD')
                .then(response => {
                    console.log('API Exchange Rate respondió con status: ' + response.status, 'exchange');
                    return response.json();
                })
                .then(data => {
                    console.log('Datos de tasa de cambio recibidos', 'exchange');
                    
                    tasaCambioUSD = data.rates.PEN || 3.75;
                    console.log('Tasa de cambio USD/PEN: ' + tasaCambioUSD, 'exchange');
                    
                    setTimeout(() => {
                        renderPayPalButtons();
                    }, 1000);
                })
                .catch(error => {
                    console.log('Error al obtener tasa de cambio: ' + error.message, 'error');
                    console.log('Usando tasa por defecto: ' + tasaCambioUSD, 'exchange');
                    
                    setTimeout(() => {
                        renderPayPalButtons();
                    }, 1000);
                });
        }

        function renderPayPalButtons() {
            if (paypalButtonsRendered) {
                console.log('PayPal ya está renderizado', 'paypal');
                return;
            }
            
            const container = document.getElementById('paypal-button-container');
            if (!container) {
                console.log('Error: Contenedor de PayPal no encontrado', 'paypal');
                return;
            }
            
            console.log('Renderizando botones de PayPal', 'paypal');
            
            container.style.display = 'block';
            container.style.width = '100%';
            container.style.minHeight = '50px';
            
            paypal.Buttons({
                style: {
                    shape: 'rect',
                    color: 'gold',
                    layout: 'vertical',
                    label: 'pay',
                    height: 50,
                    tagline: false
                },
                createOrder: function(data, actions) {
                    console.log('PayPal createOrder iniciado', 'paypal');
                    
                    const totalElement = document.getElementById('total');
                    if (!totalElement || !totalElement.textContent) {
                        console.log('Error: No hay total disponible para PayPal', 'paypal');
                        alert('Por favor seleccione un servicio antes de proceder con el pago');
                        return Promise.reject('No hay total disponible');
                    }
                    
                    const totalPEN = parseFloat(totalElement.textContent) || 0;
                    const totalUSD = (totalPEN / tasaCambioUSD).toFixed(2);
                    
                    console.log('Creando orden PayPal: S/ ' + totalPEN + ' = USD ' + totalUSD + ' (tasa: ' + tasaCambioUSD + ')', 'paypal');
                    
                    if (totalUSD <= 0) {
                        console.log('Error: Monto inválido para PayPal', 'paypal');
                        alert('El monto debe ser mayor a 0 para proceder con el pago');
                        return Promise.reject('Monto inválido');
                    }
                    
                    return actions.order.create({
                        purchase_units: [{
                            description: "Pago de consulta dental - ArtDent",
                            amount: {
                                currency_code: "USD",
                                value: totalUSD
                            }
                        }]
                    }).then(function(orderId) {
                        console.log('Orden PayPal creada exitosamente: ' + orderId, 'paypal');
                        return orderId;
                    });
                },
                onApprove: function(data, actions) {
                    console.log('PayPal onApprove iniciado - Order ID: ' + data.orderID, 'paypal');
                    
                    document.getElementById('loading-payment').style.display = 'block';
                    document.getElementById('paypal-button-container').style.display = 'none';
                    
                    return actions.order.capture().then(function(orderData) {
                        console.log('PayPal orden capturada exitosamente', 'paypal');
                        
                        const requiredFields = ['nombrePaciente', 'apellidoPaciente', 'dniPaciente', 'fechaReserva', 'horaReserva', 'servicioId', 'odontologoId'];
                        const missingFields = requiredFields.filter(field => !document.getElementById(field).value);
                        
                        if (missingFields.length > 0) {
                            console.log('Campos faltantes: ' + missingFields.join(', '), 'paypal');
                            alert('Por favor complete todos los campos requeridos: ' + missingFields.join(', '));
                            document.getElementById('loading-payment').style.display = 'none';
                            document.getElementById('paypal-button-container').style.display = 'block';
                            return;
                        }
                        
                        console.log('Enviando datos de reserva al servidor', 'paypal');
                        
                        const formData = new URLSearchParams({
                            action: 'crear',
                            nombrePaciente: document.getElementById('nombrePaciente').value,
                            apellidoPaciente: document.getElementById('apellidoPaciente').value,
                            dniPaciente: document.getElementById('dniPaciente').value,
                            telefonoPaciente: document.getElementById('telefonoPaciente').value || '',
                            correoPaciente: document.getElementById('correoPaciente').value || '',
                            fechaReserva: document.getElementById('fechaReserva').value,
                            horaReserva: document.getElementById('horaReserva').value,
                            servicioId: document.getElementById('servicioId').value,
                            odontologoId: document.getElementById('odontologoId').value,
                            descripcion: document.getElementById('descripcion').value || '',
                            facturarEmpresa: document.getElementById('facturarEmpresa').checked,
                            rucEmpresa: document.getElementById('rucEmpresa').value || '',
                            nombreEmpresa: document.getElementById('nombreEmpresa').value || '',
                            tipoPago: '1',
                            paypalOrderId: orderData.id,
                            paypalPayerId: orderData.payer.payer_id
                        });
                        
                        fetch('reserva', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded'
                            },
                            body: formData
                        })
                        .then(response => {
                            console.log('Servidor respondió con status: ' + response.status, 'paypal');
                            
                            if (!response.ok) {
                                throw new Error('Error en la respuesta del servidor');
                            }
                            return response.text();
                        })
                        .then(html => {
                            console.log('Reserva procesada exitosamente', 'paypal');
                            
                            document.open();
                            document.write(html);
                            document.close();
                        })
                        .catch(error => {
                            console.log('Error al procesar reserva: ' + error.message, 'error');
                            
                            alert('Error al procesar la reserva. Por favor contacte con soporte.');
                            document.getElementById('loading-payment').style.display = 'none';
                            document.getElementById('paypal-button-container').style.display = 'block';
                        });
                    });
                },
                onError: function(err) {
                    console.log('Error en PayPal: ' + JSON.stringify(err), 'error');
                    
                    alert('Error en el procesamiento del pago. Por favor intente nuevamente.');
                    document.getElementById('loading-payment').style.display = 'none';
                    document.getElementById('paypal-button-container').style.display = 'block';
                },
                onCancel: function(data) {
                    console.log('PayPal cancelado por usuario', 'paypal');
                    
                    alert('Pago cancelado. Puede intentar nuevamente cuando esté listo.');
                    document.getElementById('loading-payment').style.display = 'none';
                    document.getElementById('paypal-button-container').style.display = 'block';
                }
            }).render('#paypal-button-container').then(() => {
                paypalButtonsRendered = true;
                console.log('Botones PayPal renderizados exitosamente', 'paypal');
            }).catch(error => {
                paypalButtonsRendered = false;
                console.log('Error al renderizar PayPal: ' + error.message, 'error');
            });
        }

        // Inicializar PayPal cuando se carga la página
        setTimeout(() => {
            inicializarPayPal();
        }, 2000);

        // Validación adicional para usuarios logueados
        document.getElementById('reservaForm').addEventListener('submit', function(e) {
            const usuarioLogueado = document.querySelector('select[name="tipoPago"]');
            if (usuarioLogueado) {
                const tipoPago = document.getElementById('tipoPago').value;
                if (!tipoPago) {
                    e.preventDefault();
                    alert('Por favor seleccione un tipo de pago');
                    document.getElementById('tipoPago').focus();
                    return;
                }
            }
        });
    });
</script>

<%@ include file="layout/footer.jsp" %>
