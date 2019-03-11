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

        if (parametro.equals("exVersao")) {

            PrintWriter out = response.getWriter();

            try {
                int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                VersaoDAO versaoDAO = new VersaoDAO();

                Versao ver = new Versao();
                ArrayList<Versao> versoes = versaoDAO.consultarId(id);
                ver.setId(id);
                ver.setDescricao(versoes.get(0).getDescricao());
                Projeto projeto = new Projeto();
                projeto.setId(versoes.get(0).getProjeto().getId());
                ver.setProjeto(projeto);
                ver.setSituacao('I');

                int retorno = new ControleVersao().salvar(ver);

                request.setAttribute("paginaOrigem", "cadastroVersao.jsp");

                if (retorno == 1) {
                    out.println("ok");
                } else {
                    out.println("erro");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

        }

        if (parametro.equals("exModulo")) {
            PrintWriter out = response.getWriter();

            try {
                int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                ModuloDAO moduloDAO = new ModuloDAO();

                Modulo mod = new Modulo();
                ArrayList<Modulo> modulos = moduloDAO.consultarId(id);
                mod.setId(id);
                mod.setDescricao(modulos.get(0).getDescricao());
                Projeto projeto = new Projeto();
                projeto.setId(modulos.get(0).getProjeto().getId());
                mod.setProjeto(projeto);
                mod.setSituacao('I');

                int retorno = new ControleModulo().salvar(mod);

                request.setAttribute("paginaOrigem", "cadastroModulo.jsp");

                if (retorno == 1) {
                    out.println("ok");
                } else {
                    out.println("erro");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

        }

        if (parametro.equals("exFase")) {
            PrintWriter out = response.getWriter();

            try {
                int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                Fase fas = new Fase();
                fas.setId(id);
                ControleFase controleFase = new ControleFase();
                ArrayList<Fase> fases = controleFase.consultarId(fas.getId());
                fas.setDescricao(fases.get(0).getDescricao());
                fas.setSituacao('I');
                int retorno;

                retorno = controleFase.salvar(fas);

                request.setAttribute("paginaOrigem", "cadastroFase.jsp");

                if (retorno == 1) {
                    out.println("ok");
                } else {
                    out.println("erro");
                }
            } catch (Exception e) {
                out.println("" + e);
            }
        }

        if (parametro.equals("exPrioridade")) {
            PrintWriter out = response.getWriter();

            try {
                int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                Prioridade prio = new Prioridade();
                prio.setId(id);
                ControlePrioridade controlePrioridade = new ControlePrioridade();
                ArrayList<Prioridade> prioridades = controlePrioridade.consultarId(prio.getId());
                prio.setDescricao(prioridades.get(0).getDescricao());
                prio.setSituacao('I');

                int retorno;

                retorno = new ControlePrioridade().salvar(prio);

                request.setAttribute("paginaOrigem", "cadastroPrioridade.jsp");

                if (retorno == 1) {
                    out.println("ok");
                } else {
                    out.println("erro");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

        }
        
        if (parametro.equals("exCliente")) {
            PrintWriter out = response.getWriter();
            
            try {
                int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
            Cliente cli = new Cliente();
            cli.setId(id);
            ControleCliente controleCliente = new ControleCliente();
            ArrayList<Cliente> clientes = controleCliente.consultarId(cli.getId());
            Cidade cid = new Cidade();
            cid.setId(clientes.get(0).getCidade().getId());
            cli.setRazaoSocial(clientes.get(0).getRazaoSocial());
            cli.setCpfCnpj(clientes.get(0).getCpfCnpj());
            // cli = clientes.get(0);
            cli.setEndereco(clientes.get(0).getEndereco());
            cli.setTelefone(clientes.get(0).getTelefone());
            cli.setTipoCadastro(clientes.get(0).getTipoCadastro());
            cli.setSituacao('I');
            cli.setCidade(cid);
            int retorno;

            retorno = controleCliente.salvar(cli);

            request.setAttribute("paginaOrigem", "cadastroCliente.jsp");

             if (retorno == 1) {
                    out.println("ok");
                } else {
                    out.println("erro");
                }
            } catch (Exception e) {
                out.println(""+e);
            }

            

        }

        if (parametro.equals("exModulo")) {
            PrintWriter out = response.getWriter();

            try {
                int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                ModuloDAO moduloDAO = new ModuloDAO();

                Modulo mod = new Modulo();
                ArrayList<Modulo> modulos = moduloDAO.consultarId(id);
                mod.setId(id);
                mod.setDescricao(modulos.get(0).getDescricao());
                Projeto projeto = new Projeto();
                projeto.setId(modulos.get(0).getProjeto().getId());
                mod.setProjeto(projeto);
                mod.setSituacao('I');

                int retorno = new ControleModulo().salvar(mod);

                request.setAttribute("paginaOrigem", "cadastroModulo.jsp");

                if (retorno == 1) {
                    out.println("ok");
                } else {
                    out.println("erro");
                }
            } catch (Exception e) {
                out.println("" + e);
            }
        }

        if (parametro.equals("exProjeto")) {
            PrintWriter out = response.getWriter();

            try {
                int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                Projeto proj = new Projeto();
                proj.setId(id);
                ControleProjeto controleProjeto = new ControleProjeto();
                ArrayList<Projeto> projetos = controleProjeto.consultarId(proj.getId());
                proj.setDescricao(projetos.get(0).getDescricao());
                proj.setSituacao('I');

                int retorno;

                retorno = new ControleProjeto().salvar(proj);

                request.setAttribute("paginaOrigem", "cadastroProjeto.jsp");

                if (retorno == 1) {
                    out.println("ok");
                } else {
                    out.println("erro");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

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
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 45 caractere");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Cidade já cadastrada");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }
            } catch (Exception e) {
                out.println("" + e);
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
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 150 caracteres");
                    //redirecionarPagina("cadastroUsuario.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Login já utilizado em outro cadastro");

                } else if (retorno == 4) {
                    out.println("Os campos de senha não conferem");
                } else if (retorno == 5) {
                    out.println("O login ou email já está em uso. Por favor, escolha outro!");
                } else {
                    out.println("Erro desconhecido");
                }

            } catch (Exception e) {
                out.println("" + e);
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
        
        
        if (parametro.equals("cadCliente")) {
            
            PrintWriter out = response.getWriter();
            
            try {
                 String idCidade = request.getParameter("cidade");
            // System.out.println(".i.d" + id);
            Cliente cliente = new Cliente();
            Cidade cid = new Cidade();
            int idCliente;
            if (request.getParameter("id").equals("")) {
                idCliente = 0;
            } else {
                idCliente = Integer.parseInt(String.valueOf(request.getParameter("id")));
            }
            cliente.setId(idCliente);
            cliente.setRazaoSocial(request.getParameter("nome"));
            cliente.setTipoCadastro(request.getParameter("tipo").charAt(0));
            cliente.setTelefone(request.getParameter("telefone"));
            cliente.setEndereco(request.getParameter("endereco"));
            System.out.println("cpf = " + request.getParameter("cpf").replace(".", "").replace("-", "").replace("/", ""));
            System.out.println("cnpj = " + request.getParameter("cnpj").replace(".", "").replace("-", "").replace("/", ""));
            try {
                if (request.getParameter("cnpj").replace(".", "").replace("-", "").replace("/", "").replace("_", "  ").length() < 12) {
                    System.out.println("cpf acao" + request.getParameter("cnpj").replace(".", "").replace("-", "").replace("/", ""));
                    cliente.setCpfCnpj(request.getParameter("cpf").replace(".", "").replace("-", "").replace("/", ""));
                } else {
                    cliente.setCpfCnpj(request.getParameter("cnpj").replace(".", "").replace("-", "").replace("/", ""));
                }
            } catch (Exception e) {
                System.out.println("cnpj acao" + request.getParameter("cnpj").replace(".", "").replace("-", "").replace("/", ""));
                cliente.setCpfCnpj(request.getParameter("cnpj").replace(".", "").replace("-", "").replace("/", ""));
                System.out.println("Erro validar cpf" + e);
            }

            cid.setId(Integer.parseInt(idCidade));
            cliente.setCidade(cid);
            cliente.setSituacao('A');

            ControleCliente controleCliente = new ControleCliente();
            int retorno = controleCliente.salvar(cliente);

            request.setAttribute("paginaOrigem", "cadastroCliente.jsp");

            if (retorno == 1) {
                    out.println("ok");
                    //redirecionarPagina("cadastroUsuario.jsp?m=1", request, response); 
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 150 caracteres");
                    //redirecionarPagina("cadastroUsuario.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("É preciso selecionar um tipo");

                } else if (retorno == 4) {
                    out.println("CPF/CNPJ inválido");
                } else if (retorno == 5) {
                    out.println("CPF/CNPJ já utilizado em outro cadastro");
                } else {
                    out.println("Erro desconhecido");
                }
            } catch (Exception e) {
                out.println(""+e);
            }
            
           

        }
        
        

        if (parametro.equals("cadVersao")) {

            PrintWriter out = response.getWriter();

            try {
                String idProjeto = request.getParameter("projeto");
                // System.out.println(".i.d" + id);
                Versao versao = new Versao();
                int idVersao;
                if (request.getParameter("id").equals("")) {
                    idVersao = 0;
                } else {
                    idVersao = Integer.parseInt(String.valueOf(request.getParameter("id")));
                }
                versao.setId(idVersao);
                versao.setDescricao(request.getParameter("descricao"));
                versao.setSituacao('A');
                Projeto projeto = new Projeto();
                projeto.setId(Integer.parseInt(idProjeto));
                versao.setProjeto(projeto);

                ControleVersao controleVersao = new ControleVersao();
                int retorno = controleVersao.salvar(versao);

                request.setAttribute("paginaOrigem", "cadastroVersao.jsp");

                if (retorno == 1) {
                    out.println("ok");
                    //redirecionarPagina("cadastroCidade.jsp?m=1", request, response);
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 45 caractere");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Modulo já cadastrada");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

        }

        if (parametro.equals("cadModulo")) {

            PrintWriter out = response.getWriter();

            try {
                String idProjeto = request.getParameter("projeto");
                // System.out.println(".i.d" + id);
                Modulo modulo = new Modulo();
                int idModulo;
                if (request.getParameter("id").equals("")) {
                    idModulo = 0;
                } else {
                    idModulo = Integer.parseInt(String.valueOf(request.getParameter("id")));
                }
                modulo.setId(idModulo);
                modulo.setDescricao(request.getParameter("descricao"));
                modulo.setSituacao('A');
                Projeto projeto = new Projeto();
                projeto.setId(Integer.parseInt(idProjeto));
                modulo.setProjeto(projeto);

                ControleModulo controleModulo = new ControleModulo();
                int retorno = controleModulo.salvar(modulo);

                request.setAttribute("paginaOrigem", "cadastroModulo.jsp");

                if (retorno == 1) {
                    out.println("ok");
                    //redirecionarPagina("cadastroCidade.jsp?m=1", request, response);
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 45 caractere");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Modulo já cadastrada");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

        }

        if (parametro.equals("cadFase")) {
            PrintWriter out = response.getWriter();

            try {
                String id = request.getParameter("fase");
                Fase fase = new Fase();
                int idFase;
                if (request.getParameter("id").equals("")) {
                    idFase = 0;
                } else {
                    idFase = Integer.parseInt(String.valueOf(request.getParameter("id")));
                }
                fase.setId(idFase);
                fase.setDescricao(request.getParameter("descricao"));
                fase.setSituacao('A');
                int retorno = 1;
                ControleFase controleFase = new ControleFase();
                retorno = controleFase.salvar(fase);

                request.setAttribute("paginaOrigem", "cadastroFase.jsp");
                if (retorno == 1) {
                    out.println("ok");
                    //redirecionarPagina("cadastroCidade.jsp?m=1", request, response);
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 45 caractere");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Modulo já cadastrada");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }

            } catch (Exception e) {
                out.println("" + e);
            }

        }

        if (parametro.equals("cadPrioridade")) {
            PrintWriter out = response.getWriter();

            try {
                Prioridade prio = new Prioridade();
                int id;
                if (request.getParameter("id").equals("")) {
                    id = 0;
                } else {
                    id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                }
                prio.setId(id);
                prio.setDescricao(request.getParameter("descricao"));
                prio.setSituacao('A');

                ControlePrioridade controlePrioridade = new ControlePrioridade();
                int retorno = controlePrioridade.salvar(prio);

                request.setAttribute("paginaOrigem", "cadastroPrioridade.jsp");

                if (retorno == 1) {
                    out.println("ok");
                    //redirecionarPagina("cadastroCidade.jsp?m=1", request, response);
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 45 caractere");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Modulo já cadastrada");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

        }

        if (parametro.equals("cadModulo")) {
            PrintWriter out = response.getWriter();

            try {
                String idProjeto = request.getParameter("projeto");
                // System.out.println(".i.d" + id);
                Modulo modulo = new Modulo();
                int idModulo;
                if (request.getParameter("id").equals("")) {
                    idModulo = 0;
                } else {
                    idModulo = Integer.parseInt(String.valueOf(request.getParameter("id")));
                }
                modulo.setId(idModulo);
                modulo.setDescricao(request.getParameter("descricao"));
                modulo.setSituacao('A');
                Projeto projeto = new Projeto();
                projeto.setId(Integer.parseInt(idProjeto));
                modulo.setProjeto(projeto);

                ControleModulo controleModulo = new ControleModulo();
                int retorno = controleModulo.salvar(modulo);

                request.setAttribute("paginaOrigem", "cadastroModulo.jsp");
                if (retorno == 1) {
                    out.println("ok");
                    //redirecionarPagina("cadastroCidade.jsp?m=1", request, response);
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 45 caractere");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Modulo já cadastrada");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

        }

        if (parametro.equals("cadProjeto")) {
            PrintWriter out = response.getWriter();

            try {
                Projeto proj = new Projeto();
                int id;
                if (request.getParameter("id").equals("")) {
                    id = 0;
                } else {
                    id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                }
                proj.setId(id);
                proj.setDescricao(request.getParameter("descricao"));
                proj.setSituacao('A');

                ControleProjeto controleProjeto = new ControleProjeto();
                int retorno = controleProjeto.salvar(proj);

                request.setAttribute("paginaOrigem", "cadastroProjeto.jsp");

                if (retorno == 1) {
                    out.println("ok");
                    //redirecionarPagina("cadastroProjeto.jsp?m=1", request, response);
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 45 caractere");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Projeto já cadastrada");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }
            } catch (Exception e) {
                out.println("" + e);
            }
        }

        if (parametro.equals("cadCidade")) {
            PrintWriter out = response.getWriter();
            try {
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
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 45 caractere");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Cidade já cadastrada");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }
            } catch (Exception e) {
                out.println("" + e);
            }
        }

        if (parametro.equals("cadUsuario")) {
            PrintWriter out = response.getWriter();
            try {
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
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 150 caracteres");
                    //redirecionarPagina("cadastroUsuario.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Login já utilizado em outro cadastro");

                } else if (retorno == 4) {
                    out.println("Os campos de senha não conferem");
                } else if (retorno == 5) {
                    out.println("O login ou email já está em uso. Por favor, escolha outro!");
                } else {
                    out.println("Erro desconhecido");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

        }

        if (parametro.equals("login")) {

            PrintWriter out = response.getWriter();

            try {
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
                        out.println("ok");
                    }
                } else {
                    out.println("Usuário não encontrado verifique o login e senha");
                }
            } catch (Exception e) {
                out.println("" + e);
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
