package pe.edu.utp.util;

import com.ejemplo.soapclient.NumberConversion;
import com.ejemplo.soapclient.NumberConversionSoapType;
import java.math.BigDecimal;

/**
 * Utilidad para convertir números a palabras usando el servicio SOAP
 * Basado en el ejemplo de prueba.java
 */
public class NumberToWordsUtil {
    
    private static NumberConversionSoapType soapService;
    
    static {
        try {
            NumberConversion nc = new NumberConversion();
            soapService = nc.getNumberConversionSoap();
        } catch (Exception e) {
            System.err.println("Error al inicializar el servicio SOAP: " + e.getMessage());
        }
    }
    
    /**
     * Convierte un monto a palabras usando el servicio SOAP
     * @param amount El monto a convertir
     * @return El monto en palabras o mensaje de error
     */
    public static String convertToWords(BigDecimal amount) {
        try {
            if (soapService == null) {
                return "Servicio no disponible";
            }
            
            if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
                return "Monto inválido";
            }
            
            // Usar el mismo método que en prueba.java
            String resultado = soapService.numberToDollars(amount);
            
            // Adaptar para el contexto peruano
            return adaptarParaPeru(resultado, amount);
            
        } catch (Exception e) {
            System.err.println("Error al convertir monto a palabras: " + e.getMessage());
            return "Error al convertir el monto";
        }
    }
    
    /**
     * Convierte un monto double a palabras
     */
    public static String convertToWords(double amount) {
        return convertToWords(BigDecimal.valueOf(amount));
    }
    
    /**
     * Convierte un monto String a palabras
     */
    public static String convertToWords(String amount) {
        try {
            BigDecimal bd = new BigDecimal(amount);
            return convertToWords(bd);
        } catch (NumberFormatException e) {
            return "Formato de monto inválido";
        }
    }
    
    /**
     * Adapta el resultado del servicio SOAP para el contexto peruano
     */
    private static String adaptarParaPeru(String resultado, BigDecimal amount) {
        if (resultado == null || resultado.trim().isEmpty()) {
            return "Error al procesar el monto";
        }
        
        String adaptado = resultado.trim();
        
        // Reemplazos de inglés a español
        adaptado = adaptado.replace("dollars", "soles");
        adaptado = adaptado.replace("dollar", "sol");
        adaptado = adaptado.replace("cents", "céntimos");
        adaptado = adaptado.replace("cent", "céntimo");
        adaptado = adaptado.replace(" and ", " con ");
        
        // Capitalizar primera letra
        if (!adaptado.isEmpty()) {
            adaptado = Character.toUpperCase(adaptado.charAt(0)) + adaptado.substring(1);
        }
        
        // Agregar "exactos" si no hay decimales
        if (amount.remainder(BigDecimal.ONE).compareTo(BigDecimal.ZERO) == 0) {
            adaptado += " exactos";
        }
        
        return adaptado;
    }
    
    /**
     * Método de prueba - similar al main de prueba.java
     */
    public static void main(String[] args) {
        // Prueba similar a prueba.java
        BigDecimal monto = BigDecimal.valueOf(1000);
        String resultado = convertToWords(monto);
        System.out.println("El monto es de: " + resultado);
        
        // Pruebas adicionales
        System.out.println("150.50: " + convertToWords(150.50));
        System.out.println("1250.75: " + convertToWords(1250.75));
        System.out.println("2000: " + convertToWords(2000));
    }
}
