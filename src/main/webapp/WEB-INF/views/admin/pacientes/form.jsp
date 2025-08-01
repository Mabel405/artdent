<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Editar' : 'Nuevo'} Paciente - ArtDent</title>
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
                        <i class="fas fa-user-injured me-2 text-success"></i>
                        ${isEdit ? 'Editar' : 'Nuevo'} Paciente
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/admin?action=list&section=pacientes" 
                           class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-1"></i>Volver
                        </a>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="card shadow">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-user-circle me-2"></i>
                                    Información del Paciente
                                </h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/admin" method="post" id="pacienteForm">
                                    <input type="hidden" name="action" value="${isEdit ? 'update' : 'create'}">
                                    <input type="hidden" name="section" value="pacientes">
                                    <c:if test="${isEdit}">
                                        <input type="hidden" name="id" value="${paciente.idPaciente}">
                                    </c:if>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="nombre" class="form-label">
                                                <i class="fas fa-user me-1"></i>Nombre *
                                            </label>
                                            <input type="text" class="form-control" id="nombre" name="nombre" 
                                                   value="${paciente.nombre}" required maxlength="50">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="apellido" class="form-label">
                                                <i class="fas fa-user me-1"></i>Apellido *
                                            </label>
                                            <input type="text" class="form-control" id="apellido" name="apellido" 
                                                   value="${paciente.apellido}" required maxlength="50">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="dni" class="form-label">
                                                <i class="fas fa-id-card me-1"></i>DNI *
                                            </label>
                                            <input type="text" class="form-control" id="dni" name="dni" 
                                                   value="${paciente.dni}" required pattern="[0-9]{8}" maxlength="8"
                                                   title="Debe contener exactamente 8 dígitos">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="telefono" class="form-label">
                                                <i class="fas fa-phone me-1"></i>Teléfono *
                                            </label>
                                            <input type="text" class="form-control" id="telefono" name="telefono" 
                                                   value="${paciente.telefono}" required pattern="[0-9]{9}" maxlength="9"
                                                   title="Debe contener exactamente 9 dígitos">
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label for="correo" class="form-label">
                                            <i class="fas fa-envelope me-1"></i>Correo Electrónico *
                                        </label>
                                        <input type="email" class="form-control" id="correo" name="correo" 
                                               value="${paciente.correo}" required maxlength="100">
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/admin/admin?action=list&section=pacientes" 
                                           class="btn btn-secondary me-md-2">
                                            <i class="fas fa-times me-1"></i>Cancelar
                                        </a>
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-save me-1"></i>
                                            ${isEdit ? 'Actualizar' : 'Crear'} Paciente
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
        // Validación del formulario
        document.getElementById('pacienteForm').addEventListener('submit', function(e) {
            const dni = document.getElementById('dni').value;
            const telefono = document.getElementById('telefono').value;
            
            // Validar DNI
            if (!/^\d{8}$/.test(dni)) {
                e.preventDefault();
                alert('El DNI debe contener exactamente 8 dígitos');
                document.getElementById('dni').focus();
                return;
            }
            
            // Validar teléfono
            if (!/^\d{9}$/.test(telefono)) {
                e.preventDefault();
                alert('El teléfono debe contener exactamente 9 dígitos');
                document.getElementById('telefono').focus();
                return;
            }
        });

        // Solo números para DNI y teléfono
        document.getElementById('dni').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });

        document.getElementById('telefono').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    </script>
</body>
</html>
