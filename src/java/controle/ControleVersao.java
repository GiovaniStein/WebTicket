/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import DAO.FaseDAO;
import DAO.ModuloDAO;
import DAO.MotivoDAO;
import DAO.PrioridadeDAO;
import DAO.VersaoDAO;
import entidade.Fase;
import entidade.Modulo;

import entidade.Projeto;
import entidade.Versao;
import java.util.ArrayList;


public class ControleVersao {

    Versao versao;

    public int salvar(Versao versao) {
        this.versao = versao;

        VersaoDAO versaoDAO = new VersaoDAO();
        if (versao.getSituacao() == 'A') {

            if (versao.getDescricao().length() < 3 || versao.getDescricao().length() > 45) {
                return 2;
            }

            ArrayList<Versao> versoes = new ArrayList<>();
            versoes = listar(versao);

            //verifica se existe algum cadastro com o mesmo nome que seja um ID diferente do que está alterando.
            for (int i = 0; i < versoes.size(); i++) {
                if (this.versao.getDescricao().equalsIgnoreCase(versoes.get(i).getDescricao()) 
                        && versao.getId() != versoes.get(i).getId()
                        && versao.getProjeto().getId() == versoes.get(i).getProjeto().getId()) {
                    return 3;
                }
            }
        }

        //caso as duas validações acima não interfira no cadastro, será efetuado o cadasro
        if (versaoDAO.salvar(versao)) {
            return 1;
        } else {
            return 4;
        }

    }

    public ArrayList<Versao> listar(Versao versao) {
        this.versao = versao;
        VersaoDAO versaoDAO = new VersaoDAO();
        return versaoDAO.listar(versao);

    }

    public ArrayList<Versao> consultarId(int id) {

        VersaoDAO versaoDAO = new VersaoDAO();
        return versaoDAO.consultarId(id);

    }

}
