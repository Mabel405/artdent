<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso denegado - ArtDent</title>
    
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
            box-shadow: 0 25px 50px rgba(217, 119, 6, 0.1);
            padding: 3rem;
            text-align: center;
            max-width: 600px;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .error-number {
            font-size: 8rem;
            font-weight: 900;
            background: linear-gradient(135deg, var(--warning-color), #ea580c);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
            margin-bottom: 1rem;
        }
        
        .error-icon {
            font-size: 4rem;
            color: var(--warning-color);
            margin-bottom: 2rem;
            animation: pulse 2s infinite;
            filter: drop-shadow(0 4px 8px rgba(217, 119, 6, 0.2));
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .btn-primary-custom {
            background: linear-gradient(135deg, var(--warning-color), #ea580c);
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            color: white;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            margin: 0.5rem;
            box-shadow: 0 4px 12px rgba(217, 119, 6, 0.3);
        }
        
        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(217, 119, 6, 0.4);
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
        
        .alert-custom {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            border: 1px solid #f59e0b;
            border-radius: 12px;
            color: #92400e;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-card">
            <!-- Error Icon -->
            <div class="error-icon">
                <i class="fas fa-lock"></i>
            </div>
            
            <!-- Error Number -->
            <div class="error-number">403</div>
            
            <!-- Error Message -->
            <h2 class="mb-3" style="color: #1e293b; font-weight: 700;">¡Acceso Denegado!</h2>
            <p class="text-muted mb-4 fs-5">
                No tienes permisos para acceder a esta página o recurso.
            </p>
            
            <!-- Alert -->
            <div class="alert alert-custom" role="alert">
                <h6 class="alert-heading fw-bold">
                    <i class="fas fa-user-shield me-2"></i>
                    Información de Seguridad
                </h6>
                <p class="mb-0">
                    Esta página requiere permisos especiales. Si crees que deberías tener acceso, 
                    contacta al administrador del sistema.
                </p>
            </div>
            
            <!-- Action Buttons -->
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/login" class="btn-primary-custom">
                    <i class="fas fa-sign-in-alt me-2"></i>
                    Iniciar Sesión
                </a>
                <a href="${pageContext.request.contextPath}/" class="btn-primary-custom">
                    <i class="fas fa-home me-2"></i>
                    Ir al Inicio
                </a>
            </div>
            
            <div class="mt-3">
                <a href="mailto:admin@artdent.com" class="btn-secondary-custom">
                    <i class="fas fa-envelope me-2"></i>
                    Contactar Admin
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
</body>
</html>