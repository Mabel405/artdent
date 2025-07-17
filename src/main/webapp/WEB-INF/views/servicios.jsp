<%@ include file="layout/header.jsp" %>

<!-- Page Header -->
<section class="py-5 bg-primary text-white">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="display-5 fw-bold mb-3">Nuestros Servicios</h1>
                <p class="lead">Descubre nuestra amplia gama de tratamientos dentales especializados</p>
            </div>
        </div>
    </div>
</section>

<!-- Servicios Grid -->
<section class="py-5">
    <div class="container">
        <div class="row">
            <c:forEach var="servicio" items="${servicios}" varStatus="status">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100 border-0 shadow-sm hover-card">
                        <img src="${servicio.img}" class="card-img-top" alt="${servicio.tipoServicio}" style="height: 250px; object-fit: cover;">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title text-primary fw-bold">${servicio.tipoServicio}</h5>
                            <p class="card-text text-muted small mb-2">${servicio.lema}</p>
                            <p class="card-text flex-grow-1">${servicio.descripcion}</p>
                            <div class="mt-auto">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="text-primary fw-bold fs-4">S/ ${servicio.costo}</span>
                                    <span class="badge bg-primary">Disponible</span>
                                </div>
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/servicios?action=detalle&id=${servicio.idServicio}" class="btn btn-outline-primary">
                                        <i class="fas fa-info-circle me-2"></i>Ver Detalles
                                    </a>
                                    <a href="${pageContext.request.contextPath}/reserva?action=nueva&servicio=${servicio.idServicio}" class="btn btn-primary">
                                        <i class="fas fa-calendar-plus me-2"></i>Reservar Cita
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <c:if test="${empty servicios}">
            <div class="row">
                <div class="col-12 text-center py-5">
                    <i class="fas fa-tooth text-muted" style="font-size: 4rem;"></i>
                    <h3 class="text-muted mt-3">No hay servicios disponibles</h3>
                    <p class="text-muted">Pronto tendremos más servicios disponibles para ti.</p>
                </div>
            </div>
        </c:if>
    </div>
</section>

<!-- Información Adicional -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 mx-auto text-center">
                <h2 class="fw-bold mb-4">¿Por qué elegir ArtDent?</h2>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <div class="d-flex flex-column align-items-center">
                            <div class="bg-primary bg-opacity-10 rounded-circle p-3 mb-3">
                                <i class="fas fa-award text-primary fs-3"></i>
                            </div>
                            <h6 class="fw-bold">Calidad Garantizada</h6>
                            <p class="text-muted small">Todos nuestros tratamientos cuentan con garantía</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="d-flex flex-column align-items-center">
                            <div class="bg-primary bg-opacity-10 rounded-circle p-3 mb-3">
                                <i class="fas fa-clock text-primary fs-3"></i>
                            </div>
                            <h6 class="fw-bold">Horarios Flexibles</h6>
                            <p class="text-muted small">Nos adaptamos a tu disponibilidad</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="d-flex flex-column align-items-center">
                            <div class="bg-primary bg-opacity-10 rounded-circle p-3 mb-3">
                                <i class="fas fa-credit-card text-primary fs-3"></i>
                            </div>
                            <h6 class="fw-bold">Facilidades de Pago</h6>
                            <p class="text-muted small">Múltiples opciones de financiamiento</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="layout/footer.jsp" %>
