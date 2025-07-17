<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">

<jsp:include page="layout/header.jsp">
    <jsp:param name="pageTitle" value="Historial de Citas Completadas" />
</jsp:include>

<body>
    <jsp:include page="layout/sidebar.jsp">
        <jsp:param name="page" value="historial" />
    </jsp:include>

    <!-- Main content -->
    <main class="main-content">
        <!-- Header -->
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="page-title">
                    <i class="fas fa-history"></i>
                    Historial de Citas Completadas
                </h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="secretaria">Dashboard</a></li>
                        <li class="breadcrumb-item active">Historial</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container-fluid px-4">
            <!-- Resumen de estadísticas -->
            <div class="stats-summary-modern">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <div class="stats-content">
                                <h4 class="stats-title">
                                    <i class="fas fa-check-circle me-2"></i>
                                    Historial de Citas Completadas
                                </h4>
                                <p class="stats-subtitle">Registro completo de todas las citas finalizadas con éxito</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stats-numbers">
                                <div class="row text-center">
                                    <div class="col-6">
                                        <div class="stat-item">
                                            <div class="stat-value">${totalCitas}</div>
                                            <div class="stat-label">Total Citas</div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="stat-item">
                                            <div class="stat-value">${tiempoPromedio} min</div>
                                            <div class="stat-label">Tiempo Promedio</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filtros de Búsqueda -->
            <div class="filter-card-historial mb-4">
                <div class="card-body">
                    <h5 class="filter-title-historial">
                        <i class="fas fa-filter me-2"></i>
                        Filtros de Búsqueda
                    </h5>
                    <form method="get" action="${pageContext.request.contextPath}/secretaria">
                        <input type="hidden" name="action" value="historial">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Fecha desde:</label>
                                <input type="date" class="form-control" name="fechaDesde" value="${fechaDesde}">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Fecha hasta:</label>
                                <input type="date" class="form-control" name="fechaHasta" value="${fechaHasta}">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Paciente:</label>
                                <input type="text" class="form-control" name="paciente" 
                                       placeholder="Nombre del paciente" value="${pacienteBuscar}">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Odontólogo:</label>
                                <select class="form-select" name="doctorId">
                                    <option value="">Todos los doctores</option>
                                    <c:forEach var="doctor" items="${odontologos}">
                                        <option value="${doctor.idUsuario}" ${doctor.idUsuario == doctorIdFiltro ? 'selected' : ''}>
                                            Dr. ${doctor.nombre} ${doctor.apellido}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row g-3 mt-2">
                            <div class="col-md-6">
                                <label class="form-label">Servicio:</label>
                                <select class="form-select" name="servicioId">
                                    <option value="">Todos los servicios</option>
                                    <c:forEach var="servicio" items="${servicios}">
                                        <option value="${servicio.idServicio}" ${servicio.idServicio == servicioIdFiltro ? 'selected' : ''}>
                                            ${servicio.tipoServicio}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Duración:</label>
                                <select class="form-select" name="duracion">
                                    <option value="">Cualquier duración</option>
                                    <option value="corta" ${duracionFiltro == 'corta' ? 'selected' : ''}>Corta (≤ 30 min)</option>
                                    <option value="normal" ${duracionFiltro == 'normal' ? 'selected' : ''}>Normal (31-60 min)</option>
                                    <option value="larga" ${duracionFiltro == 'larga' ? 'selected' : ''}>Larga (> 60 min)</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="filter-actions">
                                        <button type="submit" class="btn btn-primary me-2">
                                            <i class="fas fa-search me-1"></i>
                                            Buscar
                                        </button>
                                        <a href="${pageContext.request.contextPath}/secretaria?action=historial" class="btn btn-outline-secondary">
                                            <i class="fas fa-times me-1"></i>
                                            Limpiar filtros
                                        </a>
                                    </div>
                                    <div class="export-actions">
                                        <button type="button" class="btn btn-success me-2" onclick="exportarHistorial('excel')">
                                            <i class="fas fa-file-excel me-1"></i>
                                            Excel
                                        </button>
                                        <button type="button" class="btn btn-info" onclick="imprimirHistorial()">
                                            <i class="fas fa-print me-1"></i>
                                            Imprimir
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Lista de Citas Completadas -->
            <div class="historial-table-container">
                <div class="card">
                    <div class="card-header historial-table-header">
                        <h5 class="historial-table-title">
                            <i class="fas fa-list me-2"></i>
                            Citas Completadas
                            <span class="badge bg-white text-success ms-2">${totalCitas} registros</span>
                            <c:if test="${not empty fechaDesde || not empty fechaHasta || not empty pacienteBuscar || doctorIdFiltro > 0 || servicioIdFiltro > 0 || not empty duracionFiltro}">
                                <span class="badge bg-warning text-dark ms-2">Filtrado</span>
                            </c:if>
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${empty citasCompletadas}">
                                <div class="empty-state-historial">
                                    <div class="empty-icon">
                                        <i class="fas fa-history"></i>
                                    </div>
                                    <h4 class="empty-title">No hay citas completadas</h4>
                                    <p class="empty-text">No se encontraron citas que coincidan con los filtros aplicados.</p>
                                    <a href="${pageContext.request.contextPath}/secretaria?action=historial" class="btn btn-primary">
                                        <i class="fas fa-refresh me-1"></i>
                                        Ver todas las citas
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover historial-table">
                                        <thead class="table-header-modern">
                                            <tr>
                                                <th>ID Cita</th>
                                                <th>Fecha</th>
                                                <th>Entrada</th>
                                                <th>Salida</th>
                                                <th>Paciente</th>
                                                <th>Servicio</th>
                                                <th>Odontólogo</th>
                                                <th>Duración</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="cita" items="${citasCompletadas}">
                                                <tr class="historial-row">
                                                    <td>
                                                        <span class="id-badge">#${cita.idCita}</span>
                                                    </td>
                                                    <td>
                                                        <div class="date-cell">
                                                            <fmt:formatDate value="${cita.diaReserva}" pattern="dd/MM/yyyy" />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="time-cell">
                                                            <c:if test="${cita.fechaHoraEntrada != null}">
                                                                <fmt:formatDate value="${cita.fechaHoraEntrada}" pattern="HH:mm" />
                                                            </c:if>
                                                            <c:if test="${cita.fechaHoraEntrada == null}">
                                                                <span class="text-muted">-</span>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="time-cell">
                                                            <c:if test="${cita.fechaHoraSalida != null}">
                                                                <fmt:formatDate value="${cita.fechaHoraSalida}" pattern="HH:mm" />
                                                            </c:if>
                                                            <c:if test="${cita.fechaHoraSalida == null}">
                                                                <span class="text-muted">-</span>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="patient-cell">
                                                            <div class="patient-name">${cita.nombreCompletoPaciente}</div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="service-badge">${cita.nombreServicio}</span>
                                                    </td>
                                                    <td>
                                                        <div class="doctor-cell">${cita.nombreCompletoOdontologo}</div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${cita.duracionMinutos != null && cita.duracionMinutos > 0}">
                                                                <c:choose>
                                                                    <c:when test="${cita.duracionMinutos <= 30}">
                                                                        <span class="duration-badge duration-short">${cita.duracionMinutos} min</span>
                                                                    </c:when>
                                                                    <c:when test="${cita.duracionMinutos <= 60}">
                                                                        <span class="duration-badge duration-normal">${cita.duracionMinutos} min</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="duration-badge duration-long">${cita.duracionMinutos} min</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">-</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons-historial">
                                                            <button class="btn btn-sm btn-outline-primary" 
                                                                    onclick="verDetalleCita(${cita.idCita})"
                                                                    title="Ver detalles completos">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-success ms-1" 
                                                                    onclick="imprimirReceta(${cita.idCita})"
                                                                    title="Imprimir receta">
                                                                <i class="fas fa-prescription"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Modal para detalle de cita -->
    <div class="modal fade" id="modalDetalleCita" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-file-medical me-2"></i>
                        Detalle Completo de Cita
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="contenidoDetalleCita">
                    <!-- Contenido cargado dinámicamente -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-success" onclick="imprimirDetalle()">
                        <i class="fas fa-print me-1"></i>
                        Imprimir
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        /* Resumen de estadísticas moderno */
        .stats-summary-modern {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 16px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 32px rgba(102, 126, 234, 0.3);
        }

        .stats-content .stats-title {
            margin: 0;
            font-weight: 700;
            font-size: 1.5rem;
        }

        .stats-content .stats-subtitle {
            margin: 0;
            opacity: 0.9;
            font-size: 1rem;
        }

        .stats-numbers {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 1rem;
        }

        .stat-item {
            padding: 0.5rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .stat-label {
            font-size: 0.85rem;
            opacity: 0.9;
        }

        /* Filtros modernos */
        .filter-card-historial {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
        }

        .filter-title-historial {
            color: #1e293b;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .filter-actions .btn,
        .export-actions .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
        }

        /* Contenedor de tabla */
        .historial-table-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .historial-table-header {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            border: none;
            padding: 1.5rem;
        }

        .historial-table-title {
            margin: 0;
            font-weight: 600;
            font-size: 1.25rem;
        }

        /* Tabla moderna */
        .historial-table {
            margin: 0;
        }

        .table-header-modern {
            background: #f8fafc;
            border-bottom: 2px solid #e2e8f0;
        }

        .table-header-modern th {
            color: #1e293b;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 1rem;
            border: none;
        }

        .historial-row {
            transition: all 0.2s ease;
            border-bottom: 1px solid #f1f5f9;
        }

        .historial-row:hover {
            background: rgba(102, 126, 234, 0.05);
            transform: scale(1.01);
        }

        .historial-row td {
            padding: 1rem;
            vertical-align: middle;
            border: none;
        }

        /* Elementos de celda */
        .id-badge {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .date-cell,
        .time-cell {
            font-weight: 500;
            color: #1e293b;
        }

        .patient-cell .patient-name {
            font-weight: 600;
            color: #1e293b;
            font-size: 0.95rem;
        }

        .service-badge {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .doctor-cell {
            color: #64748b;
            font-size: 0.9rem;
        }

        .duration-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .duration-short {
            background: #d1fae5;
            color: #065f46;
        }

        .duration-normal {
            background: #dbeafe;
            color: #1e40af;
        }

        .duration-long {
            background: #fef3c7;
            color: #92400e;
        }

        .action-buttons-historial {
            display: flex;
            gap: 0.25rem;
        }

        .action-buttons-historial .btn {
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .action-buttons-historial .btn:hover {
            transform: scale(1.05);
        }

        /* Estado vacío */
        .empty-state-historial {
            text-align: center;
            padding: 4rem 2rem;
        }

        .empty-icon {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 1.5rem;
        }

        .empty-title {
            color: #64748b;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .empty-text {
            color: #94a3b8;
            margin-bottom: 2rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .stats-numbers {
                margin-top: 1rem;
            }
            
            .filter-actions,
            .export-actions {
                margin-top: 1rem;
                text-align: center;
            }
            
            .historial-table {
                font-size: 0.85rem;
            }
            
            .historial-row td {
                padding: 0.75rem 0.5rem;
            }
        }
    </style>
    
    <script>
        function verDetalleCita(idCita) {
            fetch('${pageContext.request.contextPath}/secretaria?action=detalle-cita&idCita=' + idCita)
                .then(response => response.text())
                .then(html => {
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(html, 'text/html');
                    const contenido = doc.querySelector('.modal-body').innerHTML;
                    
                    document.getElementById('contenidoDetalleCita').innerHTML = contenido;
                    new bootstrap.Modal(document.getElementById('modalDetalleCita')).show();
                })
                .catch(error => {
                    console.error('Error:', error);
                    mostrarDetalleFallback(idCita);
                });
        }

        function mostrarDetalleFallback(idCita) {
            const contenido = `
                <div class="alert alert-warning">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Error al cargar los detalles de la cita #${idCita}
                </div>
            `;
            
            document.getElementById('contenidoDetalleCita').innerHTML = contenido;
            new bootstrap.Modal(document.getElementById('modalDetalleCita')).show();
        }

        function imprimirReceta(idCita) {
            window.open('${pageContext.request.contextPath}/secretaria/imprimir-receta?idCita=' + idCita, '_blank');
        }

        function imprimirDetalle() {
            const contenido = document.getElementById('contenidoDetalleCita').innerHTML;
            const ventana = window.open('', '_blank');
            ventana.document.write(`
                <html>
                    <head>
                        <title>Detalle de Cita Completada</title>
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                        <style>
                            body { font-family: Arial, sans-serif; }
                            .header { text-align: center; margin-bottom: 30px; }
                            .logo { font-size: 24px; font-weight: bold; color: #28a745; }
                        </style>
                    </head>
                    <body class="p-4">
                        <div class="header">
                            <div class="logo">ArtDent - Clínica Dental</div>
                            <h2>Detalle de Cita Completada</h2>
                            <p>Fecha de impresión: ` + new Date().toLocaleDateString() + `</p>
                        </div>
                        ` + contenido + `
                    </body>
                </html>
            `);
            ventana.document.close();
            ventana.print();
        }

        function exportarHistorial(formato) {
            const form = document.createElement('form');
            form.method = 'GET';
            form.action = '${pageContext.request.contextPath}/secretaria';
            
            const params = new URLSearchParams(window.location.search);
            params.set('action', 'exportar-historial');
            params.set('formato', formato);
            
            // Agregar todos los parámetros actuales
            for (const [key, value] of params) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = value;
                form.appendChild(input);
            }
            
            document.body.appendChild(form);
            form.submit();
            document.body.removeChild(form);
        }

        function imprimirHistorial() {
            window.print();
        }

        // Animaciones de entrada para las filas
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('.historial-row');
            rows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateX(-20px)';
                setTimeout(() => {
                    row.style.transition = 'all 0.3s ease';
                    row.style.opacity = '1';
                    row.style.transform = 'translateX(0)';
                }, index * 50);
            });
        });
    </script>
</body>
</html>
