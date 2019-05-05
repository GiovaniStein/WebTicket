package controle;

import DAO.PrioridadeDAO;
import entidade.Prioridade;
import java.util.ArrayList;

public class ControlePrioridade {

    Prioridade prioridade;

    public int salvar(Prioridade prioridade) {
        this.prioridade = prioridade;
        PrioridadeDAO prioridadeDAO = new PrioridadeDAO();

        if (prioridade.getSituacao() == 'A') {
            if (prioridade.getDescricao().length() < 3
                    || prioridade.getDescricao().length() > 45) {
                return 2;
            }
            ArrayList<Prioridade> prioridades = new ArrayList<>();
            prioridades = listar(prioridade);

            for (int i = 0; i < prioridades.size(); i++) {
                if (this.prioridade.getDescricao()
                        .equalsIgnoreCase(prioridades.get(i).getDescricao())
                        && prioridade.getId() != prioridades.get(i).getId()) {
                    return 3;
                }
            }
        }

        if (prioridadeDAO.salvar(prioridade)) {
            return 1;
        } else {
            return 4;
        }
    }

    public ArrayList<Prioridade> listar(Prioridade prioridade) {
        this.prioridade = prioridade;
        PrioridadeDAO prioridadeDAO = new PrioridadeDAO();
        return prioridadeDAO.listar(prioridade);
    }

    public ArrayList<Prioridade> consultarId(int id) {
        PrioridadeDAO prioridadeDAO = new PrioridadeDAO();
        return prioridadeDAO.consultarId(id);
    }
}
