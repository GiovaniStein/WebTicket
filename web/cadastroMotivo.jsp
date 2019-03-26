<%@page import="entidade.Motivo"%>


<!DOCTYPE html>
<!--<html>-->


<!--    <body class="hold-transition skin-blue sidebar-mini">-->
<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>
<%//@include file = "inicio-teste.jsp"%>

<%
    // Cidade cid = new Cidade();
    Motivo motiv = (Motivo) request.getAttribute("objmot");

    if (motiv == null) {
        motiv = new Motivo();
        motiv.setSituacao('A');
        motiv.setDescricao("");
    }
%>

<!-- Content Wrapper. Contains page content -->
<div style="height: 887px;overflow: auto;" class="content-wrapper">

    <script type="text/javascript">

        // Via JQuery
        $(document).ready(function () {
            $('#cadastraMotivo').click(function (event) {
                event.preventDefault();
                if (valida_form() === true) {
                    $.ajax({
                        type: "POST",
                        url: "/WebTicket/acao?parametro=cadMotivo",
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Houve um erro!", resultado, "error");
                            //$('#idDescricao').focus();
                        } else {
                            swal("Sucesso ao Salvar!", "", "success");
                            $('#formMotivo').each(function () {
                                this.reset();
                            });
                            $("#listadeMotivo").load("listaMotivos.jsp");
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
            if ((document.getElementById("motivoDescricao").value === null || document.getElementById("motivoDescricao").value === "")) {
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
                        <h3 class="box-title">Cadastro de motivos</h3>
                    </div>

                    <form id="formMotivo" name="cadMotivo" class="form-horizontal" action="" method="post">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="id" class="col-sm-2 control-label" >ID</label>

                                <div class="col-sm-2">
                                    <%                                                       if (motiv.getId() > 0) {%>
                                    <input id="idmotivo" type="text" class="form-control" name="id" value="<%= motiv.getId()%>" readonly >
                                    <%} else {
                                    %>

                                    <input id="idmotivo" type="text" class="form-control" name="id" value="" readonly >
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="nome" class="col-sm-2 control-label">Nome</label>

                                <div class="col-sm-7">
                                    <input id="motivoDescricao" type="text" class="form-control" name="descricao" value="<%= motiv.getDescricao()%>">

                                </div>
                            </div>
                        </div>

                        <div class="box-footer">

                            <input id="cadastraMotivo" style="float: right;width: 95px;background-color: #1087dd;" type="submit" class="btn btn-dropbox pull-right-container" name="enviar" value="Salvar"> 

                        </div>

                    </form>

                </div>

            </div>
            <!--/.col (right) -->
        </div>
        <!-- /.row -->
    </section>

    <div id="listadeMotivo">
        <%@include file = "listaMotivos.jsp"%>
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


