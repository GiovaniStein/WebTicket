
package apoio;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Formatacao {

    public static String get_SHA_512_SecurePassword(String passwordToHash) throws UnsupportedEncodingException {
        String generatedPassword = null;
        String salt = "senhapadrao";
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(salt.getBytes("UTF-8"));
            byte[] bytes = md.digest(passwordToHash.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bytes.length; i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            generatedPassword = sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        System.out.println(generatedPassword);
        return generatedPassword;
    }

    public static Date formatacaoDataAMD(String data) {
        SimpleDateFormat formato = new SimpleDateFormat("yyyy/mm/dd");
        Date dataFormatada = new Date();
        try {

            dataFormatada = formato.parse(data);
            return dataFormatada;
        } catch (Exception e) {
            System.out.println("Erro ao formatar data " + e);
        }
        return dataFormatada;
    }

    public static Date formatacaoData2(String data ) throws ParseException {
        
//      //  String pattern = "MMM dd HH:mm:ss zzzz yyyy";
//        DateFormat df = new SimpleDateFormat(data);
//        Date date = df.parse(data);
//        return date;

        DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
        Date date = (Date) formatter.parse(data);
        return date;
    }

    public static String formatacaoDataDMAHMS(Date data) {
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String dataFormatada = null;
        try {

            dataFormatada = formato.format((data));
            return dataFormatada;
        } catch (Exception e) {
            System.out.println("Erro ao formatar data " + e);
        }
        return dataFormatada;
    }

    public static String ajustaDataDMAJCalendar(Date tffDataInicio) {
        String dataFormatada = "";

        if (tffDataInicio.getDate() < 10) {
            dataFormatada = "0" + tffDataInicio.getDate() + "/";
        } else {
            dataFormatada = dataFormatada + tffDataInicio.getDate() + "/";
        }

        if ((tffDataInicio.getMonth() + 1) < 10) {
            dataFormatada = dataFormatada + "0" + (tffDataInicio.getMonth() + 1) + "/";
        } else {
            dataFormatada = dataFormatada + (tffDataInicio.getMonth() + 1) + "/";
        }
        dataFormatada = (dataFormatada + (tffDataInicio.getYear() + 1900));

        return dataFormatada;
    }

}
