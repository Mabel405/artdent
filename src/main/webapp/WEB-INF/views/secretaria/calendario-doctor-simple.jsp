<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">

<jsp:include page="layout/header.jsp">
    <jsp:param name="pageTitle" value="Calendario por Doctor" />
</jsp:include>

<body>
    <jsp:include page="layout/sidebar.jsp">
        <jsp:param name="page" value="calendario" />
    </jsp:include>

    <!-- Main content -->
    <main class="main-content">
        <!-- Header -->
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="page-title">
                    <i class="fas fa-user-md"></i>
                    Calendario por Doctor
                </h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="secretaria">Dashboard</a></li>
                        <li class="breadcrumb-item active">Calendario Doctor</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container-fluid px-4">
            <!-- Selector de Doctor -->
            <div class="card doctor-selector-card mb-4">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h4 class="mb-3">
                                <i class="fas fa-stethoscope me-2"></i>
                                Seleccionar Doctor y Fecha
                            </h4>
                            <form method="get" action="${pageContext.request.contextPath}/secretaria" class="row g-3">
                                <input type="hidden" name="action" value="calendario-doctor">
                                
                                <div class="col-md-5">
                                    <label class="form-label">Doctor:</label>
                                    <select name="doctorId" class="form-select" required>
                                        <option value="">Seleccione un doctor...</option>
                                        <c:forEach var="doctor" items="${odontologos}">
                                            <option value="${doctor.idUsuario}" 
                                                    ${doctor.idUsuario == doctorId ? 'selected' : ''}>
                                                Dr. ${doctor.nombre} ${doctor.apellido}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Fecha:</label>
                                    <input type="date" name="fecha" class="form-control" 
                                           value="<fmt:formatDate value='${fechaSeleccionada}' pattern='yyyy-MM-dd' />" required>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">&nbsp;</label>
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="fas fa-search me-1"></i>
                                        Ver Calendario
                                    </button>
                                </div>
                            </form>
                        </div>
                        <div class="col-md-4">
                            <c:if test="${doctorSeleccionado != null}">
                                <div class="doctor-info-card">
                                    <h5 class="mb-2">
                                        <i class="fas fa-user-md me-2"></i>
                                        Dr. ${doctorSeleccionado.nombre} ${doctorSeleccionado.apellido}
                                    </h5>
                                    <p class="mb-1">
                                        <i class="fas fa-envelope me-2"></i>
                                        ${doctorSeleccionado.correoElectronico}
                                    </p>
                                    <p class="mb-0">
                                        <i class="fas fa-phone me-2"></i>
                                        ${doctorSeleccionado.telefono}
                                    </p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${doctorId > 0}">
                <!-- Calendario del Día -->
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <h5 class="mb-0">
                                    <i class="fas fa-calendar-day me-2"></i>
                                    Agenda del <fmt:formatDate value="${fechaSeleccionada}" pattern="EEEE, dd 'de' MMMM 'de' yyyy" />
                                </h5>
                            </div>
                            <div class="col-md-6 text-end">
                                <span class="badge bg-light text-dark">
                                    ${reservasDoctor.size()} citas programadas
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- Horarios de la mañana -->
                            <div class="col-md-6">
                                <h6 class="text-muted mb-3">
                                    <i class="fas fa-sun me-2"></i>
                                    Horarios de Mañana
                                </h6>
                                
                                <!-- Generar slots de 8:00 a 12:00 -->
                                <c:forEach var="hora" begin="8" end="11">
                                    <c:set var="tieneReserva" value="false" />
                                    <c:set var="reservaActual" value="" />
                                    
                                    <!-- Buscar si hay reserva en esta hora -->
                                    <c:forEach var="reserva" items="${reservasDoctor}">
                                        <fmt:formatDate value="${reserva.horaReserva}" pattern="HH" var="horaReserva" />
                                        <c:if test="${horaReserva == hora}">
                                            <c:set var="tieneReserva" value="true" />
                                            <c:set var="reservaActual" value="${reserva}" />
                                        </c:if>
                                    </c:forEach>
                                    
                                    <div class="time-slot ${tieneReserva ? (reservaActual.tipoEstado == 2 ? 'occupied' : reservaActual.tipoEstado == 1 ? 'pending' : 'cancelled') : ''}">
                                        <div class="time-label">
                                            <fmt:formatNumber value="${hora}" pattern="00"/>:00 - <fmt:formatNumber value="${hora + 1}" pattern="00"/>:00
                                        </div>
                                        
                                        <c:choose>
                                            <c:when test="${tieneReserva}">
                                                <div class="appointment-info">
                                                    <div class="fw-bold mb-1">
                                                        <i class="fas fa-user me-2"></i>
                                                        ${reservaActual.nombreCompletoPaciente}
                                                    </div>
                                                    <div class="small mb-2">
                                                        <i class="fas fa-tooth me-2"></i>
                                                        ${reservaActual.nombreServicio}
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="badge ${reservaActual.tipoEstado == 2 ? 'bg-success' : reservaActual.tipoEstado == 1 ? 'bg-warning' : 'bg-danger'}">
                                                            ${reservaActual.estadoTexto}
                                                        </span>
                                                        <div>
                                                            <button class="btn btn-sm btn-outline-primary" 
                                                                    onclick="verDetalle(${reservaActual.idReserva})"
                                                                    title="Ver detalles">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                            <c:if test="${reservaActual.tipoEstado == 1}">
                                                                <button class="btn btn-sm btn-outline-success ms-1" 
                                                                        onclick="confirmarReserva(${reservaActual.idReserva})"
                                                                        title="Confirmar">
                                                                    <i class="fas fa-check"></i>
                                                                </button>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="no-appointments">
                                                    <i class="fas fa-calendar-plus me-2"></i>
                                                    Horario disponible
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Horarios de la tarde -->
                            <div class="col-md-6">
                                <h6 class="text-muted mb-3">
                                    <i class="fas fa-moon me-2"></i>
                                    Horarios de Tarde
                                </h6>
                                
                                <!-- Generar slots de 14:00 a 18:00 -->
                                <c:forEach var="hora" begin="14" end="17">
                                    <c:set var="tieneReserva" value="false" />
                                    <c:set var="reservaActual" value="" />
                                    
                                    <!-- Buscar si hay reserva en esta hora -->
                                    <c:forEach var="reserva" items="${reservasDoctor}">
                                        <fmt:formatDate value="${reserva.horaReserva}" pattern="HH" var="horaReserva" />
                                        <c:if test="${horaReserva == hora}">
                                            <c:set var="tieneReserva" value="true" />
                                            <c:set var="reservaActual" value="${reserva}" />
                                        </c:if>
                                    </c:forEach>
                                    
                                    <div class="time-slot ${tieneReserva ? (reservaActual.tipoEstado == 2 ? 'occupied' : reservaActual.tipoEstado == 1 ? 'pending' : 'cancelled') : ''}">
                                        <div class="time-label">
                                            <fmt:formatNumber value="${hora}" pattern="00"/>:00 - <fmt:formatNumber value="${hora + 1}" pattern="00"/>:00
                                        </div>
                                        
                                        <c:choose>
                                            <c:when test="${tieneReserva}">
                                                <div class="appointment-info">
                                                    <div class="fw-bold mb-1">
                                                        <i class="fas fa-user me-2"></i>
                                                        ${reservaActual.nombreCompletoPaciente}
                                                    </div>
                                                    <div class="small mb-2">
                                                        <i class="fas fa-tooth me-2"></i>
                                                        ${reservaActual.nombreServicio}
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="badge ${reservaActual.tipoEstado == 2 ? 'bg-success' : reservaActual.tipoEstado == 1 ? 'bg-warning' : 'bg-danger'}">
                                                            ${reservaActual.estadoTexto}
                                                        </span>
                                                        <div>
                                                            <button class="btn btn-sm btn-outline-primary" 
                                                                    onclick="verDetalle(${reservaActual.idReserva})"
                                                                    title="Ver detalles">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                            <c:if test="${reservaActual.tipoEstado == 1}">
                                                                <button class="btn btn-sm btn-outline-success ms-1" 
                                                                        onclick="confirmarReserva(${reservaActual.idReserva})"
                                                                        title="Confirmar">
                                                                    <i class="fas fa-check"></i>
                                                                </button>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="no-appointments">
                                                    <i class="fas fa-calendar-plus me-2"></i>
                                                    Horario disponible
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Navegación de fechas -->
                <div class="row mt-3">
                    <div class="col-12 text-center">
                        <div class="btn-group" role="group">
                            <a href="?action=calendario-doctor&doctorId=${doctorId}&fecha=<fmt:formatDate value='${fechaAnterior}' pattern='yyyy-MM-dd' />" 
                               class="btn btn-outline-primary">
                                <i class="fas fa-chevron-left me-1"></i>
                                Día Anterior
                            </a>
                            <a href="?action=calendario-doctor&doctorId=${doctorId}&fecha=<fmt:formatDate value='${fechaHoy}' pattern='yyyy-MM-dd' />" 
                               class="btn btn-primary">
                                <i class="fas fa-calendar-day me-1"></i>
                                Hoy
                            </a>
                            <a href="?action=calendario-doctor&doctorId=${doctorId}&fecha=<fmt:formatDate value='${fechaSiguiente}' pattern='yyyy-MM-dd' />" 
                               class="btn btn-outline-primary">
                                Día Siguiente
                                <i class="fas fa-chevron-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${doctorId == 0 || empty odontologos}">
                <!-- Mensaje cuando no hay doctor seleccionado o no hay doctores -->
                <div class="empty-state">
                    <i class="fas fa-user-md"></i>
                    <c:choose>
                        <c:when test="${empty odontologos}">
                            <h3>No hay doctores registrados</h3>
                            <p>No se encontraron odontólogos en el sistema. Verifique que existan usuarios con rol de odontólogo.</p>
                            <div class="alert alert-info">
                                <strong>Nota:</strong> Asegúrese de que en la base de datos existan usuarios con Rol_idRol = 3 (Odontólogo)
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h3>Seleccione un Doctor</h3>
                            <p>Elija un doctor y una fecha para ver su calendario de citas.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function verDetalle(idReserva) {
            window.location.href = '${pageContext.request.contextPath}/secretaria?action=detalle&idReserva=' + idReserva;
        }

        function confirmarReserva(idReserva) {
            if (confirm('¿Está seguro de que desea confirmar esta reserva?')) {
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

        // Debug: Mostrar información en consola
        console.log('Doctores disponibles: ${odontologos.size()}');
        console.log('Doctor seleccionado ID: ${doctorId}');
        console.log('Reservas del doctor: ${reservasDoctor.size()}');
    </script>

    <style>
        .doctor-selector-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
        }
        
        .doctor-selector-card .form-label {
            color: white;
            font-weight: 500;
        }
        
        .doctor-info-card {
            background: rgba(255,255,255,0.1);
            border-radius: 10px;
            padding: 15px;
            backdrop-filter: blur(10px);
        }
        
        .time-slot {
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 10px;
            min-height: 80px;
            background: #f8f9fa;
            transition: all 0.3s ease;
        }
        
        .time-slot:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .time-slot.occupied {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border-color: #28a745;
        }
        
        .time-slot.pending {
            background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
            color: white;
            border-color: #ffc107;
        }
        
        .time-slot.cancelled {
            background: linear-gradient(135deg, #dc3545 0%, #e83e8c 100%);
            color: white;
            border-color: #dc3545;
        }
        
        .appointment-info {
            background: rgba(255,255,255,0.9);
            border-radius: 8px;
            padding: 10px;
            margin-top: 8px;
            color: #333;
        }
        
        .time-label {
            font-weight: bold;
            font-size: 1.1rem;
            margin-bottom: 8px;
        }
        
        .no-appointments {
            text-align: center;
            color: #6c757d;
            font-style: italic;
            padding: 20px;
        }
    </style>
</body>
</html>
