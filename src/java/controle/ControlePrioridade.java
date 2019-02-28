/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import DAO.FaseDAO;
import DAO.MotivoDAO;
import DAO.PrioridadeDAO;
import DAO.ProjetoDAO;
import entidade.Fase;
import entidade.Motivo;
import entidade.Prioridade;
import entidade.Projeto;
import java.util.ArrayList;


public class ControlePrioridade {

    Prioridade prioridade;

    public int salvar(Prioridade prioridade) {
        this.prioridade = prioridade;

        PrioridadeDAO prioridadeDAO = new PrioridadeDAO();
        if (prioridade.getSituacao() == 'A') {

            if (prioridade.getDescricao().length() < 3 || prioridade.getDescricao().length() > 45) {
                return 2;
            }

            ArrayList<Prioridade> prioridades = new ArrayList<>();
            prioridades = listar(prioridade);

            //verifica se existe algum cadastro com o mesmo nome que seja um ID diferente do que está alterando.
            for (int i = 0; i < prioridades.size(); i++) {
                if (this.prioridade.getDescricao().equalsIgnoreCase(prioridades.get(i).getDescricao()) && prioridade.getId() != prioridades.get(i).getId()) {
                    return 3;
                }
            }
        }

        //caso as duas validações acima não interfira no cadastro, será efetuado o cadasro
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
