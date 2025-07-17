<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Editar' : 'Nueva'} FAQ - ArtDent</title>
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
                        <i class="fas fa-question-circle me-2 text-warning"></i>
                        ${isEdit ? 'Editar' : 'Nueva'} FAQ
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/admin?action=list&section=faq" 
                           class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i>Volver
                        </a>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="card shadow">
                            <div class="card-header bg-warning text-dark">
                                <h5 class="mb-0">
                                    <i class="fas fa-question me-2"></i>
                                    Información de la FAQ
                                </h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/admin" method="post" id="faqForm">
                                    <input type="hidden" name="action" value="${isEdit ? 'update' : 'create'}">
                                    <input type="hidden" name="section" value="faq">
                                    <c:if test="${isEdit}">
                                        <input type="hidden" name="id" value="${faq.idFaq}">
                                    </c:if>

                                    <div class="mb-4">
                                        <label for="pregunta" class="form-label">
                                            <i class="fas fa-question me-1"></i>Pregunta *
                                        </label>
                                        <input type="text" class="form-control" id="pregunta" name="pregunta" 
                                               value="${faq.pregunta}" required maxlength="255"
                                               placeholder="¿Cuál es la pregunta frecuente?">
                                        <div class="form-text">
                                            Escriba la pregunta de manera clara y concisa (máximo 255 caracteres).
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label for="respuesta" class="form-label">
                                            <i class="fas fa-reply me-1"></i>Respuesta *
                                        </label>
                                        <textarea class="form-control" id="respuesta" name="respuesta" 
                                                  rows="5" required maxlength="1000"
                                                  placeholder="Proporcione una respuesta completa y útil...">${faq.respuesta}</textarea>
                                        <div class="form-text">
                                            Respuesta detallada que ayude a resolver la duda del usuario (máximo 1000 caracteres).
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="servicioId" class="form-label">
                                                <i class="fas fa-stethoscope me-1"></i>Servicio Relacionado
                                            </label>
                                            <select class="form-select" id="servicioId" name="servicioId">
                                                <option value="">Pregunta general (no específica de un servicio)</option>
                                                <c:forEach var="servicio" items="${servicios}">
                                                    <option value="${servicio.idServicio}" 
                                                            ${faq.servicioIdServicio != null && faq.servicioIdServicio == servicio.idServicio ? 'selected' : ''}>
                                                        ${servicio.tipoServicio}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <div class="form-text">
                                                Seleccione un servicio si la FAQ es específica para ese servicio.
                                            </div>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <label for="prioridad" class="form-label">
                                                <i class="fas fa-star me-1"></i>Prioridad *
                                            </label>
                                            <select class="form-select" id="prioridad" name="prioridad" required>
                                                <option value="1" ${faq.prioridad == 1 ? 'selected' : ''}>1 - Baja</option>
                                                <option value="2" ${faq.prioridad == 2 ? 'selected' : ''}>2 - Normal</option>
                                                <option value="3" ${faq.prioridad == 3 ? 'selected' : ''}>3 - Alta</option>
                                                <option value="4" ${faq.prioridad == 4 ? 'selected' : ''}>4 - Muy Alta</option>
                                                <option value="5" ${faq.prioridad == 5 ? 'selected' : ''}>5 - Crítica</option>
                                            </select>
                                            <div class="form-text">
                                                Mayor prioridad = aparece primero.
                                            </div>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-toggle-on me-1"></i>Estado
                                            </label>
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="activo" name="activo" 
                                                       ${isEdit ? (faq.activo ? 'checked' : '') : 'checked'}>
                                                <label class="form-check-label" for="activo">
                                                    <span id="estadoLabel">${isEdit ? (faq.activo ? 'Activo' : 'Inactivo') : 'Activo'}</span>
                                                </label>
                                            </div>
                                            <div class="form-text">
                                                Solo las FAQs activas se muestran al público.
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Vista previa de la FAQ -->
                                    <div class="card bg-light mb-4">
                                        <div class="card-header">
                                            <h6 class="mb-0">
                                                <i class="fas fa-eye me-1"></i>Vista Previa de la FAQ
                                            </h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="accordion" id="previewAccordion">
                                                <div class="accordion-item">
                                                    <h2 class="accordion-header">
                                                        <button class="accordion-button collapsed" type="button" 
                                                                data-bs-toggle="collapse" data-bs-target="#previewCollapse">
                                                            <i class="fas fa-question-circle me-2 text-warning"></i>
                                                            <span id="previewPregunta">
                                                                ${not empty faq.pregunta ? faq.pregunta : 'La pregunta aparecerá aquí...'}
                                                            </span>
                                                        </button>
                                                    </h2>
                                                    <div id="previewCollapse" class="accordion-collapse collapse">
                                                        <div class="accordion-body">
                                                            <div class="d-flex align-items-start">
                                                                <i class="fas fa-reply text-primary me-2 mt-1"></i>
                                                                <div>
                                                                    <p class="mb-0" id="previewRespuesta">
                                                                        ${not empty faq.respuesta ? faq.respuesta : 'La respuesta se mostrará aquí...'}
                                                                    </p>
                                                                    <div class="mt-2">
                                                                        <small class="text-muted">
                                                                            <span class="badge bg-info me-1" id="previewServicio">
                                                                                <c:choose>
                                                                                    <c:when test="${faq.servicioIdServicio != null}">
                                                                                        <c:forEach var="servicio" items="${servicios}">
                                                                                            <c:if test="${servicio.idServicio == faq.servicioIdServicio}">
                                                                                                ${servicio.tipoServicio}
                                                                                            </c:if>
                                                                                        </c:forEach>
                                                                                    </c:when>
                                                                                    <c:otherwise>General</c:otherwise>
                                                                                </c:choose>
                                                                            </span>
                                                                            <span class="badge bg-warning text-dark" id="previewPrioridad">
                                                                                Prioridad: ${not empty faq.prioridad ? faq.prioridad : '2'}
                                                                            </span>
                                                                        </small>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/admin/admin?action=list&section=faq" 
                                           class="btn btn-secondary me-md-2">
                                            <i class="fas fa-times me-1"></i>Cancelar
                                        </a>
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-save me-1"></i>
                                            ${isEdit ? 'Actualizar' : 'Crear'} FAQ
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
        document.getElementById('pregunta').addEventListener('input', function() {
            document.getElementById('previewPregunta').textContent = 
                this.value || 'La pregunta aparecerá aquí...';
        });

        document.getElementById('respuesta').addEventListener('input', function() {
            document.getElementById('previewRespuesta').textContent = 
                this.value || 'La respuesta se mostrará aquí...';
        });

        document.getElementById('servicioId').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const servicioText = selectedOption.value ? selectedOption.text : 'General';
            document.getElementById('previewServicio').textContent = servicioText;
        });

        document.getElementById('prioridad').addEventListener('change', function() {
            document.getElementById('previewPrioridad').textContent = 'Prioridad: ' + this.value;
        });

        // Toggle estado label
        document.getElementById('activo').addEventListener('change', function() {
            document.getElementById('estadoLabel').textContent = this.checked ? 'Activo' : 'Inactivo';
        });

        // Contador de caracteres
        function setupCharCounter(fieldId, maxLength) {
            const field = document.getElementById(fieldId);
            const counter = document.createElement('div');
            counter.className = 'form-text text-end';
            counter.style.fontSize = '0.8em';
            field.parentNode.appendChild(counter);
            
            function updateCounter() {
                const remaining = maxLength - field.value.length;
                counter.textContent = `${field.value.length}/${maxLength} caracteres`;
                counter.className = remaining < 50 ? 'form-text text-end text-warning' : 'form-text text-end text-muted';
            }
            
            field.addEventListener('input', updateCounter);
            updateCounter();
        }

        // Aplicar contadores
        setupCharCounter('pregunta', 255);
        setupCharCounter('respuesta', 1000);

        // Validación del formulario
        document.getElementById('faqForm').addEventListener('submit', function(e) {
            const pregunta = document.getElementById('pregunta').value.trim();
            const respuesta = document.getElementById('respuesta').value.trim();
            
            if (pregunta.length < 10) {
                e.preventDefault();
                alert('La pregunta debe tener al menos 10 caracteres');
                document.getElementById('pregunta').focus();
                return;
            }
            
            if (respuesta.length < 20) {
                e.preventDefault();
                alert('La respuesta debe tener al menos 20 caracteres');
                document.getElementById('respuesta').focus();
                return;
            }
        });

        // Auto-resize textarea
        document.getElementById('respuesta').addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });
    </script>
</body>
</html>