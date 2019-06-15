<%@page import="entidade.Tarefa"%>
<%@page import="DAO.ClienteDAO"%>
<%@page import="entidade.Cliente"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="entidade.Usuario"%>
<%@page import="entidade.Modulo"%>
<%@page import="entidade.Fase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.VersaoDAO"%>
<%@page import="DAO.ModuloDAO"%>
<%@page import="DAO.FaseDAO"%>
<%@page import="DAO.PrioridadeDAO"%>
<%@page import="apoio.Formatacao"%>
<%@page import="DAO.ProjetoDAO"%>
<%@page import="DAO.MotivoDAO"%>
<%@page import="entidade.Versao"%>
<%@page import="entidade.Prioridade"%>
<%@page import="entidade.Motivo"%>
<%@page import="entidade.Projeto"%>
<%@page import="entidade.Cidade"%>


<!--<html>-->


<!--    <body class="hold-transition skin-blue sidebar-mini">-->
<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>
<%//@include file = "inicio-teste.jsp"%>

<%
    ArrayList<Tarefa> tarefas = (ArrayList<Tarefa>) request.getAttribute("tarefas");
    Tarefa tar = (Tarefa) request.getAttribute("tarefa");

    if (tarefas == null) {
        tarefas = new ArrayList<Tarefa>();
    } else {
        System.out.println("tamanho tela - " + tarefas.size());
    }

    if (tar == null) {
        tar = new Tarefa();
        tar.setTitulo("");
        tar.setDescricao("");
        tar.setSituacao('A');
        Cidade cidade = new Cidade();
        Usuario autor = new Usuario();
        Usuario responsavel = new Usuario();

        Cliente cli = new Cliente();
        Projeto projeto = new Projeto();
        Motivo motivo = new Motivo();
        Modulo modulo = new Modulo();
        Fase fase = new Fase();
        tar.setFase(fase);
        Prioridade prioridade = new Prioridade();
        tar.setPrioridade(prioridade);
        Versao versaoBug = new Versao();
        tar.setVersaoByIdVersaoBug(versaoBug);
        Versao versaoCorrecao = new Versao();
        tar.setVersaoByIdVersaoCorrecao(versaoCorrecao);
        tar.setModulo(modulo);
        tar.setMotivo(motivo);
        cli.setCidade(cidade);
        tar.setCliente(cli);
        tar.setUsuarioByIdUsuarioAutor(autor);
        tar.setUsuarioByIdUsuarioResponsavel(responsavel);
        tar.setProjeto(projeto);
    }
%>

<!-- Content Wrapper. Contains page content -->
<div id="listaTarefasContainer">
    <div style="height: 300px;overflow: auto;min-height: 768px;" class="content-wrapper">

        <!-- Main content -->
        <section class="content">
            <div class="row">

                <!-- right column -->
                <div class="col-md-12">
                    <!-- Horizontal Form -->
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">Listagem de tarefa</h3>
                        </div>

                        <form name="cadCidade" class="form-horizontal" action="/WebTicket/acao?parametro=listarTarefas" method="post">
                            <div class="box-body">


                                <div class="form-group">
                                    <label for="id" class="col-sm-1 control-label" >ID</label>

                                    <div class="col-sm-1">
                                        <%                                                       if (tar.getId() > 0) {%>
                                        <input type="text" class="form-control" name="id" value="<%= tar.getId()%>"  >
                                        <%} else {
                                        %>

                                        <input type="text" class="form-control" name="id" value=""  >
                                        <%
                                            }
                                        %>

                                    </div>

                                    <label for="cliente" class="col-sm-1 control-label">Cliente*</label>
                                    <div class="col-sm-4">
                                        <select id="selectCliente" class="form-control select2" name="cliente">
                                            <option value="0">Selecione </option>
                                            <%
                                                Cliente cli = new Cliente();
                                                cli.setRazaoSocial("");
                                                cli.setSituacao('A');

                                                ArrayList<Cliente> clientes = new ClienteDAO().listar(cli);

                                                for (int i = 0; i < clientes.size(); i++) {
                                                    if (tar.getCliente().getId() == clientes.get(i).getId()) {
                                            %>
                                            <option value="<%=clientes.get(i).getId()%>" selected><%=clientes.get(i).getRazaoSocial()%> </option>

                                            <%
                                            } else {
                                            %>
                                            <option value="<%=clientes.get(i).getId()%>"><%=clientes.get(i).getRazaoSocial()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>


                                <div class="form-group">


                                    <label  for="autor" class="col-sm-1 control-label"  >Autor</label>


                                    <div class="col-sm-2">
                                        <select id="selectAutor" class="form-control select2"  name="autor"  >
                                            <!--disabled = "true"-->
                                            <%
                                                Usuario autor = new Usuario();
                                                if (tar.getId() == 0) {
                                                    autor.setId(Integer.parseInt(session.getAttribute("usuarioLogado").toString()));
                                                }

                                                //System.out.println(autor.getId() + "....id");
                                                autor.setNome("");
                                                autor.setLogin("");
                                                autor.setSituacao('A');
                                                //tar.setUsuarioByIdUsuarioAutor(autor);
                                                //System.out.println(" id do autor.... "+tar.getUsuarioByIdUsuarioAutor().getId());

                                                UsuarioDAO usuarioDAO = new UsuarioDAO();
                                                ArrayList<Usuario> usuarios = usuarioDAO.listar(autor);

                                                for (int i = 0; i < usuarios.size(); i++) {
                                                    //System.out.println(usuarios.size()+".. tamanho");
                                                    if (tar.getUsuarioByIdUsuarioAutor().getId() == usuarios.get(i).getId()) {
                                            %>
                                            <option  value="<%=usuarios.get(i).getId()%>"  selected ><%=usuarios.get(i).getNome()%>  </option>

                                            <%
                                            } else {
                                            %>
                                            <option  value="<%=usuarios.get(i).getId()%>"><%=usuarios.get(i).getNome()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>





                                    <label for="responsavel" class="col-sm-1 control-label">Responsavel*</label>


                                    <div class="col-sm-2">
                                        <select id="selectResponsavel" class="form-control select2"  name="responsavel">

                                            <option value="0" >Selecione </option>

                                            <%
                                                Usuario responsavel = new Usuario();
                                                responsavel.setNome("");
                                                responsavel.setLogin("");
                                                responsavel.setRepetirSenha("");
                                                responsavel.setSenha("");

                                                responsavel.setSituacao('A');
                                                //tar.setUsuarioByIdUsuarioResponsavel(responsavel);

                                                UsuarioDAO responsavelDAO = new UsuarioDAO();
                                                ArrayList<Usuario> responsaveis = responsavelDAO.listar(responsavel);

                                                for (int i = 0; i < responsaveis.size(); i++) {
                                                    // System.out.println(responsaveis.size() + ".. tamanho");
                                                    if (tar.getUsuarioByIdUsuarioResponsavel().getId() == responsaveis.get(i).getId()) {
                                            %>
                                            <option value="<%=responsaveis.get(i).getId()%>" selected><%=responsaveis.get(i).getNome()%> </option>

                                            <%
                                            } else {
                                            %>
                                            <option value="<%=responsaveis.get(i).getId()%>"><%=responsaveis.get(i).getNome()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>

                                    </div>




                                    <label for="projeto" class="col-sm-1 control-label">Projeto*</label>


                                    <div class="col-sm-2">
                                        <select id="selectProjeto" onchange="changeData()" class="form-control select2" name="projeto" >

                                            <option value="0" >Selecione </option>

                                            <%
                                                Projeto projeto = new Projeto();
                                                projeto.setDescricao("");
                                                projeto.setSituacao('A');
                                                // tar.setProjeto(projeto);

                                                ProjetoDAO projetoDAO = new ProjetoDAO();
                                                ArrayList<Projeto> projetos = projetoDAO.listar(projeto);

                                                for (int i = 0; i < projetos.size(); i++) {
                                                    // System.out.println(projetos.size()+".. tamanho");
                                                    if (tar.getProjeto().getId() == projetos.get(i).getId()) {
                                            %>
                                            <option value="<%=projetos.get(i).getId()%>" selected><%=projetos.get(i).getDescricao()%> </option>

                                            <%
                                            } else {
                                            %>
                                            <option value="<%=projetos.get(i).getId()%>"><%=projetos.get(i).getDescricao()%></option>
                                            <%
                                                    }
                                                }
                                            %>


                                        </select>
                                    </div>

                                    <label for="motivo" class="col-sm-1 control-label">Motivo*</label>

                                    <div class="col-sm-2">
                                        <select id="selectMotivo" class="form-control select2" name="motivo" >

                                            <option value="0">Selecione </option>

                                            <%
                                                Motivo motivo = new Motivo();
                                                motivo.setDescricao("");
                                                motivo.setSituacao('A');

                                                //tar.setMotivo(motivo);
                                                MotivoDAO motivoDAO = new MotivoDAO();
                                                ArrayList<Motivo> motivos = motivoDAO.listar(motivo);

                                                for (int i = 0; i < motivos.size(); i++) {
                                                    // System.out.println(projetos.size()+".. tamanho");
                                                    if (tar.getMotivo().getId() == motivos.get(i).getId()) {
                                            %>
                                            <option value="<%=motivos.get(i).getId()%>" selected><%=motivos.get(i).getDescricao()%> </option>

                                            <%
                                            } else {
                                            %>
                                            <option value="<%=motivos.get(i).getId()%>"><%=motivos.get(i).getDescricao()%></option>
                                            <%
                                                    }
                                                }
                                            %>

                                        </select>
                                    </div>

                                </div>

                                <div class="form-group">



                                    <label for="moculo" class="col-sm-1 control-label">Módulo*</label>


                                    <div class="col-sm-2">
                                        <select disabled="disabled" id="selectModulo"  class="form-control select2" name="modulo" >
                                           <option value="0">Selecione um projeto</option>
                                        </select>
                                    </div>



                                    <label for="fase" class="col-sm-1 control-label">Fase*</label>


                                    <div class="col-sm-2">
                                        <select id="selectFase" class="form-control select2" name="fase">

                                            <option value="0" >Selecione </option>

                                            <%
                                                Fase fase = new Fase();
                                                fase.setDescricao("");
                                                fase.setSituacao('A');
                                                //tar.setFase(fase);

                                                FaseDAO faseDAO = new FaseDAO();
                                                ArrayList<Fase> fases = faseDAO.listar(fase);

                                                for (int i = 0; i < fases.size(); i++) {
                                                    // System.out.println(projetos.size()+".. tamanho");
                                                    if (tar.getFase().getId() == fases.get(i).getId()) {
                                            %>
                                            <option value="<%=fases.get(i).getId()%>" selected><%=fases.get(i).getDescricao()%> </option>

                                            <%
                                            } else {
                                            %>
                                            <option value="<%=fases.get(i).getId()%>"><%=fases.get(i).getDescricao()%></option>
                                            <%
                                                    }
                                                }
                                            %>

                                        </select>
                                    </div>



                                    <label  for="prioridade" class="col-sm-1 control-label">Prioridade*</label>


                                    <div class="col-sm-2">
                                        <select  id="selectPrioridade" class="form-control select2" name="prioridade" >

                                            <option value="0">Selecione </option>

                                            <%
                                                Prioridade prioridade = new Prioridade();
                                                prioridade.setDescricao("");
                                                prioridade.setSituacao('A');

                                                PrioridadeDAO prioridadeDAO = new PrioridadeDAO();
                                                ArrayList<Prioridade> prioridades = prioridadeDAO.listar(prioridade);

                                                for (int i = 0; i < prioridades.size(); i++) {
                                                    // System.out.println(projetos.size()+".. tamanho");
                                                    if (tar.getPrioridade().getId() == prioridades.get(i).getId()) {
                                            %>
                                            <option value="<%=prioridades.get(i).getId()%>" selected><%=prioridades.get(i).getDescricao()%> </option>

                                            <%
                                            } else {
                                            %>
                                            <option value="<%=prioridades.get(i).getId()%>"><%=prioridades.get(i).getDescricao()%></option>
                                            <%
                                                    }
                                                }
                                            %>

                                        </select>
                                    </div>


                                    <label  for="versao" class="col-sm-1 control-label">V.BUG*</label>


                                    <div class="col-sm-2">
                                        <select disabled="disabled" id="selectVersao"  class="form-control select2" name="versao" >
                                            <option value="0">Selecione um projeto</option>
                                        </select>
                                    </div>


                                </div>

                                <div class="form-group">


                                    <label  for="versaoCorrecao" class="col-sm-1 control-label">Correção*</label>


                                    <div class="col-sm-2">
                                        <select disabled="disabled" id="selectVersaoCorrecao"  class="form-control select2" name="versaoCorrecao" >

                                            <option value="0">Selecione um projeto</option>

                                        </select>
                                    </div>

                                </div>


                            </div>



                            <div class="box-footer">

                                <input id="buttonPesquisar" style="float: right;width: 95px;background-color: #1087dd;" type="submit" class="btn btn-dropbox pull-right-container" name="enviar" value="Listar"> 

                            </div>

                        </form>

                    </div>

                </div>
                <!--/.col (right) -->
            </div>
            <!-- /.row -->
        </section>

        <div id="listadeTarefas">
            <%@include file = "listaTarefas_1.jsp"%>
        </div>                        

        <!-- /.content -->
    </div>
</div>


<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script src="bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="bower_components/select2/dist/js/select2.full.js"></script>
<script src="plugins/input-mask/jquery.inputmask.js"></script>
<script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
<script src="bower_components/moment/min/moment.min.js"></script>
<script src="bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<script src="bower_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
<script src="plugins/timepicker/bootstrap-timepicker.min.js"></script>
<script src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="plugins/iCheck/icheck.min.js"></script>
<script src="bower_components/fastclick/lib/fastclick.js"></script>
<script src="dist/js/adminlte.min.js"></script>
<script src="dist/js/demo.js"></script>



<!--<script src="../../bower_components/jquery/dist/jquery.min.js"></script>-->
<!-- Bootstrap 3.3.7 -->
<!--<script src="../../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>-->
<!-- FastClick -->
<!--<script src="../../bower_components/fastclick/lib/fastclick.js"></script>-->
<!-- AdminLTE App -->
<!--<script src="../../dist/js/adminlte.min.js"></script>-->
<!-- AdminLTE for demo purposes -->
<!--<script src="../../dist/js/demo.js"></script>-->
<!-- CK Editor -->
<script src="bower_components/ckeditor/ckeditor.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>

<!-- page script -->
<script>
    $(function () {
        $('#example1').DataTable()
        $('#example2').DataTable({
            'paging': true,
            'lengthChange': false,
            'searching': false,
            'ordering': true,
            'info': true,
            'autoWidth': false
        })
    })
</script>    
<script src="js/CrudActionsEditTarefa.js" type="text/javascript" charset="utf-8"></script>
<script src="js/CrudSelectComponentData.js" type="text/javascript" charset="utf-8"></script>
