<%@ include file="layout/header.jsp" %>

<!-- Page Header -->
<section class="py-4 bg-primary text-white">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="display-6 fw-bold mb-2">Preguntas Frecuentes</h1>
                <p class="lead">Encuentra respuestas a las preguntas más comunes</p>
            </div>
        </div>
    </div>
</section>

<!-- Filtros -->
<section class="py-4 bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <form method="get" action="${pageContext.request.contextPath}/faq">
                            <div class="row align-items-end">
                                <div class="col-md-8 mb-3 mb-md-0">
                                    <label for="servicio" class="form-label">Filtrar por Servicio</label>
                                    <select class="form-select" id="servicio" name="servicio">
                                        <option value="">Todas las preguntas</option>
                                        <c:forEach var="servicio" items="${servicios}">
                                            <option value="${servicio.idServicio}" 
                                                    ${param.servicio == servicio.idServicio ? 'selected' : ''}>
                                                ${servicio.tipoServicio}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="fas fa-filter me-2"></i>Filtrar
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FAQ Content -->
<section class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <c:if test="${not empty faqs}">
                    <div class="accordion" id="faqAccordion">
                        <c:forEach var="faq" items="${faqs}" varStatus="status">
                            <div class="accordion-item border-0 shadow-sm mb-3">
                                <h2 class="accordion-header" id="heading${faq.idFaq}">
                                    <button class="accordion-button ${status.index != 0 ? 'collapsed' : ''}" type="button" 
                                            data-bs-toggle="collapse" data-bs-target="#collapse${faq.idFaq}" 
                                            aria-expanded="${status.index == 0 ? 'true' : 'false'}" 
                                            aria-controls="collapse${faq.idFaq}">
                                        <i class="fas fa-question-circle text-primary me-3"></i>
                                        <span class="fw-semibold">${faq.pregunta}</span>
                                    </button>
                                </h2>
                                <div id="collapse${faq.idFaq}" 
                                     class="accordion-collapse collapse ${status.index == 0 ? 'show' : ''}" 
                                     aria-labelledby="heading${faq.idFaq}" 
                                     data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        <div class="d-flex">
                                            <i class="fas fa-comment-dots text-primary me-3 mt-1"></i>
                                            <div>
                                                <p class="mb-0">${faq.respuesta}</p>
                                                <c:if test="${faq.prioridad > 3}">
                                                    <span class="badge bg-warning mt-2">Importante</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                
                <c:if test="${empty faqs}">
                    <div class="text-center py-5">
                        <i class="fas fa-question-circle text-muted" style="font-size: 4rem;"></i>
                        <h3 class="text-muted mt-3">No hay preguntas disponibles</h3>
                        <p class="text-muted">
                            <c:if test="${not empty param.servicio}">
                                No se encontraron preguntas para el servicio seleccionado.
                            </c:if>
                            <c:if test="${empty param.servicio}">
                                Pronto tendremos más preguntas frecuentes disponibles.
                            </c:if>
                        </p>
                        <c:if test="${not empty param.servicio}">
                            <a href="${pageContext.request.contextPath}/faq" class="btn btn-primary">
                                <i class="fas fa-arrow-left me-2"></i>Ver Todas las Preguntas
                            </a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</section>

<!-- Contact Section -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8 text-center">
                <h3 class="fw-bold mb-3">¿No encontraste lo que buscabas?</h3>
                <p class="text-muted mb-4">Nuestro equipo está aquí para ayudarte con cualquier pregunta adicional que puedas tener.</p>
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <a href="tel:+51999888777" class="btn btn-primary">
                        <i class="fas fa-phone me-2"></i>Llamar Ahora
                    </a>
                    <a href="mailto:info@artdent.com" class="btn btn-outline-primary">
                        <i class="fas fa-envelope me-2"></i>Enviar Email
                    </a>
                    <a href="${pageContext.request.contextPath}/reserva?action=nueva" class="btn btn-success">
                        <i class="fas fa-calendar-plus me-2"></i>Agendar Cita
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="layout/footer.jsp" %>
