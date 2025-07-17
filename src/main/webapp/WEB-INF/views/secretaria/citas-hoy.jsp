<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">

<jsp:include page="layout/header.jsp">
    <jsp:param name="pageTitle" value="Citas de Hoy" />
</jsp:include>

<body>
    <jsp:include page="layout/sidebar.jsp">
        <jsp:param name="activeMenu" value="citas-hoy" />
    </jsp:include>

    <!-- Main content -->
    <main class="main-content">
        <!-- Header -->
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="page-title">
                    <i class="fas fa-calendar-check"></i>
                    Citas de Hoy
                </h1>
                <div class="stats-badge">
                    <i class="fas fa-calendar-day me-2"></i>
                    <fmt:formatDate value="${fechaHoy}" pattern="dd/MM/yyyy"/>
                </div>
            </div>
        </div>

        <!-- Resumen del día -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stat-card-today stat-card-warning">
                    <div class="card-body text-center">
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-number">${reservasConfirmadas.size()}</div>
                        <div class="stat-label">Pendientes de Entrada</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card-today stat-card-info">
                    <div class="card-body text-center">
                        <div class="stat-icon">
                            <i class="fas fa-play-circle"></i>
                        </div>
                        <div class="stat-number">${reservasEnProceso.size()}</div>
                        <div class="stat-label">En Proceso</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card-today stat-card-success">
                    <div class="card-body text-center">
                        <div class="stat-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-number">${reservasCompletadas.size()}</div>
                        <div class="stat-label">Completadas</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card-today stat-card-primary">
                    <div class="card-body text-center">
                        <div class="stat-icon">
                            <i class="fas fa-calendar-day"></i>
                        </div>
                        <div class="stat-number">${reservasConfirmadas.size() + reservasEnProceso.size() + reservasCompletadas.size()}</div>
                        <div class="stat-label">Total del Día</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Citas Confirmadas (Pendientes de Entrada) -->
        <c:if test="${not empty reservasConfirmadas}">
            <div class="section-today mb-4">
                <div class="section-header-today">
                    <h4 class="section-title-today">
                        <i class="fas fa-clock text-warning me-2"></i>
                        Citas Confirmadas - Pendientes de Entrada
                        <span class="badge bg-warning text-dark ms-2">${reservasConfirmadas.size()}</span>
                    </h4>
                </div>
                <div class="row">
                    <c:forEach var="reserva" items="${reservasConfirmadas}">
                        <div class="col-lg-6 col-xl-4 mb-3">
                            <div class="cita-card cita-card-warning">
                                <div class="cita-header">
                                    <div class="cita-time">
                                        <i class="fas fa-clock me-2"></i>
                                        <fmt:formatDate value="${reserva.horaReserva}" pattern="HH:mm"/>
                                    </div>
                                    <div class="cita-status">
                                        <span class="status-badge status-warning">Confirmada</span>
                                    </div>
                                </div>
                                <div class="cita-body">
                                    <div class="patient-info">
                                        <h6 class="patient-name">
                                            <i class="fas fa-user me-2"></i>
                                            ${reserva.nombreCompletoPaciente}
                                        </h6>
                                    </div>
                                    <div class="service-info">
                                        <div class="info-row">
                                            <i class="fas fa-tooth me-2"></i>
                                            <span>${reserva.nombreServicio}</span>
                                        </div>
                                        <div class="info-row">
                                            <i class="fas fa-user-md me-2"></i>
                                            <span>${reserva.nombreCompletoOdontologo}</span>
                                        </div>
                                    </div>
                                    <c:if test="${not empty reserva.descripcion}">
                                        <div class="description-info">
                                            <small class="text-muted">
                                                <i class="fas fa-comment me-1"></i>
                                                ${reserva.descripcion}
                                            </small>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="cita-footer">
                                    <button class="btn btn-success btn-action" onclick="registrarEntrada(${reserva.idReserva})">
                                        <i class="fas fa-sign-in-alt me-2"></i>
                                        Registrar Entrada
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Citas En Proceso -->
        <c:if test="${not empty reservasEnProceso}">
            <div class="section-today mb-4">
                <div class="section-header-today">
                    <h4 class="section-title-today">
                        <i class="fas fa-play-circle text-info me-2"></i>
                        Citas En Proceso
                        <span class="badge bg-info ms-2">${reservasEnProceso.size()}</span>
                    </h4>
                </div>
                <div class="row">
                    <c:forEach var="reserva" items="${reservasEnProceso}">
                        <div class="col-lg-6 col-xl-4 mb-3">
                            <div class="cita-card cita-card-info">
                                <div class="cita-header">
                                    <div class="cita-time">
                                        <i class="fas fa-clock me-2"></i>
                                        <fmt:formatDate value="${reserva.horaReserva}" pattern="HH:mm"/>
                                    </div>
                                    <div class="cita-status">
                                        <span class="status-badge status-info">En Proceso</span>
                                    </div>
                                </div>
                                <div class="cita-body">
                                    <div class="patient-info">
                                        <h6 class="patient-name">
                                            <i class="fas fa-user me-2"></i>
                                            ${reserva.nombreCompletoPaciente}
                                        </h6>
                                    </div>
                                    <div class="service-info">
                                        <div class="info-row">
                                            <i class="fas fa-tooth me-2"></i>
                                            <span>${reserva.nombreServicio}</span>
                                        </div>
                                        <div class="info-row">
                                            <i class="fas fa-user-md me-2"></i>
                                            <span>${reserva.nombreCompletoOdontologo}</span>
                                        </div>
                                    </div>
                                    <div class="process-indicator">
                                        <div class="alert alert-info mb-0">
                                            <i class="fas fa-info-circle me-1"></i>
                                            Paciente en consulta
                                        </div>
                                    </div>
                                </div>
                                <div class="cita-footer">
                                    <button class="btn btn-primary btn-action" onclick="mostrarModalSalida(${reserva.idReserva}, '${reserva.nombreCompletoPaciente}')">
                                        <i class="fas fa-sign-out-alt me-2"></i>
                                        Registrar Salida
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Citas Completadas -->
        <c:if test="${not empty reservasCompletadas}">
            <div class="section-today mb-4">
                <div class="section-header-today">
                    <h4 class="section-title-today">
                        <i class="fas fa-check-circle text-success me-2"></i>
                        Citas Completadas Hoy
                        <span class="badge bg-success ms-2">${reservasCompletadas.size()}</span>
                    </h4>
                </div>
                <div class="row">
                    <c:forEach var="reserva" items="${reservasCompletadas}">
                        <div class="col-lg-6 col-xl-4 mb-3">
                            <div class="cita-card cita-card-success">
                                <div class="cita-header">
                                    <div class="cita-time">
                                        <i class="fas fa-clock me-2"></i>
                                        <fmt:formatDate value="${reserva.horaReserva}" pattern="HH:mm"/>
                                    </div>
                                    <div class="cita-status">
                                        <span class="status-badge status-success">Completada</span>
                                    </div>
                                </div>
                                <div class="cita-body">
                                    <div class="patient-info">
                                        <h6 class="patient-name">
                                            <i class="fas fa-user me-2"></i>
                                            ${reserva.nombreCompletoPaciente}
                                        </h6>
                                    </div>
                                    <div class="service-info">
                                        <div class="info-row">
                                            <i class="fas fa-tooth me-2"></i>
                                            <span>${reserva.nombreServicio}</span>
                                        </div>
                                        <div class="info-row">
                                            <i class="fas fa-user-md me-2"></i>
                                            <span>${reserva.nombreCompletoOdontologo}</span>
                                        </div>
                                    </div>
                                    <div class="completion-indicator">
                                        <div class="alert alert-success mb-0">
                                            <i class="fas fa-check-circle me-1"></i>
                                            Cita completada exitosamente
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Estado vacío -->
        <c:if test="${empty reservasConfirmadas && empty reservasEnProceso && empty reservasCompletadas}">
            <div class="empty-state">
                <i class="fas fa-calendar-times"></i>
                <h4>No hay citas programadas para hoy</h4>
                <p class="text-muted">
                    No se encontraron citas confirmadas para la fecha actual.
                </p>
                <a href="secretaria" class="btn btn-primary">
                    <i class="fas fa-arrow-left me-1"></i>
                    Volver al Dashboard
                </a>
            </div>
        </c:if>
    </main>

    <!-- Modal para Registrar Salida -->
    <div class="modal fade" id="modalSalida" tabindex="-1" aria-labelledby="modalSalidaLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalSalidaLabel">
                        <i class="fas fa-sign-out-alt me-2"></i>
                        Registrar Salida del Paciente
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="formSalida" method="POST" action="secretaria">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="checkout-paciente">
                        <input type="hidden" name="idReserva" id="idReservaSalida">
                        
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>Paciente:</strong> <span id="nombrePacienteSalida"></span>
                        </div>

                        <div class="mb-3">
                            <label for="diagnostico" class="form-label">
                                <i class="fas fa-stethoscope me-1"></i>
                                Diagnóstico <span class="text-danger">*</span>
                            </label>
                            <textarea class="form-control" id="diagnostico" name="diagnostico" rows="3" 
                                      placeholder="Ingrese el diagnóstico del paciente..." required></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="tratamiento" class="form-label">
                                <i class="fas fa-pills me-1"></i>
                                Tratamiento Realizado <span class="text-danger">*</span>
                            </label>
                            <textarea class="form-control" id="tratamiento" name="tratamiento" rows="3" 
                                      placeholder="Describa el tratamiento realizado..." required></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="observaciones" class="form-label">
                                <i class="fas fa-comment me-1"></i>
                                Observaciones Adicionales
                            </label>
                            <textarea class="form-control" id="observaciones" name="observaciones" rows="2" 
                                      placeholder="Observaciones adicionales (opcional)..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Cancelar
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save me-1"></i>
                            Registrar Salida
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal de Confirmación para Entrada -->
    <div class="modal fade" id="modalConfirmacionEntrada" tabindex="-1" aria-labelledby="modalConfirmacionEntradaLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalConfirmacionEntradaLabel">
                        <i class="fas fa-sign-in-alt me-2"></i>
                        Confirmar Entrada
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p id="mensajeConfirmacionEntrada" class="mb-0"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>
                        Cancelar
                    </button>
                    <button type="button" class="btn btn-success" id="btnConfirmarEntrada">
                        <i class="fas fa-check me-1"></i>
                        Confirmar Entrada
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        /* Tarjetas de estadísticas */
        .stat-card-today {
            border-radius: 12px;
            border: none;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .stat-card-today:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .stat-card-warning { background: linear-gradient(135deg, #fbbf24, #f59e0b); }
        .stat-card-info { background: linear-gradient(135deg, #3b82f6, #2563eb); }
        .stat-card-success { background: linear-gradient(135deg, #10b981, #059669); }
        .stat-card-primary { background: linear-gradient(135deg, #8b5cf6, #7c3aed); }

        .stat-card-today .card-body {
            color: white;
            padding: 1.5rem;
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            opacity: 0.9;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
            font-weight: 500;
        }

        /* Secciones */
        .section-today {
            margin-bottom: 2rem;
        }

        .section-header-today {
            margin-bottom: 1rem;
        }

        .section-title-today {
            color: #1e293b;
            font-weight: 600;
            font-size: 1.25rem;
        }

        /* Tarjetas de citas */
        .cita-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
            overflow: hidden;
            height: 100%;
        }

        .cita-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .cita-card-warning { border-left: 4px solid #f59e0b; }
        .cita-card-info { border-left: 4px solid #3b82f6; }
        .cita-card-success { border-left: 4px solid #10b981; }

        .cita-header {
            padding: 1rem;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: between;
            align-items: center;
        }

        .cita-time {
            font-weight: 600;
            color: #1e293b;
            font-size: 1.1rem;
        }

        .cita-status {
            margin-left: auto;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .status-warning {
            background: #fef3c7;
            color: #92400e;
        }

        .status-info {
            background: #dbeafe;
            color: #1e40af;
        }

        .status-success {
            background: #d1fae5;
            color: #065f46;
        }

        .cita-body {
            padding: 1rem;
            flex-grow: 1;
        }

        .patient-info {
            margin-bottom: 1rem;
        }

        .patient-name {
            color: #1e293b;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .service-info {
            margin-bottom: 1rem;
        }

        .info-row {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            color: #64748b;
            font-size: 0.9rem;
        }

        .description-info {
            margin-top: 0.75rem;
            padding: 0.5rem;
            background: #f8fafc;
            border-radius: 6px;
        }

        .process-indicator,
        .completion-indicator {
            margin-top: 0.75rem;
        }

        .cita-footer {
            padding: 1rem;
            background: #f8fafc;
            border-top: 1px solid #e2e8f0;
        }

        .btn-action {
            width: 100%;
            font-weight: 500;
            border-radius: 8px;
            padding: 0.75rem;
        }

        /* Estado vacío */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            border: 1px solid #e2e8f0;
        }

        .empty-state i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 1.5rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .stat-number {
                font-size: 2rem;
            }
            
            .cita-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            
            .cita-status {
                margin-left: 0;
            }
        }
    </style>
    
    <script>
        let idReservaEntrada = null;

        function registrarEntrada(idReserva) {
            idReservaEntrada = idReserva;
            document.getElementById('mensajeConfirmacionEntrada').innerHTML = 
                '<strong>¿Confirmar la entrada del paciente?</strong><br>' +
                '<small class="text-muted">Se registrará el inicio de la consulta.</small>';
            
            const modal = new bootstrap.Modal(document.getElementById('modalConfirmacionEntrada'));
            modal.show();
        }

        function mostrarModalSalida(idReserva, nombrePaciente) {
            document.getElementById('idReservaSalida').value = idReserva;
            document.getElementById('nombrePacienteSalida').textContent = nombrePaciente;
            
            // Limpiar formulario
            document.getElementById('diagnostico').value = '';
            document.getElementById('tratamiento').value = '';
            document.getElementById('observaciones').value = '';
            
            const modal = new bootstrap.Modal(document.getElementById('modalSalida'));
            modal.show();
        }

        document.getElementById('btnConfirmarEntrada').addEventListener('click', function () {
            if (idReservaEntrada) {
                // Realizar la petición POST para registrar entrada
                fetch('secretaria', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=checkin-paciente&idReserva=' + encodeURIComponent(idReservaEntrada)
                })
                .then(response => {
                    if (response.ok) {
                        showToast('Entrada registrada exitosamente', 'success');
                        setTimeout(() => {
                            location.reload();
                        }, 1500);
                    } else {
                        showToast('Error al registrar la entrada', 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast('Error al registrar la entrada', 'error');
                });

                // Cerrar el modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('modalConfirmacionEntrada'));
                if (modal) {
                    modal.hide();
                }
            }
        });

        // Validación del formulario de salida
        document.getElementById('formSalida').addEventListener('submit', function(e) {
            const diagnostico = document.getElementById('diagnostico').value.trim();
            const tratamiento = document.getElementById('tratamiento').value.trim();
            
            if (!diagnostico || !tratamiento) {
                e.preventDefault();
                showToast('Por favor complete todos los campos obligatorios', 'error');
                return false;
            }
            
            showToast('Registrando salida...', 'info');
        });

        function showToast(mensaje, tipo) {
            // Crear toast dinámicamente
            const toastContainer = document.createElement('div');
            toastContainer.style.position = 'fixed';
            toastContainer.style.top = '20px';
            toastContainer.style.right = '20px';
            toastContainer.style.zIndex = '9999';
            
            let colorClass, iconClass;
            switch(tipo) {
                case 'success':
                    colorClass = 'bg-success';
                    iconClass = 'fas fa-check-circle';
                    break;
                case 'error':
                    colorClass = 'bg-danger';
                    iconClass = 'fas fa-exclamation-circle';
                    break;
                case 'info':
                    colorClass = 'bg-info';
                    iconClass = 'fas fa-info-circle';
                    break;
                default:
                    colorClass = 'bg-primary';
                    iconClass = 'fas fa-info-circle';
            }
            
            toastContainer.innerHTML = `
                <div class="toast show ${colorClass} text-white" role="alert">
                    <div class="toast-body d-flex align-items-center">
                        <i class="${iconClass} me-2"></i>
                        ${mensaje}
                    </div>
                </div>
            `;
            
            document.body.appendChild(toastContainer);
            
            // Remover después de 3 segundos
            setTimeout(() => {
                toastContainer.remove();
            }, 3000);
        }

        // Auto-refresh cada 2 minutos para mantener actualizada la información
        setTimeout(function () {
            location.reload();
        }, 120000);
    </script>
</body>
</html>
