<%@page import="DAO.ProjetoDAO"%>

<%@page import="java.util.ArrayList"%>

<%@page import="entidade.Projeto"%>
<%@page import="entidade.Modulo"%>


<!DOCTYPE html>

<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>


<%    // Cidade cid = new Cidade();
    Modulo modulo = (Modulo) request.getAttribute("objmod");

    if (modulo == null) {
        modulo = new Modulo();
        modulo.setSituacao('A');
        modulo.setDescricao("");

        Projeto projeto = new Projeto();

        modulo.setProjeto(projeto);
    }
%>

<!-- Content Wrapper. Contains page content -->
<div style="height: 300px;overflow: auto;min-height: 768px;" class="content-wrapper">

    <script type="text/javascript">

        // Via JQuery
        $(document).ready(function () {
            $('#cadastraModulo').click(function (event) {
                event.preventDefault();
                if (valida_form() === true) {
                    $.ajax({
                        type: "POST",
                        url: "/WebTicket/acao?parametro=cadModulo",
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Houve um erro!", resultado, "error");
                            //$('#idDescricao').focus();
                        } else {
                            swal("Sucesso ao Salvar!", "", "success");
                            $('#formModulo').each(function () {
                                this.reset();
                            });
                            $("#listadeModulos").load("listaModulos.jsp");
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
            if ((document.getElementById("moduloDescricao").value === null || document.getElementById("moduloDescricao").value === "") ||
                    (document.getElementById("selectProjeto").value === '0' || document.getElementById("selectProjeto").value === "")) {
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
                        <h3 class="box-title">Cadastro de m�dulos</h3>
                    </div>

                    <form id="formModulo" name="cadModulo" class="form-horizontal" action="" method="post">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="id" class="col-sm-2 control-label" >ID</label>

                                <div class="col-sm-2">
                                    <%                                                       if (modulo.getId() > 0) {%>
                                    <input id="idmodulo" type="text" class="form-control" name="id" value="<%= modulo.getId()%>" readonly >
                                    <%} else {
                                    %>

                                    <input id="idmodulo" type="text" class="form-control" name="id" value="" readonly >
                                    <%
                                        }
                                    %>
                                </div>
                            </div>


                            <div class="form-group">
                                <label for="nome" class="col-sm-2 control-label">Nome*</label>

                                <div class="col-sm-6">
                                    <input id="moduloDescricao" type="text" class="form-control" name="descricao" value="<%= modulo.getDescricao()%>">

                                </div>
                            </div>
                            <div class="form-group">
                                <label for="projeto" class="col-sm-2 control-label">Projeto*</label>

                                 <div class="col-sm-6">
                                <select id="selectProjeto" class="form-control select2" name="projeto">

                                    <%

                                        Projeto projeto = new Projeto();
                                        projeto.setDescricao("");
                                        projeto.setSituacao('A');

                                        ArrayList<Projeto> projetos = new ProjetoDAO().listar(projeto);

                                        for (int i = 0; i < projetos.size(); i++) {
                                            if (modulo.getProjeto().getId() == projetos.get(i).getId()) {
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


                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">

                                </div>
                            </div>
                        </div>
                        <div class="box-footer">

                            <input id="cadastraModulo" style="float: right;width: 95px;background-color: #1087dd;" type="submit" class="btn btn-dropbox pull-right-container" name="enviar" value="Salvar"> 

                        </div>

                    </form>

                </div>

            </div>
            <!--/.col (right) -->
        </div>
        <!-- /.row -->
    </section>

    <div id="listadeModulos">
        <%@include file = "listaModulos.jsp"%>
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


