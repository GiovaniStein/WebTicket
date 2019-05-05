<%@page import="java.util.ArrayList"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="entidade.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<aside id="lateral-menu-bar"
       style="background-color: #2d2d2d"
       class="main-sidebar">
    <section class="sidebar">
        <div style="height: 40px"
             class="user-panel">
            <div style="display: inline-flex; left: 0px"
                 class="pull-left info">
                <%
                    Usuario logad = new Usuario();
                    logad.setId(Integer.parseInt(session.getAttribute("usuarioLogado").toString()));
                    System.out.println(logad.getId() + "....id");
                    logad.setNome("");
                    logad.setLogin("");
                    logad.setSituacao('A');
                    UsuarioDAO usDAO = new UsuarioDAO();
                    ArrayList<Usuario> usrs = usDAO.consultarId(logad.getId());
                %>
                <p><%=usrs.get(0).getNome()%></p>
                <a style="padding-left: 8px"
                   href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>

        <ul class="sidebar-menu"
            data-widget="tree">
            <li class="header"><h4>Menu principal</h4></li>
            <li class="treeview">
                <a href="">
                    <i class="fa fa-edit"></i> 
                    <span>Cadastros</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-down pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="cadastroCliente.jsp"><i class="fa fa-group"></i> Cliente</a></li>
                    <li><a href="cadastroCidade.jsp"><i class="fa fa-map-marker"></i> Cidade</a></li>
                    <li><a href="cadastroProjeto.jsp"><i class="fa fa-tasks"></i> Projeto</a></li>
                    <li><a href="cadastroFase.jsp"><i class="fa fa-list-ol"></i> Fase</a></li>
                    <li><a href="cadastroModulo.jsp"><i class="fa fa-cubes"></i> Módulo</a></li>
                    <li><a href="cadastroMotivo.jsp"><i class="fa fa-commenting-o"></i> Motivo</a></li>
                    <li><a href="cadastroPrioridade.jsp"><i class="fa fa-th-list"></i> Prioridade</a></li>
                    <li><a href="cadastroVersao.jsp"><i class="fa fa-hdd-o"></i> Versão</a></li>
                    <li><a href="cadastroUsuario.jsp"><i class="fa fa-id-badge"></i> Usuário</a></li>
                </ul>
            </li>

            <li class="treeview">
                <a href="">
                    <i class="fa fa-th-large"> </i>
                    <span>Tarefas</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-down pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="cadastroTarefa.jsp"><i class="fa fa-pencil-square-o"></i> Cadastrar</a></li>
                    <li><a href="listaTarefas.jsp"><i class="fa fa-list"></i> Listar</a></li>
                </ul>
            </li>

            <li class="treeview">
                <a href="">
                    <i class="fa fa-file-text-o"> </i>
                    <span>Relatórios</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-down pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="relTarefas.jsp" target="_blank"><i class="fa fa-list"></i> Tarefas (geral)</a></li>
                    <li><a href="relTarefasPorProjeto.jsp"><i class="fa fa-trello"></i> Tarefas de projeto
                            <br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbspespecífico</a></li>
                    <li><a href="relTarefasPorResponsavel.jsp"><i class="fa fa-user-circle-o"></i> Tarefas por
                            <br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbspresponsável</a></li>
                    <li><a href="relTarefasResumo.jsp"><i class="fa fa-table"></i> Tarefas por período</a></li>
                    <li><a href="ExcelTarefasResumo.jsp"><i class="fa fa-table"></i> Tarefas por período
                            <br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp(.xls)</a></li>
                    <li><a href="ExcelTarefasResumoPorProjeto.jsp"><i class="fa fa-wpforms"></i> Tarefas por projeto
                            <br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbspe período (.xls)</a></li>
                </ul>
            </li>
        </ul>
    </section>

    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>

   
    <script>
        var x = $("#lateral-menu-bar");
        var height = screen.height;
        x.height(height);
    </script>
</aside>


