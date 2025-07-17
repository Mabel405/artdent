<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="col-md-3 col-lg-2 d-md-block bg-white sidebar border-end shadow-sm">
    <div class="position-sticky pt-3">
        <div class="text-center mb-4">
            <i class="fas fa-user-shield fa-3x text-primary mb-2"></i>
            <h6 class="text-primary fw-bold">Panel Admin</h6>
        </div>
        
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${param.page == 'dashboard' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/admin">
                    <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                </a>
            </li>
            
            <!-- NUEVA SECCIÓN DE NOTIFICACIONES -->
            <li class="nav-item">
                <a class="nav-link ${param.page == 'notificaciones' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/notificaciones">
                    <i class="fas fa-bell me-2"></i>Notificaciones
                    <span class="badge bg-danger ms-2" id="sidebarNotifBadge" style="display: none;">0</span>
                    <span class="badge bg-warning ms-1" id="sidebarUrgenteBadge" style="display: none;" title="Urgentes">
                        <i class="fas fa-exclamation-triangle" style="font-size: 0.7rem;"></i>
                    </span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link ${param.page == 'usuarios' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/admin?action=list&section=usuarios">
                    <i class="fas fa-users me-2"></i>Usuarios
                    <span class="badge bg-info ms-2">${totalUsuarios}</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link ${param.page == 'pacientes' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/admin?action=list&section=pacientes">
                    <i class="fas fa-user-injured me-2"></i>Pacientes
                    <span class="badge bg-success ms-2">${totalPacientes}</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link ${param.page == 'servicios' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/admin?action=list&section=servicios">
                    <i class="fas fa-stethoscope me-2"></i>Servicios
                    <span class="badge bg-primary ms-2">${totalServicios}</span>
                </a>
            </li>
            
            <!-- SECCIÓN DE ESPECIALIZACIONES -->
            <li class="nav-item">
                <a class="nav-link ${param.page == 'especializaciones' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/admin?action=list&section=especializaciones">
                    <i class="fas fa-user-md me-2"></i>Especializaciones
                    <span class="badge bg-secondary ms-2">
                        <i class="fas fa-link"></i>
                    </span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link ${param.page == 'faq' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/admin?action=list&section=faq">
                    <i class="fas fa-question-circle me-2"></i>FAQ
                    <span class="badge bg-warning ms-2">${totalFAQs}</span>
                </a>
            </li>
            
            <hr class="my-3">
            
            <li class="nav-item">
                <a class="nav-link text-muted" href="${pageContext.request.contextPath}/inicio">
                    <i class="fas fa-globe me-2"></i>Ver Sitio Web
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link text-danger" href="${pageContext.request.contextPath}/login?action=logout">
                    <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión
                </a>
            </li>
        </ul>
    </div>
</nav>

<style>
.sidebar .nav-link {
    color: #495057;
    padding: 0.75rem 1rem;
    border-radius: 0.375rem;
    margin-bottom: 0.25rem;
    transition: all 0.2s ease;
    position: relative;
}

.sidebar .nav-link:hover {
    background-color: #f8f9fa;
    color: #0d6efd;
}

.sidebar .nav-link.active {
    background-color: #0d6efd;
    color: white;
}

.sidebar .nav-link.active .badge {
    background-color: rgba(255,255,255,0.2) !important;
}

/* Animación para notificaciones urgentes */
@keyframes pulse-sidebar {
    0% { transform: scale(1); }
    50% { transform: scale(1.1); }
    100% { transform: scale(1); }
}

.sidebar .nav-link .badge.pulse {
    animation: pulse-sidebar 2s infinite;
}

/* Indicador especial para notificaciones */
.sidebar .nav-link[href*="notificaciones"] {
    position: relative;
}

.sidebar .nav-link[href*="notificaciones"]::after {
    content: '';
    position: absolute;
    top: 50%;
    right: 8px;
    width: 8px;
    height: 8px;
    background-color: #dc3545;
    border-radius: 50%;
    transform: translateY(-50%);
    display: none;
}

.sidebar .nav-link[href*="notificaciones"].has-urgent::after {
    display: block;
    animation: pulse-sidebar 2s infinite;
}
</style>

<script>
// Script para actualizar badges de notificaciones en el sidebar
document.addEventListener('DOMContentLoaded', function() {
    actualizarBadgesSidebar();
    
    // Actualizar cada 2 minutos
    setInterval(actualizarBadgesSidebar, 120000);
});

function actualizarBadgesSidebar() {
    fetch('${pageContext.request.contextPath}/admin/notificaciones?action=api')
        .then(response => response.json())
        .then(data => {
            const badge = document.getElementById('sidebarNotifBadge');
            const urgenteBadge = document.getElementById('sidebarUrgenteBadge');
            const notifLink = document.querySelector('a[href*="notificaciones"]');
            
            if (data.count > 0) {
                badge.textContent = data.count > 99 ? '99+' : data.count;
                badge.style.display = 'inline';
                
                if (data.urgentes > 0) {
                    urgenteBadge.style.display = 'inline';
                    badge.classList.add('pulse');
                    notifLink.classList.add('has-urgent');
                } else {
                    urgenteBadge.style.display = 'none';
                    badge.classList.remove('pulse');
                    notifLink.classList.remove('has-urgent');
                }
            } else {
                badge.style.display = 'none';
                urgenteBadge.style.display = 'none';
                badge.classList.remove('pulse');
                notifLink.classList.remove('has-urgent');
            }
        })
        .catch(error => {
            console.error('Error al actualizar badges del sidebar:', error);
        });
}

// Función para marcar notificaciones como vistas cuando se hace clic
document.querySelector('a[href*="notificaciones"]')?.addEventListener('click', function() {
    // Opcional: marcar como vistas al hacer clic
    setTimeout(() => {
        const badge = document.getElementById('sidebarNotifBadge');
        const urgenteBadge = document.getElementById('sidebarUrgenteBadge');
        
        if (badge) badge.classList.remove('pulse');
        if (urgenteBadge) urgenteBadge.style.display = 'none';
        this.classList.remove('has-urgent');
    }, 1000);
});
</script>