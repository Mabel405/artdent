package pe.edu.utp.config;

/**
 * Configuración para los controladores del sistema ArtDent
 * 
 * Esta clase centraliza la configuración de los controladores web,
 * incluyendo rutas, parámetros y configuraciones específicas.
 * 
 * @author ArtDent Team
 */
public class ControllerConfig {
    
    // URLs de los controladores
    public static final String NUMBER_TO_WORDS_URL = "/api/numberToWords";
    public static final String RUC_LOOKUP_URL = "/api/ruc";
    
    // Configuración del servicio SOAP
    public static final String SOAP_SERVICE_URL = "https://www.dataaccess.com/webservicesserver/NumberConversion.wso?WSDL";
    public static final String SOAP_PACKAGE_NAME = "com.ejemplo.soapclient";
    
    // Configuración de RUC
    public static final String RUC_API_URL = "https://dniruc.apisperu.com/api/v1/ruc/";
    public static final String RUC_API_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFydGRlbnRAdGVzdC5jb20ifQ.X8lMqyXQfZZKQQyQy5c4KQQyQy5c4KQQyQy5c4KQQyQ";
    
    // Configuración de respuestas
    public static final String JSON_CONTENT_TYPE = "application/json";
    public static final String UTF8_ENCODING = "UTF-8";
    
    // Mensajes de error estándar
    public static final String ERROR_MISSING_AMOUNT = "Parámetro 'amount' es requerido";
    public static final String ERROR_MISSING_RUC = "Parámetro 'numero' es requerido";
    public static final String ERROR_INVALID_NUMBER = "El monto debe ser un número válido";
    public static final String ERROR_INVALID_RUC = "El RUC debe tener exactamente 11 dígitos";
    public static final String ERROR_NEGATIVE_AMOUNT = "El monto debe ser mayor a 0";
    public static final String ERROR_SOAP_SERVICE = "Error interno del servidor";
    public static final String ERROR_RUC_NOT_FOUND = "No se encontró información para este RUC";
    
    /**
     * Valida si una URL corresponde a un controlador del sistema
     */
    public static boolean isControllerUrl(String url) {
        return url != null && (
            url.contains(NUMBER_TO_WORDS_URL) ||
            url.contains(RUC_LOOKUP_URL)
        );
    }
    
    /**
     * Obtiene la configuración CORS para los controladores
     */
    public static void setCorsHeaders(javax.servlet.http.HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
    }
    
    /**
     * Valida el formato de un RUC
     */
    public static boolean isValidRucFormat(String ruc) {
        return ruc != null && ruc.matches("\\d{11}");
    }
}
