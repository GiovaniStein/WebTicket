package controle;

import DAO.ModuloDAO;
import entidade.Modulo;
import java.util.ArrayList;

public class ControleModulo {

    Modulo modulo;

    public int salvar(Modulo modulo) {
        this.modulo = modulo;
        ModuloDAO moduloDAO = new ModuloDAO();

        if (modulo.getSituacao() == 'A') {
            if (modulo.getDescricao().length() < 3
                    || modulo.getDescricao().length() > 45) {
                return 2;
            }
            ArrayList<Modulo> modulos = new ArrayList<>();
            modulos = listar(modulo);

            for (int i = 0; i < modulos.size(); i++) {
                if (this.modulo.getDescricao()
                        .equalsIgnoreCase(modulos.get(i).getDescricao())
                        && modulo.getId() != modulos.get(i).getId()
                        && modulo.getProjeto().getId()
                        == modulos.get(i).getProjeto().getId()) {
                    return 3;
                }
            }
        }

        if (moduloDAO.salvar(modulo)) {
            return 1;
        } else {
            return 4;
        }
    }

    public ArrayList<Modulo> listar(Modulo modulo) {
        this.modulo = modulo;
        ModuloDAO moduloDAO = new ModuloDAO();
        return moduloDAO.listar(modulo);
    }

    public ArrayList<Modulo> consultarId(int id) {
        ModuloDAO moduloDAO = new ModuloDAO();
        return moduloDAO.consultarId(id);
    }
}
