package controle;

import DAO.ProjetoDAO;
import entidade.Projeto;
import java.util.ArrayList;

public class ControleProjeto {

    Projeto projeto;

    public int salvar(Projeto projeto) {
        this.projeto = projeto;
        ProjetoDAO projetoDAO = new ProjetoDAO();

        if (projeto.getSituacao() == 'A') {
            if (projeto.getDescricao().length() < 3
                    || projeto.getDescricao().length() > 45) {
                return 2;
            }
            ArrayList<Projeto> projetos = new ArrayList<>();
            projetos = listar(projeto);

            for (int i = 0; i < projetos.size(); i++) {
                if (this.projeto.getDescricao()
                        .equalsIgnoreCase(projetos.get(i).getDescricao())
                        && projeto.getId() != projetos.get(i).getId()) {
                    return 3;
                }
            }
        }

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
