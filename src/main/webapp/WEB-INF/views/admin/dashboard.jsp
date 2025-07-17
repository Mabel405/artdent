<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Administrador - ArtDent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-light">
    <!-- Header -->
    <jsp:include page="layout/header.jsp"/>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="layout/sidebar.jsp">
                <jsp:param name="page" value="dashboard"/>
            </jsp:include>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-tachometer-alt me-2 text-primary"></i>Dashboard Administrador
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-primary">
                                <i class="fas fa-download me-1"></i>Exportar Datos
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Estadísticas principales -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-start border-primary border-4 shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs fw-bold text-primary text-uppercase mb-1">
                                            Total Usuarios
                                        </div>
                                        <div class="h5 mb-0 fw-bold text-gray-800">${totalUsuarios}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-users fa-2x text-primary"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-start border-success border-4 shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs fw-bold text-success text-uppercase mb-1">
                                            Total Pacientes
                                        </div>
                                        <div class="h5 mb-0 fw-bold text-gray-800">${totalPacientes}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-user-injured fa-2x text-success"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-start border-info border-4 shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs fw-bold text-info text-uppercase mb-1">
                                            Servicios Activos
                                        </div>
                                        <div class="h5 mb-0 fw-bold text-gray-800">${totalServicios}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-stethoscope fa-2x text-info"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-start border-warning border-4 shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs fw-bold text-warning text-uppercase mb-1">
                                            Reservas Pendientes
                                        </div>
                                        <div class="h5 mb-0 fw-bold text-gray-800">${reservasPendientes}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clock fa-2x text-warning"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Acciones rápidas -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card shadow">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-bolt me-2"></i>Acciones Rápidas
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=usuarios" 
                                           class="btn btn-outline-primary w-100 h-100 d-flex flex-column justify-content-center">
                                            <i class="fas fa-user-plus fa-2x mb-2"></i>
                                            <span>Nuevo Usuario</span>
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=pacientes" 
                                           class="btn btn-outline-success w-100 h-100 d-flex flex-column justify-content-center">
                                            <i class="fas fa-user-injured fa-2x mb-2"></i>
                                            <span>Nuevo Paciente</span>
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=servicios" 
                                           class="btn btn-outline-info w-100 h-100 d-flex flex-column justify-content-center">
                                            <i class="fas fa-plus-circle fa-2x mb-2"></i>
                                            <span>Nuevo Servicio</span>
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=faq" 
                                           class="btn btn-outline-warning w-100 h-100 d-flex flex-column justify-content-center">
                                            <i class="fas fa-question-circle fa-2x mb-2"></i>
                                            <span>Nueva FAQ</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Gráficos -->
                <div class="row">
                    <div class="col-lg-6 mb-4">
                        <div class="card shadow">
                            <div class="card-header bg-light">
                                <h6 class="m-0 fw-bold text-primary">Distribución por Tipo</h6>
                            </div>
                            <div class="card-body">
                                <canvas id="pieChart" width="100" height="100"></canvas>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-6 mb-4">
                        <div class="card shadow">
                            <div class="card-header bg-light">
                                <h6 class="m-0 fw-bold text-primary">Actividad del Sistema</h6>
                            </div>
                            <div class="card-body">
                                <canvas id="barChart" width="100" height="100"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Gráfico de pastel
        const pieCtx = document.getElementById('pieChart').getContext('2d');
        new Chart(pieCtx, {
            type: 'doughnut',
            data: {
                labels: ['Usuarios', 'Pacientes', 'Servicios', 'FAQs'],
                datasets: [{
                    data: [${totalUsuarios}, ${totalPacientes}, ${totalServicios}, ${totalFAQs}],
                    backgroundColor: [
                        '#0d6efd',
                        '#198754',
                        '#0dcaf0',
                        '#ffc107'
                    ]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        // Gráfico de barras
        const barCtx = document.getElementById('barChart').getContext('2d');
        new Chart(barCtx, {
            type: 'bar',
            data: {
                labels: ['Usuarios', 'Pacientes', 'Servicios', 'Reservas'],
                datasets: [{
                    label: 'Cantidad',
                    data: [${totalUsuarios}, ${totalPacientes}, ${totalServicios}, ${totalReservas}],
                    backgroundColor: [
                        'rgba(13, 110, 253, 0.8)',
                        'rgba(25, 135, 84, 0.8)',
                        'rgba(13, 202, 240, 0.8)',
                        'rgba(255, 193, 7, 0.8)'
                    ],
                    borderColor: [
                        '#0d6efd',
                        '#198754',
                        '#0dcaf0',
                        '#ffc107'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
    </script>
</body>
</html>
