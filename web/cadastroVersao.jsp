<%@page import="DAO.ProjetoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Projeto"%>
<%@page import="entidade.Versao"%>
<!DOCTYPE html>

<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>

<%  Versao versao = (Versao) request.getAttribute("objver");

    if (versao == null) {
        versao = new Versao();
        versao.setSituacao('A');
        versao.setDescricao("");
        Projeto projeto = new Projeto();
        versao.setProjeto(projeto);
    }
%>

<!-- Content Wrapper. Contains page content -->
<div style="height: 300px;overflow: auto;min-height: 768px;"
     class="content-wrapper">

    <!-- Main content -->
    <section class="content">
        <div class="row">

            <!-- right column -->
            <div class="col-md-12">

                <!-- Horizontal Form -->
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">Cadastro de versão</h3>
                    </div>
                    <form id="formVersao"
                          name="cadVersao"
                          class="form-horizontal"
                          action=""
                          method="post">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="id"
                                       class="col-sm-2 control-label">ID</label>
                                <div class="col-sm-2">
                                    <%
                                        if (versao.getId() > 0) {
                                    %>
                                    <input id="idversao"
                                           style="width: 95px"
                                           type="text"
                                           class="form-control"
                                           name="id"
                                           value="<%= versao.getId()%>"
                                           readonly>
                                    <%
                                    } else {
                                    %>
                                    <input id="idversao"
                                           style="width: 95px"
                                           type="text"
                                           class="form-control"
                                           name="id"
                                           value=""
                                           readonly>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="nome"
                                       class="col-sm-2 control-label">Nome</label>
                                <div class="col-sm-6">
                                    <input id="versaoDescricao"
                                           type="text"
                                           class="form-control"
                                           name="descricao"
                                           value="<%= versao.getDescricao()%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="projeto"
                                       class="col-sm-2 control-label">Projeto</label>
                                <div class="col-sm-6">
                                    <select id="selectProjetoVersao"
                                            class="form-control select2"
                                            name="projeto">
                                        <option value="0">Selecione</option>
                                        <%
                                            Projeto projeto = new Projeto();
                                            projeto.setDescricao("");
                                            projeto.setSituacao('A');
                                            ArrayList<Projeto> projetos = new ProjetoDAO().listar(projeto);
                                            for (int i = 0; i < projetos.size(); i++) {
                                                if (versao.getProjeto().getId() == projetos.get(i).getId()) {
                                        %>
                                        <option value="<%=projetos.get(i).getId()%>"
                                                selected><%=projetos.get(i).getDescricao()%></option>
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
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <input id="cadastraVersao"
                                   style="float: right;width: 95px;background-color: #1087dd;"
                                   type="submit"
                                   class="btn btn-dropbox pull-right-container"
                                   name="enviar"
                                   value="Salvar">
                        </div>
                    </form>
                </div>
            </div>
            <!--/.col (right) -->
        </div>
        <!-- /.row -->
    </section>
    <div id="listadeVersao">
        <%@include file = "listaVersoes.jsp"%>
    </div>
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
<script src="js/CrudActionsVercao.js" type="text/javascript" charset="utf-8"></script>