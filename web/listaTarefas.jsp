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
                                <label for="cliente" class="col-sm-0 control-label">Cliente*</label>

                                <select class="form-control select2" style="width: 20%;" name="cliente">
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

                            <div class="row">
                                <div class="col-xs-8 col-sm-5 col-md-8 col-lg-3" >
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-3 col-md-4 col-sm-4">
                                                <label style="float: right;" for="autor" class="col-sm-4 control-label"  >Autor</label>
                                            </div>

                                            <div class="col-xs-8">
                                                <select readonly class="form-control select2" style="width: 100%;" name="autor"  >
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

                                        </div>

                                    </div>
                                </div>
                                <div class="col-sm-3" >
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-3 col-sm-3">
                                                <label for="responsavel" class="col-sm-1 control-label">Responsavel*</label>

                                            </div>
                                            <div class="col-xs-8">
                                                <select class="form-control select2" style="width: 100%;" name="responsavel">

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


                                        </div>



                                    </div>

                                </div>

                                <div class="col-sm-3" >
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-3 ">
                                                <label style="float: right;" for="projeto" class="col-sm-0 control-label">Projeto*</label>
                                            </div>

                                            <div class="col-xs-8">
                                                <select  class="form-control select2" style="width: 100%;" name="projeto" >

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

                                        </div>

                                    </div>
                                </div>



                                <div class="col-xs-6 col-sm-3">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-4 col-sm-3">
                                                <label style="float: right;" for="motivo" class="col-sm-0 control-label">Motivo*</label>
                                            </div>

                                            <div class="col-xs-8 col-sm-8">
                                                <select  class="form-control select2" style="width: 100%;" name="motivo" >

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

                                    </div>
                                </div>



                            </div>

                            <div class="row">
                                <div class="col-xs-3 col-sm-3 " >
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-3 col-md-3 col-sm-3 col-lg-4">
                                                <label style="float: right;" for="moculo" class="col-sm-3 col-lg-5   control-label">Módulo*</label>
                                            </div>

                                            <div class="col-xs-8 col-lg-8">
                                                <select   class="form-control select2" style="width: 100%;" name="modulo" >

                                                    <option value="0">Selecione </option>

                                                    <%
                                                        Modulo modulo = new Modulo();
                                                        modulo.setDescricao("");
                                                        modulo.setSituacao('A');
                                                        // modulo.setProjeto(projeto);
                                                        //tar.setModulo(modulo);

                                                        ModuloDAO moduloDAO = new ModuloDAO();
                                                        ArrayList<Modulo> modulos = moduloDAO.listar(modulo);

                                                        for (int i = 0; i < modulos.size(); i++) {
                                                            // System.out.println(projetos.size()+".. tamanho");
                                                            if (tar.getModulo().getId() == modulos.get(i).getId()) {
                                                    %>
                                                    <option value="<%=modulos.get(i).getId()%>" selected><%=modulos.get(i).getDescricao()%> </option>

                                                    <%
                                                    } else {
                                                    %>
                                                    <option value="<%=modulos.get(i).getId()%>"><%=modulos.get(i).getDescricao()%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>

                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>



                                <div class="col-xs-3" >
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-3 col-sm-3">
                                                <label for="fase" class="col-sm-1 control-label">Fase*</label>

                                            </div>
                                            <div class="col-xs-8">
                                                <select class="form-control select2" style="width: 100%;" name="fase">

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
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xs-6 col-sm-3" >
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-4 col-sm-3">
                                                <label style="float: right;" for="prioridade" class="col-lg-0  control-label">Prioridade*</label>
                                            </div>

                                            <div class="col-xs-8">
                                                <select   class="form-control select2" style="width: 100%;" name="prioridade" >

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
                                        </div>
                                    </div>
                                </div>




                                <!-- -->
                            </div>

                            <div class="row">                                <!--<div class="col-xs-3 " >
//                                    <div class="form-group">
//
//
//                                        <label for="dataPrevisao" class="col-sm-4  control-label" >Previsão*</label>
//                                        <div class="row">
//                                            <div class="col-sm-7">                                                                                                      data-inputmask='"mask": "99/99/9999"' data-mask 
//                                                <input type="date" class="form-control" name="dataPrevisao"  value="<%//=tar.getDatahoraPrevisao()%>">
//                                            </div>
//                                        </div>
//                                    </div>
//                                </div> -->

                                <div class="col-xs-3 col-sm-3 " >
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-3 col-md-3 col-sm-3 col-lg-4">
                                                <label style="float: right;" for="versao" class="col-sm-3 col-lg-5   control-label">V.Bug*</label>
                                            </div>

                                            <div class="col-xs-8 ">
                                                <select   class="form-control select2" style="width: 100%;" name="versao" >

                                                    <option value="0">Selecione </option>


                                                    <%
                                                        Versao versaoBug = new Versao();
                                                        versaoBug.setDescricao("");
                                                        versaoBug.setSituacao('A');
                                                        //  versaoBug.setProjeto(projeto);
                                                        //    tar.setVersaoByIdVersaoBug(versaoBug);

                                                        VersaoDAO versaoBugDAO = new VersaoDAO();
                                                        ArrayList<Versao> versoesBug = versaoBugDAO.listar(versaoBug);

                                                        for (int i = 0; i < versoesBug.size(); i++) {
                                                            // System.out.println(projetos.size()+".. tamanho");
                                                            if (tar.getVersaoByIdVersaoBug().getId() == versoesBug.get(i).getId()) {
                                                    %>
                                                    <option value="<%=versoesBug.get(i).getId()%>" selected><%=versoesBug.get(i).getDescricao()%> </option>

                                                    <%
                                                    } else {
                                                    %>
                                                    <option value="<%=versoesBug.get(i).getId()%>"><%=versoesBug.get(i).getDescricao()%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>

                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xs-3" >
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-3">
                                                <label  for="versaoCorrecao" class="col-xs-4 control-label">Correção*</label>
                                            </div>

                                            <div class="col-xs-6">
                                                <select   class="form-control select2" style="width: 100%;" name="versaoCorrecao" >


                                                    <option value="0" >Selecione </option>

                                                    <%
                                                        Versao versaoCorrecao = new Versao();
                                                        versaoCorrecao.setDescricao("");
                                                        versaoCorrecao.setSituacao('A');
                                                        //  versaoCorrecao.setProjeto(projeto);
                                                        //tar.setVersaoByIdVersaoCorrecao(versaoCorrecao);

                                                        VersaoDAO versaoCorrecaoDAO = new VersaoDAO();
                                                        ArrayList<Versao> versoesCorrecao = versaoCorrecaoDAO.listar(versaoCorrecao);

                                                        for (int i = 0; i < versoesCorrecao.size(); i++) {
                                                            // System.out.println(projetos.size()+".. tamanho");
                                                            if (tar.getVersaoByIdVersaoCorrecao().getId() == versoesCorrecao.get(i).getId()) {
                                                    %>
                                                    <option value="<%=versoesCorrecao.get(i).getId()%>" selected><%=versoesCorrecao.get(i).getDescricao()%> </option>

                                                    <%
                                                    } else {
                                                    %>
                                                    <option value="<%=versoesCorrecao.get(i).getId()%>"><%=versoesCorrecao.get(i).getDescricao()%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>

                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <%
                                if (request.getParameterMap().containsKey("m") && (request.getParameter("m").equals("1") || request.getParameter("m").equals("10"))) {
                            %>
                            <div class="alert alert-success alert-dismissible">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-check"></i> Sucesso!</h4>
                                <%if (request.getParameter("m").equals("1")) {
                                %>
                                Cidade salva com sucesso!
                                <%
                                } else if (request.getParameter("m").equals("10")) {
                                %>
                                Cidade excluída com sucesso!
                                <%
                                    }
                                %>

                            </div>
                            <%                                        }
                            %>

                            <%
                                if (request.getParameterMap().containsKey("m") && (request.getParameter("m").equals("2") || request.getParameter("m").equals("3"))) {
                            %>
                            <div class="alert alert-danger">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-ban"></i> Erro!</h4>
                                <%if (request.getParameter("m").equals("2")) {
                                %>
                                <h5>Erro ao salvar cidade!</h5><br>
                                <h5>Nome precisa ter de 3 até 45 caracteres.</h5>   
                                <% } else if (request.getParameter("m").equals("3")) {

                                %>

                                Erro ao salvar cidade!<br>  
                                Cidade já cadastrada.

                                <%                                }

                                %>

                            </div>
                            <%                                        }
                            %>

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


<script>
    $(function () {
        //Initialize Select2 Elements
        $('.select2').select2()

        //Datemask dd/mm/yyyy
        $('#datemask').inputmask('dd/mm/yyyy', {'placeholder': 'dd/mm/yyyy'})
        //Datemask2 mm/dd/yyyy
        $('#datemask2').inputmask('mm/dd/yyyy', {'placeholder': 'mm/dd/yyyy'})
        //Money Euro
        $('[data-mask]').inputmask()

        //Date range picker
        $('#reservation').daterangepicker()
        //Date range picker with time picker
        $('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A'})
        //Date range as a button
        $('#daterange-btn').daterangepicker(
                {
                    ranges: {
                        'Today': [moment(), moment()],
                        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                        'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                        'This Month': [moment().startOf('month'), moment().endOf('month')],
                        'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                    },
                    startDate: moment().subtract(29, 'days'),
                    endDate: moment()
                },
                function (start, end) {
                    $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
                }
        )

        //Date picker
        $('#datepicker').datepicker({
            autoclose: true
        })

        //iCheck for checkbox and radio inputs
        $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass: 'iradio_minimal-blue'
        })
        //Red color scheme for iCheck
        $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
            checkboxClass: 'icheckbox_minimal-red',
            radioClass: 'iradio_minimal-red'
        })
        //Flat red color scheme for iCheck
        $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
            checkboxClass: 'icheckbox_flat-green',
            radioClass: 'iradio_flat-green'
        })

        //Colorpicker
        $('.my-colorpicker1').colorpicker()
        //color picker with addon
        $('.my-colorpicker2').colorpicker()

        //Timepicker
        $('.timepicker').timepicker({
            showInputs: false
        })
    })
</script>

