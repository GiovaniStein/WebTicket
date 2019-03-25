
<%@page import="entidade.Usuario"%>
<%@page import="DAO.CidadeDAO"%>
<%@page import="DAO.ProjetoDAO"%>

<%@page import="java.util.ArrayList"%>

<%@page import="entidade.Cidade"%>
<%@page import="entidade.Cliente"%>


<!DOCTYPE html>

<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>


<%    // Cidade cid = new Cidade();
    Usuario usuario = (Usuario) request.getAttribute("objuser");

    if (usuario == null) {
        usuario = new Usuario();
        usuario.setSituacao('A');
        usuario.setNome("");
        usuario.setLogin("");
        usuario.setSenha("");
        usuario.setRepetirSenha("");

    }
%>

<!-- Content Wrapper. Contains page content -->
<div style="height: 887px;overflow: auto;" class="content-wrapper">

    <script type="text/javascript">

        // Via JQuery
        $(document).ready(function () {
          
            $('#cadastraUsuario').click(function (event) {
                var resultado = "";
                event.preventDefault();
                if (valida_form() === true) {
                    $.ajax({
                        type: "POST",
                        url: "/WebTicket/acao?parametro=cadUsuario",
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        resultado = $.trim(retorno);
                        
                        if (resultado !== "ok") {
                            swal("Houve um erro!", resultado, "error");
                            //$('#loginUsuario').focus();
                        } else {
                            swal("Sucesso ao Salvar!", "", "success");
                            $('#formusuario').each(function () {
                                this.reset();
                            });
                            $("#listadeUsuarios").load("listaUsuarios.jsp");
                        }
                        
                    });
                     $('#nomeUsuario').focus();
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
            if ((document.getElementById("nomeUsuario").value == null || document.getElementById("nomeUsuario").value == "") || (document.getElementById("loginUsuario").value == null || document.getElementById("loginUsuario").value == "") || (document.getElementById("senhaUsuario").value == null || document.getElementById("senhaUsuario").value == "") || (document.getElementById("repetirSenhaUsuario").value == null || document.getElementById("repetirSenhaUsuario").value == "")) {
                return false
            } else {
                return true
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
                        <h3 class="box-title">Cadastro de usu�rio</h3>
                    </div>

                    <form id="formusuario" name="cadCliente" class="form-horizontal">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="id" class="col-sm-2 control-label" >ID</label>


                                <div class="col-md-3">
                                    <%                                                       if (usuario.getId() > 0) {%>
                                    <input id="idUsuario" style="width: 95px" type="text" class="form-control" name="id" value="<%= usuario.getId()%>" readonly >

                                    <%} else {
                                    %>

                                    <input id="idUsuario" style="width: 95px" type="text" class="form-control" name="id" value="" readonly >

                                    <%
                                        }
                                    %>


                                </div>
                            </div>
                            <div class="form-group">
                                <label for="nome" class="col-sm-2 control-label">Nome*</label>

                                <div class="col-sm-7">
                                    <input autofocus id="nomeUsuario" type="text" class="form-control" name="nome" value="<%=usuario.getNome()%>">

                                </div>
                            </div>


                            <div class="form-group">
                                <label for="login" class="col-sm-2 control-label">Login</label>

                                <div class="col-sm-7">
                                    <%
                                        if (usuario.getLogin() != null || usuario.getLogin() != "") {
                                    %>
                                    <input id="loginUsuario" type="email" class="form-control" name="login" value="<%=usuario.getLogin()%>">        
                                    <%
                                    } else {
                                    %>
                                    <input id="loginUsuario" type="email" class="form-control">        

                                    <%    }
                                    %>

                                </div>

                            </div>

                            <div class="form-group">
                                <label for="senha" class="col-sm-2 control-label">Senha</label>

                                <div class="col-sm-7">
                                    <input id="senhaUsuario" type="password" class="form-control" name="senha" value="<%=usuario.getSenha()%>">

                                </div>
                            </div>

                            <div class="form-group">
                                <label for="repetirSenha" class="col-sm-2 control-label">Repetir senha</label>

                                <div class="col-sm-7">
                                    <input id="repetirSenhaUsuario" type="password" class="form-control" name="repetirSenha" value="<%=usuario.getRepetirSenha()%>">

                                </div>
                            </div>





                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">

                                </div>
                            </div>
                        </div>
                        <div class="box-footer">

                            <input id="cadastraUsuario" style="float: right;width: 95px;background-color: #1087dd;" type="submit" class="btn btn-dropbox pull-right-container" name="enviar" value="Salvar"> 

                        </div>

                    </form>

                </div>

            </div>
            <!--/.col (right) -->
        </div>
        <!-- /.row -->
    </section>
    <div id="listadeUsuarios">  
        <%@include file = "listaUsuarios.jsp"%>
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
        //Initialize Select2 Elements
        $(".select2").select2();
        //Money Euro
        $("[data-mask]").inputmask();
        //Desabilita e habilita conforme a manutencao
        $(document).ready(ajustaInterface);
        $(document).ready(habilitarCampos);
        //Ajusta o CNPJ/CPF conforme o tipo de pessoa
        $("#tipo").on("change", ajustaInterface);
    });
    function ajustaInterface() {
        if ($("#tipo").val() === 'F') {
            $("#grupo_cnpj").hide();
            $("#grupo_cpf").show();
            $("#cnpj").prop('required', false);
            $("#cpf").prop('required', true);
        } else {
            $("#grupo_cnpj").show();
            $("#grupo_cpf").hide();
            $("#cnpj").prop('required', true);
            $("#cpf").prop('required', false);
        }
    }

    function habilitarCampos() {
        if ($("#id").val() == 0) {
            $("#tipo").prop("disabled", false);
        } else {
            $("#tipo").prop("disabled", false);
        }
    }
</script>