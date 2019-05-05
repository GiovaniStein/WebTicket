package apoio;

public class Validacao {

    private static final int[] P_CPF = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2};
    private static final int[] P_CNPJ = {6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2};

    private static int calcularDigito(String str, int[] peso) {
        int soma = 0;

        for (int indice = str.length() - 1, digito; indice >= 0; indice--) {
            digito = Integer.parseInt(str.substring(indice, indice + 1));
            soma += digito * peso[peso.length - str.length() + indice];
        }
        soma = 11 - soma % 11;
        return soma > 9 ? 0 : soma;
    }

    private static boolean validarCPF(String cpf) {
        if ((cpf == null) || (cpf.length() != 11)) {
            return false;
        }
        Integer digito1 = calcularDigito(cpf.substring(0, 9), P_CPF);
        Integer digito2 = calcularDigito(cpf.substring(0, 9)
                + digito1, P_CPF);
        return cpf.equals(cpf.substring(0, 9) + digito1.toString()
                + digito2.toString());
    }

    public static boolean validarCPFCNPJ(String CPFCNPJ) {
        CPFCNPJ.replace(".", "").replace("-", "").replace("/", "");
        boolean retorno = false;

        if (CPFCNPJ.length() == 11) {
            System.out.println("cnpj" + CPFCNPJ);
            retorno = validarCPF(CPFCNPJ);
        } else {
            System.out.println("cpf");
            retorno = validarCNPJ(CPFCNPJ);
        }
        return retorno;
    }

    private static boolean validarCNPJ(String cnpj) {
        if ((cnpj == null) || (cnpj.length() != 14)) {
            return false;
        }
        Integer digito1 = calcularDigito(cnpj.substring(0, 12), P_CNPJ);
        Integer digito2 = calcularDigito(cnpj.substring(0, 12)
                + digito1, P_CNPJ);
        return cnpj.equals(cnpj.substring(0, 12)
                + digito1.toString() + digito2.toString());
    }

    public static boolean validarDataDMA(int d, int m, int a) {
        boolean correto = true;
        int[] dias = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        if (a < 0 || m < 1 || m > 12) {
            correto = false;
        } else {
            // valida o dia
            if (a % 4 == 0 && (a % 100 != 0 || a % 400 == 0)) {
                dias[1] = 29;
            }
            if (d < 1 || d > dias[m - 1]) {
                correto = false;
            }
        }
        return (correto);
    }

    public static boolean validarDataFormatada(String dataComFormato) {
        String[] data = dataComFormato.split("/");
        return (validarDataDMA(Integer.parseInt(data[0]),
                Integer.parseInt(data[1]), Integer.parseInt(data[1])));
    }
}
