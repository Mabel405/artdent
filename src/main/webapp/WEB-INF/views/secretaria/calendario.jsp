<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendario General - ArtDent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .calendar-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .doctor-filter {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .appointment-card {
            border-left: 4px solid #28a745;
            transition: all 0.3s ease;
            margin-bottom: 10px;
        }
        .appointment-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .appointment-card.pending {
            border-left-color: #ffc107;
        }
        .appointment-card.cancelled {
            border-left-color: #dc3545;
        }
        .appointment-card.completed {
            border-left-color: #6f42c1;
        }
        .quick-actions {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
        }
        .fab {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
        }
        .fab:hover {
            transform: scale(1.1);
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <jsp:include page="layout/sidebar.jsp">
        <jsp:param name="page" value="calendario" />
    </jsp:include>

    <!-- Main content -->
    <main class="main-content">
        <!-- Header -->
        <jsp:include page="layout/header.jsp">
            <jsp:param name="title" value="Calendario General" />
            <jsp:param name="icon" value="fas fa-calendar-alt" />
            <jsp:param name="breadcrumb" value="Calendario" />
        </jsp:include>

        <div class="container-fluid px-4">
            <!-- Header del Calendario -->
            <div class="calendar-header">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="mb-2">
                            <i class="fas fa-calendar-day me-2"></i>
                            <fmt:formatDate value="${fechaSeleccionada}" pattern="EEEE, dd 'de' MMMM 'de' yyyy" />
                        </h3>
                        <p class="mb-0">Gestión de citas y horarios</p>
                    </div>
                    <div class="col-md-6 text-end">
                        <form method="get" action="${pageContext.request.contextPath}/secretaria" class="d-inline-flex gap-2">
                            <input type="hidden" name="action" value="calendario">
                            <input type="date" name="fecha" class="form-control" 
                                   value="<fmt:formatDate value='${fechaSeleccionada}' pattern='yyyy-MM-dd' />">
                            <button type="submit" class="btn btn-light">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Filtros y Acciones Rápidas -->
            <div class="doctor-filter">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h5 class="mb-3">
                            <i class="fas fa-filter me-2"></i>
                            Filtros y Vista Rápida
                        </h5>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <a href="${pageContext.request.contextPath}/secretaria?action=calendario-doctor" 
                                   class="btn btn-outline-primary w-100">
                                    <i class="fas fa-user-md me-2"></i>
                                    Ver por Doctor
                                </a>
                            </div>
                            <div class="col-md-4">
                                <select class="form-select" onchange="filtrarPorDoctor(this.value)">
                                    <option value="">Todos los doctores</option>
                                    <c:forEach var="doctor" items="${odontologos}">
                                        <option value="${doctor.idUsuario}">
                                            Dr. ${doctor.nombre} ${doctor.apellido}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <select class="form-select" onchange="filtrarPorEstado(this.value)">
                                    <option value="">Todos los estados</option>
                                    <option value="1">Pendientes</option>
                                    <option value="2">Confirmadas</option>
                                    <option value="4">Completadas</option>
                                    <option value="3">Canceladas</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 text-end">
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-success" onclick="nuevaCita()">
                                <i class="fas fa-plus me-1"></i>
                                Nueva Cita
                            </button>
                            <button type="button" class="btn btn-info" onclick="exportarCalendario()">
                                <i class="fas fa-download me-1"></i>
                                Exportar
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Lista de Citas del Día -->
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-list me-2"></i>
                                Citas del Día
                                <span class="badge bg-primary ms-2">${reservasFecha.size()}</span>
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty reservasFecha}">
                                    <div class="text-center py-5">
                                        <i class="fas fa-calendar-times fa-4x text-muted mb-3"></i>
                                        <h4 class="text-muted">No hay citas programadas</h4>
                                        <p class="text-muted">No se encontraron citas para la fecha seleccionada.</p>
                                        <button class="btn btn-primary" onclick="nuevaCita()">
                                            <i class="fas fa-plus me-1"></i>
                                            Programar Nueva Cita
                                        </button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="row" id="citasContainer">
                                        <c:forEach var="reserva" items="${reservasFecha}">
                                            <div class="col-md-6 col-lg-4 mb-3 cita-item" 
                                                 data-doctor="${reserva.odontologoIdUsuario}" 
                                                 data-estado="${reserva.tipoEstado}">
                                                <div class="card appointment-card ${reserva.tipoEstado == 1 ? 'pending' : reserva.tipoEstado == 3 ? 'cancelled' : reserva.tipoEstado == 4 ? 'completed' : ''}">
                                                    <div class="card-body">
                                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                                            <h6 class="card-title mb-0">
                                                                <fmt:formatDate value="${reserva.horaReserva}" pattern="HH:mm" />
                                                            </h6>
                                                            <span class="badge ${reserva.tipoEstado == 2 ? 'bg-success' : reserva.tipoEstado == 1 ? 'bg-warning' : reserva.tipoEstado == 3 ? 'bg-danger' : 'bg-purple'}">
                                                                ${reserva.estadoTexto}
                                                            </span>
                                                        </div>
                                                        
                                                        <div class="mb-2">
                                                            <strong>${reserva.nombreCompletoPaciente}</strong>
                                                        </div>
                                                        
                                                        <div class="small text-muted mb-2">
                                                            <i class="fas fa-tooth me-1"></i>
                                                            ${reserva.nombreServicio}
                                                        </div>
                                                        
                                                        <div class="small text-muted mb-3">
                                                            <i class="fas fa-user-md me-1"></i>
                                                            ${reserva.nombreCompletoOdontologo}
                                                        </div>
                                                        
                                                        <div class="d-flex gap-1">
                                                            <button class="btn btn-sm btn-outline-primary" 
                                                                    onclick="verDetalle(${reserva.idReserva})"
                                                                    title="Ver detalles">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                            
                                                            <c:if test="${reserva.tipoEstado == 1}">
                                                                <button class="btn btn-sm btn-outline-success" 
                                                                        onclick="confirmarCita(${reserva.idReserva})"
                                                                        title="Confirmar">
                                                                    <i class="fas fa-check"></i>
                                                                </button>
                                                            </c:if>
                                                            
                                                            <c:if test="${reserva.tipoEstado == 2}">
                                                                <button class="btn btn-sm btn-outline-info" 
                                                                        onclick="reprogramar(${reserva.idReserva})"
                                                                        title="Reprogramar">
                                                                    <i class="fas fa-calendar-alt"></i>
                                                                </button>
                                                            </c:if>
                                                            
                                                            <button class="btn btn-sm btn-outline-secondary" 
                                                                    onclick="verHistorialPaciente(${reserva.pacienteIdPaciente})"
                                                                    title="Historial del paciente">
                                                                <i class="fas fa-history"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Botones de Acción Flotantes -->
    <div class="quick-actions">
        <button class="fab btn btn-primary" onclick="nuevaCita()" title="Nueva Cita">
            <i class="fas fa-plus"></i>
        </button>
        <button class="fab btn btn-success" onclick="verCitasHoy()" title="Citas de Hoy">
            <i class="fas fa-calendar-day"></i>
        </button>
        <button class="fab btn btn-info" onclick="buscarPaciente()" title="Buscar Paciente">
            <i class="fas fa-search"></i>
        </button>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filtrarPorDoctor(doctorId) {
            const citas = document.querySelectorAll('.cita-item');
            citas.forEach(cita => {
                if (doctorId === '' || cita.dataset.doctor === doctorId) {
                    cita.style.display = 'block';
                } else {
                    cita.style.display = 'none';
                }
            });
        }

        function filtrarPorEstado(estado) {
            const citas = document.querySelectorAll('.cita-item');
            citas.forEach(cita => {
                if (estado === '' || cita.dataset.estado === estado) {
                    cita.style.display = 'block';
                } else {
                    cita.style.display = 'none';
                }
            });
        }

        function verDetalle(idReserva) {
            window.location.href = '${pageContext.request.contextPath}/secretaria?action=detalle&idReserva=' + idReserva;
        }

        function confirmarCita(idReserva) {
            if (confirm('¿Confirmar esta cita?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/secretaria';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'confirmar-reserva';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'idReserva';
                idInput.value = idReserva;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function reprogramar(idReserva) {
            window.location.href = '${pageContext.request.contextPath}/secretaria?action=reprogramar&idReserva=' + idReserva;
        }

        function verHistorialPaciente(pacienteId) {
            window.location.href = '${pageContext.request.contextPath}/secretaria?action=historial&pacienteId=' + pacienteId;
        }

        function nuevaCita() {
            // Redirigir al formulario de nueva cita
            window.location.href = '${pageContext.request.contextPath}/reservas?action=nueva';
        }

        function verCitasHoy() {
            window.location.href = '${pageContext.request.contextPath}/secretaria?action=citas-hoy';
        }

        function buscarPaciente() {
            const nombre = prompt('Ingrese el nombre del paciente:');
            if (nombre) {
                window.location.href = '${pageContext.request.contextPath}/secretaria?action=buscar-paciente&nombre=' + encodeURIComponent(nombre);
            }
        }

        function exportarCalendario() {
            const fecha = '<fmt:formatDate value="${fechaSeleccionada}" pattern="yyyy-MM-dd" />';
            window.open('${pageContext.request.contextPath}/secretaria/exportar-calendario?fecha=' + fecha, '_blank');
        }
    </script>
</body>
</html>
