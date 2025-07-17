<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">

<jsp:include page="layout/header.jsp">
    <jsp:param name="pageTitle" value="Detalle de Solicitud" />
</jsp:include>

<body>
    <jsp:include page="layout/sidebar.jsp">
        <jsp:param name="page" value="solicitudes" />
    </jsp:include>

    <!-- Main content -->
    <main class="main-content">
        <!-- Header -->
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="page-title">
                    <i class="fas fa-file-alt"></i>
                    Detalle de Solicitud #${reservaDetalle.idReserva}
                </h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="secretaria">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="secretaria?action=solicitudes">Solicitudes</a></li>
                        <li class="breadcrumb-item active">Detalle</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container-fluid px-4">
            <div class="row">
                <div class="col-12">
                    <div class="detail-card">
                        <div class="detail-header">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h2 class="mb-2">
                                        <i class="fas fa-file-alt me-2"></i>
                                        Solicitud #${reservaDetalle.idReserva}
                                    </h2>
                                    <p class="mb-0 opacity-75">Información completa de la reserva</p>
                                </div>
                                <span class="status-badge status-pendiente">
                                    ${reservaDetalle.estadoTexto}
                                </span>
                            </div>
                        </div>

                        <div class="detail-body">
                            <!-- Información del Paciente -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-user"></i>
                                    Información del Paciente
                                </h3>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-label">Nombre Completo</div>
                                        <div class="info-value">${reservaDetalle.nombreCompletoPaciente}</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">ID del Paciente</div>
                                        <div class="info-value">${reservaDetalle.pacienteIdPaciente}</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Información de la Cita -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-calendar-check"></i>
                                    Información de la Cita
                                </h3>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-label">Fecha</div>
                                        <div class="info-value">
                                            <fmt:formatDate value="${reservaDetalle.diaReserva}" pattern="EEEE, dd 'de' MMMM 'de' yyyy"/>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Hora</div>
                                        <div class="info-value">
                                            <fmt:formatDate value="${reservaDetalle.horaReserva}" pattern="HH:mm"/>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Servicio</div>
                                        <div class="info-value">${reservaDetalle.nombreServicio}</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Odontólogo Asignado</div>
                                        <div class="info-value">${reservaDetalle.nombreCompletoOdontologo}</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Información Adicional -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-info-circle"></i>
                                    Información Adicional
                                </h3>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <div class="info-label">Token de Cliente</div>
                                        <div class="info-value">
                                            <code style="background: #e2e8f0; padding: 4px 8px; border-radius: 4px;">
                                                ${reservaDetalle.tokenCliente}
                                            </code>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Estado</div>
                                        <div class="info-value">${reservaDetalle.estadoTexto}</div>
                                    </div>
                                    <c:if test="${not empty reservaDetalle.descripcion}">
                                        <div class="info-item" style="grid-column: 1 / -1;">
                                            <div class="info-label">Descripción</div>
                                            <div class="info-value">${reservaDetalle.descripcion}</div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Acciones -->
                            <div class="info-section">
                                <h3 class="section-title">
                                    <i class="fas fa-cogs"></i>
                                    Acciones Disponibles
                                </h3>
                                <div class="d-flex flex-wrap gap-3">
                                    <c:if test="${reservaDetalle.tipoEstado == 1}">
                                        <button class="btn btn-success btn-action" onclick="confirmarReserva(${reservaDetalle.idReserva})">
                                            <i class="fas fa-check"></i>
                                            Confirmar Reserva
                                        </button>
                                        <button class="btn btn-danger btn-action" onclick="cancelarReserva(${reservaDetalle.idReserva})">
                                            <i class="fas fa-times"></i>
                                            Cancelar Reserva
                                        </button>
                                    </c:if>
                                    <a href="secretaria?action=solicitudes" class="btn btn-secondary btn-action">
                                        <i class="fas fa-arrow-left"></i>
                                        Volver a Solicitudes
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Modal de Confirmación -->
    <div class="modal fade" id="modalConfirmacion" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Confirmar Acción
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p id="mensajeConfirmacion"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="btnConfirmarAccion">Confirmar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let accionPendiente = null;
        let idReservaPendiente = null;

        function confirmarReserva(idReserva) {
            accionPendiente = 'confirmar';
            idReservaPendiente = idReserva;
            document.getElementById('mensajeConfirmacion').innerHTML = 
                '<strong>¿Está seguro de confirmar esta reserva?</strong><br>' +
                '<small class="text-muted">Se enviará una notificación de confirmación al paciente.</small>';
            
            const modal = new bootstrap.Modal(document.getElementById('modalConfirmacion'));
            modal.show();
        }

        function cancelarReserva(idReserva) {
            accionPendiente = 'cancelar';
            idReservaPendiente = idReserva;
            document.getElementById('mensajeConfirmacion').innerHTML = 
                '<strong>¿Está seguro de cancelar esta reserva?</strong><br>' +
                '<small class="text-muted">Se enviará una notificación de cancelación al paciente.</small>';
            
            const modal = new bootstrap.Modal(document.getElementById('modalConfirmacion'));
            modal.show();
        }

        document.getElementById('btnConfirmarAccion').addEventListener('click', function () {
            if (accionPendiente && idReservaPendiente) {
                let actionMapped = (accionPendiente === 'confirmar') ? 'confirmar-reserva'
                        : (accionPendiente === 'cancelar') ? 'cancelar-reserva'
                        : '';

                if (!actionMapped) {
                    alert('Acción no válida');
                    return;
                }

                fetch('secretaria', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=' + encodeURIComponent(actionMapped) + '&idReserva=' + encodeURIComponent(idReservaPendiente)
                })
                .then(response => {
                    if (response.ok) {
                        window.location.href = 'secretaria?action=solicitudes';
                    } else {
                        alert('Error al procesar la solicitud');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error al procesar la solicitud');
                });

                const modal = bootstrap.Modal.getInstance(document.getElementById('modalConfirmacion'));
                if (modal) {
                    modal.hide();
                }
            }
        });
    </script>

    <style>
        .detail-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border: 1px solid #e2e8f0;
            overflow: hidden;
        }

        .detail-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 24px;
        }

        .detail-body {
            padding: 32px;
        }

        .info-section {
            margin-bottom: 32px;
        }

        .section-title {
            color: #667eea;
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .info-item {
            background: #f8fafc;
            padding: 16px;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }

        .info-label {
            font-weight: 600;
            color: #64748b;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .info-value {
            color: #1e293b;
            font-weight: 500;
            font-size: 1.1rem;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .status-pendiente {
            background: #fef3c7;
            color: #92400e;
        }

        .btn-action {
            border-radius: 8px;
            padding: 12px 24px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</body>
</html>
