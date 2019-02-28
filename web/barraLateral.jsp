
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="entidade.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<aside id="lateral-menu-bar" style="background-color: #2d2d2d" class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div style="height: 40px" class="user-panel">
            
            <div style="display: inline-flex; left: 0px" class="pull-left info">
                <%
                    Usuario logad = new Usuario();

                    logad.setId(Integer.parseInt(session.getAttribute("usuarioLogado").toString()));

                    System.out.println(logad.getId() + "....id");
                    logad.setNome("");
                    logad.setLogin("");
                    logad.setSituacao('A');
                    //tar.setUsuarioByIdUsuarioAutor(autor);
                    //System.out.println(" id do autor.... "+tar.getUsuarioByIdUsuarioAutor().getId());

                    UsuarioDAO usDAO = new UsuarioDAO();
                    ArrayList<Usuario> usrs = usDAO.listar(logad);

                %>




                <p><%=usrs.get(0).getNome()%></p>
                <a style="padding-left: 8px" href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <ul class="sidebar-menu" data-widget="tree">
            <li class="header"><h4>Menu principal</h4>
            </li>
            <li class="treeview">
                <a  href="">
                    <i class="fa fa-address-card"></i> 
                    <span>Cadastros</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="cadastroCliente.jsp"><i class="fa fa-circle-o"></i> Clientes</a></li>
                    <!-- <li class="active"><a href="cadastroCidade.jsp"><i class="fa fa-circle-o"></i> Cidades</a></li>-->  
                    <li><a href="cadastroCidade.jsp"><i class="fa fa-circle-o"></i> Cidades</a></li>
                    <li><a href="cadastroVersao.jsp"><i class="fa fa-vimeo"></i> Cadastro de Versão</a></li>
                    <li><a href="cadastroMotivo.jsp"><i class="fa fa-commenting-o"></i> Cadastro de Motivo</a></li>
                    <li><a href="cadastroProjeto.jsp"><i class="fa fa-cogs"></i> Cadastro de Projeto</a></li>
                    <li><a href="cadastroModulo.jsp"><i class="fa fa-cubes"></i> Cadastro de Módulo</a></li>
                    <li><a href="cadastroPrioridade.jsp"><i class="fa fa-cubes"></i> Cadastro de Prioridade</a></li>
                    <li><a href="cadastroFase.jsp"><i class="fa fa-cubes"></i> Cadastro de Fase</a></li>
                    <li><a href="cadastroUsuario.jsp"><i class="fa fa-cubes"></i> Cadastro de Usuário</a></li>

                </ul>
            </li>

            

            <li class="treeview">
                <a href="">
                    <i class="fa fa-cogs"> </i>
                    <span>Tarefa</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="cadastroTarefa.jsp"><i class="fa fa-vimeo"></i> Cadastro de Tarefa</a></li>
                    <li><a href="listaTarefas1.jsp"><i class="fa fa-vimeo"></i> Listagem de Tarefas</a></li>

                </ul>
            </li>

            <li class="treeview">
                <a href="">
                    <i class="fa fa-cogs"> </i>
                    <span>Relatórios</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">

                    <li><a href="relTarefas.jsp"><i class="fa fa-vimeo"></i>Geral de Tarefas</a></li>
                    
                    <li><a href="relTarefasPorResponsavel.jsp"><i class="fa fa-vimeo"></i>Resumo Tarefas<BR>&nbsp&nbsp&nbsp&nbsp por responsável</a></li>
                    <li><a href="relTarefasResumo.jsp"><i class="fa fa-vimeo"></i>Resumo Tarefas<BR>&nbsp&nbsp&nbsp&nbsp por período</a></li>
                    <li><a href="relTarefasPorProjeto.jsp"><i class="fa fa-vimeo"></i>Resumo Tarefas <BR>&nbsp &nbsp &nbspde um Projeto</a></li>
                    <li><a href="ExcelTarefasResumo.jsp"><i class="fa fa-vimeo"></i>Excel Tarefas por período</a></li>
                    <li><a href="ExcelTarefasResumoPorProjeto.jsp"><i class="fa fa-vimeo"></i>Excel Tarefas <BR>&nbsp &nbsp &nbsp por período e de um projeto</a></li>
                    

                </ul>
            </li>

          
        </ul>
    </section>
    <!-- /.sidebar -->
    
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <script>
      var x = $("#lateral-menu-bar");
      var height = screen.height;
       x.height(height);
</script>
</aside>


