/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package apoio;

/**
 *
 * @author Giovani
 */
public class ProjectUtils {
    
    public static int[] stringToCharCodeArray(String s) {
       char[] values = s.toCharArray();
       int[] charCode = new int[values.length];
       for(int i=0;i<values.length;i++){
           charCode[i] = (int) values[i];
       }
       return charCode;
    }
    
    
}
