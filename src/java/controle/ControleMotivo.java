package controle;

import DAO.MotivoDAO;
import entidade.Motivo;
import java.util.ArrayList;

public class ControleMotivo {

    Motivo motivo;

    public int salvar(Motivo motivo) {
        this.motivo = motivo;
        MotivoDAO motivoDAO = new MotivoDAO();

        if (motivo.getSituacao() == 'A') {
            if (motivo.getDescricao().length() < 3) {
                return 2;
            }
            ArrayList<Motivo> motivos = new ArrayList<>();
            motivos = listar(motivo);

            for (int i = 0; i < motivos.size(); i++) {
                if (this.motivo.getDescricao()
                        .equalsIgnoreCase(motivos.get(i).getDescricao())
                        && motivo.getId() != motivos.get(i).getId()) {
                    return 3;
                }
            }
        }

        if (motivoDAO.salvar(motivo)) {
            return 1;
        } else {
            return 4;
        }
    }

    public ArrayList<Motivo> listar(Motivo motivo) {
        this.motivo = motivo;
        MotivoDAO motivoDAO = new MotivoDAO();
        return motivoDAO.listar(this.motivo);
    }

    public ArrayList<Motivo> consultarId(int id) {
        MotivoDAO motivoDAO = new MotivoDAO();
        return motivoDAO.consultarId(id);
    }
}
