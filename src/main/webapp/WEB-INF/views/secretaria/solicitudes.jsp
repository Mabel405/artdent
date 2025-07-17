<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">

<jsp:include page="layout/header.jsp">
    <jsp:param name="pageTitle" value="Solicitudes de Reserva" />
</jsp:include>

<body>
    <jsp:include page="layout/sidebar.jsp">
        <jsp:param name="activeMenu" value="solicitudes" />
    </jsp:include>

    <!-- Main content -->
    <main class="main-content">
        <!-- Header -->
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="page-title">
                    <i class="fas fa-clipboard-list"></i>
                    Solicitudes de Reserva
                </h1>
                <div class="stats-badge">
                    <i class="fas fa-clock me-2"></i>
                    ${reservasPendientes.size()} solicitudes pendientes
                </div>
            </div>
        </div>

        <!-- Filtros -->
        <div class="filter-card">
            <h5 class="mb-3">
                <i class="fas fa-filter me-2"></i>
                Filtros de Búsqueda
            </h5>
            <form method="GET" action="secretaria" id="filtroForm">
                <input type="hidden" name="action" value="solicitudes">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">
                            <i class="fas fa-calendar me-1"></i>
                            Filtrar por fecha:
                        </label>
                        <input type="date" class="form-control" name="fecha" value="${filtroFecha}">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search me-1"></i>
                            Buscar
                        </button>
                        <a href="secretaria?action=solicitudes" class="btn btn-outline-secondary ms-2">
                            <i class="fas fa-times me-1"></i>
                            Limpiar filtros
                        </a>
                    </div>
                </div>
            </form>
        </div>

        <!-- Lista de Solicitudes (Diseño Compacto) -->
        <div class="solicitudes-container" id="listaSolicitudes">
            <c:choose>
                <c:when test="${not empty reservasPendientes}">
                    <c:forEach var="reserva" items="${reservasPendientes}">
                        <div class="solicitud-item-compact fade-in mb-3">
                            <div class="solicitud-header-compact">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="solicitud-title-compact">
                                        <i class="fas fa-file-alt me-2"></i>
                                        Solicitud #${reserva.idReserva}
                                    </h6>
                                    <span class="status-badge-compact">${reserva.estadoTexto}</span>
                                </div>
                            </div>
                            
                            <div class="solicitud-body-compact">
                                <!-- Fecha y hora destacada -->
                                <div class="info-highlight-compact mb-3">
                                    <i class="fas fa-calendar-day me-2"></i>
                                    <strong>
                                        <fmt:formatDate value="${reserva.diaReserva}" pattern="EEEE, dd 'de' MMMM 'de' yyyy"/>
                                        • 
                                        <fmt:formatDate value="${reserva.horaReserva}" pattern="HH:mm"/>
                                    </strong>
                                </div>
                                
                                <!-- Información en grid compacto -->
                                <div class="row g-3">
                                    <div class="col-md-3">
                                        <div class="info-item-compact">
                                            <div class="info-label-compact">
                                                <i class="fas fa-user me-1"></i>
                                                PACIENTE
                                            </div>
                                            <div class="info-value-compact">
                                                ${reserva.nombreCompletoPaciente}
                                                <small class="text-muted d-block">(ID: ${reserva.pacienteIdPaciente})</small>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="info-item-compact">
                                            <div class="info-label-compact">
                                                <i class="fas fa-tooth me-1"></i>
                                                SERVICIO
                                            </div>
                                            <div class="info-value-compact">
                                                ${reserva.nombreServicio}
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="info-item-compact">
                                            <div class="info-label-compact">
                                                <i class="fas fa-user-md me-1"></i>
                                                ODONTÓLOGO
                                            </div>
                                            <div class="info-value-compact">
                                                ${reserva.nombreCompletoOdontologo}
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="info-item-compact">
                                            <div class="info-label-compact">
                                                <i class="fas fa-key me-1"></i>
                                                TOKEN CLIENTE
                                            </div>
                                            <div class="token-display-compact">
                                                ${reserva.tokenCliente}
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Descripción si existe -->
                                <c:if test="${not empty reserva.descripcion}">
                                    <div class="row mt-3">
                                        <div class="col-12">
                                            <div class="info-item-compact">
                                                <div class="info-label-compact">
                                                    <i class="fas fa-comment me-1"></i>
                                                    DESCRIPCIÓN
                                                </div>
                                                <div class="info-value-compact">
                                                    <em class="text-muted">${reserva.descripcion}</em>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            
                            <div class="solicitud-actions-compact">
                                <a href="secretaria?action=detalle&idReserva=${reserva.idReserva}" 
                                   class="btn btn-info btn-sm">
                                    <i class="fas fa-eye me-1"></i>
                                    Ver Detalles
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-check-circle"></i>
                        <h4>¡Excelente trabajo!</h4>
                        <p class="text-muted">
                            <c:choose>
                                <c:when test="${not empty filtroFecha}">
                                    No se encontraron solicitudes que coincidan con los filtros aplicados.
                                </c:when>
                                <c:otherwise>
                                    No hay solicitudes pendientes en este momento.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="secretaria" class="btn btn-primary">
                            <i class="fas fa-arrow-left me-1"></i>
                            Volver al Dashboard
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        .solicitud-item-compact {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .solicitud-item-compact:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .solicitud-header-compact {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: white;
            padding: 12px 16px;
        }

        .solicitud-title-compact {
            margin: 0;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .status-badge-compact {
            background: rgba(255,255,255,0.2);
            padding: 2px 8px;
            border-radius: 8px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .solicitud-body-compact {
            padding: 16px;
        }

        .info-highlight-compact {
            background: #f8fafc;
            padding: 8px 12px;
            border-radius: 6px;
            border-left: 3px solid #2563eb;
            font-size: 0.9rem;
            color: #2563eb;
        }

        .info-item-compact {
            margin-bottom: 8px;
        }

        .info-label-compact {
            color: #64748b;
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 2px;
        }

        .info-value-compact {
            color: #1e293b;
            font-weight: 500;
            font-size: 0.85rem;
            line-height: 1.3;
        }

        .token-display-compact {
            background: #f1f5f9;
            padding: 4px 8px;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            font-size: 0.75rem;
            color: #475569;
            border: 1px solid #e2e8f0;
            word-break: break-all;
        }

        .solicitud-actions-compact {
            padding: 12px 16px;
            background: #f8fafc;
            border-top: 1px solid #e2e8f0;
            text-align: right;
        }

        .fade-in {
            opacity: 0;
            transform: translateY(10px);
            animation: fadeInUp 0.4s ease forwards;
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            border: 1px solid #e2e8f0;
        }

        .empty-state i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .solicitud-actions-compact {
                text-align: center;
            }
            
            .info-highlight-compact {
                font-size: 0.8rem;
            }
        }
    </style>

    <script>
        // Animación de entrada para las tarjetas
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.solicitud-item-compact');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.animationDelay = `${index * 0.1}s`;
                }, 100);
            });
        });

        // Auto-refresh cada 5 minutos
        setTimeout(function () {
            location.reload();
        }, 300000);
    </script>
</body>
</html>
