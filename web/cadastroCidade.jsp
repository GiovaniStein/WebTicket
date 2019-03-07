<%@page import="entidade.Cidade"%>


<!--<html>-->


<!--    <body class="hold-transition skin-blue sidebar-mini">-->
<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>
<%//@include file = "inicio-teste.jsp"%>

<%
    // Cidade cid = new Cidade();
    Cidade cid = (Cidade) request.getAttribute("objcid");

    if (cid == null) {
        cid = new Cidade();
        cid.setSituacao('A');
        cid.setDescricao("");
    }
%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <script type="text/javascript">

        // Via JQuery
        $(document).ready(function () {
            $('#cadastraCidade').click(function (event) {
                event.preventDefault();
                if (valida_form() === true) {
                    $.ajax({
                        type: "POST",
                        url: "/WebTicket/acao?parametro=cadCidade",
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Houve um erro!", resultado, "error");
                            //$('#idDescricao').focus();
                        } else {
                            swal("Sucesso ao Salvar!", "", "success");
                            $('#formCidade').each(function () {
                                this.reset();
                            });
                            $("#listadeCidades").load("listaCidades.jsp");
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
            if ((document.getElementById("idDescricao").value === null || document.getElementById("idDescricao").value === "")) {
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
            <div style="width: 100%" class="col-md-6">
                <!-- Horizontal Form -->
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">Cadastro de cidade</h3>
                    </div>

                    <form id="formCidade" name="cadCidade" class="form-horizontal" action="" method="post">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="id" class="col-sm-2 control-label" >ID</label>

                                <div class="col-sm-2">
                                    <%                                                       if (cid.getId() > 0) {%>
                                    <input id="idCidade" type="text" class="form-control" name="id" value="<%= cid.getId()%>" readonly />
                                    <%} else {
                                    %>

                                    <input id="idCidade" type="text" class="form-control" name="id" value="" readonly >
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="nome" class="col-sm-2 control-label">Nome</label>

                                <div class="col-sm-7">
                                    <input autofocus="true" id="idDescricao" type="text" class="form-control" name="descricao" value="<%= cid.getDescricao()%>">

                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">

                                </div>
                            </div>
                        </div>

                        <div class="box-footer">

                            <input id="cadastraCidade" style="float: right;width: 95px;background-color: #1087dd;" type="submit" class="btn btn-dropbox pull-right-container" name="enviar" value="Salvar"> 

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

<!-- jQuery 3 -->
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- page script -->


