<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Sidebar -->
<nav class="sidebar">
    <div class="position-sticky pt-3">
        <div class="text-center mb-4 p-3">
            <h3 class="text-white mb-2">
                <i class="fas fa-tooth"></i> ArtDent
            </h3>
            <p class="text-white-50 mb-0 small">Panel de Secretaría</p>
        </div>

        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${param.activeMenu == 'dashboard' ? 'active' : ''}" href="secretaria">
                    <i class="fas fa-tachometer-alt"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeMenu == 'solicitudes' ? 'active' : ''}" href="secretaria?action=solicitudes">
                    <i class="fas fa-clipboard-list"></i>
                    Solicitudes
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeMenu == 'citas-hoy' ? 'active' : ''}" href="secretaria?action=citas-hoy">
                    <i class="fas fa-calendar-check"></i>
                    Citas de Hoy
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeMenu == 'calendario' ? 'active' : ''}" href="secretaria?action=calendario">
                    <i class="fas fa-calendar-alt"></i>
                    Calendario
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeMenu == 'historial' ? 'active' : ''}" href="secretaria?action=historial">
                    <i class="fas fa-history"></i>
                    Historial de Citas
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeMenu == 'reportes' ? 'active' : ''}" href="secretaria?action=reportes">
                    <i class="fas fa-chart-bar"></i>
                    Reportes
                </a>
            </li>
            <hr class="my-3">
            
            <li class="nav-item">
                <a class="nav-link text-muted" href="${pageContext.request.contextPath}/inicio">
                    <i class="fas fa-globe me-2"></i>Ver Sitio Web
                </a>
            </li>

            <li class="nav-item mt-3">
                <a class="nav-link text-danger" href="login?action=logout">
                    <i class="fas fa-sign-out-alt"></i>
                    Cerrar Sesión
                </a>
            </li>
        </ul>
    </div>
</nav>
