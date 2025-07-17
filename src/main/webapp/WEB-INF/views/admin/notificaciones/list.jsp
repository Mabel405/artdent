<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Centro de Notificaciones - ArtDent</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
    .notification-card {
        transition: all 0.3s ease;
        border-left: 4px solid transparent;
        cursor: pointer;
        position: relative;
    }
    
    .notification-card.nueva { 
        border-left-color: #28a745; 
        background-color: #f8fff9; 
    }
    
    .notification-card.confirmada { 
        border-left-color: #17a2b8; 
        background-color: #f0fcff; 
    }
    
    .notification-card.cancelada { 
        border-left-color: #dc3545; 
        background-color: #fff5f5; 
    }
    
    .notification-card.reprogramada { 
        border-left-color: #ffc107; 
        background-color: #fffdf0; 
    }
    
    /* Estilos mejorados para notificaciones urgentes */
    .notification-card.urgente {
        animation: pulse 2s infinite;
        border-left-width: 6px !important;
        border-left-color: #dc3545 !important;
        background: linear-gradient(135deg, #fff5f5 0%, #ffe6e6 100%);
        box-shadow: 0 0 15px rgba(220, 53, 69, 0.3);
    }
    
    .notification-card.urgente .notification-icon {
        animation: shake 1s infinite;
    }
    
    .notification-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    
    .notification-card.urgente:hover {
        box-shadow: 0 8px 25px rgba(220, 53, 69, 0.4);
    }
    
    .notification-icon {
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        font-size: 1.2rem;
    }
    
    .stats-card {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 15px;
    }
    
    .filter-section {
        background-color: #f8f9fa;
        border-radius: 10px;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
    }
    
    /* Indicador visual prominente para urgentes */
    .urgente-indicator {
        position: absolute;
        top: -8px;
        right: -8px;
        width: 24px;
        height: 24px;
        background: #dc3545;
        border: 2px solid white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 10px;
        font-weight: bold;
        z-index: 10;
        animation: bounce 1s infinite;
    }
    
    /* Badge urgente mejorado */
    .badge-urgente {
        background: linear-gradient(45deg, #dc3545, #ff6b6b) !important;
        animation: glow 2s ease-in-out infinite alternate;
        font-weight: bold;
        text-shadow: 0 0 3px rgba(0,0,0,0.3);
    }
    
    /* Animaciones */
    @keyframes pulse {
        0% { 
            box-shadow: 0 0 0 0 rgba(220, 53, 69, 0.7);
        }
        70% { 
            box-shadow: 0 0 0 10px rgba(220, 53, 69, 0);
        }
        100% { 
            box-shadow: 0 0 0 0 rgba(220, 53, 69, 0);
        }
    }
    
    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-2px); }
        75% { transform: translateX(2px); }
    }
    
    @keyframes bounce {
        0%, 20%, 50%, 80%, 100% {
            transform: translateY(0);
        }
        40% {
            transform: translateY(-3px);
        }
        60% {
            transform: translateY(-2px);
        }
    }
    
    @keyframes glow {
        from {
            box-shadow: 0 0 5px rgba(220, 53, 69, 0.5);
        }
        to {
            box-shadow: 0 0 10px rgba(220, 53, 69, 0.8);
        }
    }
    
    .empty-state {
        text-align: center;
        padding: 3rem;
        color: #6c757d;
    }
    
    /* Mejoras adicionales */
    .notification-meta {
        font-size: 0.9rem;
    }
    
    .time-badge {
        font-size: 0.75rem;
        opacity: 0.8;
    }
    
    .urgente-text {
        color: #dc3545;
        font-weight: bold;
        text-shadow: 0 0 2px rgba(220, 53, 69, 0.3);
    }
    
    /* Contador de urgentes en header */
    .urgente-counter {
        background: #dc3545;
        color: white;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 11px;
        font-weight: bold;
        margin-left: 5px;
        animation: pulse-counter 2s infinite;
    }
    
    @keyframes pulse-counter {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.1); }
    }
</style>
</head>
<body class="bg-light">
<!-- Header -->
<jsp:include page="../layout/header.jsp"/>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <jsp:include page="../layout/sidebar.jsp">
            <jsp:param name="page" value="notificaciones"/>
        </jsp:include>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">
                    <i class="fas fa-bell me-2 text-primary"></i>Centro de Notificaciones
                    <span class="badge bg-primary ms-2">${totalRecientes}</span>
                    <c:if test="${urgentes > 0}">
                        <span class="urgente-counter">${urgentes}</span>
                    </c:if>
                </h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <button type="button" class="btn btn-outline-success me-2" onclick="location.reload()">
                        <i class="fas fa-sync me-1"></i>Actualizar
                    </button>
                    <div class="dropdown">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                            <i class="fas fa-filter me-1"></i>Filtros Rápidos
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="?action=urgentes">
                                <i class="fas fa-exclamation-triangle text-danger me-2"></i>Solo Urgentes
                                <c:if test="${urgentes > 0}">
                                    <span class="badge bg-danger ms-2">${urgentes}</span>
                                </c:if>
                            </a></li>
                            <li><a class="dropdown-item" href="?action=hoy">
                                <i class="fas fa-calendar-day text-info me-2"></i>Solo Hoy
                            </a></li>
                            <li><a class="dropdown-item" href="?tipo=1">
                                <i class="fas fa-calendar-plus text-success me-2"></i>Nuevas Reservas
                            </a></li>
                            <li><a class="dropdown-item" href="?tipo=3">
                                <i class="fas fa-times-circle text-danger me-2"></i>Canceladas
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="notificaciones">
                                <i class="fas fa-list me-2"></i>Ver Todas
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Estadísticas rápidas -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card stats-card text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h4 class="mb-0">${totalRecientes}</h4>
                                    <p class="mb-0">Recientes</p>
                                </div>
                                <div class="align-self-center">
                                    <i class="fas fa-clock fa-2x opacity-75"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-danger text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h4 class="mb-0">${urgentes}</h4>
                                    <p class="mb-0">Urgentes</p>
                                </div>
                                <div class="align-self-center">
                                    <i class="fas fa-exclamation-triangle fa-2x opacity-75"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-success text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h4 class="mb-0">${hoy}</h4>
                                    <p class="mb-0">Hoy</p>
                                </div>
                                <div class="align-self-center">
                                    <i class="fas fa-calendar-day fa-2x opacity-75"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-warning text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h4 class="mb-0">${canceladas}</h4>
                                    <p class="mb-0">Canceladas</p>
                                </div>
                                <div class="align-self-center">
                                    <i class="fas fa-times-circle fa-2x opacity-75"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filtros principales -->
            <div class="filter-section">
                <form method="get" class="row">
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Tipo de Estado</label>
                        <select class="form-select" name="tipo">
                            <option value="">Todos los estados</option>
                            <option value="1" ${tipoFiltro == '1' ? 'selected' : ''}>Nueva Reserva</option>
                            <option value="2" ${tipoFiltro == '2' ? 'selected' : ''}>Confirmada</option>
                            <option value="3" ${tipoFiltro == '3' ? 'selected' : ''}>Cancelada</option>
                            <option value="4" ${tipoFiltro == '4' ? 'selected' : ''}>Reprogramada</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Prioridad</label>
                        <select class="form-select" name="prioridad">
                            <option value="">Todas las prioridades</option>
                            <option value="URGENTE" ${prioridadFiltro == 'URGENTE' ? 'selected' : ''}>Urgente</option>
                            <option value="ALTA" ${prioridadFiltro == 'ALTA' ? 'selected' : ''}>Alta</option>
                            <option value="NORMAL" ${prioridadFiltro == 'NORMAL' ? 'selected' : ''}>Normal</option>
                            <option value="BAJA" ${prioridadFiltro == 'BAJA' ? 'selected' : ''}>Baja</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Período</label>
                        <select class="form-select" name="dias">
                            <option value="1" ${diasAtras == 1 ? 'selected' : ''}>Último día</option>
                            <option value="3" ${diasAtras == 3 ? 'selected' : ''}>Últimos 3 días</option>
                            <option value="7" ${diasAtras == 7 ? 'selected' : ''}>Última semana</option>
                            <option value="15" ${diasAtras == 15 ? 'selected' : ''}>Últimos 15 días</option>
                            <option value="30" ${diasAtras == 30 ? 'selected' : ''}>Último mes</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-bold">&nbsp;</label>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-filter me-1"></i>Aplicar
                            </button>
                            <a href="notificaciones" class="btn btn-outline-secondary">
                                <i class="fas fa-times me-1"></i>Limpiar
                            </a>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Lista de notificaciones -->
            <div class="row">
                <c:forEach var="notif" items="${notificaciones}">
                    <div class="col-12 mb-3">
                        <div class="card notification-card ${notif.tipoEstado == 1 ? 'nueva' : ''} ${notif.tipoEstado == 2 ? 'confirmada' : ''} ${notif.tipoEstado == 3 ? 'cancelada' : ''} ${notif.tipoEstado == 4 ? 'reprogramada' : ''} ${notif.esUrgente ? 'urgente' : ''}">
                            <div class="card-body position-relative">
                                <!-- Indicador de urgencia -->
                                <c:if test="${notif.esUrgente}">
                                    <div class="urgente-indicator">
                                        <i class="fas fa-exclamation"></i>
                                    </div>
                                </c:if>
                                
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <div class="notification-icon bg-${notif.color} bg-opacity-10 text-${notif.color}">
                                            <i class="${notif.icono}"></i>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <h5 class="card-title mb-0 fw-bold ${notif.esUrgente ? 'urgente-text' : ''}">
                                                ${notif.titulo}
                                                <c:if test="${notif.esReciente}">
                                                    <span class="badge bg-success ms-2" style="font-size: 0.6rem;">NUEVO</span>
                                                </c:if>
                                                <c:if test="${notif.esUrgente}">
                                                    <span class="badge bg-danger ms-2" style="font-size: 0.6rem;">
                                                        <i class="fas fa-bolt me-1"></i>URGENTE
                                                    </span>
                                                </c:if>
                                            </h5>
                                            <div class="d-flex align-items-center">
                                                <span class="badge ${notif.prioridad == 'URGENTE' ? 'badge-urgente bg-danger' : notif.prioridad == 'ALTA' ? 'bg-warning' : notif.prioridad == 'NORMAL' ? 'bg-info' : 'bg-secondary'} me-2">
                                                    <c:if test="${notif.prioridad == 'URGENTE'}">
                                                        <i class="fas fa-exclamation-triangle me-1"></i>
                                                    </c:if>
                                                    ${notif.prioridad}
                                                </span>
                                                <small class="text-muted time-badge">
                                                    <i class="fas fa-clock me-1"></i>
                                                    ${notif.tiempoTranscurrido}
                                                </small>
                                            </div>
                                        </div>
                                        
                                        <p class="card-text mb-2 ${notif.esUrgente ? 'fw-bold' : ''}">${notif.mensaje}</p>
                                        
                                        <!-- Información de la reserva -->
                                        <div class="alert ${notif.esUrgente ? 'alert-danger' : 'alert-light'} py-2 mb-2">
                                            <div class="row notification-meta">
                                                <div class="col-md-3">
                                                    <small class="text-muted d-block">Paciente:</small>
                                                    <strong>${notif.nombreCompletoPaciente}</strong>
                                                </div>
                                                <div class="col-md-3">
                                                    <small class="text-muted d-block">Fecha y Hora:</small>
                                                    <strong>
                                                        <fmt:formatDate value="${notif.diaReserva}" pattern="dd/MM/yyyy"/>
                                                        ${notif.horaReserva}
                                                    </strong>
                                                </div>
                                                <div class="col-md-3">
                                                    <small class="text-muted d-block">Servicio:</small>
                                                    <strong>${notif.tipoServicio}</strong>
                                                </div>
                                                <div class="col-md-3">
                                                    <small class="text-muted d-block">Odontólogo:</small>
                                                    <strong>${notif.nombreCompletoOdontologo}</strong>
                                                </div>
                                            </div>
                                            
                                            <!-- Información adicional para urgentes -->
                                            <c:if test="${notif.esUrgente}">
                                                <div class="row mt-2">
                                                    <div class="col-12">
                                                        <div class="alert alert-warning py-1 mb-0">
                                                            <small>
                                                                <i class="fas fa-exclamation-triangle me-1"></i>
                                                                <strong>Atención Urgente Requerida:</strong>
                                                                <c:choose>
                                                                    <c:when test="${notif.tipoEstado == 1}">
                                                                        Cita programada dentro de las próximas 2 horas
                                                                    </c:when>
                                                                    <c:when test="${notif.tipoEstado == 3}">
                                                                        Reserva cancelada recientemente
                                                                    </c:when>
                                                                    <c:when test="${notif.tipoEstado == 4}">
                                                                        Reserva reprogramada recientemente
                                                                    </c:when>
                                                                </c:choose>
                                                            </small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="badge bg-${notif.color} bg-opacity-10 text-${notif.color}">
                                                    ${notif.estadoTexto}
                                                </span>
                                                <small class="text-muted ms-2">
                                                    Actualizado: <fmt:formatDate value="${notif.fechaActualizacion}" pattern="dd/MM HH:mm"/>
                                                </small>
                                            </div>
                                            <div>
                                                <button type="button" class="btn btn-sm ${notif.esUrgente ? 'btn-danger' : 'btn-outline-info'}" 
                                                        onclick="verDetalle(${notif.idReserva})"
                                                        title="Ver detalles completos">
                                                    <i class="fas fa-eye"></i>
                                                    <c:if test="${notif.esUrgente}">
                                                        <span class="ms-1">URGENTE</span>
                                                    </c:if>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty notificaciones}">
                <div class="empty-state">
                    <i class="fas fa-bell-slash text-muted" style="font-size: 4rem;"></i>
                    <h4 class="text-muted mt-3">No hay notificaciones</h4>
                    <p class="text-muted">No se encontraron notificaciones con los filtros aplicados</p>
                    <a href="notificaciones" class="btn btn-primary">
                        <i class="fas fa-refresh me-1"></i>Ver todas las notificaciones
                    </a>
                </div>
            </c:if>
        </main>
    </div>
</div>

<!-- Modal para detalles de reserva -->
<div class="modal fade" id="detalleModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-calendar-alt me-2"></i>Detalles de la Reserva
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="detalleContent">
                <div class="text-center">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Cargando...</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Función para mostrar notificación de urgentes al cargar la página
    document.addEventListener('DOMContentLoaded', function() {
        const urgentesCount = ${urgentes};
        if (urgentesCount > 0) {
            // Mostrar toast de notificación
            showUrgentNotification(urgentesCount);
        }
        
        // Auto-scroll a la primera notificación urgente
        const firstUrgent = document.querySelector('.notification-card.urgente');
        if (firstUrgent) {
            setTimeout(() => {
                firstUrgent.scrollIntoView({ 
                    behavior: 'smooth', 
                    block: 'center' 
                });
            }, 1000);
        }
    });
    
    function showUrgentNotification(count) {
        // Crear toast dinámicamente
        const toastHtml = `
            <div class="toast-container position-fixed top-0 end-0 p-3">
                <div id="urgentToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header bg-danger text-white">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <strong class="me-auto">Notificaciones Urgentes</strong>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                    </div>
                    <div class="toast-body">
                        Tienes <strong>${count}</strong> notificación${count > 1 ? 'es' : ''} urgente${count > 1 ? 's' : ''} que requieren atención inmediata.
                    </div>
                </div>
            </div>
        `;
        
        document.body.insertAdjacentHTML('beforeend', toastHtml);
        
        const toast = new bootstrap.Toast(document.getElementById('urgentToast'));
        toast.show();
    }

    function verDetalle(idReserva) {
        const modal = new bootstrap.Modal(document.getElementById('detalleModal'));
        modal.show();
        
        fetch('notificaciones?action=detalle&id=' + idReserva)
            .then(response => response.json())
            .then(data => {
                if (data.error) {
                    document.getElementById('detalleContent').innerHTML = 
                        '<div class="alert alert-danger">' + data.error + '</div>';
                } else {
                    mostrarDetalle(data);
                }
            })
            .catch(error => {
                document.getElementById('detalleContent').innerHTML = 
                    '<div class="alert alert-danger">Error al cargar los detalles</div>';
            });
    }
    
    function mostrarDetalle(reserva) {
        const content = document.getElementById('detalleContent');
        
        const fechaReserva = reserva.diaReserva ? new Date(reserva.diaReserva).toLocaleDateString('es-ES') : 'No disponible';
        const fechaRegistro = reserva.fechaRegistro ? new Date(reserva.fechaRegistro).toLocaleString('es-ES') : 'No disponible';
        
        // Construir HTML usando concatenación de strings
        let html = '<div class="row">' +
            '<div class="col-md-6">' +
                '<h6 class="text-primary"><i class="fas fa-user me-2"></i>Información del Paciente</h6>' +
                '<table class="table table-sm">' +
                    '<tr><td><strong>Nombre:</strong></td><td>' + (reserva.nombrePaciente || '') + ' ' + (reserva.apellidoPaciente || '') + '</td></tr>' +
                    '<tr><td><strong>Teléfono:</strong></td><td>' + (reserva.telefonoPaciente || 'No disponible') + '</td></tr>' +
                    '<tr><td><strong>Correo:</strong></td><td>' + (reserva.correoPaciente || 'No disponible') + '</td></tr>' +
                '</table>' +
            '</div>' +
            '<div class="col-md-6">' +
                '<h6 class="text-primary"><i class="fas fa-calendar me-2"></i>Información de la Cita</h6>' +
                '<table class="table table-sm">' +
                    '<tr><td><strong>Fecha:</strong></td><td>' + fechaReserva + '</td></tr>' +
                    '<tr><td><strong>Hora:</strong></td><td>' + (reserva.horaReserva || 'No disponible') + '</td></tr>' +
                    '<tr><td><strong>Servicio:</strong></td><td>' + (reserva.tipoServicio || 'No disponible') + '</td></tr>' +
                '</table>' +
            '</div>' +
        '</div>' +
        '<div class="row mt-3">' +
            '<div class="col-md-6">' +
                '<h6 class="text-primary"><i class="fas fa-user-md me-2"></i>Odontólogo</h6>' +
                '<p><strong>Dr. ' + (reserva.nombreOdontologo || '') + ' ' + (reserva.apellidoOdontologo || '') + '</strong></p>' +
            '</div>' +
            '<div class="col-md-6">' +
                '<h6 class="text-primary"><i class="fas fa-money-bill me-2"></i>Costo</h6>' +
                '<p><strong>S/ ' + (reserva.costoServicio ? parseFloat(reserva.costoServicio).toFixed(2) : '0.00') + '</strong></p>' +
            '</div>' +
        '</div>';
        
        // Agregar descripción si existe
        if (reserva.descripcion && reserva.descripcion.trim() !== '') {
            html += '<div class="row mt-3">' +
                '<div class="col-12">' +
                    '<h6 class="text-primary">Descripción</h6>' +
                    '<p>' + reserva.descripcion + '</p>' +
                '</div>' +
            '</div>';
        }
        
        // Agregar información de registro
        html += '<div class="row mt-3">' +
            '<div class="col-12">' +
                '<small class="text-muted">' +
                    '<strong>Registrado:</strong> ' + fechaRegistro + '<br>' +
                    '<strong>Por:</strong> ' + (reserva.nombreUsuarioRegistro || 'Sistema') +
                '</small>' +
            '</div>' +
        '</div>';
        
        content.innerHTML = html;
    }
    
    // Sonido de alerta para notificaciones urgentes (opcional)
    function playUrgentSound() {
        // Solo si el usuario ha interactuado con la página
        if (document.hasFocus()) {
            const audio = new Audio('data:audio/wav;base64,UklGRnoGAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQoGAACBhYqFbF1fdJivrJBhNjVgodDbq2EcBj+a2/LDciUFLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBSuBzvLZiTYIG2m98OScTgwOUarm7blmGgU7k9n1unEiBC13yO/eizEIHWq+8+OWT');
            audio.play().catch(() => {
                // Silenciar error si no se puede reproducir
            });
        }
    }
</script>
</body>
</html>