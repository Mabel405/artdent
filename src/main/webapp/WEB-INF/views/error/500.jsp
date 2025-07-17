<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error interno del servidor - ArtDent</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #64748b;
            --success-color: #059669;
            --warning-color: #d97706;
            --error-color: #dc2626;
            --bg-gradient-start: #f1f5f9;
            --bg-gradient-end: #e2e8f0;
        }
        
        body {
            background: linear-gradient(135deg, var(--bg-gradient-start) 0%, var(--bg-gradient-end) 100%);
            min-height: 100vh;
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .error-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        
        .error-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            box-shadow: 0 25px 50px rgba(220, 38, 38, 0.1);
            padding: 3rem;
            text-align: center;
            max-width: 700px;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .error-number {
            font-size: 8rem;
            font-weight: 900;
            background: linear-gradient(135deg, var(--error-color), #b91c1c);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
            margin-bottom: 1rem;
        }
        
        .error-icon {
            font-size: 4rem;
            color: var(--error-color);
            margin-bottom: 2rem;
            animation: shake 2s infinite;
            filter: drop-shadow(0 4px 8px rgba(220, 38, 38, 0.2));
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-3px); }
            20%, 40%, 60%, 80% { transform: translateX(3px); }
        }
        
        .btn-primary-custom {
            background: linear-gradient(135deg, var(--error-color), #b91c1c);
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            color: white;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            margin: 0.5rem;
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
        }
        
        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(220, 38, 38, 0.4);
            color: white;
        }
        
        .btn-secondary-custom {
            background: transparent;
            border: 2px solid var(--secondary-color);
            color: var(--secondary-color);
            border-radius: 12px;
            padding: 10px 22px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            margin: 0.5rem;
        }
        
        .btn-secondary-custom:hover {
            background: var(--secondary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(100, 116, 139, 0.3);
        }
        
        .error-details {
            background: linear-gradient(135deg, #fef2f2, #fee2e2);
            border-radius: 16px;
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
            border: 1px solid #fecaca;
        }
        
        .alert-custom {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            border: 1px solid #f59e0b;
            border-radius: 12px;
            color: #92400e;
        }
        
        .code-block {
            background: #1e293b;
            color: #e2e8f0;
            padding: 0.5rem 0.75rem;
            border-radius: 6px;
            font-family: 'JetBrains Mono', 'Fira Code', monospace;
            font-size: 0.875rem;
            word-break: break-all;
        }
        
        .stack-trace {
            background: #1e293b;
            color: #e2e8f0;
            padding: 1rem;
            border-radius: 8px;
            font-family: 'JetBrains Mono', 'Fira Code', monospace;
            font-size: 0.8rem;
            max-height: 200px;
            overflow-y: auto;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-card">
            <!-- Error Icon -->
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            
            <!-- Error Number -->
            <div class="error-number">500</div>
            
            <!-- Error Message -->
            <h2 class="mb-3" style="color: #1e293b; font-weight: 700;">¡Error interno del servidor!</h2>
            <p class="text-muted mb-4 fs-5">
                Ha ocurrido un error inesperado. Nuestro equipo técnico ha sido notificado.
            </p>
            
            <!-- Error Details -->
            <div class="error-details">
                <h6 style="color: #1e293b;" class="mb-3">
                    <i class="fas fa-bug me-2" style="color: var(--error-color);"></i>
                    Información del Error
                </h6>
                <div class="row text-start">
                    <div class="col-md-6 mb-3">
                        <small class="text-muted">
                            <strong>Fecha y hora:</strong><br>
                            <fmt:formatDate value="<%= new java.util.Date() %>" 
                                          pattern="dd/MM/yyyy HH:mm:ss"/>
                        </small>
                    </div>
                    <div class="col-md-6 mb-3">
                        <small class="text-muted">
                            <strong>ID de sesión:</strong><br>
                            <div class="code-block mt-1">${pageContext.session.id}</div>
                        </small>
                    </div>
                </div>
                
                <c:if test="${not empty pageContext.exception}">
                    <div class="mt-3">
                        <small class="text-muted">
                            <strong>Tipo de excepción:</strong><br>
                            <div class="code-block mt-1">${pageContext.exception.class.simpleName}</div>
                        </small>
                    </div>
                    
                    <c:if test="${not empty pageContext.exception.message}">
                        <div class="mt-2">
                            <small class="text-muted">
                                <strong>Mensaje:</strong><br>
                                <span style="color: var(--error-color); font-weight: 500;">${pageContext.exception.message}</span>
                            </small>
                        </div>
                    </c:if>
                </c:if>
            </div>
            
            <!-- Alert -->
            <div class="alert alert-custom" role="alert">
                <h6 class="alert-heading fw-bold">
                    <i class="fas fa-tools me-2"></i>
                    ¿Qué está pasando?
                </h6>
                <p class="mb-0">
                    El servidor encontró una situación inesperada. Este error ha sido registrado 
                    automáticamente y será revisado por nuestro equipo técnico.
                </p>
            </div>
            
            <!-- Action Buttons -->
            <div class="mt-4">
                <a href="javascript:history.back()" class="btn-primary-custom">
                    <i class="fas fa-arrow-left me-2"></i>
                    Página Anterior
                </a>
                <a href="${pageContext.request.contextPath}/" class="btn-primary-custom">
                    <i class="fas fa-home me-2"></i>
                    Ir al Inicio
                </a>
                <button onclick="location.reload()" class="btn-primary-custom">
                    <i class="fas fa-redo me-2"></i>
                    Intentar de Nuevo
                </button>
            </div>
            
            <!-- Support Contact -->
            <div class="mt-4 p-3 rounded" style="background: linear-gradient(135deg, #f8fafc, #f1f5f9); border: 1px solid #e2e8f0;">
                <h6 style="color: #1e293b;">
                    <i class="fas fa-headset me-2" style="color: var(--primary-color);"></i>
                    ¿Necesitas ayuda inmediata?
                </h6>
                <p class="mb-2 small text-muted">
                    Si este error persiste, contacta a nuestro equipo de soporte:
                </p>
                <div>
                    <a href="mailto:soporte@artdent.com" class="btn-secondary-custom">
                        <i class="fas fa-envelope me-1"></i>
                        soporte@artdent.com
                    </a>
                    <a href="tel:+51999999999" class="btn-secondary-custom">
                        <i class="fas fa-phone me-1"></i>
                        +51 999 999 999
                    </a>
                </div>
            </div>
            
            <!-- Footer -->
            <div class="mt-4 pt-3 border-top">
                <small class="text-muted">
                    <i class="fas fa-shield-alt me-1" style="color: var(--primary-color);"></i>
                    ArtDent - Sistema de Gestión Dental | Error ID: ${pageContext.session.id}
                </small>
            </div>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Reportar error automáticamente
        function reportError() {
            const errorData = {
                url: window.location.href,
                userAgent: navigator.userAgent,
                timestamp: new Date().toISOString(),
                sessionId: '${pageContext.session.id}',
                exception: '${pageContext.exception.class.simpleName}',
                message: '${pageContext.exception.message}'
            };
            
            console.log('Error reportado:', errorData);
        }
        
        document.addEventListener('DOMContentLoaded', reportError);
    </script>
</body>
</html>