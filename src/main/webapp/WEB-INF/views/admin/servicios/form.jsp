<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Editar' : 'Nuevo'} Servicio - ArtDent</title>
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
                        <i class="fas fa-stethoscope me-2 text-info"></i>
                        ${isEdit ? 'Editar' : 'Nuevo'} Servicio
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/admin?action=list&section=servicios" 
                           class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i>Volver
                        </a>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="card shadow">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-tooth me-2"></i>
                                    Información del Servicio
                                </h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/admin" method="post" id="servicioForm">
                                    <input type="hidden" name="action" value="${isEdit ? 'update' : 'create'}">
                                    <input type="hidden" name="section" value="servicios">
                                    <c:if test="${isEdit}">
                                        <input type="hidden" name="id" value="${servicio.idServicio}">
                                    </c:if>

                                    <div class="row">
                                        <div class="col-md-8 mb-3">
                                            <label for="tipoServicio" class="form-label">
                                                <i class="fas fa-stethoscope me-1"></i>Tipo de Servicio *
                                            </label>
                                            <input type="text" class="form-control" id="tipoServicio" name="tipoServicio" 
                                                   value="${servicio.tipoServicio}" required maxlength="255"
                                                   placeholder="Ej: Limpieza Dental, Ortodoncia, Implantes...">
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="costo" class="form-label">
                                                <i class="fas fa-dollar-sign me-1"></i>Costo (S/) *
                                            </label>
                                            <div class="input-group">
                                                <span class="input-group-text">S/</span>
                                                <input type="number" class="form-control" id="costo" name="costo" 
                                                       value="${servicio.costo}" required min="0" step="0.01" max="9999.99"
                                                       placeholder="0.00">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="lema" class="form-label">
                                            <i class="fas fa-quote-left me-1"></i>Lema o Frase Promocional *
                                        </label>
                                        <input type="text" class="form-control" id="lema" name="lema" 
                                               value="${servicio.lema}" required maxlength="255"
                                               placeholder="Frase corta y atractiva para promocionar el servicio">
                                        <div class="form-text">
                                            Frase que aparecerá como subtítulo del servicio (máximo 255 caracteres).
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="descripcion" class="form-label">
                                            <i class="fas fa-align-left me-1"></i>Descripción del Servicio *
                                        </label>
                                        <textarea class="form-control" id="descripcion" name="descripcion" 
                                                  rows="4" required maxlength="1000"
                                                  placeholder="Descripción detallada del servicio, beneficios, procedimientos...">${servicio.descripcion}</textarea>
                                        <div class="form-text">
                                            Descripción que verán los pacientes en el sitio web (máximo 1000 caracteres).
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="respuesta" class="form-label">
                                            <i class="fas fa-info-circle me-1"></i>Información Adicional
                                        </label>
                                        <textarea class="form-control" id="respuesta" name="respuesta" 
                                                  rows="3" maxlength="1000"
                                                  placeholder="Información adicional, recomendaciones, cuidados post-tratamiento...">${servicio.respuesta}</textarea>
                                        <div class="form-text">
                                            Información complementaria o respuestas a preguntas frecuentes sobre el servicio.
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label for="img" class="form-label">
                                            <i class="fas fa-image me-1"></i>URL de la Imagen
                                        </label>
                                        <input type="url" class="form-control" id="img" name="img" 
                                               value="${servicio.img}" maxlength="500"
                                               placeholder="https://ejemplo.com/imagen-servicio.jpg">
                                        <div class="form-text">
                                            URL de la imagen representativa del servicio. Debe ser una URL válida.
                                        </div>
                                        
                                        <!-- Vista previa de la imagen -->
                                        <div class="mt-3" id="imagePreview" style="display: none;">
                                            <label class="form-label">Vista previa:</label>
                                            <div class="border rounded p-2 bg-light" style="max-width: 300px;">
                                                <img id="previewImg" src="/placeholder.svg" alt="Vista previa" 
                                                     class="img-fluid rounded" style="max-height: 200px;">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Resumen del servicio -->
                                    <div class="card bg-light mb-4">
                                        <div class="card-header">
                                            <h6 class="mb-0">
                                                <i class="fas fa-eye me-1"></i>Vista Previa del Servicio
                                            </h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <h5 class="text-info" id="previewTipo">
                                                        ${not empty servicio.tipoServicio ? servicio.tipoServicio : 'Nombre del Servicio'}
                                                    </h5>
                                                    <p class="text-muted small" id="previewLema">
                                                        ${not empty servicio.lema ? servicio.lema : 'Lema del servicio aparecerá aquí'}
                                                    </p>
                                                    <p id="previewDescripcion">
                                                        ${not empty servicio.descripcion ? servicio.descripcion : 'La descripción del servicio se mostrará aquí...'}
                                                    </p>
                                                </div>
                                                <div class="col-md-4 text-end">
                                                    <span class="h4 text-success" id="previewCosto">
                                                        S/ ${not empty servicio.costo ? servicio.costo : '0.00'}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/admin/admin?action=list&section=servicios" 
                                           class="btn btn-secondary me-md-2">
                                            <i class="fas fa-times me-1"></i>Cancelar
                                        </a>
                                        <button type="submit" class="btn btn-info">
                                            <i class="fas fa-save me-1"></i>
                                            ${isEdit ? 'Actualizar' : 'Crear'} Servicio
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
        // Vista previa de imagen
        document.getElementById('img').addEventListener('input', function() {
            const url = this.value;
            const preview = document.getElementById('imagePreview');
            const previewImg = document.getElementById('previewImg');
            
            if (url && isValidUrl(url)) {
                previewImg.src = url;
                previewImg.onload = function() {
                    preview.style.display = 'block';
                };
                previewImg.onerror = function() {
                    preview.style.display = 'none';
                };
            } else {
                preview.style.display = 'none';
            }
        });

        // Validar URL
        function isValidUrl(string) {
            try {
                new URL(string);
                return true;
            } catch (_) {
                return false;
            }
        }

        // Vista previa en tiempo real
        document.getElementById('tipoServicio').addEventListener('input', function() {
            document.getElementById('previewTipo').textContent = this.value || 'Nombre del Servicio';
        });

        document.getElementById('lema').addEventListener('input', function() {
            document.getElementById('previewLema').textContent = this.value || 'Lema del servicio aparecerá aquí';
        });

        document.getElementById('descripcion').addEventListener('input', function() {
            document.getElementById('previewDescripcion').textContent = this.value || 'La descripción del servicio se mostrará aquí...';
        });

        document.getElementById('costo').addEventListener('input', function() {
            const valor = parseFloat(this.value) || 0;
            document.getElementById('previewCosto').textContent = 'S/ ' + valor.toFixed(2);
        });

        // Validación del formulario
        document.getElementById('servicioForm').addEventListener('submit', function(e) {
            const costo = parseFloat(document.getElementById('costo').value);
            
            // Validar costo
            if (isNaN(costo) || costo < 0) {
                e.preventDefault();
                alert('El costo debe ser un número válido mayor o igual a 0');
                document.getElementById('costo').focus();
                return;
            }
            
            if (costo > 9999.99) {
                e.preventDefault();
                alert('El costo no puede ser mayor a S/ 9,999.99');
                document.getElementById('costo').focus();
                return;
            }

            // Validar URL de imagen si se proporciona
            const imgUrl = document.getElementById('img').value;
            if (imgUrl && !isValidUrl(imgUrl)) {
                e.preventDefault();
                alert('La URL de la imagen no es válida');
                document.getElementById('img').focus();
                return;
            }
        });

        // Formatear costo al perder el foco
        document.getElementById('costo').addEventListener('blur', function() {
            const valor = parseFloat(this.value);
            if (!isNaN(valor)) {
                this.value = valor.toFixed(2);
            }
        });

        // Contador de caracteres para campos de texto largo
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

        // Aplicar contadores de caracteres
        setupCharCounter('descripcion', 1000);
        setupCharCounter('respuesta', 1000);
        setupCharCounter('lema', 255);

        // Cargar vista previa de imagen existente al cargar la página
        window.addEventListener('load', function() {
            const imgInput = document.getElementById('img');
            if (imgInput.value) {
                imgInput.dispatchEvent(new Event('input'));
            }
        });
    </script>
</body>
</html>