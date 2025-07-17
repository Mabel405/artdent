<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Especializaciones de Odontólogos - ArtDent</title>
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
                        <i class="fas fa-user-md me-2 text-secondary"></i>Especializaciones de Odontólogos
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=especializaciones" 
                           class="btn btn-secondary">
                            <i class="fas fa-plus me-1"></i>Nueva Especialización
                        </a>
                    </div>
                </div>

                <!-- Filtros -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <select class="form-select" id="odontologoFilter">
                                    <option value="">Todos los odontólogos</option>
                                    <c:forEach var="odontologo" items="${odontologos}">
                                        <option value="${odontologo.idUsuario}">
                                            Dr. ${odontologo.nombre} ${odontologo.apellido}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <select class="form-select" id="servicioFilter">
                                    <option value="">Todos los servicios</option>
                                    <c:forEach var="servicio" items="${servicios}">
                                        <option value="${servicio.idServicio}">${servicio.tipoServicio}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="disponibilidadFilter">
                                    <option value="">Todas</option>
                                    <option value="true">Disponibles</option>
                                    <option value="false">No disponibles</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-outline-secondary" onclick="clearFilters()">
                                    <i class="fas fa-times me-1"></i>Limpiar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tabla de especializaciones -->
                <div class="card shadow">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-list me-2"></i>Lista de Especializaciones (${especializaciones.size()})
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0" id="especializacionesTable">
                                <thead class="table-light">
                                    <tr>
                                        <th>Odontólogo</th>
                                        <th>Servicio/Especialización</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="esp" items="${especializaciones}">
                                        <tr data-odontologo="${esp.idUsuario}" 
                                            data-servicio="${esp.idServicio}"
                                            data-disponibilidad="${esp.disponibilidad}">
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm me-3">
                                                        <i class="fas fa-user-md fa-2x text-secondary"></i>
                                                    </div>
                                                    <div>
                                                        <div class="fw-bold">Dr. ${esp.nombreUsuario}</div>
                                                        <small class="text-muted">ID: ${esp.idUsuario}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <span class="fw-bold text-primary">${esp.tipoServicio}</span>
                                                    <c:if test="${esp.costoServicio != null}">
                                                        <div class="small text-muted">
                                                            Costo: S/ <fmt:formatNumber value="${esp.costoServicio}" pattern="#,##0.00"/>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge ${esp.disponibilidad ? 'bg-success' : 'bg-danger'}">
                                                    <i class="fas fa-${esp.disponibilidad ? 'check' : 'times'} me-1"></i>
                                                    ${esp.disponibilidad ? 'Disponible' : 'No disponible'}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <button type="button" class="btn btn-sm btn-outline-${esp.disponibilidad ? 'warning' : 'success'}" 
                                                            onclick="toggleDisponibilidad(${esp.idUsuario}, ${esp.idServicio}, ${esp.disponibilidad}, '${esp.nombreUsuario}', '${esp.tipoServicio}')"
                                                            title="${esp.disponibilidad ? 'Marcar como no disponible' : 'Marcar como disponible'}">
                                                        <i class="fas fa-${esp.disponibilidad ? 'eye-slash' : 'eye'}"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            onclick="confirmarEliminacion(${esp.idUsuario}, ${esp.idServicio}, '${esp.nombreUsuario}', '${esp.tipoServicio}')"
                                                            title="Eliminar especialización">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <c:if test="${empty especializaciones}">
                    <div class="text-center py-5">
                        <i class="fas fa-user-md text-muted" style="font-size: 4rem;"></i>
                        <h4 class="text-muted mt-3">No hay especializaciones registradas</h4>
                        <p class="text-muted">Comienza asignando especialidades a los odontólogos</p>
                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=especializaciones" 
                           class="btn btn-secondary">
                            <i class="fas fa-plus me-1"></i>Agregar Especialización
                        </a>
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <!-- Modal de confirmación para eliminar -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle me-2"></i>Confirmar Eliminación
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>¿Está seguro que desea eliminar la especialización de <strong id="doctorNombre"></strong> en <strong id="servicioNombre"></strong>?</p>
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Esta acción no se puede deshacer.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <a href="#" id="confirmarEliminar" class="btn btn-danger">
                        <i class="fas fa-trash me-1"></i>Eliminar
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de confirmación para toggle -->
    <div class="modal fade" id="toggleModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title">
                        <i class="fas fa-exchange-alt me-2"></i>Cambiar Disponibilidad
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>¿Está seguro que desea cambiar la disponibilidad de <strong id="doctorNombreToggle"></strong> para el servicio <strong id="servicioNombreToggle"></strong>?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <a href="#" id="confirmarToggle" class="btn btn-warning">
                        <i class="fas fa-exchange-alt me-1"></i>Confirmar
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Filtros
        document.getElementById('odontologoFilter').addEventListener('change', function() {
            filterTable();
        });

        document.getElementById('servicioFilter').addEventListener('change', function() {
            filterTable();
        });

        document.getElementById('disponibilidadFilter').addEventListener('change', function() {
            filterTable();
        });

        function filterTable() {
            const odontologoFilter = document.getElementById('odontologoFilter').value;
            const servicioFilter = document.getElementById('servicioFilter').value;
            const disponibilidadFilter = document.getElementById('disponibilidadFilter').value;
            const rows = document.querySelectorAll('#especializacionesTable tbody tr');
            
            rows.forEach(row => {
                let show = true;
                
                if (odontologoFilter && row.dataset.odontologo !== odontologoFilter) {
                    show = false;
                }
                
                if (servicioFilter && row.dataset.servicio !== servicioFilter) {
                    show = false;
                }
                
                if (disponibilidadFilter && row.dataset.disponibilidad !== disponibilidadFilter) {
                    show = false;
                }
                
                row.style.display = show ? '' : 'none';
            });
        }

        function clearFilters() {
            document.getElementById('odontologoFilter').value = '';
            document.getElementById('servicioFilter').value = '';
            document.getElementById('disponibilidadFilter').value = '';
            
            const rows = document.querySelectorAll('#especializacionesTable tbody tr');
            rows.forEach(row => {
                row.style.display = '';
            });
        }

        function confirmarEliminacion(idUsuario, idServicio, nombreDoctor, nombreServicio) {
            document.getElementById('doctorNombre').textContent = 'Dr. ' + nombreDoctor;
            document.getElementById('servicioNombre').textContent = nombreServicio;
            document.getElementById('confirmarEliminar').href = 
                '${pageContext.request.contextPath}/admin/admin?action=delete&section=especializaciones&idUsuario=' + idUsuario + '&idServicio=' + idServicio;
            
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }

        function toggleDisponibilidad(idUsuario, idServicio, disponibilidad, nombreDoctor, nombreServicio) {
            document.getElementById('doctorNombreToggle').textContent = 'Dr. ' + nombreDoctor;
            document.getElementById('servicioNombreToggle').textContent = nombreServicio;
            document.getElementById('confirmarToggle').href = 
                '${pageContext.request.contextPath}/admin/admin?action=toggle&section=especializaciones&idUsuario=' + idUsuario + '&idServicio=' + idServicio + '&disponibilidad=' + disponibilidad;
            
            new bootstrap.Modal(document.getElementById('toggleModal')).show();
        }
    </script>
</body>
</html>