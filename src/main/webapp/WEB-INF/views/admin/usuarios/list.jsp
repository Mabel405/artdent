<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Usuarios - ArtDent</title>
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
                <jsp:param name="page" value="usuarios"/>
            </jsp:include>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-users me-2 text-primary"></i>Gestión de Usuarios
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=usuarios" 
                           class="btn btn-primary">
                            <i class="fas fa-plus me-1"></i>Nuevo Usuario
                        </a>
                    </div>
                </div>

                <!-- Filtros -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="searchInput" placeholder="Buscar por nombre o DNI...">
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" id="rolFilter">
                                    <option value="">Todos los roles</option>
                                    <option value="1">Administrador</option>
                                    <option value="2">Secretaria</option>
                                    <option value="3">Odontólogo</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-outline-secondary" onclick="clearFilters()">
                                    <i class="fas fa-times me-1"></i>Limpiar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tabla de usuarios -->
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-list me-2"></i>Lista de Usuarios (${usuarios.size()})
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0" id="usuariosTable">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre Completo</th>
                                        <th>DNI</th>
                                        <th>Correo</th>
                                        <th>Teléfono</th>
                                        <th>Rol</th>
                                        <th>Fecha Nacimiento</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="usuario" items="${usuarios}">
                                        <tr data-rol="${usuario.rolIdRol}">
                                            <td>${usuario.idUsuario}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm me-2">
                                                        <i class="fas fa-user-circle fa-2x text-muted"></i>
                                                    </div>
                                                    <div>
                                                        <div class="fw-bold">${usuario.nombre} ${usuario.apellido}</div>
                                                        <small class="text-muted">${usuario.direccion}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><code>${usuario.dni}</code></td>
                                            <td>
                                                <a href="mailto:${usuario.correoElectronico}" class="text-decoration-none">
                                                    ${usuario.correoElectronico}
                                                </a>
                                            </td>
                                            <td>
                                                <a href="tel:${usuario.telefono}" class="text-decoration-none">
                                                    ${usuario.telefono}
                                                </a>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${usuario.rolIdRol == 1}">
                                                        <span class="badge bg-danger">
                                                            <i class="fas fa-user-shield me-1"></i>Administrador
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${usuario.rolIdRol == 2}">
                                                        <span class="badge bg-info">
                                                            <i class="fas fa-user-tie me-1"></i>Secretaria
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${usuario.rolIdRol == 3}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-user-md me-1"></i>Odontólogo
                                                        </span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${usuario.fechaNacimiento}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="${pageContext.request.contextPath}/admin/admin?action=edit&section=usuarios&id=${usuario.idUsuario}" 
                                                       class="btn btn-sm btn-outline-primary" title="Editar">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            onclick="confirmarEliminacion(${usuario.idUsuario}, '${usuario.nombre} ${usuario.apellido}')"
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

                <c:if test="${empty usuarios}">
                    <div class="text-center py-5">
                        <i class="fas fa-users text-muted" style="font-size: 4rem;"></i>
                        <h4 class="text-muted mt-3">No hay usuarios registrados</h4>
                        <p class="text-muted">Comienza agregando el primer usuario al sistema</p>
                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=usuarios" 
                           class="btn btn-primary">
                            <i class="fas fa-plus me-1"></i>Agregar Usuario
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
                    <p>¿Está seguro que desea eliminar al usuario <strong id="usuarioNombre"></strong>?</p>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Filtro de búsqueda
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const filter = this.value.toLowerCase();
            const rows = document.querySelectorAll('#usuariosTable tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });

        // Filtro por rol
        document.getElementById('rolFilter').addEventListener('change', function() {
            const selectedRol = this.value;
            const rows = document.querySelectorAll('#usuariosTable tbody tr');
            
            rows.forEach(row => {
                if (selectedRol === '' || row.dataset.rol === selectedRol) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });

        // Limpiar filtros
        function clearFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('rolFilter').value = '';
            
            const rows = document.querySelectorAll('#usuariosTable tbody tr');
            rows.forEach(row => {
                row.style.display = '';
            });
        }

        // Confirmar eliminación
        function confirmarEliminacion(id, nombre) {
            document.getElementById('usuarioNombre').textContent = nombre;
            document.getElementById('confirmarEliminar').href = 
                '${pageContext.request.contextPath}/admin/admin?action=delete&section=usuarios&id=' + id;
            
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
