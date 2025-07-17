<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/admin">
            <i class="fas fa-tooth me-2"></i>ArtDent Admin
        </a>
        
        <div class="navbar-nav ms-auto">
            <div class="nav-item dropdown">
                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" 
                   data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-user-circle me-2"></i>
                    <span>${sessionScope.usuario.nombre} ${sessionScope.usuario.apellido}</span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                        <h6 class="dropdown-header">
                            <i class="fas fa-user-shield me-1"></i>Administrador
                        </h6>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/inicio">
                            <i class="fas fa-globe me-2"></i>Ver Sitio Web
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/login?action=logout">
                            <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<!-- Mensajes de notificación -->
<c:if test="${not empty sessionScope.mensaje}">
    <div class="alert alert-${sessionScope.tipoMensaje == 'success' ? 'success' : 'danger'} alert-dismissible fade show m-3" role="alert">
        <i class="fas fa-${sessionScope.tipoMensaje == 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
        ${sessionScope.mensaje}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="mensaje" scope="session"/>
    <c:remove var="tipoMensaje" scope="session"/>
</c:if>
