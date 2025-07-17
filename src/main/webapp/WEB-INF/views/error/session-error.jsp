<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sesión expirada - ArtDent</title>
    
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
            max-width: 500px;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .error-icon {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 2rem;
            animation: fadeInOut 3s infinite;
            filter: drop-shadow(0 4px 8px rgba(37, 99, 235, 0.2));
        }
        
        @keyframes fadeInOut {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
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
        
        .alert-custom {
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            border: 1px solid #93c5fd;
            border-radius: 12px;
            color: #1e40af;
        }
        
        .countdown {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--primary-color);
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-card">
            <!-- Error Icon -->
            <div class="error-icon">
                <i class="fas fa-clock"></i>
            </div>
            
            <!-- Error Message -->
            <h2 class="mb-3" style="color: #1e293b; font-weight: 700;">¡Sesión Expirada!</h2>
            <p class="text-muted mb-4">
                Tu sesión ha expirado por seguridad. Por favor, inicia sesión nuevamente.
            </p>
            
            <!-- Alert -->
            <div class="alert alert-custom" role="alert">
                <i class="fas fa-info-circle me-2"></i>
                Las sesiones expiran automáticamente después de un período de inactividad para proteger tu información.
            </div>
            
            <!-- Countdown -->
            <div class="countdown mb-4">
                <i class="fas fa-hourglass-half me-2"></i>
                Redirección automática en <span id="countdown">10</span> segundos
            </div>
            
            <!-- Action Buttons -->
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/login" class="btn-primary-custom">
                    <i class="fas fa-sign-in-alt me-2"></i>
                    Iniciar Sesión Ahora
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
    
    <script>
        // Auto-redirect al login después de 10 segundos
        let countdown = 10;
        const countdownElement = document.getElementById('countdown');
        
        const timer = setInterval(() => {
            countdown--;
            countdownElement.textContent = countdown;
            
            if (countdown <= 0) {
                clearInterval(timer);
                window.location.href = '${pageContext.request.contextPath}/login';
            }
        }, 1000);
    </script>
</body>
</html>