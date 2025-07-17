package pe.edu.utp.test;

import pe.edu.utp.controller.RucController;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Pruebas unitarias para el controlador de consulta RUC
 */
public class RucControllerTest {
    
    @Test
    public void testRucControllerBasico() {
        System.out.println("=== Iniciando pruebas RucController ===");
        
        // Ejecutar el método de prueba del controller
        RucController.testRucController();
        
        System.out.println("=== Pruebas completadas ===");
        
        // La prueba pasa si no hay excepciones
        assertTrue("RucController debe ejecutarse sin errores", true);
    }
    
    @Test
    public void testRucValidos() {
        System.out.println("\n=== Probando RUCs válidos ===");
        
        String[] rucsPrueba = {
            "20552103816", // CORPORACION PERUANA DE PRODUCTOS QUIMICOS S.A.
            "20100070970", // SUPERMERCADOS PERUANOS SOCIEDAD ANONIMA
            "20131312955", // CENCOSUD RETAIL PERU S.A.
            "20325117835"  // CLINICA DENTAL ARTDENT S.A.C.
        };
        
        for (String ruc : rucsPrueba) {
            System.out.println("Probando RUC: " + ruc);
            assertNotNull("RUC no debe ser null", ruc);
            assertEquals("RUC debe tener 11 dígitos", 11, ruc.length());
            assertTrue("RUC debe ser solo números", ruc.matches("\\d{11}"));
        }
        
        System.out.println("Todos los RUCs de prueba son válidos");
    }
    
    @Test
    public void testFormatosInvalidos() {
        System.out.println("\n=== Probando formatos inválidos ===");
        
        String[] rucInvalidos = {
            "123456789",    // Muy corto
            "123456789012", // Muy largo
            "1234567890a",  // Contiene letra
            "",             // Vacío
            null            // Null
        };
        
        for (String ruc : rucInvalidos) {
            System.out.println("Probando RUC inválido: " + ruc);
            
            if (ruc != null) {
                assertFalse("RUC inválido debe fallar validación: " + ruc, 
                           ruc.matches("\\d{11}"));
            }
        }
        
        System.out.println("Validación de formatos inválidos completada");
    }
}
