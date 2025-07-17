<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.pageTitle} - ArtDent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2563eb;
            --primary-dark: #1d4ed8;
            --secondary-color: #64748b;
            --success-color: #059669;
            --warning-color: #d97706;
            --danger-color: #dc2626;
            --light-bg: #f8fafc;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --border-radius: 12px;
        }

        * {
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--light-bg);
            color: #1e293b;
        }

        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            position: fixed;
            top: 0;
            left: 0;
            width: 280px;
            z-index: 1000;
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
        }

        .sidebar .nav-link {
            color: rgba(255,255,255,0.85);
            padding: 16px 24px;
            border-radius: var(--border-radius);
            margin: 6px 16px;
            transition: all 0.3s ease;
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background: rgba(255,255,255,0.15);
            color: white;
            transform: translateX(8px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .sidebar .nav-link i {
            width: 20px;
            margin-right: 12px;
        }

        .main-content {
            margin-left: 280px;
            background-color: var(--light-bg);
            min-height: 100vh;
            padding: 24px;
        }

        .page-header {
            background: white;
            border-radius: var(--border-radius);
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: var(--card-shadow);
            border-left: 4px solid var(--primary-color);
        }

        .page-title {
            color: #1e293b;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .stats-badge {
            background: linear-gradient(135deg, var(--warning-color), #f59e0b);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .filter-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: var(--card-shadow);
            border: 1px solid #e2e8f0;
        }

        .solicitud-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            margin-bottom: 24px;
        }

        .solicitud-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .card-header-custom {
            background: linear-gradient(135deg, var(--warning-color), #f59e0b);
            color: white;
            padding: 16px 20px;
            border-bottom: none;
        }

        .card-header-custom h6 {
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .status-badge {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .card-body-custom {
            padding: 20px;
        }

        .info-item {
            margin-bottom: 16px;
            padding: 12px;
            background: #f8fafc;
            border-radius: 8px;
            border-left: 3px solid var(--primary-color);
        }

        .info-label {
            font-weight: 600;
            color: var(--secondary-color);
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .info-value {
            color: #1e293b;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .patient-name {
            color: var(--primary-color);
            font-weight: 600;
        }

        .service-name {
            color: var(--success-color);
            font-weight: 600;
        }

        .doctor-name {
            color: #7c3aed;
            font-weight: 600;
        }

        .token-code {
            background: #f1f5f9;
            padding: 6px 12px;
            border-radius: 6px;
            font-family: 'Courier New', monospace;
            font-size: 0.9rem;
            color: var(--secondary-color);
            border: 1px solid #e2e8f0;
        }

        .card-footer-custom {
            background: #f8fafc;
            padding: 16px 20px;
            border-top: 1px solid #e2e8f0;
        }

        .btn-action {
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success-color), #10b981);
            color: white;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #047857, var(--success-color));
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(5, 150, 105, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger-color), #ef4444);
            color: white;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #b91c1c, var(--danger-color));
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.4);
        }

        .btn-info {
            background: linear-gradient(135deg, #0ea5e9, #3b82f6);
            color: white;
        }

        .btn-info:hover {
            background: linear-gradient(135deg, #0284c7, #2563eb);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(14, 165, 233, 0.4);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            border: none;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--primary-dark), #1e40af);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.4);
        }

        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #d1d5db;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--success-color);
            margin-bottom: 20px;
        }

        .empty-state h4 {
            color: #1e293b;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .empty-state p {
            color: var(--secondary-color);
            margin-bottom: 24px;
        }

        .modal-content {
            border-radius: var(--border-radius);
            border: none;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            border-bottom: 1px solid #e2e8f0;
            padding: 20px 24px;
        }

        .modal-body {
            padding: 24px;
        }

        .modal-footer {
            border-top: 1px solid #e2e8f0;
            padding: 16px 24px;
        }

        .loading-spinner {
            display: none;
            text-align: center;
            padding: 20px;
        }

        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
                padding: 16px;
            }
            
            .solicitud-card {
                margin-bottom: 16px;
            }
            
            .btn-action {
                width: 100%;
                margin-bottom: 8px;
            }
        }
    </style>
</head>
