<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<jsp:include page="layout/header.jsp">
    <jsp:param name="pageTitle" value="Notificaciones" />
</jsp:include>

<body>
    <jsp:include page="layout/sidebar.jsp">
        <jsp:param name="page" value="notificaciones" />
    </jsp:include>

    <!-- Main content -->
    <main class="main-content">
        <div class="container-fluid p-4">
            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h2">
                    <i class="fas fa-bell me-2"></i>
                    Notificaciones
                </h1>
                <div class="btn-group">
                    <button class="btn btn-outline-primary" onclick="marcarTodasLeidas()">
                        <i class="fas fa-check-double me-1"></i>
                        Marcar todas como leídas
                    </button>
                    <button class="btn btn-outline-secondary" onclick="actualizarNotificaciones()">
                        <i class="fas fa-sync me-1"></i>
                        Actualizar
                    </button>
                </div>
            </div>

            <!-- Estadísticas de notificaciones -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card stat-card-warning">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h6>No Leídas</h6>
                                    <h4>${notificacionesNoLeidas}</h4>
                                </div>
                                <i class="fas fa-exclamation-circle fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card-info">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h6>Hoy</h6>
                                    <h4>${notificacionesHoy}</h4>
                                </div>
                                <i class="fas fa-calendar-day fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card-success">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h6>Esta Semana</h6>
                                    <h4>${notificacionesSemana}</h4>
                                </div>
                                <i class="fas fa-calendar-week fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h6>Total</h6>
                                    <h4>${totalNotificaciones}</h4>
                                </div>
                                <i class="fas fa-bell fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filtros -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <label class="form-label">Tipo:</label>
                            <select class="form-select" id="filtroTipo">
                                <option value="">Todos los tipos</option>
                                <option value="nueva_reserva">Nueva Reserva</option>
                                <option value="reserva_confirmada">Reserva Confirmada</option>
                                <option value="reserva_cancelada">Reserva Cancelada</option>
                                <option value="recordatorio">Recordatorio</option>
                                <option value="sistema">Sistema</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Estado:</label>
                            <select class="form-select" id="filtroEstado">
                                <option value="">Todos</option>
                                <option value="no_leida">No Leídas</option>
                                <option value="leida">Leídas</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Fecha:</label>
                            <input type="date" class="form-control" id="filtroFecha">
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <button class="btn btn-primary" onclick="aplicarFiltros()">
                                <i class="fas fa-search me-1"></i>
                                Filtrar
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Lista de Notificaciones -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">
                        <i class="fas fa-list me-2"></i>
                        Lista de Notificaciones
                    </h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${not empty notificaciones}">
                            <c:forEach var="notif" items="${notificaciones}">
                                <div class="notification-item ${notif.leida ? '' : 'unread'}" data-id="${notif.id}">
                                    <div class="d-flex align-items-start p-3 border-bottom">
                                        <div class="notification-icon me-3">
                                            <c:choose>
                                                <c:when test="${notif.tipo == 'nueva_reserva'}">
                                                    <i class="fas fa-plus-circle text-warning fa-2x"></i>
                                                </c:when>
                                                <c:when test="${notif.tipo == 'reserva_confirmada'}">
                                                    <i class="fas fa-check-circle text-success fa-2x"></i>
                                                </c:when>
                                                <c:when test="${notif.tipo == 'reserva_cancelada'}">
                                                    <i class="fas fa-times-circle text-danger fa-2x"></i>
                                                </c:when>
                                                <c:when test="${notif.tipo == 'recordatorio'}">
                                                    <i class="fas fa-clock text-info fa-2x"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-info-circle text-secondary fa-2x"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h6 class="mb-1 ${notif.leida ? 'text-muted' : 'fw-bold'}">${notif.titulo}</h6>
                                                    <p class="mb-1 ${notif.leida ? 'text-muted' : ''}">${notif.mensaje}</p>
                                                    <small class="text-muted">
                                                        <i class="fas fa-clock me-1"></i>
                                                        <fmt:formatDate value="${notif.fechaCreacion}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </small>
                                                </div>
                                                <div class="btn-group btn-group-sm">
                                                    <c:if test="${not notif.leida}">
                                                        <button class="btn btn-outline-primary" onclick="marcarLeida(${notif.id})">
                                                            <i class="fas fa-check"></i>
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${notif.accionable}">
                                                        <button class="btn btn-outline-success" onclick="ejecutarAccion('${notif.accion}', ${notif.relacionId})">
                                                            <i class="fas fa-external-link-alt"></i>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fas fa-bell-slash fa-4x text-muted mb-3"></i>
                                <h4>No hay notificaciones</h4>
                                <p class="text-muted">Las notificaciones aparecerán aquí cuando ocurran eventos importantes.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function marcarLeida(idNotificacion) {
            fetch('secretaria', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `action=marcar-leida&idNotificacion=${idNotificacion}`
            })
            .then(response => {
                if (response.ok) {
                    const notifElement = document.querySelector(`[data-id="${idNotificacion}"]`);
                    notifElement.classList.remove('unread');
                    notifElement.querySelector('.btn-outline-primary').remove();
                }
            });
        }

        function marcarTodasLeidas() {
            if (confirm('¿Marcar todas las notificaciones como leídas?')) {
                fetch('secretaria', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=marcar-todas-leidas'
                })
                .then(response => {
                    if (response.ok) {
                        location.reload();
                    }
                });
            }
        }

        function ejecutarAccion(accion, relacionId) {
            switch(accion) {
                case 'ver_solicitud':
                    window.location.href = `secretaria?action=solicitudes&highlight=${relacionId}`;
                    break;
                case 'ver_cita':
                    window.location.href = `secretaria?action=historial&highlight=${relacionId}`;
                    break;
                default:
                    console.log('Acción no definida:', accion);
            }
        }

        function aplicarFiltros() {
            const tipo = document.getElementById('filtroTipo').value;
            const estado = document.getElementById('filtroEstado').value;
            const fecha = document.getElementById('filtroFecha').value;
            
            let url = 'secretaria?action=notificaciones';
            const params = [];
            
            if (tipo) params.push('tipo=' + tipo);
            if (estado) params.push('estado=' + estado);
            if (fecha) params.push('fecha=' + fecha);
            
            if (params.length > 0) {
                url += '&' + params.join('&');
            }
            
            window.location.href = url;
        }

        function actualizarNotificaciones() {
            location.reload();
        }

        // Auto-actualizar cada 30 segundos
        setInterval(function() {
            actualizarNotificaciones();
        }, 30000);
    </script>

    <style>
        .notification-item.unread {
            background-color: #f8f9fa;
            border-left: 4px solid #007bff;
        }
        .notification-item:hover {
            background-color: #f1f3f4;
        }
        .notification-icon {
            min-width: 50px;
        }
    </style>
</body>
</html>
