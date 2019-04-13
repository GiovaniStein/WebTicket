/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import DAO.CidadeDAO;
import DAO.ModuloDAO;
import DAO.ProjetoDAO;
import DAO.TarefaDAO;
import DAO.UsuarioDAO;
import DAO.VersaoDAO;

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
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
        
        if(parametro.equals("appInformation")){
            HashMap<String, Integer> values = new HashMap<String, Integer>();
            UsuarioDAO userdao = new UsuarioDAO();
            ProjetoDAO projetodao = new ProjetoDAO();
            VersaoDAO versaodao = new VersaoDAO();
            values.put("countUsers", userdao.CountUsers());
            values.put("countProjects", projetodao.countProject());
            values.put("countVersion", versaodao.countVersion());
            
            
        }

        if (parametro.equals("logout")) {
            HttpSession sessao = request.getSession();
            sessao.invalidate();
            response.sendRedirect("index.jsp");
        }

        if (parametro.equals("edTarefa")) {
            int id = Integer.parseInt(String.valueOf(request.getParameter("id")));

            ArrayList<Tarefa> tarefas = new TarefaDAO().consultarId(id);
            Tarefa tarefa = new Tarefa();
            tarefa = tarefas.get(0);
            request.setAttribute("objtar", tarefa);

            encaminharPagina("cadastroTarefa.jsp", request, response);

        }

        if (parametro.equals("exTarefa")) {

            PrintWriter out = response.getWriter();

            try {
                int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                Tarefa tar = new Tarefa();
                tar.setId(id);
                ControleTarefa controleTarefa = new ControleTarefa();
                ArrayList<Tarefa> tarefas = controleTarefa.consultarId(tar.getId());
                Cidade cid = new Cidade();

                Cliente cli = new Cliente();
                cli.setId(tarefas.get(0).getCliente().getId());
                cli.setCidade(cid);
                tar.setCliente(cli);
                Fase fas = new Fase();
                fas.setId(tarefas.get(0).getFase().getId());
                Versao versaoBug = new Versao();
                versaoBug.setId(tarefas.get(0).getVersaoByIdVersaoBug().getId());
                Versao versaoCorrecao = new Versao();
                versaoCorrecao.setId(tarefas.get(0).getVersaoByIdVersaoCorrecao().getId());
                tar.setVersaoByIdVersaoBug(versaoBug);
                tar.setVersaoByIdVersaoCorrecao(versaoCorrecao);
                tar.setTitulo(tarefas.get(0).getTitulo());
                tar.setDescricao(tarefas.get(0).getDescricao());
                tar.setDatahoraCriacao(tarefas.get(0).getDatahoraCriacao());
                tar.setDatahoraPrevisao(tarefas.get(0).getDatahoraPrevisao());

                Modulo modulo = new Modulo();
                modulo.setId(tarefas.get(0).getModulo().getId());
                tar.setModulo(modulo);
                Prioridade prioridade = new Prioridade();
                prioridade.setId(tarefas.get(0).getPrioridade().getId());
                tar.setPrioridade(prioridade);
                Projeto projeto = new Projeto();
                projeto.setId(tarefas.get(0).getProjeto().getId());
                tar.setProjeto(projeto);
                Usuario autor = new Usuario();
                autor.setId(tarefas.get(0).getUsuarioByIdUsuarioAutor().getId());
                tar.setUsuarioByIdUsuarioAutor(autor);
                Usuario responsavel = new Usuario();
                responsavel.setId(tarefas.get(0).getUsuarioByIdUsuarioResponsavel().getId());
                tar.setUsuarioByIdUsuarioResponsavel(responsavel);
                Motivo motivo = new Motivo();
                motivo.setId(tarefas.get(0).getMotivo().getId());
                tar.setMotivo(motivo);
                tar.setFase(fas);

                tar.setSituacao('I');
                int retorno;

                retorno = controleTarefa.salvar(tar);

                request.setAttribute("paginaOrigem", "cadastroTarefa.jsp");

                if (retorno == 1) {
                    out.println("ok");
                } else {
                    out.println("erro");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

        }

        if (parametro.equals("exMotivo")) {

            PrintWriter out = response.getWriter();

            try {
                int id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                Motivo motiv = new Motivo();
                motiv.setId(id);

                motiv.setDescricao("");
                motiv.setSituacao('I');

                int retorno = new ControleMotivo().salvar(motiv);

                request.setAttribute("paginaOrigem", "cadastroMotivo.jsp");

                if (retorno == 1) {
                    out.println("ok");
                } else {
                    out.println("erro");
                }
            } catch (Exception e) {
                out.println("" + e);
            }

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

        if (parametro.equals("excelTarefasResumo")) {

            TarefaDAO tarefaDAO = new TarefaDAO();
            ArrayList<Tarefa> tarefas = new ArrayList<>();

            try {
                tarefas = tarefaDAO.gerarExcelResumoPorPeriodo(request.getParameter("datainclusaoinicio"), request.getParameter("datainclusaofinal"));

                //arquivo = new Arquivo("C:\\Users\\Mileto\\Documents\\NetBeansProjects\\HelpWeb\\src\\java\\servlet\\Excel.csv");
                String textoArquivo = "";
                //   if (arquivo.abrirEscrita(true)) {

                String cabecalho = "Id;Titulo;Cliente;Projeto;Motivo;Modulo;Prioridade;Fase;Autor;Responsavel;Versao Bug;Versao Correção";
                // arquivo.escreverLinha(cabecalho);
                //  textoArquivo = textoArquivo + cabecalho + "\n";
                textoArquivo = cabecalho + "\n";
                //  arquivo.escreverLinha(cabecalho);
                for (int i = 0; i < tarefas.size(); i++) {
                    String linha = tarefas.get(i).getId() + ";"
                            + tarefas.get(i).getTitulo() + ";"
                            + tarefas.get(i).getCliente().getRazaoSocial() + ";"
                            + tarefas.get(i).getProjeto().getDescricao() + ";"
                            + tarefas.get(i).getMotivo().getDescricao() + ";"
                            + tarefas.get(i).getModulo().getDescricao() + ";"
                            + tarefas.get(i).getPrioridade().getDescricao() + ";"
                            + tarefas.get(i).getFase().getDescricao() + ";"
                            + tarefas.get(i).getUsuarioByIdUsuarioAutor().getNome() + ";"
                            + tarefas.get(i).getUsuarioByIdUsuarioResponsavel().getNome() + ";"
                            + tarefas.get(i).getVersaoByIdVersaoBug().getDescricao() + ";"
                            + tarefas.get(i).getVersaoByIdVersaoCorrecao().getDescricao() + ";";

                    textoArquivo = textoArquivo + linha + "\n";
                    //   arquivo.escreverLinha(linha);

                }
                // arquivo.fecharArquivo();

                //  }
                String txt = textoArquivo;
                File file = new File(txt);
                FileOutputStream teste = new FileOutputStream("Excel");
                teste.write(txt.getBytes());
                teste.flush();
                teste.close();
                response.setContentType("text/plain");
                response.setHeader("Content-disposition", "attachment; filename=" + "Tarefas por periodo" + ".csv");
                ServletOutputStream os = response.getOutputStream();
                os.write(txt.getBytes());
                os.flush();
                os.close();

            } catch (Exception e) {
                System.out.println("erro ao gerar excel jsp " + e);
            }

        }
        if (parametro.equals("excelTarefasResumoPorProjeto")) {

            TarefaDAO tarefaDAO = new TarefaDAO();
            ArrayList<Tarefa> tarefas = new ArrayList<>();

            try {
                tarefas = tarefaDAO.gerarExcelResumoPorPeriodoEProjeto(request.getParameter("datainclusaoinicio"), request.getParameter("datainclusaofinal"), Integer.parseInt(request.getParameter("idProjeto")));

                String textoArquivo = "";

                String cabecalho = "Id;Titulo;Cliente;Projeto;Motivo;Modulo;Prioridade;Fase;Autor;Responsavel;Versao Bug;Versao Correção";

                textoArquivo = cabecalho + "\n";

                for (int i = 0; i < tarefas.size(); i++) {
                    String linha = tarefas.get(i).getId() + ";"
                            + tarefas.get(i).getTitulo() + ";"
                            + tarefas.get(i).getCliente().getRazaoSocial() + ";"
                            + tarefas.get(i).getProjeto().getDescricao() + ";"
                            + tarefas.get(i).getMotivo().getDescricao() + ";"
                            + tarefas.get(i).getModulo().getDescricao() + ";"
                            + tarefas.get(i).getPrioridade().getDescricao() + ";"
                            + tarefas.get(i).getFase().getDescricao() + ";"
                            + tarefas.get(i).getUsuarioByIdUsuarioAutor().getNome() + ";"
                            + tarefas.get(i).getUsuarioByIdUsuarioResponsavel().getNome() + ";"
                            + tarefas.get(i).getVersaoByIdVersaoBug().getDescricao() + ";"
                            + tarefas.get(i).getVersaoByIdVersaoCorrecao().getDescricao() + ";";

                    textoArquivo = textoArquivo + linha + "\n";

                }

                String txt = textoArquivo;
                File file = new File(txt);
                FileOutputStream teste = new FileOutputStream("Excel");
                teste.write(txt.getBytes());
                teste.flush();
                teste.close();
                response.setContentType("text/plain");
                response.setHeader("Content-disposition", "attachment; filename=" + "Tarefas por periodo e projeto" + ".csv");
                ServletOutputStream os = response.getOutputStream();
                os.write(txt.getBytes());
                os.flush();
                os.close();

            } catch (Exception e) {
                System.out.println("erro ao gerar excel jsp " + e);
            }

        }


        if (parametro.equals("relTarefasResumo")) {

            TarefaDAO tarefaDAO = new TarefaDAO();
            try {
                byte[] bytes = tarefaDAO.gerarRelatorioResumoPorPeriodo(request.getParameter("datainclusaoinicio"), request.getParameter("datainclusaofinal"));

                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream outStream = response.getOutputStream();
                outStream.write(bytes, 0, bytes.length);
                outStream.flush();
                outStream.close();
            } catch (Exception e) {
                System.out.println("erro ao gerar relatorio jsp " + e);
            }

        }

        if (parametro.equals("relTarefasPorProjeto")) {

            TarefaDAO tarefaDAO = new TarefaDAO();
            try {
                byte[] bytes = tarefaDAO.gerarRelatorioResumoPorPeriodoEProjeto(request.getParameter("datainclusaoinicio"), request.getParameter("datainclusaofinal"), Integer.parseInt(request.getParameter("idProjeto")));

                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream outStream = response.getOutputStream();
                outStream.write(bytes, 0, bytes.length);
                outStream.flush();
                outStream.close();
                response.getWriter().print("ok");
            } catch (Exception e) {
                System.out.println("erro ao gerar relatorio jsp " + e);
                response.getWriter().print("erro " + e);
            }

        }
        if (parametro.equals("relTarefasPorResponsavel")) {

            TarefaDAO tarefaDAO = new TarefaDAO();
            try {
                byte[] bytes = tarefaDAO.gerarRelatorioResumoPorPeriodoEResponsavel(request.getParameter("datainclusaoinicio"), request.getParameter("datainclusaofinal"));

                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream outStream = response.getOutputStream();
                outStream.write(bytes, 0, bytes.length);
                outStream.flush();
                outStream.close();
            } catch (Exception e) {
                System.out.println("erro ao gerar relatorio jsp " + e);
            }

        }

        if (parametro.equals("cadMovimentacao")) {
            String idTarefa = request.getParameter("idTarefa");
            String movimentacao = request.getParameter("movimentacao");
            PrintWriter out = response.getWriter();

            MovimentoTarefa movimentacaoTarefa = new MovimentoTarefa();
            try {
                Usuario autorMovimento = new Usuario();
                TarefaDAO tarefaDAO = new TarefaDAO();
                HttpSession sessao = request.getSession();

                autorMovimento.setId(Integer.parseInt(sessao.getAttribute("usuarioLogado").toString()));

                ArrayList<Tarefa> tarefa = tarefaDAO.consultarId(Integer.valueOf(idTarefa));
                movimentacaoTarefa.setTarefa(tarefa.get(0));
                movimentacaoTarefa.setSituacao('A');

                movimentacaoTarefa.setUsuario(autorMovimento);
                movimentacaoTarefa.setDatahoraMovimento(new Date());
                movimentacaoTarefa.setDescricao(movimentacao);
                movimentacaoTarefa.setAnexo("teste");

                ControleMovimentacaoTarefa controleMovimento = new ControleMovimentacaoTarefa();
                int retorno = controleMovimento.salvar(movimentacaoTarefa);

                if (retorno == 1) {
                    out.println("ok");
                    //redirecionarPagina("cadastroCidade.jsp?m=1", request, response);
                } else if (retorno == 2) {
                    out.println("Descrição precisa ter mais que 3 caracteres");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 6) {
                    out.println("Erro ao salvar");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }

            } catch (Exception e) {
                System.out.println("Erro ao salvar movimentação " + e);
                out.println("" + e);
            }

        }

        if (parametro.equals("listarTarefas")) {

            //-----------------------//
            String idTarefa = request.getParameter("id");
            String idCliente = request.getParameter("cliente");
            String idProjeto = request.getParameter("projeto");
            String idPrioridade = request.getParameter("prioridade");
            String idMotivo = request.getParameter("motivo");
            String idModulo = request.getParameter("modulo");
            String idFase = request.getParameter("fase");
            String idVersaoBug = request.getParameter("versao");
            String idVersaoCorrecao = request.getParameter("versaoCorrecao");
            String idAutor = request.getParameter("autor");
            String idResponsavel = request.getParameter("responsavel");
//
            Tarefa tarefa = new Tarefa();

            Cliente cliente = new Cliente();
            Fase fase = new Fase();
            Modulo modulo = new Modulo();
            Motivo motivo = new Motivo();
            Prioridade prioridade = new Prioridade();
            Projeto projeto = new Projeto();
            Versao versaoBug = new Versao();
            Versao versaoCorrecao = new Versao();
            Usuario autor = new Usuario();
            Usuario responsavel = new Usuario();

            cliente.setId(Integer.parseInt(idCliente));
            tarefa.setCliente(cliente);
            //  tarefa.setDescricao(request.getParameter("descricao"));
            fase.setId(Integer.parseInt(idFase));
            System.out.println("id da fase = " + idFase);
            tarefa.setFase(fase);
            modulo.setId(Integer.parseInt(idModulo));
            tarefa.setModulo(modulo);
            motivo.setId(Integer.parseInt(idMotivo));
            tarefa.setMotivo(motivo);
            prioridade.setId(Integer.parseInt(idPrioridade));
            tarefa.setPrioridade(prioridade);
            projeto.setId(Integer.parseInt(idProjeto));
            tarefa.setProjeto(projeto);
            tarefa.setSituacao('A');
            try {
                tarefa.setId(Integer.parseInt(idTarefa));
            } catch (Exception e) {
            }

            versaoBug.setId(Integer.parseInt(idVersaoBug));
            tarefa.setVersaoByIdVersaoBug(versaoBug);
            versaoCorrecao.setId(Integer.parseInt(idVersaoCorrecao));
            tarefa.setVersaoByIdVersaoCorrecao(versaoCorrecao);
            responsavel.setId(Integer.parseInt(idResponsavel));
            tarefa.setUsuarioByIdUsuarioResponsavel(responsavel);
            autor.setId(Integer.parseInt(idAutor));
            tarefa.setUsuarioByIdUsuarioAutor(autor);

            TarefaDAO tarefaDAO = new TarefaDAO();
            ArrayList<Tarefa> tarefas = new ArrayList<>();
            tarefas = tarefaDAO.listarComParametro(tarefa);

            request.setAttribute("tarefas", tarefas);
            request.setAttribute("tarefa", tarefa);
            encaminharPagina("listaTarefas.jsp", request, response);
        }

        if (parametro.equals("cadTarefa")) {

            PrintWriter out = response.getWriter();

            try {
                String idCliente = request.getParameter("cliente");
                String idProjeto = request.getParameter("projeto");
                String idPrioridade = request.getParameter("prioridade");
                String idMotivo = request.getParameter("motivo");
                String idModulo = request.getParameter("modulo");
                String idFase = request.getParameter("fase");
                String idVersaoBug = request.getParameter("versao");
                String idVersaoCorrecao = request.getParameter("versaoCorrecao");
                String idAutor = request.getParameter("autor");
                String idResponsavel = request.getParameter("responsavel");

                Tarefa tarefa = new Tarefa();

                Cliente cliente = new Cliente();
                Fase fase = new Fase();
                Modulo modulo = new Modulo();
                Motivo motivo = new Motivo();
                Prioridade prioridade = new Prioridade();
                Projeto projeto = new Projeto();
                Versao versaoBug = new Versao();
                Versao versaoCorrecao = new Versao();
                Usuario autor = new Usuario();
                Usuario responsavel = new Usuario();

                int idTarefa;
                if (request.getParameter("id").equals("")) {
                    idTarefa = 0;
                } else {
                    idTarefa = Integer.parseInt(String.valueOf(request.getParameter("id")));
                }

                tarefa.setId(idTarefa);
                cliente.setId(Integer.parseInt(idCliente));
                tarefa.setCliente(cliente);
                tarefa.setDescricao(request.getParameter("descricao"));
                fase.setId(Integer.parseInt(idFase));
                tarefa.setFase(fase);
                modulo.setId(Integer.parseInt(idModulo));
                tarefa.setModulo(modulo);
                motivo.setId(Integer.parseInt(idMotivo));
                tarefa.setMotivo(motivo);
                prioridade.setId(Integer.parseInt(idPrioridade));
                tarefa.setPrioridade(prioridade);
                projeto.setId(Integer.parseInt(idProjeto));
                tarefa.setProjeto(projeto);
                tarefa.setSituacao('A');
                tarefa.setTitulo(request.getParameter("titulo"));

                SimpleDateFormat formato = new SimpleDateFormat("yyyy/MM/dd");

                try {
                    Date data = formato.parse(request.getParameter("dataPrevisao").replace("-", "/"));
                    tarefa.setDatahoraPrevisao(data);
                } catch (ParseException ex) {
                    Logger.getLogger(acao.class.getName()).log(Level.SEVERE, null, ex);

                }

                tarefa.setDatahoraCriacao(new Date());

                versaoBug.setId(Integer.parseInt(idVersaoBug));
                tarefa.setVersaoByIdVersaoBug(versaoBug);
                versaoCorrecao.setId(Integer.parseInt(idVersaoCorrecao));
                tarefa.setVersaoByIdVersaoCorrecao(versaoCorrecao);
                responsavel.setId(Integer.parseInt(idResponsavel));
                tarefa.setUsuarioByIdUsuarioResponsavel(responsavel);
                autor.setId(Integer.parseInt(idAutor));
                tarefa.setUsuarioByIdUsuarioAutor(autor);

                ControleTarefa controleTarefa = new ControleTarefa();
                int retorno = controleTarefa.salvar(tarefa);

//            MovimentoTarefa movimentacaoTarefa = new MovimentoTarefa();
//            try {
//                Usuario autorMovimento = new Usuario();
//                HttpSession sessao = request.getSession();
//
//                autorMovimento.setId(Integer.parseInt(sessao.getAttribute("usuarioLogado").toString()));
//
//                movimentacaoTarefa.setTarefa(tarefa);
//                movimentacaoTarefa.setSituacao('A');
//
//                movimentacaoTarefa.setUsuario(autorMovimento);
//                movimentacaoTarefa.setDatahoraMovimento(new Date());
//                movimentacaoTarefa.setDescricao(request.getParameter("movimentacao"));
//                movimentacaoTarefa.setAnexo("teste");
//
//                ControleMovimentacaoTarefa controleMovimento = new ControleMovimentacaoTarefa();
//                controleMovimento.salvar(movimentacaoTarefa);
//            } catch (Exception e) {
//                System.out.println("Erro ao salvar movimentação " + e);
//            }
                request.setAttribute("paginaOrigem", "cadastroTarefa.jsp");

                if (retorno == 1) {
                    out.println("ok");
                    //redirecionarPagina("cadastroCidade.jsp?m=1", request, response);
                } else if (retorno == 2) {
                    out.println("Título precisa ter de 3 até 100 caracteres");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Descrição precisa ter de 3 até 100 caracteres");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }
            } catch (Exception e) {
            }

        }

        if (parametro.equals("cadMotivo")) {
            PrintWriter out = response.getWriter();
            try {
                Motivo motiv = new Motivo();
                int id;
                if (request.getParameter("id").equals("")) {
                    id = 0;
                } else {
                    id = Integer.parseInt(String.valueOf(request.getParameter("id")));
                }
                motiv.setId(id);
                motiv.setDescricao(request.getParameter("descricao"));
                motiv.setSituacao('A');

                ControleMotivo controleMotivo = new ControleMotivo();
                int retorno = controleMotivo.salvar(motiv);

                request.setAttribute("paginaOrigem", "cadastroProjeto.jsp");

                if (retorno == 1) {
                    out.println("ok");
                    //redirecionarPagina("cadastroCidade.jsp?m=1", request, response);
                } else if (retorno == 2) {
                    out.println("Nome precisa ter de 3 até 45 caractere");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else if (retorno == 3) {
                    out.println("Motivo já cadastrado");
                    //redirecionarPagina("cadastroCidade.jsp?m=" + retorno, request, response);
                } else {
                    out.println("Erro desconhecido");
                }

            } catch (Exception e) {
                out.println("Erro desconhecido" + e);
            }

        }

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
                out.println("" + e);
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
                    out.println("Projeto já cadastrado");
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
                    out.println("Fase já cadastrada");
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
                    out.println("Prioridade já cadastrada");
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
                    out.println("Modulo já cadastrado");
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

                    }
                    response.sendRedirect("inicio.jsp");
                } else {
                    redirecionarPagina("index.jsp?m=2", request, response);
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
