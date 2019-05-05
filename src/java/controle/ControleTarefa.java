package controle;

import DAO.TarefaDAO;
import entidade.Tarefa;
import java.util.ArrayList;

public class ControleTarefa {

    Tarefa tarefa;
    TarefaDAO tarefaDAO = new TarefaDAO();

    public int salvar(Tarefa tarefa) {
        this.tarefa = tarefa;

        if (tarefa.getSituacao() == 'A') {
            if (tarefa.getTitulo().length() < 3
                    || tarefa.getTitulo().length() > 150) {
                return 2;
            }
            if (tarefa.getDescricao().length() < 3) {
                return 3;
            }
            if (tarefa.getCliente().getId() < 1) {
                return 7;
            } else if (tarefa.getFase().getId() < 1) {
                return 7;
            } else if (tarefa.getModulo().getId() < 1) {
                return 7;
            } else if (tarefa.getMotivo().getId() < 1) {
                return 7;
            } else if (tarefa.getPrioridade().getId() < 1) {
                return 7;
            } else if (tarefa.getProjeto().getId() < 1) {
                return 7;
            } else if (tarefa.getUsuarioByIdUsuarioResponsavel().getId() < 1) {
                return 7;
            } else if (tarefa.getVersaoByIdVersaoBug().getId() < 1) {
                return 7;
            } else if (tarefa.getVersaoByIdVersaoCorrecao().getId() < 1) {
                return 7;
            }
        }

        if (tarefaDAO.salvar(tarefa)) {
            return 1;
        } else {
            return 6;
        }
    }

    public ArrayList<Tarefa> listar(Tarefa tarefa) {
        this.tarefa = tarefa;
        return tarefaDAO.listar(this.tarefa);
    }

    public ArrayList<Tarefa> consultarId(int id) {
        return tarefaDAO.consultarId(id);
    }
}
