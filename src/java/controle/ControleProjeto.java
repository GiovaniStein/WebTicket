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
import entidade.Projeto;
import java.util.ArrayList;


public class ControleProjeto {

    Projeto projeto;

    public int salvar(Projeto projeto) {
        this.projeto = projeto;

        ProjetoDAO projetoDAO = new ProjetoDAO();
        if (projeto.getSituacao() == 'A') {

            if (projeto.getDescricao().length() < 3 || projeto.getDescricao().length() > 45) {
                return 2;
            }

            ArrayList<Projeto> projetos = new ArrayList<>();
            projetos = listar(projeto);

            //verifica se existe algum cadastro com o mesmo nome que seja um ID diferente do que está alterando.
            for (int i = 0; i < projetos.size(); i++) {
                if (this.projeto.getDescricao().equalsIgnoreCase(projetos.get(i).getDescricao()) && projeto.getId() != projetos.get(i).getId()) {
                    return 3;
                }
            }
        }

        //caso as duas validações acima não interfira no cadastro, será efetuado o cadasro
        if (projetoDAO.salvar(projeto)) {
            return 1;
        } else {
            return 4;
        }

    }

    public ArrayList<Projeto> listar(Projeto projeto) {
        this.projeto = projeto;
        ProjetoDAO projetoDAO = new ProjetoDAO();
        return projetoDAO.listar(projeto);

    }

    public ArrayList<Projeto> consultarId(int id) {

        ProjetoDAO projetoDAO = new ProjetoDAO();
        return projetoDAO.consultarId(id);

    }

}
