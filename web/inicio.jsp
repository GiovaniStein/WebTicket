<%@page import="DAO.TarefaDAO"%>
<%@page import="DAO.VersaoDAO"%>
<%@page import="DAO.ProjetoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>



<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>


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
<script src="js/Chart.bundle.js" type="text/javascript"></script>
<script src="js/Chart.bundle.min.js" type="text/javascript"></script>
<script src="js/Chart.js" type="text/javascript"></script>
<link href="js/Chart.min.css" rel="stylesheet" type="text/css"/>
<script src="js/Chart.min.js" type="text/javascript"></script>

<div style="height: 300px;overflow: auto;min-height: 768px; background-color: #ecf0f5" class="content-wrapper">

    <%        UsuarioDAO userdao = new UsuarioDAO();
        ProjetoDAO projetodao = new ProjetoDAO();
        VersaoDAO versaodao = new VersaoDAO();
        TarefaDAO tarefadao = new TarefaDAO();

        int countUsers = userdao.CountUsers();
        int countProjects = projetodao.countProject();
        int countVersao = versaodao.countVersion();
        int countTask = tarefadao.countTask();

    %>

    <section class="content">

        <div class="row">

            <div class="col-md-3">
                <div class="info-box bg-yellow">
                    <span class="info-box-icon"><i class="fa fa-ticket"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">Nº de Tarefas</span>
                        <span id="KpiTarefas" style="font-size: 30px" class="info-box-number"><%=countTask%></span>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="info-box bg-green">
                    <span class="info-box-icon"><i class="fa fa-users"></i></span>

                    <div class="info-box-content">
                        <span class="info-box-text">Nº Usuários</span>
                        <span id="KpiUsuarios" style="font-size: 30px" class="info-box-number"><%=countUsers%></span>
                    </div>
                </div>
                <!-- /.info-box-content -->
            </div>
            <div class="col-md-3">
                <div class="info-box bg-red">
                    <span class="info-box-icon"><i class="fa fa-cloud"></i></span>

                    <div class="info-box-content">
                        <span class="info-box-text">Nº de Projetos</span>
                        <span id="KpiProjetos" style="font-size: 30px" class="info-box-number"><%=countProjects%></span>

                    </div>
                    <!-- /.info-box-content -->
                </div>
            </div>
            <!-- /.info-box -->
            <div class="col-md-3">
                <div class="info-box bg-aqua">
                    <span class="info-box-icon"><i class="fa fa-code-fork"></i></span>

                    <div class="info-box-content">
                        <span class="info-box-text">Nº Versões</span>
                        <span id="KpiVersoes" style="font-size: 30px" class="info-box-number"><%=countVersao%></span>

                    </div>
                    <!-- /.info-box-content -->
                </div>
                <!-- /.info-box -->


            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="nav-tabs-custom">
                    <!-- Tabs within a box -->
                    <ul class="nav nav-tabs pull-right">
                        <li class="pull-left header"><i class="fa fa-inbox"></i> Quantidade de tarefas por projeto</li>
                    </ul>
                    <canvas id="barChartContainer" height="150"></canvas>
                </div>
            </div>

            <div class="col-md-6">
                <div class="nav-tabs-custom">
                    <!-- Tabs within a box -->
                    <ul class="nav nav-tabs pull-right">
                        <li class="pull-left header"><i class="fa fa-inbox"></i> Tarefas por fase</li>
                    </ul>
                    <canvas id="pieChartContainer" height="150"></canvas>
                </div>
            </div>
        </div>


    </section>


</div>
<!-- page script -->


<script>
    $(document).ready(function () {
        var values = {};
        $.ajax({
            type: "GET",
            url: "/WebTicket/acao?parametro=appInformation",
            data: $('form').serialize()
        }).done(function (retorno) {
            var resultado = $.trim(retorno);
            values = JSON.parse(resultado);
            console.log(values);
            
            var projectsnames = Object.getOwnPropertyNames(values.tasksPerProject);
            var projectvalues = Object.values(values.tasksPerProject);
            var stepnames = Object.getOwnPropertyNames(values.tasksPerStep);
            var stepvalues = Object.values(values.tasksPerStep);
            var ctx = document.getElementById('barChartContainer').getContext('2d');
            var ctx2 = document.getElementById('pieChartContainer').getContext('2d');
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: projectsnames,
                    datasets: [{
                            label: 'Nº de projetos',
                            data: projectvalues,
                            backgroundColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                }
            });
            var myChart2 = new Chart(ctx2, {
                type: 'pie',
                data: {
                    labels: stepnames,
                    datasets: [{
                            label: '',
                            data: stepvalues,
                            backgroundColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                }
            });
        });

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