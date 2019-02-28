/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import DAO.FaseDAO;
import DAO.MotivoDAO;
import entidade.Fase;
import entidade.Motivo;

import java.util.ArrayList;


public class ControleFase {

    Fase fase;

    public int salvar(Fase fase) {
//         int retorno = 1;
        this.fase = fase;
        FaseDAO faseDAO = new FaseDAO();
        if (fase.getSituacao() == 'A') {

            //verifica se o tamanho do nome é <3, caso seja, não conseguirá cadastrar.
            if (fase.getDescricao().length() < 3 || fase.getDescricao().length() > 45) {
                return 2;
            }

            ArrayList<Fase> fases = new ArrayList<>();
            fases = listar(fase);

            //verifica se existe algum cadastro com o mesmo nome que seja um ID diferente do que está alterando.
            for (int i = 0; i < fases.size(); i++) {
                if (this.fase.getDescricao().equalsIgnoreCase(fases.get(i).getDescricao()) && fase.getId() != fases.get(i).getId()) {
                    return 3;
                }

            }
        }

        //caso as duas validações acima não interfira no cadastro, será efetuado o cadasro
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
