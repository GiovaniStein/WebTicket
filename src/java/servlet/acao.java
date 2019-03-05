/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import DAO.CidadeDAO;
import DAO.ClienteDAO;
import DAO.FaseDAO;
import DAO.ModuloDAO;
import DAO.MotivoDAO;
import DAO.PrioridadeDAO;
import DAO.ProjetoDAO;
import DAO.TarefaDAO;
import DAO.UsuarioDAO;
import DAO.VersaoDAO;
import apoio.Arquivo;

import apoio.Formatacao;
import controle.ControleCidade;
import controle.ControleCliente;
import controle.ControleFase;
import controle.ControleModulo;
import controle.ControleMotivo;
import controle.ControleMovimentacaoTarefa;
import controle.ControlePrioridade;
import controle.ControleProjeto;
import controle.ControleTarefa;
import controle.ControleUsuario;
import controle.ControleVersao;
import entidade.Cidade;
import entidade.Cliente;
import entidade.Fase;
import entidade.Modulo;
import entidade.Motivo;
import entidade.MovimentoTarefa;
import entidade.Prioridade;
import entidade.Projeto;
import entidade.Tarefa;
import entidade.Usuario;
import entidade.Versao;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;

/**
 *
 * @author Giovani
 */
public class acao extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet acaoCidade  </title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet acao at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String parametro = request.getParameter("parametro");
        System.out.println(parametro);

        if (parametro.equals("logout")) {
            HttpSession sessao = request.getSession();
            sessao.invalidate();
            response.sendRedirect("index.jsp");
        }
        
          if (parametro.equals("edCidade")) {
            int id = Integer.parseInt(String.valueOf(request.getParameter("id")));

            ArrayList<Cidade> cidades = new CidadeDAO().consultarId(id);
            Cidade cid = new Cidade();
            cid = cidades.get(0);
            request.setAttribute("objcid", cid);

            encaminharPagina("cadastroCidade.jsp", request, response);
        }
        
        if (parametro.equals("exCidade")) {
            PrintWriter out = response.getWriter();
            try {
                 int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
            Cidade cid = new Cidade();
            cid.setId(id);
            ControleCidade controleCidade = new ControleCidade();
            ArrayList<Cidade> cidades = controleCidade.consultarId(cid.getId());
            cid.setDescricao(cidades.get(0).getDescricao());

            cid.setSituacao('I');

            int retorno = new ControleCidade().salvar(cid);

            request.setAttribute("paginaOrigem", "cadastroCidade.jsp");

          if (retorno == 1) {
                out.println("ok");
                //redirecionarPagina("cadastroCidade.jsp?m=1", request, response);
            } else if(retorno == 2)  {
                out.println("Nome precisa ter de 3 até 45 caractere");
                //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
            }else if(retorno == 3)  {
                out.println("Cidade já cadastrada");
                //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
            }else{
                out.println("Erro desconhecido");
            }
            } catch (Exception e) {
                out.println(""+e);
            }
        }
        
        if (parametro.equals("edUsuario")) {
            int id = Integer.parseInt(String.valueOf(request.getParameter("id")));

            ArrayList<Usuario> usuarios = new UsuarioDAO().consultarId(id);
            Usuario user = new Usuario();
            user = usuarios.get(0);
            user.setSenha("");
            user.setRepetirSenha("");
            request.setAttribute("objuser", user);

            encaminharPagina("cadastroUsuario.jsp", request, response);
        }
        
        if (parametro.equals("exUsuario")) {
            PrintWriter out = response.getWriter();
            try {
                int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
            Usuario user = new Usuario();
            user.setId(id);

            ControleUsuario controleUsuario = new ControleUsuario();
            ArrayList<Usuario> usuarios = controleUsuario.consultarId(user.getId());
            user.setLogin(usuarios.get(0).getLogin());
            user.setNome(usuarios.get(0).getNome());
            user.setSenha(usuarios.get(0).getSenha());
            user.setRepetirSenha(usuarios.get(0).getRepetirSenha());

            user.setSituacao('I');

            int retorno = new ControleUsuario().salvar(user);

            request.setAttribute("paginaOrigem", "cadastroUsuario.jsp");

             
            if (retorno == 1) {
                out.println("ok");
               //redirecionarPagina("cadastroUsuario.jsp?m=1", request, response); 
            } else if(retorno == 2){
                out.println("Nome precisa ter de 3 até 150 caracteres");
                //redirecionarPagina("cadastroUsuario.jsp?m=" + retorno, request, response);
            }else if(retorno == 3){
                out.println("Login já utilizado em outro cadastro");
            
            }else if(retorno == 4){
                out.println("Os campos de senha não conferem");
            }else if(retorno == 5){
                out.println("O login ou email já está em uso. Por favor, escolha outro!");
            }else{
               out.println("Erro desconhecido");
            }

        
            } catch (Exception e) {
                out.println(""+e);
            }
        }
    }
            
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        String parametro = request.getParameter("parametro");
        System.out.println(parametro);
        
         if (parametro.equals("cadCidade")) {
             PrintWriter out = response.getWriter();
             try{
                  Cidade cid = new Cidade();
            int id;
            if (request.getParameter("id").equals("")) {
                id = 0;
            } else {
                id = Integer.parseInt(String.valueOf(request.getParameter("id")));
            }
            cid.setId(id);
            cid.setDescricao(request.getParameter("descricao"));
            cid.setSituacao('A');
            ControleCidade controleCidade = new ControleCidade();
            int retorno = controleCidade.salvar(cid);
            request.setAttribute("paginaOrigem", "cadastroCidade.jsp");

            
            if (retorno == 1) {
                out.println("ok");
                //redirecionarPagina("cadastroCidade.jsp?m=1", request, response);
            } else if(retorno == 2)  {
                out.println("Nome precisa ter de 3 até 45 caractere");
                //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
            }else if(retorno == 3)  {
                out.println("Cidade já cadastrada");
                //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
            }else{
                out.println("Erro desconhecido");
            }
             }catch(Exception e){
                 out.println(""+e);
             }
        }
        
         if (parametro.equals("cadUsuario")) {
             PrintWriter out = response.getWriter();
             try{
                Usuario usuario = new Usuario();
            int id;
            if (request.getParameter("id").equals("")) {
                id = 0;
            } else {
                id = Integer.parseInt(String.valueOf(request.getParameter("id")));
            }
            usuario.setId(id);
            usuario.setNome(request.getParameter("nome"));
            usuario.setLogin(request.getParameter("login"));
            usuario.setSenha(request.getParameter("senha"));
            usuario.setRepetirSenha(request.getParameter("repetirSenha"));
            usuario.setSituacao('A');
            ControleUsuario controleUsuario = new ControleUsuario();
            int retorno = controleUsuario.salvar(usuario);
            request.setAttribute("paginaOrigem", "cadastroUsuario.jsp");
            
            if (retorno == 1) {
                out.println("ok");
               //redirecionarPagina("cadastroUsuario.jsp?m=1", request, response); 
            } else if(retorno == 2){
                out.println("Nome precisa ter de 3 até 150 caracteres");
                //redirecionarPagina("cadastroUsuario.jsp?m=" + retorno, request, response);
            }else if(retorno == 3){
                out.println("Login já utilizado em outro cadastro");
            
            }else if(retorno == 4){
                out.println("Os campos de senha não conferem");
            }else if(retorno == 5){
                out.println("O login ou email já está em uso. Por favor, escolha outro!");
            }else{
               out.println("Erro desconhecido");
            }
             }catch(Exception e){
                 out.println(""+e);
             }
            

        }
        
        if (parametro.equals("login")) {
            Usuario user = new Usuario();
            user.setLogin(request.getParameter("login"));
            user.setSenha(Formatacao.get_SHA_512_SecurePassword(request.getParameter("senha")));
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            ArrayList<Usuario> usuarios = usuarioDAO.listar(user);
            boolean retorno = false;
            try {
                if (usuarios.size() > 0) {
                    if ((user.getLogin().equalsIgnoreCase(usuarios.get(0).getLogin()) && user.getSenha().equals(usuarios.get(0).getSenha()))) {
                        retorno = true;
                    } else {
                        retorno = false;
                    }
                }
            } catch (Exception e) {
                retorno = false;
            }

            if (retorno) {
                if (user != null) {
                    HttpSession sessao = request.getSession();
                    //System.out.println("id..."+usuarios.get(0).getId());
                    sessao.setAttribute("usuarioLogado", usuarios.get(0).getId());

                }
                response.sendRedirect("inicio.jsp");
            } else {
                redirecionarPagina("index.jsp?m=2", request, response);
            }

        }
        
    }
     @Override
    public String getServletInfo() {
        return "Short description";
    }
    
     private void encaminharPagina(String pagina, HttpServletRequest request, HttpServletResponse response) {
        try {
            RequestDispatcher rd = request.getRequestDispatcher(pagina);
            rd.forward(request, response);

            // response.sendRedirect(pagina);
        } catch (Exception e) {
            System.out.println("Erro ao encaminhar: " + e);
        }
    }

    private void redirecionarPagina(String pagina, HttpServletRequest request, HttpServletResponse response) {
        try {
//             RequestDispatcher rd = request.getRequestDispatcher(pagina);
//             rd.forward(request, response);
//
            response.sendRedirect(pagina);
        } catch (Exception e) {
            System.out.println("Erro ao encaminhar: " + e);
        }
    }
    
    
}
