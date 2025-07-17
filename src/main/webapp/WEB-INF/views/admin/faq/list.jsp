<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de FAQ - ArtDent</title>
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
                <jsp:param name="page" value="faq"/>
            </jsp:include>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-question-circle me-2 text-warning"></i>Gestión de FAQ
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=faq" 
                           class="btn btn-warning">
                            <i class="fas fa-plus me-1"></i>Nueva FAQ
                        </a>
                    </div>
                </div>

                <!-- Filtros -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="searchInput" placeholder="Buscar por pregunta o respuesta...">
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" id="servicioFilter">
                                    <option value="">Todos los servicios</option>
                                    <option value="general">Preguntas generales</option>
                                    <c:forEach var="servicio" items="${servicios}">
                                        <option value="${servicio.idServicio}">${servicio.tipoServicio}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="estadoFilter">
                                    <option value="">Todos los estados</option>
                                    <option value="1">Activos</option>
                                    <option value="0">Inactivos</option>
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

                <!-- Lista de FAQs -->
                <div class="row" id="faqsGrid">
                    <c:forEach var="faq" items="${faqs}" varStatus="status">
                        <div class="col-lg-6 mb-4 faq-card" 
                             data-servicio="${faq.servicioIdServicio != null ? faq.servicioIdServicio : 'general'}"
                             data-estado="${faq.activo ? '1' : '0'}">
                            <div class="card shadow h-100 ${faq.activo ? '' : 'border-secondary'}">
                                <div class="card-header d-flex justify-content-between align-items-center ${faq.activo ? 'bg-warning text-dark' : 'bg-secondary text-white'}">
                                    <div class="d-flex align-items-center">
                                        <span class="badge ${faq.activo ? 'bg-dark' : 'bg-light text-dark'} me-2">
                                            #${faq.idFaq}
                                        </span>
                                        <small>
                                            <i class="fas fa-star me-1"></i>Prioridad: ${faq.prioridad}
                                        </small>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <c:choose>
                                            <c:when test="${faq.servicioIdServicio != null}">
                                                <c:forEach var="servicio" items="${servicios}">
                                                    <c:if test="${servicio.idServicio == faq.servicioIdServicio}">
                                                        <span class="badge bg-info me-2">
                                                            <i class="fas fa-stethoscope me-1"></i>${servicio.tipoServicio}
                                                        </span>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-primary me-2">
                                                    <i class="fas fa-globe me-1"></i>General
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="badge ${faq.activo ? 'bg-success' : 'bg-danger'}">
                                            <i class="fas fa-${faq.activo ? 'check' : 'times'} me-1"></i>
                                            ${faq.activo ? 'Activo' : 'Inactivo'}
                                        </span>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <h6 class="card-title text-primary mb-3">
                                        <i class="fas fa-question me-2"></i>${faq.pregunta}
                                    </h6>
                                    <div class="card-text">
                                        <div class="bg-light p-3 rounded mb-3">
                                            <small class="text-muted d-block mb-1">
                                                <i class="fas fa-reply me-1"></i>Respuesta:
                                            </small>
                                            <p class="mb-0">${faq.respuesta}</p>
                                        </div>
                                    </div>
                                    <div class="mt-auto">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <small class="text-muted">
                                                <i class="fas fa-calendar me-1"></i>
                                                Creado: <fmt:formatDate value="${faq.fechaCreacion}" pattern="dd/MM/yyyy"/>
                                            </small>
                                            <c:if test="${faq.fechaActualizacion != null}">
                                                <small class="text-muted">
                                                    <i class="fas fa-edit me-1"></i>
                                                    Actualizado: <fmt:formatDate value="${faq.fechaActualizacion}" pattern="dd/MM/yyyy"/>
                                                </small>
                                            </c:if>
                                        </div>
                                        <div class="btn-group w-100" role="group">
                                            <a href="${pageContext.request.contextPath}/admin/admin?action=edit&section=faq&id=${faq.idFaq}" 
                                               class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-edit me-1"></i>Editar
                                            </a>
                                            <button type="button" class="btn btn-outline-${faq.activo ? 'warning' : 'success'} btn-sm" 
                                                    onclick="toggleEstado(${faq.idFaq}, ${faq.activo}, '${faq.pregunta}')">
                                                <i class="fas fa-${faq.activo ? 'eye-slash' : 'eye'} me-1"></i>
                                                ${faq.activo ? 'Desactivar' : 'Activar'}
                                            </button>
                                            <button type="button" class="btn btn-outline-danger btn-sm" 
                                                    onclick="confirmarEliminacion(${faq.idFaq}, '${faq.pregunta}')">
                                                <i class="fas fa-trash me-1"></i>Eliminar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${empty faqs}">
                    <div class="text-center py-5">
                        <i class="fas fa-question-circle text-muted" style="font-size: 4rem;"></i>
                        <h4 class="text-muted mt-3">No hay preguntas frecuentes registradas</h4>
                        <p class="text-muted">Comienza agregando la primera FAQ al sistema</p>
                        <a href="${pageContext.request.contextPath}/admin/admin?action=new&section=faq" 
                           class="btn btn-warning">
                            <i class="fas fa-plus me-1"></i>Agregar FAQ
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
                    <p>¿Está seguro que desea eliminar la FAQ <strong id="faqPregunta"></strong>?</p>
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Esta acción marcará la FAQ como inactiva permanentemente.
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

    <!-- Modal de confirmación para cambiar estado -->
    <div class="modal fade" id="toggleModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title">
                        <i class="fas fa-exchange-alt me-2"></i>Cambiar Estado
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>¿Está seguro que desea <strong id="accionEstado"></strong> la FAQ <strong id="faqPreguntaToggle"></strong>?</p>
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
        // Filtro de búsqueda
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const filter = this.value.toLowerCase();
            const cards = document.querySelectorAll('.faq-card');
            
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(filter) ? '' : 'none';
            });
        });

        // Filtro por servicio
        document.getElementById('servicioFilter').addEventListener('change', function() {
            const selectedServicio = this.value;
            const cards = document.querySelectorAll('.faq-card');
            
            cards.forEach(card => {
                if (selectedServicio === '' || card.dataset.servicio === selectedServicio) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });

        // Filtro por estado
        document.getElementById('estadoFilter').addEventListener('change', function() {
            const selectedEstado = this.value;
            const cards = document.querySelectorAll('.faq-card');
            
            cards.forEach(card => {
                if (selectedEstado === '' || card.dataset.estado === selectedEstado) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });

        // Limpiar filtros
        function clearFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('servicioFilter').value = '';
            document.getElementById('estadoFilter').value = '';
            
            const cards = document.querySelectorAll('.faq-card');
            cards.forEach(card => {
                card.style.display = '';
            });
        }

        // Confirmar eliminación
        function confirmarEliminacion(id, pregunta) {
            document.getElementById('faqPregunta').textContent = pregunta;
            document.getElementById('confirmarEliminar').href = 
                '${pageContext.request.contextPath}/admin/admin?action=delete&section=faq&id=' + id;
            
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }

        // Toggle estado
        function toggleEstado(id, estadoActual, pregunta) {
            const accion = estadoActual ? 'desactivar' : 'activar';
            document.getElementById('accionEstado').textContent = accion;
            document.getElementById('faqPreguntaToggle').textContent = pregunta;
            document.getElementById('confirmarToggle').href = 
                '${pageContext.request.contextPath}/admin/admin?action=toggle&section=faq&id=' + id;
            
            new bootstrap.Modal(document.getElementById('toggleModal')).show();
        }
    </script>
</body>
</html>