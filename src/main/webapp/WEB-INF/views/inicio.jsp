<%@ include file="layout/header.jsp" %>

<!-- Hero Section -->
<section class="hero-section bg-gradient-primary text-white py-5" style="background-image: url('https://saluddata.com/wp-content/uploads/2024/07/Diseno-de-un-consultorio-dental.webp');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;">
    <div class="container">
        <div class="row align-items-center min-vh-75">
            <div class="col-lg-6">
                <h1 class="display-4 fw-bold mb-4">Tu Sonrisa es Nuestra Pasión</h1>
                <p class="lead mb-4">En ArtDent ofrecemos servicios dentales de calidad con tecnología de vanguardia y un equipo profesional comprometido con tu bienestar y salud bucal.</p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="${pageContext.request.contextPath}/reserva?action=nueva" class="btn btn-light btn-lg px-4">
                        <i class="fas fa-calendar-plus me-2"></i>Reservar Cita
                    </a>
                    <a href="${pageContext.request.contextPath}/servicios" class="btn btn-outline-light btn-lg px-4">
                        <i class="fas fa-stethoscope me-2"></i>Ver Servicios
                    </a>
                </div>
            </div>
            <div class="col-lg-6 text-center">
                <img src="https://clinicadental-globo.com/wp-content/uploads/2020/11/odontologo.jpg" alt="Clínica Dental ArtDent" class="img-fluid rounded-3 shadow-lg">
            </div>
        </div>
    </div>
</section>

<!-- Características Principales -->
<section class="py-5">
    <div class="container">
        <div class="row text-center">
            <!-- Tarjeta 1 -->
            <div class="col-lg-4 mb-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body p-4">
                        <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                             style="width: 80px; height: 80px; overflow: hidden;">
                            <img src="https://cdn-icons-png.flaticon.com/512/12061/12061912.png" alt="Profesionales" style="width: 60%; height: auto;">
                        </div>
                        <h5 class="card-title">Profesionales Expertos</h5>
                        <p class="card-text text-muted">Nuestro equipo está formado por odontólogos especializados con años de experiencia y formación continua.</p>
                    </div>
                </div>
            </div>
            <!-- Tarjeta 2 -->
            <div class="col-lg-4 mb-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body p-4">
                        <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                             style="width: 80px; height: 80px; overflow: hidden;">
                            <img src="https://cdn-icons-png.flaticon.com/512/2111/2111125.png" alt="Tecnología" style="width: 60%; height: auto;">
                        </div>
                        <h5 class="card-title">Tecnología Avanzada</h5>
                        <p class="card-text text-muted">Utilizamos equipos de última generación para brindarte tratamientos precisos y cómodos.</p>
                    </div>
                </div>
            </div>
            <!-- Tarjeta 3 -->
            <div class="col-lg-4 mb-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body p-4">
                        <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                             style="width: 80px; height: 80px; overflow: hidden;">
                            <img src="https://cdn-icons-png.freepik.com/256/12772/12772096.png?semt=ais_hybrid" alt="Atención Personalizada" style="width: 60%; height: auto;">
                        </div>
                        <h5 class="card-title">Atención Personalizada</h5>
                        <p class="card-text text-muted">Cada paciente es único, por eso adaptamos nuestros tratamientos a tus necesidades específicas.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


<!-- Servicios Destacados -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold">Nuestros Servicios Destacados</h2>
            <p class="text-muted">Ofrecemos una amplia gama de servicios dentales para cuidar tu salud bucal</p>
        </div>
        
        <div class="row">
            <c:forEach var="servicio" items="${serviciosDestacados}" varStatus="status">
                <div class="col-lg-4 mb-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="${servicio.img}" class="card-img-top" alt="${servicio.tipoServicio}" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title text-primary">${servicio.tipoServicio}</h5>
                            <p class="card-text text-muted small">${servicio.lema}</p>
                            <p class="card-text">${servicio.descripcion}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-primary fw-bold fs-5">S/ ${servicio.costo}</span>
                                <a href="${pageContext.request.contextPath}/servicios?action=detalle&id=${servicio.idServicio}" class="btn btn-outline-primary btn-sm">Ver Más</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/servicios" class="btn btn-primary btn-lg">
                <i class="fas fa-eye me-2"></i>Ver Todos los Servicios
            </a>
        </div>
    </div>
</section>

<!-- Call to Action -->
<section class="py-5 bg-primary text-white">
    <div class="container text-center">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <h2 class="fw-bold mb-3">¿Listo para Mejorar tu Sonrisa?</h2>
                <p class="lead mb-4">Agenda tu cita hoy mismo y descubre por qué somos la clínica dental de confianza en Lima.</p>
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <a href="${pageContext.request.contextPath}/reserva?action=nueva" class="btn btn-light btn-lg px-4">
                        <i class="fas fa-calendar-plus me-2"></i>Reservar Cita Ahora
                    </a>
                    <a href="tel:+51999888777" class="btn btn-outline-light btn-lg px-4">
                        <i class="fas fa-phone me-2"></i>Llamar Ahora
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="layout/footer.jsp" %>
