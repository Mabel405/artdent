<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - ArtDent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2563eb;
            --primary-dark: #1d4ed8;
            --secondary-color: #64748b;
            --success-color: #059669;
            --warning-color: #d97706;
            --danger-color: #dc2626;
            --light-bg: #f8fafc;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --border-radius: 12px;
        }

        * {
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--light-bg);
            color: #1e293b;
        }

        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            position: fixed;
            top: 0;
            left: 0;
            width: 280px;
            z-index: 1000;
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
        }

        .sidebar .nav-link {
            color: rgba(255,255,255,0.85);
            padding: 16px 24px;
            border-radius: var(--border-radius);
            margin: 6px 16px;
            transition: all 0.3s ease;
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .sidebar .nav-link:hover {
            background: rgba(255,255,255,0.15);
            color: white;
            transform: translateX(8px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .sidebar .nav-link.active {
            background: rgba(255,255,255,0.2);
            color: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .sidebar .nav-link i {
            width: 20px;
            margin-right: 12px;
        }

        .main-content {
            margin-left: 280px;
            background-color: var(--light-bg);
            min-height: 100vh;
            padding: 24px;
        }

        .stats-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 24px;
            box-shadow: var(--card-shadow);
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
            height: 100%;
        }

        .stats-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .stats-label {
            color: var(--secondary-color);
            font-weight: 500;
            font-size: 0.95rem;
        }

        .stats-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }

        .icon-pending { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .icon-confirmed { background: linear-gradient(135deg, #059669, #047857); }
        .icon-completed { background: linear-gradient(135deg, #2563eb, #1d4ed8); }
        .icon-cancelled { background: linear-gradient(135deg, #dc2626, #b91c1c); }

        .section-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            border: 1px solid #e2e8f0;
            overflow: hidden;
        }

        .section-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            padding: 20px 24px;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .section-body {
            padding: 24px;
        }

        .quick-actions {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            border-radius: var(--border-radius);
            padding: 24px;
            margin-bottom: 32px;
        }

        .quick-actions h3 {
            color: white;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .action-btn {
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.2);
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .action-btn:hover {
            background: rgba(255,255,255,0.25);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .citas-table {
            margin: 0;
        }

        .citas-table th {
            background-color: #f8fafc;
            border: none;
            color: var(--secondary-color);
            font-weight: 600;
            padding: 16px;
        }

        .citas-table td {
            border: none;
            padding: 16px;
            vertical-align: middle;
        }

        .citas-table tbody tr {
            border-bottom: 1px solid #e2e8f0;
        }

        .citas-table tbody tr:hover {
            background-color: #f8fafc;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-pendiente {
            background: #fef3c7;
            color: #92400e;
        }

        .status-confirmada {
            background: #d1fae5;
            color: #065f46;
        }

        .status-completada {
            background: #dbeafe;
            color: #1e40af;
        }

        .status-proceso {
            background: #e0f2fe;
            color: #0369a1;
        }

        .welcome-header {
            background: white;
            border-radius: var(--border-radius);
            padding: 24px;
            margin-bottom: 32px;
            box-shadow: var(--card-shadow);
            border: 1px solid #e2e8f0;
        }

        .welcome-header h1 {
            color: var(--primary-color);
            margin-bottom: 8px;
            font-weight: 700;
        }

        .welcome-header p {
            color: var(--secondary-color);
            margin: 0;
        }

        .date-display {
            color: var(--secondary-color);
            font-size: 0.9rem;
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
        <div class="container-fluid">
            <!-- Welcome Header -->
            <div class="welcome-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h1><i class="fas fa-tachometer-alt me-2"></i>Dashboard</h1>
                        <p>Resumen general del sistema de gestión dental</p>
                    </div>
                    <div class="date-display">
                        <i class="fas fa-calendar me-2"></i>
                        <fmt:formatDate value="${fechaHoy}" pattern="EEEE, dd 'de' MMMM 'de' yyyy"/>
                    </div>
                </div>
            </div>

            <!-- Estadísticas Principales -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <div class="stats-number text-warning">
                                    ${reservasPendientes != null ? reservasPendientes : 0}
                                </div>
                                <div class="stats-label">Solicitudes Pendientes</div>
                            </div>
                            <div class="stats-icon icon-pending">
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <div class="stats-number text-success">
                                    ${estadisticasMes['Confirmadas'] != null ? estadisticasMes['Confirmadas'] : 0}
                                </div>
                                <div class="stats-label">Citas Confirmadas</div>
                            </div>
                            <div class="stats-icon icon-confirmed">
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <div class="stats-number text-primary">
                                    ${estadisticasMes['Completadas'] != null ? estadisticasMes['Completadas'] : 0}
                                </div>
                                <div class="stats-label">Citas Completadas</div>
                            </div>
                            <div class="stats-icon icon-completed">
                                <i class="fas fa-user-check"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="stats-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <div class="stats-number text-danger">
                                    ${estadisticasMes['Canceladas'] != null ? estadisticasMes['Canceladas'] : 0}
                                </div>
                                <div class="stats-label">Citas Canceladas</div>
                            </div>
                            <div class="stats-icon icon-cancelled">
                                <i class="fas fa-times-circle"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Acciones Rápidas -->
            <div class="quick-actions">
                <h3><i class="fas fa-bolt me-2"></i>Acciones Rápidas</h3>
                <div class="d-flex flex-wrap gap-3">
                    <a href="secretaria?action=solicitudes" class="action-btn">
                        <i class="fas fa-clipboard-list"></i>
                        Gestionar Solicitudes
                    </a>
                    <a href="secretaria?action=citas-hoy" class="action-btn">
                        <i class="fas fa-calendar-day"></i>
                        Ver Citas de Hoy
                    </a>
                    <a href="secretaria?action=calendario" class="action-btn">
                        <i class="fas fa-calendar-alt"></i>
                        Ver Calendario
                    </a>
                    <a href="secretaria?action=historial" class="action-btn">
                        <i class="fas fa-history"></i>
                        Historial de Citas
                    </a>
                    <a href="secretaria?action=reportes" class="action-btn">
                        <i class="fas fa-chart-bar"></i>
                        Ver Reportes
                    </a>
                </div>
            </div>

            <div class="row">
                <!-- Citas de Hoy -->
                <div class="col-lg-8 mb-4">
                    <div class="section-card">
                        <div class="section-header">
                            <i class="fas fa-calendar-day me-2"></i>
                            Citas de Hoy
                        </div>
                        <div class="section-body">
                            <c:choose>
                                <c:when test="${not empty reservasHoy}">
                                    <div class="table-responsive">
                                        <table class="table citas-table">
                                            <thead>
                                                <tr>
                                                    <th>Hora</th>
                                                    <th>Paciente</th>
                                                    <th>Servicio</th>
                                                    <th>Odontólogo</th>
                                                    <th>Estado</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="reserva" items="${reservasHoy}" begin="0" end="4">
                                                    <tr>
                                                        <td>
                                                            <strong>
                                                                <fmt:formatDate value="${reserva.horaReserva}" pattern="HH:mm"/>
                                                            </strong>
                                                        </td>
                                                        <td>
                                                            <i class="fas fa-user me-2 text-muted"></i>
                                                            ${reserva.nombreCompletoPaciente}
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-light text-dark">
                                                                ${reserva.nombreServicio}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <i class="fas fa-user-md me-2 text-muted"></i>
                                                            ${reserva.nombreCompletoOdontologo}
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${reserva.tipoEstado == 1}">
                                                                    <span class="status-badge status-pendiente">Pendiente</span>
                                                                </c:when>
                                                                <c:when test="${reserva.tipoEstado == 2}">
                                                                    <span class="status-badge status-confirmada">Confirmada</span>
                                                                </c:when>
                                                                <c:when test="${reserva.tipoEstado == 4}">
                                                                    <span class="status-badge status-completada">Completada</span>
                                                                </c:when>
                                                                <c:when test="${reserva.tipoEstado == 5}">
                                                                    <span class="status-badge status-proceso">En Proceso</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="status-badge bg-secondary text-white">${reserva.estadoTexto}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="text-center mt-3">
                                        <a href="secretaria?action=citas-hoy" class="btn btn-outline-primary">
                                            <i class="fas fa-eye me-2"></i>Ver todas las citas de hoy
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-4">
                                        <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">No hay citas programadas para hoy</h5>
                                        <p class="text-muted">Las citas aparecerán aquí cuando sean confirmadas.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Solicitudes Pendientes -->
                <div class="col-lg-4 mb-4">
                    <div class="section-card">
                        <div class="section-header">
                            <i class="fas fa-clipboard-list me-2"></i>
                            Solicitudes Pendientes
                        </div>
                        <div class="section-body">
                            <c:choose>
                                <c:when test="${not empty reservasPendientesList}">
                                    <c:forEach var="solicitud" items="${reservasPendientesList}">
                                        <div class="d-flex align-items-center mb-3 p-3 bg-light rounded">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">${solicitud.nombreCompletoPaciente}</h6>
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar me-1"></i>
                                                    <fmt:formatDate value="${solicitud.diaReserva}" pattern="dd/MM/yyyy"/>
                                                    <i class="fas fa-clock ms-2 me-1"></i>
                                                    <fmt:formatDate value="${solicitud.horaReserva}" pattern="HH:mm"/>
                                                </small>
                                                <br>
                                                <small class="text-muted">
                                                    <i class="fas fa-tooth me-1"></i>
                                                    ${solicitud.nombreServicio}
                                                </small>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <div class="text-center mt-3">
                                        <a href="secretaria?action=solicitudes" class="btn btn-outline-warning">
                                            <i class="fas fa-tasks me-2"></i>Gestionar todas las solicitudes
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-4">
                                        <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
                                        <h6 class="text-muted">¡Excelente!</h6>
                                        <p class="text-muted small">No hay solicitudes pendientes por revisar.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>