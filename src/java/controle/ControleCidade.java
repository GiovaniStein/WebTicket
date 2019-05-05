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
            if (cidade.getDescricao().length() < 3
                    || cidade.getDescricao().length() > 150) {
                return 2;
            }
            ArrayList<Cidade> cidades = new ArrayList<>();
            cidades = listar(cidade);

            for (int i = 0; i < cidades.size(); i++) {
                if (this.cidade.getDescricao()
                        .equalsIgnoreCase(cidades.get(i).getDescricao())
                        && cidade.getId() != cidades.get(i).getId()) {
                    return 3;
                }
            }
        }

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
