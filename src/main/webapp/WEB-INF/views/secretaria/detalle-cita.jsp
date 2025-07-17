<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">

<jsp:include page="layout/header.jsp">
    <jsp:param name="pageTitle" value="Detalle de Cita" />
</jsp:include>

<body>
    <div class="modal-body">
        <c:if test="${citaDetalle != null}">
            <div class="row">
                <div class="col-md-6">
                    <h6><i class="fas fa-user me-2 text-primary"></i>Información del Paciente</h6>
                    <div class="card border-primary">
                        <div class="card-body">
                            <p><strong>Nombre:</strong> ${citaDetalle.nombreCompletoPaciente}</p>
                            <p><strong>Fecha de Cita:</strong> <fmt:formatDate value="${citaDetalle.diaReserva}" pattern="dd/MM/yyyy" /></p>
                            <p><strong>Hora Programada:</strong> <fmt:formatDate value="${citaDetalle.horaReserva}" pattern="HH:mm" /></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <h6><i class="fas fa-clock me-2 text-success"></i>Tiempos de Atención</h6>
                    <div class="card border-success">
                        <div class="card-body">
                            <p><strong>Hora de Entrada:</strong> 
                                <c:if test="${citaDetalle.fechaHoraEntrada != null}">
                                    <fmt:formatDate value="${citaDetalle.fechaHoraEntrada}" pattern="HH:mm:ss" />
                                </c:if>
                                <c:if test="${citaDetalle.fechaHoraEntrada == null}">
                                    No registrada
                                </c:if>
                            </p>
                            <p><strong>Hora de Salida:</strong> 
                                <c:if test="${citaDetalle.fechaHoraSalida != null}">
                                    <fmt:formatDate value="${citaDetalle.fechaHoraSalida}" pattern="HH:mm:ss" />
                                </c:if>
                                <c:if test="${citaDetalle.fechaHoraSalida == null}">
                                    No registrada
                                </c:if>
                            </p>
                            <p><strong>Duración Total:</strong> 
                                <c:choose>
                                    <c:when test="${citaDetalle.duracionMinutos != null && citaDetalle.duracionMinutos > 0}">
                                        <span class="badge bg-info">${citaDetalle.duracionMinutos} minutos</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">No calculada</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row mt-3">
                <div class="col-md-6">
                    <h6><i class="fas fa-tooth me-2 text-info"></i>Información del Servicio</h6>
                    <div class="card border-info">
                        <div class="card-body">
                            <p><strong>Servicio:</strong> 
                                <span class="badge bg-info">${citaDetalle.nombreServicio}</span>
                            </p>
                            <p><strong>Odontólogo:</strong> ${citaDetalle.nombreCompletoOdontologo}</p>
                            <p><strong>ID Cita:</strong> #${citaDetalle.idCita}</p>
                            <p><strong>ID Reserva:</strong> #${citaDetalle.reservaIdReserva}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <h6><i class="fas fa-stethoscope me-2 text-warning"></i>Estado de la Cita</h6>
                    <div class="card border-warning">
                        <div class="card-body">
                            <p><strong>Estado:</strong> 
                                <span class="badge bg-success">Completada</span>
                            </p>
                            <p><strong>Fecha de Registro:</strong> 
                                <fmt:formatDate value="${citaDetalle.fechaHoraEntrada}" pattern="dd/MM/yyyy" />
                            </p>
                            <c:if test="${citaDetalle.duracionMinutos != null}">
                                <p><strong>Eficiencia:</strong> 
                                    <c:choose>
                                        <c:when test="${citaDetalle.duracionMinutos <= 30}">
                                            <span class="badge bg-success">Excelente</span>
                                        </c:when>
                                        <c:when test="${citaDetalle.duracionMinutos <= 60}">
                                            <span class="badge bg-warning">Normal</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Extendida</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row mt-3">
                <div class="col-12">
                    <h6><i class="fas fa-file-medical me-2 text-danger"></i>Diagnóstico y Observaciones</h6>
                    <div class="card border-danger">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Diagnóstico:</strong></p>
                                    <div class="bg-light p-3 rounded">
                                        <c:choose>
                                            <c:when test="${not empty citaDetalle.diagnostico}">
                                                ${citaDetalle.diagnostico}
                                            </c:when>
                                            <c:otherwise>
                                                <em class="text-muted">No se registró diagnóstico específico</em>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Observaciones:</strong></p>
                                    <div class="bg-light p-3 rounded">
                                        <c:choose>
                                            <c:when test="${not empty citaDetalle.observaciones}">
                                                ${citaDetalle.observaciones}
                                            </c:when>
                                            <c:otherwise>
                                                <em class="text-muted">No se registraron observaciones adicionales</em>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            
                            <c:if test="${not empty citaDetalle.tratamiento}">
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <p><strong>Tratamiento Realizado:</strong></p>
                                        <div class="bg-success bg-opacity-10 p-3 rounded border border-success">
                                            ${citaDetalle.tratamiento}
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Información adicional -->
            <div class="row mt-3">
                <div class="col-12">
                    <div class="alert alert-info">
                        <h6><i class="fas fa-info-circle me-2"></i>Información Adicional</h6>
                        <div class="row">
                            <div class="col-md-4">
                                <small><strong>Fecha de Entrada:</strong><br>
                                <fmt:formatDate value="${citaDetalle.fechaHoraEntrada}" pattern="dd/MM/yyyy HH:mm:ss" /></small>
                            </div>
                            <div class="col-md-4">
                                <small><strong>Fecha de Salida:</strong><br>
                                <c:if test="${citaDetalle.fechaHoraSalida != null}">
                                    <fmt:formatDate value="${citaDetalle.fechaHoraSalida}" pattern="dd/MM/yyyy HH:mm:ss" />
                                </c:if>
                                <c:if test="${citaDetalle.fechaHoraSalida == null}">
                                    Cita en proceso
                                </c:if>
                                </small>
                            </div>
                            <div class="col-md-4">
                                <small><strong>Tiempo Total:</strong><br>
                                <c:if test="${citaDetalle.duracionMinutos != null}">
                                    ${citaDetalle.duracionTexto}
                                </c:if>
                                <c:if test="${citaDetalle.duracionMinutos == null}">
                                    En proceso...
                                </c:if>
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${citaDetalle == null}">
            <div class="alert alert-warning text-center">
                <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
                <h5>Cita no encontrada</h5>
                <p>No se pudo cargar la información de la cita solicitada.</p>
            </div>
        </c:if>
    </div>
</body>
</html>
