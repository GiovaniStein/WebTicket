
package controle;

import DAO.UsuarioDAO;
import apoio.Formatacao;
import entidade.Usuario;
import java.util.ArrayList;


public class ControleUsuario {

    Usuario usuario;

    public int salvar(Usuario usuario) {
        this.usuario = usuario;
        UsuarioDAO usuarioDAO = new UsuarioDAO();

        if (usuario.getSituacao() == 'A') {

            //verifica se o tamanho do nome é <3, caso seja, não conseguirá cadastrar.
            if (usuario.getNome().length() < 3 || usuario.getNome().length() > 150) {
                return 2;
            }
            

            ArrayList<Usuario> usuarios = new ArrayList<>();
            ArrayList<Usuario> todosusuarios = new ArrayList<>();

            usuarios = listar(usuario);

            //verifica se existe algum cadastro com o mesmo nome que seja um ID diferente do que está alterando.
            for (int i = 0; i < usuarios.size(); i++) {
                if (this.usuario.getLogin().equalsIgnoreCase(usuarios.get(i).getLogin()) && usuario.getId() != usuarios.get(i).getId()) {
                    return 3;
                }
            }
            
            todosusuarios = listarTodos(usuario);
            
            for(Usuario u:todosusuarios){
                if(u.getLogin().equals(usuario.getLogin())){
                    return 5;
                }
            }

            if (!usuario.getSenha().equals(usuario.getRepetirSenha())) {
                return 4;
            }
        }
        if (usuario.getId() == 0) {

            try {
                String senha = Formatacao.get_SHA_512_SecurePassword(usuario.getSenha());
                usuario.setSenha(senha);
                usuario.setRepetirSenha(senha);
            } catch (Exception e) {
            }
        }

        //caso as duas validações acima não interfira no cadastro, será efetuado o cadasro
        if (usuarioDAO.salvar(usuario)) {
            return 1;
        } else {
            return 4;
        }
    }

    public ArrayList<Usuario> listar(Usuario usuario) {
        this.usuario = usuario;
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        return usuarioDAO.listar(this.usuario);
    }
    
     public ArrayList<Usuario> listarTodos(Usuario usuario) {
        this.usuario = usuario;
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        return usuarioDAO.listarTodos(this.usuario);
    }
    
      public ArrayList<Usuario> consultarId(int id) {

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        return usuarioDAO.consultarId(id);

    }
}
