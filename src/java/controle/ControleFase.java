package controle;

import DAO.FaseDAO;
import entidade.Fase;
import java.util.ArrayList;

public class ControleFase {

    Fase fase;

    public int salvar(Fase fase) {
        this.fase = fase;
        FaseDAO faseDAO = new FaseDAO();

        if (fase.getSituacao() == 'A') {
            if (fase.getDescricao().length() < 3
                    || fase.getDescricao().length() > 45) {
                return 2;
            }
            ArrayList<Fase> fases = new ArrayList<>();
            fases = listar(fase);

            for (int i = 0; i < fases.size(); i++) {
                if (this.fase.getDescricao()
                        .equalsIgnoreCase(fases.get(i).getDescricao())
                        && fase.getId() != fases.get(i).getId()) {
                    return 3;
                }
            }
        }

        if (faseDAO.salvar(fase)) {
            return 1;
        } else {
            return 4;
        }
    }

    public ArrayList<Fase> listar(Fase fase) {
        this.fase = fase;
        FaseDAO faseDAO = new FaseDAO();
        return faseDAO.listar(this.fase);
    }

    public ArrayList<Fase> consultarId(int id) {
        FaseDAO faseDAO = new FaseDAO();
        return faseDAO.consultarId(id);
    }
}
