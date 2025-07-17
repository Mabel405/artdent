<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ArtDent - Clínica Dental</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <style>
        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 14px;
        }
        
        /* FORZAR la visibilidad del dropdown */
        .user-dropdown {
            min-width: 250px !important;
            z-index: 9999 !important;
            position: absolute !important;
            top: 100% !important;
            right: 0 !important;
            background: white !important;
            border: 1px solid rgba(0,0,0,.15) !important;
            border-radius: 0.375rem !important;
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,.175) !important;
            padding: 0.5rem 0 !important;
            margin: 0.125rem 0 0 !important;
        }
        
        /* Asegurar que el dropdown sea visible cuando esté activo */
        .dropdown-menu.show {
            display: block !important;
            opacity: 1 !important;
            visibility: visible !important;
            transform: none !important;
        }
        
        /* Contenedor del dropdown */
        .dropdown {
            position: relative !important;
        }
        
        .user-info {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 8px;
        }
        
        .role-badge {
            font-size: 0.75rem;
            padding: 2px 8px;
            border-radius: 12px;
        }
        
        .navbar-user-section {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .notification-badge {
            position: relative;
            top: -2px;
            right: -2px;
            background: #dc3545;
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .user-status-indicator {
            width: 8px;
            height: 8px;
            background: #28a745;
            border-radius: 50%;
            position: absolute;
            bottom: 0;
            right: 0;
            border: 2px solid white;
        }
        
        /* Navbar con z-index menor para que el dropdown aparezca encima */
        .navbar {
            z-index: 1040 !important;
        }
        
        /* Asegurar que el dropdown funcione correctamente */
        .dropdown-toggle::after {
            margin-left: 0.5em;
        }
        
        /* Estilos adicionales para los items del dropdown */
        .dropdown-item {
            padding: 0.5rem 1rem !important;
            color: #212529 !important;
            text-decoration: none !important;
            background-color: transparent !important;
            border: 0 !important;
            display: block !important;
            width: 100% !important;
            clear: both !important;
            font-weight: 400 !important;
            line-height: 1.5 !important;
            white-space: nowrap !important;
        }
        
        .dropdown-item:hover,
        .dropdown-item:focus {
            background-color: #f8f9fa !important;
            color: #1e2125 !important;
        }
        
        .dropdown-divider {
            height: 0 !important;
            margin: 0.5rem 0 !important;
            overflow: hidden !important;
            border-top: 1px solid #dee2e6 !important;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/inicio">
                <i class="fas fa-tooth text-primary me-2 fs-3"></i>
                <span class="fw-bold text-primary fs-4">ArtDent</span>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/inicio">
                            <i class="fas fa-home me-1"></i>Inicio
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/servicios">
                            <i class="fas fa-stethoscope me-1"></i>Servicios
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/reserva?action=consultar">
                            <i class="fas fa-calendar-check me-1"></i>Consultar Cita
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/nosotros">
                            <i class="fas fa-users me-1"></i>Nosotros
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/faq">
                            <i class="fas fa-question-circle me-1"></i>FAQ
                        </a>
                    </li>
                </ul>
                
                <!-- Sección de usuario dinámico -->
                <div class="navbar-user-section">
                    <!-- Botón de reservar cita (siempre visible) -->
                    <a href="${pageContext.request.contextPath}/reserva?action=nueva" class="btn btn-primary me-2">
                        <i class="fas fa-calendar-plus me-1"></i>Reservar Cita
                    </a>
                    
                    <!-- Verificar si hay usuario en sesión -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.usuario}">
                            <!-- Usuario logueado -->
                            
                            <!-- Notificaciones (SOLO para administrador) -->
                            <c:if test="${sessionScope.usuario.rolIdRol == 1}">
                                <div class="position-relative me-2">
                                    <a href="${pageContext.request.contextPath}/admin/notificaciones" 
                                       class="btn btn-outline-secondary btn-sm position-relative"
                                       title="Notificaciones">
                                        <i class="fas fa-bell"></i>
                                        <!-- Badge de notificaciones -->
                                        <span class="notification-badge" id="notificationCount" style="display: none;">0</span>
                                    </a>
                                </div>
                            </c:if>
                            
                            <!-- Dropdown del usuario -->
                            <div class="dropdown">
                                <button class="btn btn-outline-primary dropdown-toggle d-flex align-items-center" 
                                        type="button" 
                                        id="userDropdown" 
                                        data-bs-toggle="dropdown" 
                                        aria-expanded="false"
                                        data-bs-auto-close="outside">
                                    <!-- Avatar del usuario con indicador de estado -->
                                    <div class="user-avatar me-2 position-relative">
                                        ${sessionScope.usuario.nombre.substring(0,1).toUpperCase()}${sessionScope.usuario.apellido.substring(0,1).toUpperCase()}
                                        <div class="user-status-indicator"></div>
                                    </div>
                                    <span class="d-none d-md-inline">
                                        ${sessionScope.usuario.nombre} ${sessionScope.usuario.apellido}
                                    </span>
                                </button>
                                
                                <ul class="dropdown-menu dropdown-menu-end user-dropdown" aria-labelledby="userDropdown">
                                    <!-- Información del usuario -->
                                    <li>
                                        <div class="user-info">
                                            <div class="fw-bold text-dark">
                                                ${sessionScope.usuario.nombre} ${sessionScope.usuario.apellido}
                                            </div>
                                            <div class="small text-muted">${sessionScope.usuario.correoElectronico}</div>
                                            <div class="mt-1">
                                                <c:choose>
                                                    <c:when test="${sessionScope.usuario.rolIdRol == 1}">
                                                        <span class="role-badge bg-danger text-white">
                                                            <i class="fas fa-crown me-1"></i>Administrador
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${sessionScope.usuario.rolIdRol == 2}">
                                                        <span class="role-badge bg-info text-white">
                                                            <i class="fas fa-user-tie me-1"></i>Secretaria
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${sessionScope.usuario.rolIdRol == 3}">
                                                        <span class="role-badge bg-success text-white">
                                                            <i class="fas fa-user-md me-1"></i>Odontólogo
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="role-badge bg-secondary text-white">
                                                            <i class="fas fa-user me-1"></i>Usuario
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </li>
                                    
                                    <li><hr class="dropdown-divider"></li>
                                    
                                    <!-- Enlaces específicos por rol -->
                                    <c:choose>
                                        <c:when test="${sessionScope.usuario.rolIdRol == 1}">
                                            <!-- Administrador - Tiene acceso a AMBOS paneles -->
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/admin">
                                                    <i class="fas fa-crown me-2 text-danger"></i>Panel Administrador
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/secretaria">
                                                    <i class="fas fa-user-tie me-2 text-info"></i>Panel Secretaria
                                                </a>
                                            </li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/admin?action=list&section=usuarios">
                                                    <i class="fas fa-users me-2 text-info"></i>Gestionar Usuarios
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/reportes">
                                                    <i class="fas fa-chart-bar me-2 text-success"></i>Reportes
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/notificaciones">
                                                    <i class="fas fa-bell me-2 text-warning"></i>Notificaciones
                                                    <c:if test="${not empty sessionScope.notificacionesUrgentes && sessionScope.notificacionesUrgentes > 0}">
                                                        <span class="badge bg-danger ms-1">${sessionScope.notificacionesUrgentes}</span>
                                                    </c:if>
                                                </a>
                                            </li>
                                        </c:when>
                                        
                                        <c:when test="${sessionScope.usuario.rolIdRol == 2}">
                                            <!-- Secretaria - Solo acceso a su panel -->
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/secretaria">
                                                    <i class="fas fa-user-tie me-2 text-info"></i>Panel Secretaria
                                                </a>
                                            </li>
                                            <li><hr class="dropdown-divider"></li>
                                            
                                        </c:when>
                                        
                                        <c:when test="${sessionScope.usuario.rolIdRol == 3}">
                                            <!-- Odontólogo -->
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/odontologo/dashboard">
                                                    <i class="fas fa-tachometer-alt me-2 text-primary"></i>Mi Panel
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/odontologo/citas">
                                                    <i class="fas fa-calendar-check me-2 text-info"></i>Mis Citas
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/odontologo/pacientes">
                                                    <i class="fas fa-user-injured me-2 text-success"></i>Mis Pacientes
                                                </a>
                                            </li>
                                        </c:when>
                                    </c:choose>
                                    
                                    <li><hr class="dropdown-divider"></li>
                                    
                                    <!-- Cerrar sesión -->
                                    <li>
                                        <a class="dropdown-item text-danger" href="#" onclick="confirmarCerrarSesion()">
                                            <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </c:when>
                        
                        <c:otherwise>
                            <!-- Usuario no logueado -->
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary">
                                <i class="fas fa-sign-in-alt me-1"></i>Iniciar Sesión
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
    
    <!-- Espaciado para navbar fijo -->
    <div style="height: 80px;"></div>
    
    <!-- Modal de confirmación para cerrar sesión -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="logoutModalLabel">
                        <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <i class="fas fa-question-circle fa-3x text-warning mb-3"></i>
                    <p class="mb-0">¿Estás seguro de que deseas cerrar sesión?</p>
                    <small class="text-muted">Se perderán los datos no guardados</small>
                </div>
                <div class="modal-footer justify-content-center">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Cancelar
                    </button>
                    <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-danger">
                        <i class="fas fa-sign-out-alt me-1"></i>Cerrar Sesión
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Toast Container -->
    <div id="toastContainer" class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;"></div>
    
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Inicializar todos los dropdowns manualmente
        document.addEventListener('DOMContentLoaded', function() {
            // Inicializar dropdowns
            var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
            var dropdownList = dropdownElementList.map(function (dropdownToggleEl) {
                return new bootstrap.Dropdown(dropdownToggleEl);
            });
            
            // Debug: Verificar si el dropdown se inicializa
            console.log('Dropdowns inicializados:', dropdownList.length);
            
            // Agregar event listener para debug
            const userDropdown = document.getElementById('userDropdown');
            if (userDropdown) {
                userDropdown.addEventListener('click', function(e) {
                    console.log('Dropdown clickeado');
                    
                    // FORZAR la visibilidad del dropdown si no aparece
                    setTimeout(() => {
                        const dropdownMenu = userDropdown.nextElementSibling;
                        if (dropdownMenu && !dropdownMenu.classList.contains('show')) {
                            console.log('Forzando visibilidad del dropdown');
                            dropdownMenu.classList.add('show');
                            dropdownMenu.style.display = 'block';
                            dropdownMenu.style.position = 'absolute';
                            dropdownMenu.style.top = '100%';
                            dropdownMenu.style.right = '0';
                            dropdownMenu.style.zIndex = '9999';
                        }
                    }, 100);
                });
                
                userDropdown.addEventListener('show.bs.dropdown', function () {
                    console.log('Dropdown mostrándose');
                });
                
                userDropdown.addEventListener('shown.bs.dropdown', function () {
                    console.log('Dropdown mostrado');
                    
                    // Asegurar que el dropdown sea visible
                    const dropdownMenu = userDropdown.nextElementSibling;
                    if (dropdownMenu) {
                        dropdownMenu.style.display = 'block !important';
                        dropdownMenu.style.opacity = '1';
                        dropdownMenu.style.visibility = 'visible';
                        dropdownMenu.style.zIndex = '9999';
                        console.log('Dropdown forzado a ser visible');
                    }
                });
                
                userDropdown.addEventListener('hide.bs.dropdown', function () {
                    console.log('Dropdown ocultándose');
                });
            }
        });
        
        // Función alternativa para mostrar/ocultar dropdown manualmente
        function toggleUserDropdown() {
            const userDropdown = document.getElementById('userDropdown');
            const dropdownMenu = userDropdown.nextElementSibling;
            
            if (dropdownMenu.classList.contains('show')) {
                dropdownMenu.classList.remove('show');
                dropdownMenu.style.display = 'none';
            } else {
                dropdownMenu.classList.add('show');
                dropdownMenu.style.display = 'block';
                dropdownMenu.style.position = 'absolute';
                dropdownMenu.style.top = '100%';
                dropdownMenu.style.right = '0';
                dropdownMenu.style.zIndex = '9999';
            }
        }
        
        // Función para confirmar cerrar sesión
        function confirmarCerrarSesion() {
            const modal = new bootstrap.Modal(document.getElementById('logoutModal'));
            modal.show();
        }
        
        // Cargar contador de notificaciones (SOLO para administrador)
        <c:if test="${sessionScope.usuario.rolIdRol == 1}">
        function cargarNotificaciones() {
            fetch('${pageContext.request.contextPath}/admin/notificaciones?action=count')
                .then(response => response.json())
                .then(data => {
                    const badge = document.getElementById('notificationCount');
                    if (data.urgentes > 0) {
                        badge.textContent = data.urgentes > 99 ? '99+' : data.urgentes;
                        badge.style.display = 'flex';
                        badge.classList.add('animate__animated', 'animate__pulse');
                    } else {
                        badge.style.display = 'none';
                    }
                })
                .catch(error => console.log('Error al cargar notificaciones:', error));
        }
        
        // Cargar notificaciones al inicio y cada 30 segundos
        document.addEventListener('DOMContentLoaded', function() {
            cargarNotificaciones();
            setInterval(cargarNotificaciones, 30000);
        });
        </c:if>
        
        // Función para mostrar toast
        function mostrarToast(mensaje, tipo = 'info') {
            const toastContainer = document.getElementById('toastContainer');
            
            const iconos = {
                'success': 'fas fa-check-circle',
                'error': 'fas fa-exclamation-circle',
                'warning': 'fas fa-exclamation-triangle',
                'info': 'fas fa-info-circle'
            };
            
            const toast = document.createElement('div');
            toast.className = `toast align-items-center text-white bg-${tipo} border-0`;
            toast.setAttribute('role', 'alert');
            toast.innerHTML = `
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="${iconos[tipo]} me-2"></i>${mensaje}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            `;
            
            toastContainer.appendChild(toast);
            
            const bsToast = new bootstrap.Toast(toast, {
                autohide: true,
                delay: 4000
            });
            bsToast.show();
            
            // Remover el toast después de que se oculte
            toast.addEventListener('hidden.bs.toast', function() {
                if (toastContainer.contains(toast)) {
                    toastContainer.removeChild(toast);
                }
            });
        }
        
        // Función para actualizar el estado del usuario (opcional)
        function actualizarEstadoUsuario() {
            const indicator = document.querySelector('.user-status-indicator');
            if (indicator) {
                indicator.style.background = '#28a745';
            }
        }
        
        // Actualizar estado cada minuto
        <c:if test="${not empty sessionScope.usuario}">
        setInterval(actualizarEstadoUsuario, 60000);
        </c:if>
        
        // Cerrar dropdown al hacer clic fuera
        document.addEventListener('click', function(event) {
            const dropdown = document.querySelector('.dropdown');
            const dropdownMenu = document.querySelector('.user-dropdown');
            
            if (dropdown && dropdownMenu && !dropdown.contains(event.target)) {
                dropdownMenu.classList.remove('show');
                dropdownMenu.style.display = 'none';
            }
        });
    </script>
</body>
</html>