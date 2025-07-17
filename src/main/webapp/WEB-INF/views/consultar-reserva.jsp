<%@ include file="layout/header.jsp" %>
<script src="https://www.paypal.com/sdk/js?client-id=Ab76YGp-Kv0PL6XzfwP4zH0OJN4oMfbk4CCxw84dyOsfEGAUWl6JRdgE0r3kUAxkyA45rsjaby4DkcDj&currency=USD&locale=es_ES" data-sdk-integration-source="button-factory"></script>
<!-- Page Header -->
<section class="py-4 bg-primary text-white">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="display-6 fw-bold mb-2">Consultar Estado de Cita</h1>
                <p class="lead">Ingresa tu token o DNI para verificar tus citas</p>
            </div>
        </div>
    </div>
</section>

<!-- Formulario de Consulta -->
<section class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-search me-2"></i>Buscar Citas</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/reserva" method="post">
                            <input type="hidden" name="action" value="buscar">
                            
                            <div class="mb-3">
                                <label for="token" class="form-label">Token de Consulta</label>
                                <input type="text" class="form-control" id="token" name="token" 
                                       placeholder="Ingresa tu token de 11 caracteres" maxlength="11">
                                <div class="form-text">El token te fue proporcionado al momento de hacer la reserva</div>
                            </div>
                            
                            <div class="text-center my-3">
                                <span class="text-muted">- O -</span>
                            </div>
                            
                            <div class="mb-3">
                                <label for="dni" class="form-label">DNI del Paciente</label>
                                <input type="text" class="form-control" id="dni" name="dni" 
                                       placeholder="Ingresa tu DNI" maxlength="8" pattern="[0-9]{8}">
                                <div class="form-text">Ingresa tu número de DNI de 8 dígitos</div>
                            </div>
                            
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Buscar Citas
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Mensajes -->
        <c:if test="${not empty mensaje}">
            <div class="row justify-content-center mt-4">
                <div class="col-lg-8">
                    <div class="alert alert-info text-center">
                        <i class="fas fa-info-circle me-2"></i>
                        ${mensaje}
                    </div>
                </div>
            </div>
        </c:if>
        
        <!-- Resultados de Búsqueda -->
        <c:if test="${not empty reservas}">
            <div class="row justify-content-center mt-5">
                <div class="col-lg-10">
                    <h3 class="text-center mb-4">
                        <c:if test="${not empty paciente}">
                            Citas de ${paciente.nombre} ${paciente.apellido}
                        </c:if>
                        <c:if test="${empty paciente}">
                            Resultados de la Búsqueda
                        </c:if>
                    </h3>
                    
                    <div class="row">
                        <c:forEach var="reserva" items="${reservas}" varStatus="status">
                            <div class="col-md-6 mb-4">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <span class="fw-bold">Cita #${reserva.idReserva}</span>
                                        <span class="badge ${reserva.tipoEstado == 1 ? 'bg-warning' : reserva.tipoEstado == 2 ? 'bg-success' : 'bg-danger'}">
                                            ${reserva.tipoEstado == 1 ? 'Pendiente' : reserva.tipoEstado == 2 ? 'Confirmada' : 'Cancelada'}
                                        </span>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-2">
                                            <i class="fas fa-calendar text-primary me-2"></i>
                                            <strong>Fecha:</strong> ${reserva.diaReserva} (${reserva.diaSemana})
                                        </div>
                                        <div class="mb-2">
                                            <i class="fas fa-clock text-primary me-2"></i>
                                            <strong>Hora:</strong> ${reserva.horaReserva}
                                        </div>
                                        <div class="mb-2">
                                            <i class="fas fa-key text-primary me-2"></i>
                                            <strong>Token:</strong> <code>${reserva.tokenCliente}</code>
                                        </div>
                                        <c:if test="${not empty reserva.descripcion}">
                                            <div class="mb-2">
                                                <i class="fas fa-comment text-primary me-2"></i>
                                                <strong>Descripción:</strong> ${reserva.descripcion}
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="card-footer bg-light">
                                        <small class="text-muted">
                                            <i class="fas fa-info-circle me-1"></i>
                                            ${reserva.tipoEstado == 1 ? 'Tu cita está pendiente de confirmación' : 
                                              reserva.tipoEstado == 2 ? 'Tu cita ha sido confirmada' : 'Tu cita ha sido cancelada'}
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>
        
        <!-- Información Adicional -->
        <div class="row justify-content-center mt-5">
            <div class="col-lg-8">
                <div class="card bg-light border-0">
                    <div class="card-body text-center">
                        <h5 class="text-primary mb-3">¿Necesitas Ayuda?</h5>
                        <p class="text-muted mb-3">Si tienes problemas para encontrar tu cita o necesitas hacer cambios, contáctanos:</p>
                        <div class="d-flex flex-wrap justify-content-center gap-3">
                            <a href="tel:+51999888777" class="btn btn-outline-primary">
                                <i class="fas fa-phone me-2"></i>+51 999 888 777
                            </a>
                            <a href="mailto:info@artdent.com" class="btn btn-outline-primary">
                                <i class="fas fa-envelope me-2"></i>info@artdent.com
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="layout/footer.jsp" %>
