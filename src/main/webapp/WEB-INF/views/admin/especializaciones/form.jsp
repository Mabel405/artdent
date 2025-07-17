<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nueva Especialización - ArtDent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Header -->
    <jsp:include page="../layout/header.jsp"/>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="../layout/sidebar.jsp">
                <jsp:param name="page" value="especializaciones"/>
            </jsp:include>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-user-md me-2 text-secondary"></i>
                        Nueva Especialización
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/admin?action=list&section=especializaciones" 
                           class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i>Volver
                        </a>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="card shadow">
                            <div class="card-header bg-secondary text-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-link me-2"></i>
                                    Asignar Especialización a Odontólogo
                                </h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/admin" method="post" id="especializacionForm">
                                    <input type="hidden" name="action" value="create">
                                    <input type="hidden" name="section" value="especializaciones">

                                    <div class="mb-4">
                                        <label for="idUsuario" class="form-label">
                                            <i class="fas fa-user-md me-1"></i>Odontólogo *
                                        </label>
                                        <select class="form-select" id="idUsuario" name="idUsuario" required>
                                            <option value="">Seleccionar odontólogo...</option>
                                            <c:forEach var="odontologo" items="${odontologos}">
                                                <option value="${odontologo.idUsuario}">
                                                    Dr. ${odontologo.nombre} ${odontologo.apellido} - DNI: ${odontologo.dni}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="form-text">
                                            Seleccione el odontólogo al que desea asignar la especialización.
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label for="idServicio" class="form-label">
                                            <i class="fas fa-stethoscope me-1"></i>Servicio/Especialización *
                                        </label>
                                        <select class="form-select" id="idServicio" name="idServicio" required>
                                            <option value="">Seleccionar servicio...</option>
                                            <c:forEach var="servicio" items="${servicios}">
                                                <option value="${servicio.idServicio}" data-costo="${servicio.costo}">
                                                    ${servicio.tipoServicio}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="form-text">
                                            Seleccione el servicio en el que se especializa el odontólogo.
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="disponibilidad" name="disponibilidad" checked>
                                            <label class="form-check-label" for="disponibilidad">
                                                <i class="fas fa-toggle-on me-1"></i>
                                                <span id="disponibilidadLabel">Disponible para atender este servicio</span>
                                            </label>
                                        </div>
                                        <div class="form-text">
                                            Marque si el odontólogo está actualmente disponible para atender este servicio.
                                        </div>
                                    </div>

                                    <!-- Vista previa de la especialización -->
                                    <div class="card bg-light mb-4" id="previewCard" style="display: none;">
                                        <div class="card-header">
                                            <h6 class="mb-0">
                                                <i class="fas fa-eye me-1"></i>Vista Previa de la Especialización
                                            </h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6 class="text-secondary">Odontólogo:</h6>
                                                    <p class="mb-2" id="previewOdontologo">-</p>
                                                </div>
                                                <div class="col-md-6">
                                                    <h6 class="text-primary">Especialización:</h6>
                                                    <p class="mb-2" id="previewServicio">-</p>
                                                    <small class="text-muted" id="previewCosto"></small>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                                <span class="badge bg-success" id="previewEstado">
                                                    <i class="fas fa-check me-1"></i>Disponible
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <strong>Nota:</strong> Una vez asignada la especialización, el odontólogo podrá atender citas para este servicio específico. 
                                        Puede cambiar la disponibilidad en cualquier momento desde la lista de especializaciones.
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/admin/admin?action=list&section=especializaciones" 
                                           class="btn btn-secondary me-md-2">
                                            <i class="fas fa-times me-1"></i>Cancelar
                                        </a>
                                        <button type="submit" class="btn btn-secondary">
                                            <i class="fas fa-save me-1"></i>
                                            Crear Especialización
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Vista previa en tiempo real
        function updatePreview() {
            const odontologoSelect = document.getElementById('idUsuario');
            const servicioSelect = document.getElementById('idServicio');
            const disponibilidad = document.getElementById('disponibilidad').checked;
            const previewCard = document.getElementById('previewCard');
            
            if (odontologoSelect.value && servicioSelect.value) {
                const odontologoText = odontologoSelect.options[odontologoSelect.selectedIndex].text;
                const servicioText = servicioSelect.options[servicioSelect.selectedIndex].text;
                const costo = servicioSelect.options[servicioSelect.selectedIndex].dataset.costo;
                
                document.getElementById('previewOdontologo').textContent = odontologoText;
                document.getElementById('previewServicio').textContent = servicioText;
                document.getElementById('previewCosto').textContent = 'Costo del servicio: S/ ' + parseFloat(costo).toFixed(2);
                
                const estadoBadge = document.getElementById('previewEstado');
                if (disponibilidad) {
                    estadoBadge.className = 'badge bg-success';
                    estadoBadge.innerHTML = '<i class="fas fa-check me-1"></i>Disponible';
                } else {
                    estadoBadge.className = 'badge bg-danger';
                    estadoBadge.innerHTML = '<i class="fas fa-times me-1"></i>No disponible';
                }
                
                previewCard.style.display = 'block';
            } else {
                previewCard.style.display = 'none';
            }
        }

        // Event listeners
        document.getElementById('idUsuario').addEventListener('change', updatePreview);
        document.getElementById('idServicio').addEventListener('change', updatePreview);
        document.getElementById('disponibilidad').addEventListener('change', function() {
            const label = document.getElementById('disponibilidadLabel');
            label.textContent = this.checked ? 'Disponible para atender este servicio' : 'No disponible para atender este servicio';
            updatePreview();
        });

        // Validación del formulario
        document.getElementById('especializacionForm').addEventListener('submit', function(e) {
            const idUsuario = document.getElementById('idUsuario').value;
            const idServicio = document.getElementById('idServicio').value;
            
            if (!idUsuario) {
                e.preventDefault();
                alert('Debe seleccionar un odontólogo');
                document.getElementById('idUsuario').focus();
                return;
            }
            
            if (!idServicio) {
                e.preventDefault();
                alert('Debe seleccionar un servicio');
                document.getElementById('idServicio').focus();
                return;
            }
        });
    </script>
</body>
</html>