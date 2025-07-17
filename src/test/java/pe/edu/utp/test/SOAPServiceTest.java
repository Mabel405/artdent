package pe.edu.utp.test;

import pe.edu.utp.util.NumberToWordsUtil;
import org.junit.Test;
import static org.junit.Assert.*;
import pe.edu.utp.controller.NumberToWordsController;

/**
 * Pruebas unitarias para el servicio SOAP de conversión de números a palabras
 * Basado en el ejemplo de prueba.java
 */
public class SOAPServiceTest {
    
    @Test
    public void testConvertirMontoBasico() {
        String resultado = NumberToWordsUtil.convertToWords(1000.0);
        assertNotNull("El resultado no debe ser null", resultado);
        assertFalse("El resultado no debe estar vacío", resultado.trim().isEmpty());
        assertTrue("Debe contener 'soles'", resultado.toLowerCase().contains("soles"));
        System.out.println("Prueba 1000: " + resultado);
    }
    
    @Test
    public void testConvertirMontoConDecimales() {
        String resultado = NumberToWordsUtil.convertToWords(150.50);
        assertNotNull("El resultado no debe ser null", resultado);
        assertTrue("Debe contener 'soles'", resultado.toLowerCase().contains("soles"));
        assertTrue("Debe contener 'céntimos'", resultado.toLowerCase().contains("céntimos"));
        System.out.println("Prueba 150.50: " + resultado);
    }
    
    @Test
    public void testConvertirMontoEntero() {
        String resultado = NumberToWordsUtil.convertToWords(2000);
        assertNotNull("El resultado no debe ser null", resultado);
        assertTrue("Debe contener 'soles'", resultado.toLowerCase().contains("soles"));
        assertTrue("Debe contener 'exactos'", resultado.toLowerCase().contains("exactos"));
        System.out.println("Prueba 2000: " + resultado);
    }
    
    @Test
    public void testConvertirMontoString() {
        String resultado = NumberToWordsUtil.convertToWords("1250.75");
        assertNotNull("El resultado no debe ser null", resultado);
        assertTrue("Debe contener 'soles'", resultado.toLowerCase().contains("soles"));
        System.out.println("Prueba String 1250.75: " + resultado);
    }
    
    @Test
    public void testMontoInvalido() {
        String resultado = NumberToWordsUtil.convertToWords(-100);
        assertTrue("Debe indicar monto inválido", resultado.contains("inválido"));
        System.out.println("Prueba monto negativo: " + resultado);
    }
    
    @Test
    public void testFormatoInvalido() {
        String resultado = NumberToWordsUtil.convertToWords("abc");
        assertTrue("Debe indicar formato inválido", resultado.contains("inválido"));
        System.out.println("Prueba formato inválido: " + resultado);
    }
    
    /**
     * Prueba similar al main de prueba.java
     */
    @Test
    public void testComoPruebaJava() {
        // Replicar exactamente lo que hace prueba.java
        double monto = 1000.0;
        String resultado = NumberToWordsUtil.convertToWords(monto);
        System.out.println("El monto es de: " + resultado);
        
        assertNotNull("El resultado no debe ser null", resultado);
        assertTrue("Debe contener 'soles'", resultado.toLowerCase().contains("soles"));
        System.out.println("Prueba como prueba.java completada exitosamente");
    }

    @Test
    public void testNumberToWordsController() {
        System.out.println("\n=== Prueba del Controller ===");
        NumberToWordsController.testController();
        System.out.println("Prueba del controller completada");
    }
}
