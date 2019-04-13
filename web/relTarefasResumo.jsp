<%@page import="entidade.Tarefa"%>
<%@page import="entidade.Cidade"%>


<!--<html>-->


<!--    <body class="hold-transition skin-blue sidebar-mini">-->
<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>
<%//@include file = "inicio-teste.jsp"%>

<%
        Tarefa tar = new Tarefa();

    
%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">

    <!-- Main content -->
    <section class="content">
        <div class="row">

            <!-- right column -->
            <div class="col-md-12">
                <!-- Horizontal Form -->
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">Filtro de relatório</h3>
                    </div>

                    <form id="relTarefasResumo" name="relTarefasResumo" class="form-horizontal" action="/WebTicket/acao?parametro=relTarefasResumo" method="post">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="id" class="col-sm-2 control-label" >Data inicial</label>

                               <div class="col-sm-6">
                                    <input type="date" class="form-control" name="datainclusaoinicio">

                                </div>
                            </div>
                            <div class="form-group">
                                <label for="date" class="col-sm-2 control-label">Data final</label>

                                <div class="col-sm-6">
                                    <input type="date" class="form-control" name="datainclusaofinal">

                                </div>
                            </div>
                           
                        </div>

                        


                        <div class="box-footer">

                            <input type="submit" class="btn btn-instagram pull-right-container" style="float: right;width: 95px;background-color: #1087dd;" name="enviar" value="Listar"> 
                            

                        </div>

                    </form>

                </div>

            </div>
            <!--/.col (right) -->
        </div>
        <!-- /.row -->
    </section>

  
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

<script type="text/javascript">
    $("#relTarefasResumo").submit(function () {
        $("#relTarefasResumo").attr('target', '_blank');
        return true;
    });
</script>
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

