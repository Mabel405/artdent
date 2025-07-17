<%@ include file="layout/header.jsp" %>

<!-- Page Header -->
<section class="py-5 bg-primary text-white">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="display-5 fw-bold mb-3">Nosotros</h1>
                <p class="lead">Conoce m�s sobre ArtDent y nuestro compromiso con tu salud bucal</p>
            </div>
        </div>
    </div>
</section>

<!-- Nuestra Historia -->
<section class="py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-4 mb-lg-0">
                <h2 class="fw-bold text-primary mb-4">Nuestra Historia</h2>
                <p class="text-muted mb-3">
                    ArtDent naci� en 2015 con la visi�n de revolucionar la atenci�n dental en Lima. 
                    Fundada por un grupo de odont�logos especializados, nuestra cl�nica se ha convertido 
                    en un referente de calidad y excelencia en el cuidado bucal.
                </p>
                <p class="text-muted mb-3">
                    Durante estos a�os, hemos atendido a m�s de 10,000 pacientes, realizando tratamientos 
                    con los m�s altos est�ndares de calidad y utilizando tecnolog�a de vanguardia para 
                    garantizar los mejores resultados.
                </p>
                <p class="text-muted">
                    Nuestro compromiso va m�s all� de los tratamientos: creemos en la educaci�n preventiva 
                    y en construir relaciones duraderas con nuestros pacientes.
                </p>
            </div>
            <div class="col-lg-6">
                <img src="https://en.artdent.hu/wp-content/uploads/2017/01/Artdent-enterior-078.jpg" 
                     alt="Interior de ArtDent" class="img-fluid rounded-3 shadow">
            </div>
        </div>
    </div>
</section>

<!-- Misi�n, Visi�n y Valores -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body text-center p-4">
                        <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3" 
                             style="width: 80px; height: 80px;">
                            <i class="fas fa-bullseye text-primary fs-2"></i>
                        </div>
                        <h5 class="card-title text-primary fw-bold">Nuestra Misi�n</h5>
                        <p class="card-text text-muted">
                            Brindar servicios odontol�gicos de excelencia, utilizando tecnolog�a avanzada 
                            y un enfoque humanizado para mejorar la salud bucal y la calidad de vida de 
                            nuestros pacientes.
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mb-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body text-center p-4">
                        <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3" 
                             style="width: 80px; height: 80px;">
                            <i class="fas fa-eye text-primary fs-2"></i>
                        </div>
                        <h5 class="card-title text-primary fw-bold">Nuestra Visi�n</h5>
                        <p class="card-text text-muted">
                            Ser la cl�nica dental l�der en Lima, reconocida por nuestra innovaci�n, 
                            calidad de servicio y compromiso con la salud bucal integral de la comunidad.
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mb-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body text-center p-4">
                        <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3" 
                             style="width: 80px; height: 80px;">
                            <i class="fas fa-heart text-primary fs-2"></i>
                        </div>
                        <h5 class="card-title text-primary fw-bold">Nuestros Valores</h5>
                        <p class="card-text text-muted">
                            Excelencia, integridad, compromiso, innovaci�n y respeto. Estos valores 
                            gu�an cada una de nuestras acciones y decisiones en el cuidado de tu salud bucal.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Nuestro Equipo -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold text-primary">Nuestro Equipo</h2>
            <p class="text-muted">Profesionales altamente calificados comprometidos con tu bienestar</p>
        </div>
        
        <div class="row">
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/img/doctor1.jpg" 
                         class="card-img-top" alt="Dr. Mar�a Gonz�lez" style="height: 300px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h5 class="card-title text-primary">Dra. Mar�a Gonz�lez</h5>
                        <p class="text-muted mb-2">Directora General</p>
                        <p class="card-text small">
                            Especialista en Odontolog�a General con 15 a�os de experiencia. 
                            Graduada de la Universidad Nacional Mayor de San Marcos.
                        </p>
                        <div class="d-flex justify-content-center">
                            <a href="#" class="text-primary me-3"><i class="fab fa-linkedin"></i></a>
                            <a href="#" class="text-primary"><i class="fas fa-envelope"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/img/doctor2.jpg" 
                         class="card-img-top" alt="Dr. Carlos Mendoza" style="height: 300px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h5 class="card-title text-primary">Dr. Carlos Mendoza</h5>
                        <p class="text-muted mb-2">Especialista en Ortodoncia</p>
                        <p class="card-text small">
                            Ortodoncista certificado con especializaci�n en t�cnicas invisibles. 
                            M�s de 1000 casos exitosos en ortodoncia.
                        </p>
                        <div class="d-flex justify-content-center">
                            <a href="#" class="text-primary me-3"><i class="fab fa-linkedin"></i></a>
                            <a href="#" class="text-primary"><i class="fas fa-envelope"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/img/doctor3.jpg" 
                         class="card-img-top" alt="Dra. Ana Rodr�guez" style="height: 300px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h5 class="card-title text-primary">Dra. Ana Rodr�guez</h5>
                        <p class="text-muted mb-2">Especialista en Implantolog�a</p>
                        <p class="card-text small">
                            Cirujana oral especializada en implantes dentales y cirug�a reconstructiva. 
                            Certificada internacionalmente en t�cnicas avanzadas.
                        </p>
                        <div class="d-flex justify-content-center">
                            <a href="#" class="text-primary me-3"><i class="fab fa-linkedin"></i></a>
                            <a href="#" class="text-primary"><i class="fas fa-envelope"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Instalaciones -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold text-primary">Nuestras Instalaciones</h2>
            <p class="text-muted">Espacios modernos y c�modos dise�ados para tu bienestar</p>
        </div>
        
        <div class="row">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/img/sala-espera.jpg" 
                         class="card-img-top" alt="Sala de Espera" style="height: 200px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h6 class="card-title">Sala de Espera</h6>
                        <p class="card-text small text-muted">Ambiente c�modo y relajante para tu comodidad</p>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/img/consultorio.jpg" 
                         class="card-img-top" alt="Consultorio" style="height: 200px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h6 class="card-title">Consultorios</h6>
                        <p class="card-text small text-muted">Equipados con tecnolog�a de �ltima generaci�n</p>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/img/rayos-x.jpg" 
                         class="card-img-top" alt="Sala de Rayos X" style="height: 200px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h6 class="card-title">Sala de Rayos X</h6>
                        <p class="card-text small text-muted">Diagn�stico preciso con equipos digitales</p>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/img/esterilizacion.jpg" 
                         class="card-img-top" alt="�rea de Esterilizaci�n" style="height: 200px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h6 class="card-title">Esterilizaci�n</h6>
                        <p class="card-text small text-muted">M�ximos est�ndares de higiene y seguridad</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Certificaciones -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold text-primary">Certificaciones y Reconocimientos</h2>
            <p class="text-muted">Avalados por las principales instituciones del sector salud</p>
        </div>
        
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="row text-center">
                    <div class="col-md-3 mb-4">
                        <div class="p-3">
                            <i class="fas fa-certificate text-primary fs-1 mb-3"></i>
                            <h6>ISO 9001</h6>
                            <small class="text-muted">Gesti�n de Calidad</small>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="p-3">
                            <i class="fas fa-shield-alt text-primary fs-1 mb-3"></i>
                            <h6>MINSA</h6>
                            <small class="text-muted">Autorizaci�n Sanitaria</small>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="p-3">
                            <i class="fas fa-award text-primary fs-1 mb-3"></i>
                            <h6>COP Lima</h6>
                            <small class="text-muted">Colegio Odontol�gico</small>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="p-3">
                            <i class="fas fa-star text-primary fs-1 mb-3"></i>
                            <h6>5 Estrellas</h6>
                            <small class="text-muted">Calificaci�n Promedio</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="layout/footer.jsp" %>
