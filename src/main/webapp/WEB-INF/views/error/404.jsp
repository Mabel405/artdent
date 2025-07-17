<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página no encontrada - ArtDent</title>
    
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
            box-shadow: 0 25px 50px rgba(37, 99, 235, 0.1);
            padding: 3rem;
            text-align: center;
            max-width: 600px;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .error-number {
            font-size: 8rem;
            font-weight: 900;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
            margin-bottom: 1rem;
            text-shadow: 0 4px 8px rgba(37, 99, 235, 0.1);
        }
        
        .error-icon {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 2rem;
            animation: bounce 2s infinite;
            filter: drop-shadow(0 4px 8px rgba(37, 99, 235, 0.2));
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }
        
        .btn-primary-custom {
            background: linear-gradient(135deg, var(--primary-color), #1d4ed8);
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            color: white;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            margin: 0.5rem;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }
        
        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.4);
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
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            border-radius: 16px;
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
            border: 1px solid #e2e8f0;
        }
        
        .breadcrumb-custom {
            background: transparent;
            padding: 0;
            margin-bottom: 2rem;
        }
        
        .breadcrumb-custom .breadcrumb-item {
            color: var(--secondary-color);
        }
        
        .breadcrumb-custom .breadcrumb-item.active {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .alert-custom {
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            border: 1px solid #93c5fd;
            border-radius: 12px;
            color: #1e40af;
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
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-card">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb breadcrumb-custom justify-content-center">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
                            <i class="fas fa-home me-1"></i>Inicio
                        </a>
                    </li>
                    <li class="breadcrumb-item active">Error 404</li>
                </ol>
            </nav>
            
            <!-- Error Icon -->
            <div class="error-icon">
                <i class="fas fa-search"></i>
            </div>
            
            <!-- Error Number -->
            <div class="error-number">404</div>
            
            <!-- Error Message -->
            <h2 class="mb-3" style="color: #1e293b; font-weight: 700;">¡Página no encontrada!</h2>
            <p class="text-muted mb-4 fs-5">
                La página que buscas no existe o ha sido movida a otra ubicación.
            </p>
            
            <!-- Error Details -->
            <div class="error-details">
                <h6 style="color: #1e293b;" class="mb-3">
                    <i class="fas fa-info-circle me-2" style="color: var(--primary-color);"></i>
                    Detalles del Error
                </h6>
                <div class="row text-start">
                    <div class="col-md-6 mb-3">
                        <small class="text-muted">
                            <strong>URL solicitada:</strong><br>
                            <div class="code-block mt-1">${pageContext.request.requestURL}</div>
                        </small>
                    </div>
                    <div class="col-md-6 mb-3">
                        <small class="text-muted">
                            <strong>Fecha y hora:</strong><br>
                            <fmt:formatDate value="<%= new java.util.Date() %>" 
                                          pattern="dd/MM/yyyy HH:mm:ss"/>
                        </small>
                    </div>
                </div>
                <div class="row text-start">
                    <div class="col-md-6">
                        <small class="text-muted">
                            <strong>Método:</strong> 
                            <span class="badge" style="background-color: var(--primary-color);">${pageContext.request.method}</span>
                        </small>
                    </div>
                    <div class="col-md-6">
                        <small class="text-muted">
                            <strong>Sesión ID:</strong><br>
                            <div class="code-block mt-1">${pageContext.session.id}</div>
                        </small>
                    </div>
                </div>
            </div>
            
            <!-- Suggestions -->
            <div class="alert alert-custom" role="alert">
                <h6 class="alert-heading fw-bold">
                    <i class="fas fa-lightbulb me-2"></i>
                    ¿Qué puedes hacer?
                </h6>
                <ul class="list-unstyled mb-0 text-start">
                    <li class="mb-1"><i class="fas fa-check me-2" style="color: var(--success-color);"></i>Verifica que la URL esté escrita correctamente</li>
                    <li class="mb-1"><i class="fas fa-check me-2" style="color: var(--success-color);"></i>Regresa a la página anterior</li>
                    <li class="mb-1"><i class="fas fa-check me-2" style="color: var(--success-color);"></i>Ve a la página principal</li>
                    <li><i class="fas fa-check me-2" style="color: var(--success-color);"></i>Contacta al administrador si persiste el error</li>
                </ul>
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
            </div>
            
            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-secondary-custom">
                    <i class="fas fa-tachometer-alt me-2"></i>
                    Dashboard
                </a>
                <a href="mailto:soporte@artdent.com" class="btn-secondary-custom">
                    <i class="fas fa-envelope me-2"></i>
                    Soporte
                </a>
            </div>
            
            <!-- Footer -->
            <div class="mt-4 pt-3 border-top">
                <small class="text-muted">
                    <i class="fas fa-shield-alt me-1" style="color: var(--primary-color);"></i>
                    ArtDent - Sistema de Gestión Dental
                </small>
            </div>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>