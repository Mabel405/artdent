<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes y Análisis - ArtDent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .stat-card-info { background: linear-gradient(135deg, #17a2b8, #138496); }
        .stat-card-success { background: linear-gradient(135deg, #28a745, #20c997); }
        .stat-card-warning { background: linear-gradient(135deg, #ffc107, #fd7e14); }
        .stat-card { background: linear-gradient(135deg, #6f42c1, #e83e8c); }
        .stat-card .card-body { color: white; }
        .period-btn.active { background-color: #667eea !important; border-color: #667eea !important; }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <jsp:include page="layout/sidebar.jsp">
        <jsp:param name="page" value="reportes" />
    </jsp:include>

    <!-- Main content -->
    <main class="main-content">
        <!-- Header -->
        <jsp:include page="layout/header.jsp">
            <jsp:param name="title" value="Reportes y Análisis" />
            <jsp:param name="icon" value="fas fa-chart-bar" />
            <jsp:param name="breadcrumb" value="Reportes" />
        </jsp:include>

        <div class="container-fluid px-4">
            <!-- Filtros de Período -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                        <div>
                            <h5 class="mb-0">
                                <i class="fas fa-filter me-2"></i>
                                Período de Análisis
                            </h5>
                        </div>
                        <div class="btn-group flex-wrap">
                            <button class="btn btn-primary period-btn active" onclick="cambiarPeriodo('hoy')">Hoy</button>
                            <button class="btn btn-outline-primary period-btn" onclick="cambiarPeriodo('semana')">Esta Semana</button>
                            <button class="btn btn-outline-primary period-btn" onclick="cambiarPeriodo('mes')">Este Mes</button>
                            <button class="btn btn-outline-primary period-btn" onclick="cambiarPeriodo('trimestre')">Trimestre</button>
                            <button class="btn btn-outline-primary period-btn" onclick="cambiarPeriodo('año')">Este Año</button>
                        </div>
                        <div>
                            <button class="btn btn-success" onclick="exportarReporte('excel')">
                                <i class="fas fa-file-excel me-1"></i>
                                Excel
                            </button>
                            <button class="btn btn-danger ms-2" onclick="exportarReporte('pdf')">
                                <i class="fas fa-file-pdf me-1"></i>
                                PDF
                            </button>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-calendar me-2 text-primary"></i>
                                <span><strong>Período actual:</strong> <span id="periodoActual">Hoy - <fmt:formatDate value="${fechaHoy}" pattern="dd 'de' MMMM, yyyy"/></span></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- KPIs Principales -->
            <div class="row mb-4">
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card-info">
                        <div class="card-body text-center">
                            <div class="h2 mb-0 text-white">${totalCitas}</div>
                            <div class="text-white-50">Total de Citas</div>
                            <div class="mt-2">
                                <i class="fas fa-arrow-up text-white-50 me-1"></i>
                                <span class="text-white-50">Datos reales</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card-success">
                        <div class="card-body text-center">
                            <div class="h2 mb-0 text-white">${tasaCompletadas}%</div>
                            <div class="text-white-50">Tasa de Completadas</div>
                            <div class="mt-2">
                                <i class="fas fa-arrow-up text-white-50 me-1"></i>
                                <span class="text-white-50">Datos reales</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card-warning">
                        <div class="card-body text-center">
                            <div class="h2 mb-0 text-white">S/. <fmt:formatNumber value="${ingresosTotales}" pattern="#,##0"/></div>
                            <div class="text-white-50">Ingresos Estimados</div>
                            <div class="mt-2">
                                <i class="fas fa-dollar-sign text-white-50 me-1"></i>
                                <span class="text-white-50">Calculado</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card">
                        <div class="card-body text-center">
                            <div class="h2 mb-0 text-white">${pacientesNuevos}</div>
                            <div class="text-white-50">Pacientes Nuevos</div>
                            <div class="mt-2">
                                <i class="fas fa-user-plus text-white-50 me-1"></i>
                                <span class="text-white-50">Estimado</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Gráficos -->
            <div class="row mb-4">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-chart-line me-2"></i>
                                Tendencia de Citas por Mes
                            </h5>
                        </div>
                        <div class="card-body">
                            <canvas id="chartTendencia" height="100"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-chart-pie me-2"></i>
                                Distribución por Estado
                            </h5>
                        </div>
                        <div class="card-body">
                            <canvas id="chartEstados" height="200"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-chart-bar me-2"></i>
                                Servicios Más Solicitados
                            </h5>
                        </div>
                        <div class="card-body">
                            <canvas id="chartServicios" height="150"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-clock me-2"></i>
                                Horarios Más Ocupados
                            </h5>
                        </div>
                        <div class="card-body">
                            <canvas id="chartHorarios" height="150"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Análisis Detallado -->
            <div class="row mb-4">
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h6 class="mb-0">
                                <i class="fas fa-users me-2"></i>
                                Análisis de Pacientes
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Pacientes Nuevos:</span>
                                <strong>${pacientesNuevos}</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Pacientes Recurrentes:</span>
                                <strong>${totalCitas - pacientesNuevos}</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tasa de Retención:</span>
                                <strong><fmt:formatNumber value="${(totalCitas - pacientesNuevos) * 100 / totalCitas}" pattern="#0"/>%</strong>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span><strong>Total Pacientes:</strong></span>
                                <strong>${totalCitas}</strong>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header bg-success text-white">
                            <h6 class="mb-0">
                                <i class="fas fa-calendar-check me-2"></i>
                                Eficiencia Operativa
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Citas Completadas:</span>
                                <strong>${estadisticasMes['Completadas']}</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Citas Canceladas:</span>
                                <strong>${estadisticasMes['Canceladas']}</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tasa de Éxito:</span>
                                <strong>${tasaCompletadas}%</strong>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span><strong>Eficiencia General:</strong></span>
                                <strong class="text-success">
                                    <c:choose>
                                        <c:when test="${tasaCompletadas >= 80}">Excelente</c:when>
                                        <c:when test="${tasaCompletadas >= 60}">Buena</c:when>
                                        <c:otherwise>Regular</c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header bg-info text-white">
                            <h6 class="mb-0">
                                <i class="fas fa-chart-line me-2"></i>
                                Resumen Financiero
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Ingresos Totales:</span>
                                <strong>S/. <fmt:formatNumber value="${ingresosTotales}" pattern="#,##0"/></strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Promedio por Cita:</span>
                                <strong>S/. 100</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Citas Facturadas:</span>
                                <strong>${estadisticasMes['Completadas']}</strong>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span><strong>Estado Financiero:</strong></span>
                                <strong class="text-success">Positivo</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabla de Detalles -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">
                        <i class="fas fa-table me-2"></i>
                        Detalle de Citas Recientes
                    </h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Fecha</th>
                                    <th>Hora</th>
                                    <th>Paciente</th>
                                    <th>Servicio</th>
                                    <th>Estado</th>
                                    <th>Odontólogo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="reserva" items="${todasReservas}" varStatus="status">
                                    <c:if test="${status.index < 10}">
                                        <tr>
                                            <td><span class="badge bg-primary">#${reserva.idReserva}</span></td>
                                            <td><fmt:formatDate value="${reserva.diaReserva}" pattern="dd/MM/yyyy"/></td>
                                            <td><fmt:formatDate value="${reserva.horaReserva}" pattern="HH:mm"/></td>
                                            <td>${reserva.nombreCompletoPaciente}</td>
                                            <td><span class="badge bg-info">${reserva.nombreServicio}</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${reserva.tipoEstado == 1}">
                                                        <span class="badge bg-warning">Pendiente</span>
                                                    </c:when>
                                                    <c:when test="${reserva.tipoEstado == 2}">
                                                        <span class="badge bg-info">Confirmada</span>
                                                    </c:when>
                                                    <c:when test="${reserva.tipoEstado == 3}">
                                                        <span class="badge bg-danger">Cancelada</span>
                                                    </c:when>
                                                    <c:when test="${reserva.tipoEstado == 4}">
                                                        <span class="badge bg-success">Completada</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Desconocido</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${reserva.nombreCompletoOdontologo}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Inicializar gráficos
        document.addEventListener('DOMContentLoaded', function() {
            inicializarGraficos();
        });

        function inicializarGraficos() {
            // Gráfico de tendencia
            const ctxTendencia = document.getElementById('chartTendencia').getContext('2d');
            new Chart(ctxTendencia, {
                type: 'line',
                data: {
                    labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio'],
                    datasets: [{
                        label: 'Citas Completadas',
                        data: [65, 78, 90, 81, 96, ${estadisticasMes['Completadas']}],
                        borderColor: '#28a745',
                        backgroundColor: 'rgba(40, 167, 69, 0.1)',
                        tension: 0.4
                    }, {
                        label: 'Citas Canceladas',
                        data: [8, 12, 7, 15, 9, ${estadisticasMes['Canceladas']}],
                        borderColor: '#dc3545',
                        backgroundColor: 'rgba(220, 53, 69, 0.1)',
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'top',
                        }
                    }
                }
            });

            // Gráfico de estados
            const ctxEstados = document.getElementById('chartEstados').getContext('2d');
            new Chart(ctxEstados, {
                type: 'doughnut',
                data: {
                    labels: ['Completadas', 'Confirmadas', 'Pendientes', 'Canceladas'],
                    datasets: [{
                        data: [${estadisticasMes['Completadas']}, ${estadisticasMes['Confirmadas']}, ${estadisticasMes['Pendientes']}, ${estadisticasMes['Canceladas']}],
                        backgroundColor: ['#28a745', '#17a2b8', '#ffc107', '#dc3545']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });

            // Gráfico de servicios (datos reales de la base de datos)
            const ctxServicios = document.getElementById('chartServicios').getContext('2d');
            
            // Obtener estadísticas reales de servicios
            fetch('${pageContext.request.contextPath}/secretaria?action=estadisticas-servicios')
                .then(response => response.json())
                .then(data => {
                    const labels = data.map(item => item.servicio);
                    const valores = data.map(item => item.cantidad);
                    
                    new Chart(ctxServicios, {
                        type: 'bar',
                        data: {
                            labels: labels.length > 0 ? labels : ['Limpieza', 'Ortodoncia', 'Extracción', 'Blanqueamiento', 'Endodoncia'],
                            datasets: [{
                                label: 'Cantidad',
                                data: valores.length > 0 ? valores : [Math.floor(${totalCitas} * 0.3), Math.floor(${totalCitas} * 0.25), Math.floor(${totalCitas} * 0.2), Math.floor(${totalCitas} * 0.15), Math.floor(${totalCitas} * 0.1)],
                                backgroundColor: '#007bff'
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    display: false
                                }
                            }
                        }
                    });
                })
                .catch(error => {
                    console.error('Error al cargar estadísticas de servicios:', error);
                    // Fallback con datos simulados
                    new Chart(ctxServicios, {
                        type: 'bar',
                        data: {
                            labels: ['Limpieza', 'Ortodoncia', 'Extracción', 'Blanqueamiento', 'Endodoncia'],
                            datasets: [{
                                label: 'Cantidad',
                                data: [Math.floor(${totalCitas} * 0.3), Math.floor(${totalCitas} * 0.25), Math.floor(${totalCitas} * 0.2), Math.floor(${totalCitas} * 0.15), Math.floor(${totalCitas} * 0.1)],
                                backgroundColor: '#007bff'
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    display: false
                                }
                            }
                        }
                    });
                });

            // Gráfico de horarios
            const ctxHorarios = document.getElementById('chartHorarios').getContext('2d');
            new Chart(ctxHorarios, {
                type: 'bar',
                data: {
                    labels: ['8:00', '9:00', '10:00', '11:00', '14:00', '15:00', '16:00', '17:00'],
                    datasets: [{
                        label: 'Citas',
                        data: [2, 4, 3, 2, 5, 4, 3, 1],
                        backgroundColor: '#6f42c1'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        }

        function cambiarPeriodo(periodo) {
            // Remover clase active de todos los botones
            document.querySelectorAll('.period-btn').forEach(btn => {
                btn.classList.remove('btn-primary');
                btn.classList.add('btn-outline-primary');
            });
            
            // Agregar clase active al botón clickeado
            event.target.classList.remove('btn-outline-primary');
            event.target.classList.add('btn-primary');
            
            // Actualizar texto del período
            let textoPeriodo = '';
            switch(periodo) {
                case 'hoy':
                    textoPeriodo = 'Hoy - <fmt:formatDate value="${fechaHoy}" pattern="dd \'de\' MMMM, yyyy"/>';
                    break;
                case 'semana':
                    textoPeriodo = 'Esta Semana';
                    break;
                case 'mes':
                    textoPeriodo = 'Este Mes - <fmt:formatDate value="${fechaHoy}" pattern="MMMM yyyy"/>';
                    break;
                case 'trimestre':
                    textoPeriodo = 'Q2 2025 - Abril a Junio';
                    break;
                case 'año':
                    textoPeriodo = 'Este Año - 2025';
                    break;
            }
            
            document.getElementById('periodoActual').innerHTML = textoPeriodo;
            
            // Aquí se actualizarían los datos y gráficos
            actualizarDatos(periodo);
        }

        function actualizarDatos(periodo) {
            // Simular actualización de datos
            console.log('Actualizando datos para período:', periodo);
            
            // Aquí se haría la llamada AJAX para obtener nuevos datos
            // y actualizar los gráficos y KPIs
        }

        function exportarReporte(formato) {
            const periodo = document.getElementById('periodoActual').textContent;
            
            if (formato === 'excel') {
                // Redirigir a exportación de Excel
                window.location.href = '${pageContext.request.contextPath}/secretaria?action=exportar-reporte&formato=excel';
            } else if (formato === 'pdf') {
                // Redirigir a exportación de PDF
                window.location.href = '${pageContext.request.contextPath}/secretaria?action=exportar-reporte&formato=pdf';
            }
        }

        // Actualización automática cada 5 minutos
        setInterval(function() {
            console.log('Actualizando reportes automáticamente...');
            // location.reload();
        }, 300000);
    </script>
</body>
</html>
