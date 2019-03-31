/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import DAO.ClienteDAO;
import DAO.MovimentoTarefaDAO;
import DAO.TarefaDAO;
import apoio.Validacao;
import entidade.Cliente;
import entidade.MovimentoTarefa;
import entidade.Tarefa;
import java.util.ArrayList;


public class ControleMovimentacaoTarefa {

    MovimentoTarefa movimentacaoTarefa;
    MovimentoTarefaDAO movimentoDAO = new MovimentoTarefaDAO();

    public int salvar(MovimentoTarefa movimentacaoTarefa) {
        this.movimentacaoTarefa = movimentacaoTarefa;

        if (movimentacaoTarefa.getSituacao() == 'A') {

            if (movimentacaoTarefa.getDescricao().length() < 3 ) {
                return 2;
            }
           

        }
        if (movimentoDAO.salvar(movimentacaoTarefa)) {
            return 1;
        } else {
            return 6;
        }

    }

    public ArrayList<MovimentoTarefa> listar( MovimentoTarefa movimentacaoTarefa) {
        this.movimentacaoTarefa= movimentacaoTarefa;

        return movimentoDAO.listar(this.movimentacaoTarefa);
    }

    public ArrayList<MovimentoTarefa> consultarId(int id) {

        return movimentoDAO.consultarId(id);

    }

}
