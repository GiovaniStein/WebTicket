/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import DAO.CidadeDAO;
import entidade.Cidade;
import java.util.ArrayList;


public class ControleCidade {

    Cidade cidade;

    public int salvar(Cidade cidade) {
        this.cidade = cidade;
        CidadeDAO cidadeDAO = new CidadeDAO();

        if (cidade.getSituacao() == 'A') {

            //verifica se o tamanho do nome é <3, caso seja, não conseguirá cadastrar.
            if (cidade.getDescricao().length() < 3 || cidade.getDescricao().length() > 150) {
                return 2;
            }

            ArrayList<Cidade> cidades = new ArrayList<>();

            cidades = listar(cidade);

            //verifica se existe algum cadastro com o mesmo nome que seja um ID diferente do que está alterando.
            for (int i = 0; i < cidades.size(); i++) {
                if (this.cidade.getDescricao().equalsIgnoreCase(cidades.get(i).getDescricao()) && cidade.getId() != cidades.get(i).getId()) {
                    return 3;
                }

            }
        }
        //caso as duas validações acima não interfira no cadastro, será efetuado o cadasro
        if (cidadeDAO.salvar(cidade)) {
            return 1;
        } else {
            return 4;
        }
    }

    public ArrayList<Cidade> listar(Cidade cidade) {
        this.cidade = cidade;
        CidadeDAO cidadeDAO = new CidadeDAO();
        return cidadeDAO.listar(this.cidade);
    }

    public ArrayList<Cidade> consultarId(int id) {

        CidadeDAO cidadeDAO = new CidadeDAO();
        return cidadeDAO.consultarId(id);

    }

}
