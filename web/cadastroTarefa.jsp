<%@page import="entidade.Cidade"%>
<%@page import="java.util.ArrayList"%>
<%@page import="apoio.Formatacao"%>
<%@page import="DAO.VersaoDAO"%>
<%@page import="entidade.Versao"%>
<%@page import="java.lang.Exception"%>
<%@page import="DAO.ModuloDAO"%>
<%@page import="entidade.Modulo"%>
<%@page import="DAO.FaseDAO"%>
<%@page import="entidade.Fase"%>
<%@page import="DAO.PrioridadeDAO"%>
<%@page import="entidade.Prioridade"%>
<%@page import="DAO.MotivoDAO"%>
<%@page import="entidade.Motivo"%>
<%@page import="DAO.ProjetoDAO"%>
<%@page import="entidade.Projeto"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="entidade.Usuario"%>
<%@page import="DAO.ClienteDAO"%>
<%@page import="entidade.Cliente"%>
<%@page import="entidade.Tarefa"%>



<!--<html>-->


<!--    <body class="hold-transition skin-blue sidebar-mini">-->
<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>


<%    // Cidade cid = new Cidade();
    Tarefa tar = (Tarefa) request.getAttribute("objtar");

    if (tar == null) {

        tar = new Tarefa();
        tar.setTitulo("");
        tar.setDescricao("");
        tar.setSituacao('A');
        Cidade cidade = new Cidade();
        Usuario autor = new Usuario();
        Usuario responsavel = new Usuario();

        Cliente cliente = new Cliente();
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
        cliente.setCidade(cidade);
        tar.setCliente(cliente);
        tar.setUsuarioByIdUsuarioAutor(autor);
        tar.setUsuarioByIdUsuarioResponsavel(responsavel);
        tar.setProjeto(projeto);

    }
%>

<!-- Content Wrapper. Contains page content -->
<div style="height: 887px;overflow: auto;" class="content-wrapper">

    <script type="text/javascript">

        // Via JQuery
        $(document).ready(function () {
            $('#cadastraTarefa').click(function (event) {
                event.preventDefault();
                if (valida_form() === true) {
                    $.ajax({
                        type: "POST",
                        url: "/WebTicket/acao?parametro=cadTarefa",
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Houve um erro!", resultado, "error");
                            //$('#idDescricao').focus();
                        } else {
                            swal("Sucesso ao Salvar!", "", "success");
                            $('#cadTarefa').each(function () {
                                this.reset();
                            });
                        }
                    });
                    return false;

                } else {
                    swal("Preencha os campos corretamente!");
                }
            }
            );
        });
    </script>

    <script type="text/javascript">

        function valida_form() {
            if ((document.getElementById("selectCliente").value === '0' || document.getElementById("selectCliente").value === "") || 
                    ((document.getElementById("selectAutor").value === '0' || document.getElementById("selectAutor").value === "")) || 
                    ((document.getElementById("selectResponsavel").value === '0' || document.getElementById("selectResponsavel").value === "")) ||
                    ((document.getElementById("selectProjeto").value === '0' || document.getElementById("selectProjeto").value === "")) ||
                    ((document.getElementById("selectMotivo").value === '0' || document.getElementById("selectMotivo").value === "")) ||
                    ((document.getElementById("selectModulo").value === '0' || document.getElementById("selectModulo").value === "")) ||
                    ((document.getElementById("selectFase").value === '0' || document.getElementById("selectFase").value === "")) ||
                    ((document.getElementById("selectPrioridade").value === '0' || document.getElementById("selectPrioridade").value === "")) ||
                    ((document.getElementById("selectVersao").value === '0' || document.getElementById("selectVersao").value === "")) ||
                    ((document.getElementById("selectVersaoCorrecao").value === '0' || document.getElementById("selectVersaoCorrecao").value === "")) ||
                    ((document.getElementById("dataPrevisao").value === '' || document.getElementById("dataPrevisao").value === null)) ||
                    ((document.getElementById("datahoraCriacao").value === '' || document.getElementById("datahoraCriacao").value === null)) ||
                    ((document.getElementById("tituloTarefa").value === '' || document.getElementById("tituloTarefa").value === null)) ||
                    ((document.getElementById("editor1").value === '' || document.getElementById("editor1").value === null))) {
                return false;
            } else {
                return true;
            }
        }
    </script>

    <!-- Main content -->
    <section class="content">
        <div class="row">

            <!-- right column -->
            <div class="col-md-12">
                <!-- Horizontal Form -->
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">Cadastro de tarefa</h3>
                    </div>

                    <form name="cadTarefa" class="form-horizontal" action="" method="post">

                        <div class="box-body">
                            <div class="form-group">
                                <label for="id" class="col-sm-1 control-label" >ID</label>

                                <div class="col-sm-1">
                                    <%                                                       if (tar.getId() > 0) {%>
                                    <input type="text" class="form-control" name="id" value="<%= tar.getId()%>" readonly >
                                    <%} else {
                                    %>

                                    <input type="text" class="form-control" name="id" value="" readonly >
                                    <%
                                        }
                                    %>

                                </div>

                                <label for="cliente" class="col-sm-1 control-label">Cliente*</label>
                                <div class="col-sm-4">
                                    <select id="selectCliente" class="form-control select2" name="cliente">
                                        <option value="0">Selecione </option>
                                        <%
                                            Cliente cliente = new Cliente();
                                            cliente.setRazaoSocial("");
                                            cliente.setSituacao('A');

                                            ArrayList<Cliente> clientes = new ClienteDAO().listar(cliente);

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
                                    <select id="selectProjeto"  class="form-control select2"  name="projeto" >

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
                                    <select id="selectModulo"  class="form-control select2" name="modulo" >

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
                                    <select id="selectVersao"  class="form-control select2" name="versao" >

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



                            <div class="form-group">


                                <label  for="versaoCorrecao" class="col-sm-1 control-label">Correção*</label>


                                <div class="col-sm-2">
                                    <select id="selectVersaoCorrecao"  class="form-control select2" name="versaoCorrecao" >

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

                                <label for="datahoraCriacao" class="col-sm-1 control-label" >Inclusão</label>
                                <div class="col-sm-2">
                                    <%
                                        try {
                                            if (tar.getDatahoraCriacao().toString().length() > 0) {
                                                System.out.println("tem inclusao" + tar.getDatahoraPrevisao());
                                                //System.out.println("tem inclusao" +tar.getDatahoraPrevisao());

                                    %>

                                    <input id="datahoraCriacao" type="datetime" class="form-control" name="datahoraCriacao"  value="<%=Formatacao.formatacaoDataDMAHMS(tar.getDatahoraCriacao())%>" readonly>
                                    <%
                                    } else {
                                        System.out.println("nao tem inclusao");
                                    %>
                                    <input type="date" class="form-control" name="datahoraCriacao"  value="" readonly>

                                    <%
                                            System.out.println("nao tem inclusao");
                                        }
                                    } catch (Exception e) {
//System.out.println("entrou na catch");
                                    %>
                                    <input id="datahoraCriacao" type="date" name="datahoraCriacao" class="form-control" value="" readonly>

                                    <%
                                        }
                                    %>
                                </div>

                                <label for="dataPrevisao" class="col-sm-1 control-label" >Previsão*</label>

                                <div class="col-sm-2">                                                                                                      <!--data-inputmask='"mask": "99/99/9999"' data-mask -->
                                    <input id="dataPrevisao" type="date" class="form-control" name="dataPrevisao"  value="<%=tar.getDatahoraPrevisao()%>">
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
                                if (request.getParameterMap().containsKey("m") && (request.getParameter("m").equals("2") || request.getParameter("m").equals("3") || request.getParameter("m").equals("6") || request.getParameter("m").equals("7"))) {
                            %>
                            <div class="alert alert-danger">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <h4><i class="icon fa fa-ban"></i> Erro!</h4>
                                <%if (request.getParameter("m").equals("2")) {
                                %>
                                <h5>Erro ao salvar tarefa!</h5><br>
                                <h5>Título precisa ter de 3 até 100 caracteres.</h5>   
                                <% } else if (request.getParameter("m").equals("3")) {

                                %>

                                <h5>Erro ao salvar tarefa!</h5><br>  
                                <h5>Descrição precisa ter de 3 até 100 caracteres.</h5>

                                <%  } else if (request.getParameter("m").equals("6")) {

                                %>
                                Erro ao salvar tarefa!<br>  
                                verifique com o suporte.



                                <%} else if (request.getParameter("m").equals("7")) {

                                %>
                                Erro ao salvar tarefa!<br>  
                                verifique se todos os campos estão preenchidos.


                                <%                                        }

                                    }
                                %>
                            </div>


                            <div class="form-group">
                                <label for="nome" class="col-sm-1 control-label">Título*</label>
                                <div class="col-xs-6">
                                    <input id="tituloTarefa" type="text" class="form-control" name="titulo" value="<%= tar.getTitulo()%>">
                                </div>
                            </div>



                            <div class="form-group">

                                <label for="descricao" class="col-sm-1 control-label">Descrição*</label>



                                <div class="col-xs-8">

                                    <textarea id="editor1" name="descricao"  rows="5" cols="5">
                                        <%=tar.getDescricao()%></textarea>
                                </div>


                            </div>



                            <div class="form-group">
                                <label for="movimentacao" class="col-sm-1 control-label">Movimentação</label>
                                <div class="col-xs-8">

                                    <textarea id="editor2" name="movimentacao"  rows="5" cols="5">
                                    </textarea>
                                </div>
                            </div>





                            <div class="box-footer">

                                <input id="cadastraTarefa" style="float: right;width: 95px;background-color: #1087dd;" type="submit" class="btn btn-dropbox pull-right-container" name="enviar" value="Salvar"> 

                            </div>
                        </div>

                    </form>

                </div>



            </div>
            <!--/.col (right) -->
            <!--</div>-->
            <!-- /.row -->
            <%//@include file = "listaMovimentacoes.jsp"%>
    </section>

    <%@include file = "listaMovimentacoes.jsp"%>
    <!-- /.content -->

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
<script>
    $(function () {
        // Replace the <textarea id="editor1"> with a CKEditor
        // instance, using default configuration.
        CKEDITOR.replace('editor1')
        CKEDITOR.replace('editor2')
        //bootstrap WYSIHTML5 - text editor
        $('.textarea').wysihtml5()
    })
</script>

