<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Pacientes - ArtDent</title>
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
                <jsp:param name="page" value="pacientes"/>
            </jsp:include>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-user-injured me-2 text-success"></i>Gestión de Pacientes
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=pacientes" 
                           class="btn btn-success">
                            <i class="fas fa-plus me-1"></i>Nuevo Paciente
                        </a>
                    </div>
                </div>

                <!-- Filtros -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" class="form-control" id="searchInput" placeholder="Buscar por nombre, DNI o correo...">
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-outline-secondary" onclick="clearFilters()">
                                    <i class="fas fa-times me-1"></i>Limpiar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tabla de pacientes -->
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-list me-2"></i>Lista de Pacientes (${pacientes.size()})
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0" id="pacientesTable">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre Completo</th>
                                        <th>DNI</th>
                                        <th>Correo</th>
                                        <th>Teléfono</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="paciente" items="${pacientes}">
                                        <tr>
                                            <td>${paciente.idPaciente}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm me-2">
                                                        <i class="fas fa-user-circle fa-2x text-success"></i>
                                                    </div>
                                                    <div>
                                                        <div class="fw-bold">${paciente.nombre} ${paciente.apellido}</div>
                                                        <small class="text-muted">Paciente</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><code>${paciente.dni}</code></td>
                                            <td>
                                                <a href="mailto:${paciente.correo}" class="text-decoration-none">
                                                    ${paciente.correo}
                                                </a>
                                            </td>
                                            <td>
                                                <a href="tel:${paciente.telefono}" class="text-decoration-none">
                                                    ${paciente.telefono}
                                                </a>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="${pageContext.request.contextPath}/admin/admin?action=edit&section=pacientes&id=${paciente.idPaciente}" 
                                                       class="btn btn-sm btn-outline-primary" title="Editar">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            onclick="confirmarEliminacion(${paciente.idPaciente}, '${paciente.nombre} ${paciente.apellido}')"
                                                            title="Eliminar">
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

                <c:if test="${empty pacientes}">
                    <div class="text-center py-5">
                        <i class="fas fa-user-injured text-muted" style="font-size: 4rem;"></i>
                        <h4 class="text-muted mt-3">No hay pacientes registrados</h4>
                        <p class="text-muted">Comienza agregando el primer paciente al sistema</p>
                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=pacientes" 
                           class="btn btn-success">
                            <i class="fas fa-plus me-1"></i>Agregar Paciente
                        </a>
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <!-- Modal de confirmación -->
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
                    <p>¿Está seguro que desea eliminar al paciente <strong id="pacienteNombre"></strong>?</p>
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Esta acción no se puede deshacer y eliminará todo el historial médico asociado.
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Filtro de búsqueda
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const filter = this.value.toLowerCase();
            const rows = document.querySelectorAll('#pacientesTable tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });

        // Limpiar filtros
        function clearFilters() {
            document.getElementById('searchInput').value = '';
            
            const rows = document.querySelectorAll('#pacientesTable tbody tr');
            rows.forEach(row => {
                row.style.display = '';
            });
        }

        // Confirmar eliminación
        function confirmarEliminacion(id, nombre) {
            document.getElementById('pacienteNombre').textContent = nombre;
            document.getElementById('confirmarEliminar').href = 
                '${pageContext.request.contextPath}/admin/admin?action=delete&section=pacientes&id=' + id;
            
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
