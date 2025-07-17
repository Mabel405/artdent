package pe.edu.utp.controller;

import com.ejemplo.soapclient.NumberConversion;
import com.ejemplo.soapclient.NumberConversionSoapType;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

/**
 * Controller para convertir números a palabras usando el servicio SOAP
 * Similar al ejemplo de prueba.java pero como endpoint web
 * 
 * @author ArtDent Team
 */
@WebServlet("/api/numberToWords")
public class NumberToWordsController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            String amountParam = request.getParameter("amount");
            
            if (amountParam == null || amountParam.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("error", "Parámetro 'amount' es requerido");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Convertir el parámetro a BigDecimal
            BigDecimal amount;
            try {
                amount = new BigDecimal(amountParam);
            } catch (NumberFormatException e) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("error", "El monto debe ser un número válido");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Validar que el monto sea positivo
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("error", "El monto debe ser mayor a 0");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Usar el servicio SOAP igual que en prueba.java
            NumberConversion nc = new NumberConversion();
            NumberConversionSoapType ncst = nc.getNumberConversionSoap();
            
            // Convertir el monto a palabras usando el servicio SOAP
            String resultado = ncst.numberToDollars(amount);
            
            // Adaptar el resultado para el contexto peruano
            String resultadoAdaptado = adaptarResultadoParaPeru(resultado, amount);
            
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("words", resultadoAdaptado);
            jsonResponse.addProperty("originalAmount", amount.toString());
            
            // Log para debugging (similar a prueba.java)
            System.out.println("NumberToWordsController - El monto " + amount + " es de: " + resultadoAdaptado);
            
        } catch (Exception e) {
            System.err.println("Error en NumberToWordsController: " + e.getMessage());
            e.printStackTrace();
            
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", "Error interno del servidor: " + e.getMessage());
        }
        
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    /**
     * Adapta el resultado del servicio SOAP para el contexto peruano
     * Traduce completamente de inglés a español peruano
     */
    private String adaptarResultadoParaPeru(String resultado, BigDecimal amount) {
        if (resultado == null) {
            return "Error al convertir el monto";
        }
        
        String adaptado = resultado.toLowerCase();
        
        // Traducir números básicos
        adaptado = adaptado.replace("zero", "cero");
        adaptado = adaptado.replace("one", "uno");
        adaptado = adaptado.replace("two", "dos");
        adaptado = adaptado.replace("three", "tres");
        adaptado = adaptado.replace("four", "cuatro");
        adaptado = adaptado.replace("five", "cinco");
        adaptado = adaptado.replace("six", "seis");
        adaptado = adaptado.replace("seven", "siete");
        adaptado = adaptado.replace("eight", "ocho");
        adaptado = adaptado.replace("nine", "nueve");
        adaptado = adaptado.replace("ten", "diez");
        adaptado = adaptado.replace("eleven", "once");
        adaptado = adaptado.replace("twelve", "doce");
        adaptado = adaptado.replace("thirteen", "trece");
        adaptado = adaptado.replace("fourteen", "catorce");
        adaptado = adaptado.replace("fifteen", "quince");
        adaptado = adaptado.replace("sixteen", "dieciséis");
        adaptado = adaptado.replace("seventeen", "diecisiete");
        adaptado = adaptado.replace("eighteen", "dieciocho");
        adaptado = adaptado.replace("nineteen", "diecinueve");
        adaptado = adaptado.replace("twenty", "veinte");
        adaptado = adaptado.replace("thirty", "treinta");
        adaptado = adaptado.replace("forty", "cuarenta");
        adaptado = adaptado.replace("fifty", "cincuenta");
        adaptado = adaptado.replace("sixty", "sesenta");
        adaptado = adaptado.replace("seventy", "setenta");
        adaptado = adaptado.replace("eighty", "ochenta");
        adaptado = adaptado.replace("ninety", "noventa");
        
        // Traducir centenas y miles
        adaptado = adaptado.replace("hundred", "cientos");
        adaptado = adaptado.replace("thousand", "mil");
        adaptado = adaptado.replace("million", "millón");
        adaptado = adaptado.replace("billion", "mil millones");
        
        // Casos especiales para centenas
        adaptado = adaptado.replace("uno cientos", "cien");
        adaptado = adaptado.replace("dos cientos", "doscientos");
        adaptado = adaptado.replace("tres cientos", "trescientos");
        adaptado = adaptado.replace("cuatro cientos", "cuatrocientos");
        adaptado = adaptado.replace("cinco cientos", "quinientos");
        adaptado = adaptado.replace("seis cientos", "seiscientos");
        adaptado = adaptado.replace("siete cientos", "setecientos");
        adaptado = adaptado.replace("ocho cientos", "ochocientos");
        adaptado = adaptado.replace("nueve cientos", "novecientos");
        
        // Reemplazar monedas
        adaptado = adaptado.replace("dollars", "soles");
        adaptado = adaptado.replace("dollar", "sol");
        adaptado = adaptado.replace("cents", "céntimos");
        adaptado = adaptado.replace("cent", "céntimo");
        
        // Conectores
        adaptado = adaptado.replace(" and ", " con ");
        adaptado = adaptado.replace("-", " ");
        
        // Limpiar espacios múltiples
        adaptado = adaptado.replaceAll("\\s+", " ").trim();
        
        // Capitalizar la primera letra
        if (!adaptado.isEmpty()) {
            adaptado = Character.toUpperCase(adaptado.charAt(0)) + adaptado.substring(1);
        }
        
        // Agregar "exactos" si no hay céntimos
        if (amount.remainder(BigDecimal.ONE).compareTo(BigDecimal.ZERO) == 0) {
            adaptado += " exactos";
        }
        
        // Remover punto final si existe
        if (adaptado.endsWith(".")) {
            adaptado = adaptado.substring(0, adaptado.length() - 1);
        }
        
        return adaptado;
    }
    
    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setStatus(HttpServletResponse.SC_OK);
    }
    
    /**
     * Método de prueba para verificar el funcionamiento del controller
     * Similar al main de prueba.java
     */
    public static void testController() {
        System.out.println("=== Prueba NumberToWordsController ===");
        
        // Simular lo que hace prueba.java
        try {
            NumberConversion nc = new NumberConversion();
            NumberConversionSoapType ncst = nc.getNumberConversionSoap();
            String resultado = ncst.numberToDollars(BigDecimal.valueOf(1000));
            System.out.println("Resultado directo SOAP: " + resultado);
            
            // Crear instancia del controller para probar adaptación
            NumberToWordsController controller = new NumberToWordsController();
            String adaptado = controller.adaptarResultadoParaPeru(resultado, BigDecimal.valueOf(1000));
            System.out.println("Resultado adaptado: " + adaptado);
            
        } catch (Exception e) {
            System.err.println("Error en prueba: " + e.getMessage());
        }
        
        System.out.println("=== Fin de prueba ===");
    }
}
