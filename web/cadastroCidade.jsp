<%@page import="entidade.Cidade"%>

<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>

<%  Cidade cid = (Cidade) request.getAttribute("objcid");

    if (cid == null) {
        cid = new Cidade();
        cid.setSituacao('A');
        cid.setDescricao("");
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
                        <h3 class="box-title">Cadastro de cidade</h3>
                    </div>
                    <form id="formCidade"
                          name="cadCidade"
                          class="form-horizontal"
                          action=""
                          method="post">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="id"
                                       class="col-sm-2 control-label">ID</label>
                                <div class="col-sm-2">
                                    <%
                                        if (cid.getId() > 0) {
                                    %>
                                    <input id="idCidade"
                                           style="width: 95px"
                                           type="text"
                                           class="form-control"
                                           name="id"
                                           value="<%= cid.getId()%>"
                                           readonly>
                                    <%
                                    } else {
                                    %>
                                    <input id="idCidade"
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
                                <div class="col-sm-7">
                                    <input autofocus
                                           id="idDescricao"
                                           type="text"
                                           class="form-control"
                                           name="descricao"
                                           value="<%= cid.getDescricao()%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <input id="cadastraCidade"
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
    <div id="listadeCidades">
        <%@include file = "listaCidades.jsp"%>
    </div>
    <!-- /.content -->
</div>

<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="bower_components/fastclick/lib/fastclick.js"></script>
<script src="dist/js/adminlte.min.js"></script>
<script src="dist/js/demo.js"></script>
<script src="js/CrudActionsCidade.js" type="text/javascript" charset="utf-8"></script>
