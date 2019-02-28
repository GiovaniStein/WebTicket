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
import entidade.Fase;
import entidade.Modulo;

import entidade.Projeto;
import java.util.ArrayList;


public class ControleModulo {

    Modulo modulo;

    public int salvar(Modulo modulo) {
        this.modulo = modulo;

        ModuloDAO moduloDAO = new ModuloDAO();
        if (modulo.getSituacao() == 'A') {

            if (modulo.getDescricao().length() < 3 || modulo.getDescricao().length() > 45) {
                return 2;
            }

            ArrayList<Modulo> modulos = new ArrayList<>();
            modulos = listar(modulo);

            //verifica se existe algum cadastro com o mesmo nome que seja um ID diferente do que está alterando.
            for (int i = 0; i < modulos.size(); i++) {
                if (this.modulo.getDescricao().equalsIgnoreCase(modulos.get(i).getDescricao()) 
                        && modulo.getId() != modulos.get(i).getId() 
                        && modulo.getProjeto().getId() == modulos.get(i).getProjeto().getId()) {
                    return 3;
                }
            }
        }

        //caso as duas validações acima não interfira no cadastro, será efetuado o cadasro
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
