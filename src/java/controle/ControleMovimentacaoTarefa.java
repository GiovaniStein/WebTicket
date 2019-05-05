package controle;

import DAO.MovimentoTarefaDAO;
import entidade.MovimentoTarefa;
import java.util.ArrayList;

public class ControleMovimentacaoTarefa {

    MovimentoTarefa movimentacaoTarefa;
    MovimentoTarefaDAO movimentoDAO = new MovimentoTarefaDAO();

    public int salvar(MovimentoTarefa movimentacaoTarefa) {
        this.movimentacaoTarefa = movimentacaoTarefa;

        if (movimentacaoTarefa.getSituacao() == 'A') {
            if (movimentacaoTarefa.getDescricao().length() < 3) {
                return 2;
            }
        }

        if (movimentoDAO.salvar(movimentacaoTarefa)) {
            return 1;
        } else {
            return 6;
        }
    }

    public ArrayList<MovimentoTarefa>
            listar(MovimentoTarefa movimentacaoTarefa) {
        this.movimentacaoTarefa = movimentacaoTarefa;
        return movimentoDAO.listar(this.movimentacaoTarefa);
    }

    public ArrayList<MovimentoTarefa> consultarId(int id) {
        return movimentoDAO.consultarId(id);
    }
}
