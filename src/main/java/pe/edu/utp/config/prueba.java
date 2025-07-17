/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.utp.config;

import com.ejemplo.soapclient.NumberConversion;
import com.ejemplo.soapclient.NumberConversionSoapType;
import java.math.BigDecimal;

/**
 *
 * @author alex0
 */
public class prueba {
    public static void main(String[] args) {
        NumberConversion nc = new NumberConversion();
        NumberConversionSoapType ncst = nc.getNumberConversionSoap();
        String resultado = ncst.numberToDollars(BigDecimal.valueOf(1000));
        System.out.println("El monto es de: "+resultado);
    }
}
