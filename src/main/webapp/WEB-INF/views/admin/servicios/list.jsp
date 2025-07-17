<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Servicios - ArtDent</title>
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
                <jsp:param name="page" value="servicios"/>
            </jsp:include>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-stethoscope me-2 text-info"></i>Gestión de Servicios
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=servicios" 
                           class="btn btn-info">
                            <i class="fas fa-plus me-1"></i>Nuevo Servicio
                        </a>
                    </div>
                </div>

                <!-- Filtros -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" class="form-control" id="searchInput" placeholder="Buscar por nombre o descripción...">
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-outline-secondary" onclick="clearFilters()">
                                    <i class="fas fa-times me-1"></i>Limpiar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Grid de servicios -->
                <div class="row" id="serviciosGrid">
                    <c:forEach var="servicio" items="${servicios}">
                        <div class="col-lg-4 col-md-6 mb-4 servicio-card">
                            <div class="card shadow h-100">
                                <div class="card-img-top bg-light d-flex align-items-center justify-content-center" style="height: 200px;">
                                    <c:choose>
                                        <c:when test="${not empty servicio.img}">
                                            <img src="${servicio.img}" alt="${servicio.tipoServicio}" 
                                                 class="img-fluid" style="max-height: 180px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-tooth fa-4x text-muted"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title text-info">${servicio.tipoServicio}</h5>
                                    <p class="card-text text-muted small">${servicio.lema}</p>
                                    <p class="card-text flex-grow-1">${servicio.descripcion}</p>
                                    <div class="mt-auto">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <span class="h5 text-success mb-0">
                                                S/ <fmt:formatNumber value="${servicio.costo}" pattern="#,##0.00"/>
                                            </span>
                                            <span class="badge bg-info">ID: ${servicio.idServicio}</span>
                                        </div>
                                        <div class="btn-group w-100" role="group">
                                            <a href="${pageContext.request.contextPath}/admin/admin?action=edit&section=servicios&id=${servicio.idServicio}" 
                                               class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-edit me-1"></i>Editar
                                            </a>
                                            <button type="button" class="btn btn-outline-danger btn-sm" 
                                                    onclick="confirmarEliminacion(${servicio.idServicio}, '${servicio.tipoServicio}')">
                                                <i class="fas fa-trash me-1"></i>Eliminar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${empty servicios}">
                    <div class="text-center py-5">
                        <i class="fas fa-stethoscope text-muted" style="font-size: 4rem;"></i>
                        <h4 class="text-muted mt-3">No hay servicios registrados</h4>
                        <p class="text-muted">Comienza agregando el primer servicio al sistema</p>
                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=servicios" 
                           class="btn btn-info">
                            <i class="fas fa-plus me-1"></i>Agregar Servicio
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
                    <p>¿Está seguro que desea eliminar el servicio <strong id="servicioNombre"></strong>?</p>
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Esta acción no se puede deshacer y afectará las reservas asociadas.
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
            const cards = document.querySelectorAll('.servicio-card');
            
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(filter) ? '' : 'none';
            });
        });

        // Limpiar filtros
        function clearFilters() {
            document.getElementById('searchInput').value = '';
            
            const cards = document.querySelectorAll('.servicio-card');
            cards.forEach(card => {
                card.style.display = '';
            });
        }

        // Confirmar eliminación
        function confirmarEliminacion(id, nombre) {
            document.getElementById('servicioNombre').textContent = nombre;
            document.getElementById('confirmarEliminar').href = 
                '${pageContext.request.contextPath}/admin/admin?action=delete&section=servicios&id=' + id;
            
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
