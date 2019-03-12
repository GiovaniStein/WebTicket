<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Web Ticket</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <!-- Bootstrap 3.3.7 -->
        <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <!-- AdminLTE Skins. Choose a skin from the css/skins
             folder instead of downloading all of them to reduce the load. -->
        <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
        <link rel="stylesheet" href="css/mycss.css">
        <!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.33.1/sweetalert2.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.33.1/sweetalert2.js"></script>
        <!--  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">-->
        <script src="js/sweetalert2.js" type="text/javascript"></script>
        <link href="js/sweetalert2.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
        
        

    </head>

    <body class="hold-transition skin-blue sidebar-mini">
        <div style="background-color: #1a3246 !important" class="wrapper">
            
            
          


            <!-- Content Wrapper. Contains page content -->


            <!--content-wrapper-->
            <div  class="form-horizontal">
                <!--content-wrapper-->


                <br>
                <br>

                <!-- Main content -->
                <section  class="box-header">
                    <div class="row">

                        <div style="width: 100%" class="col-md-6">
                            <!-- Horizontal Form -->



                            <div style="text-align: center;font-size: 53px;color: #ffffff;">
                                <img src="images/ic_launcher.png" alt="" width="80" height="80"/>
                                WebTicket
                            </div>

                            <!--box box-info-->
                            <div style="box-shadow: 0 1px 1px rgba(0, 0, 0, 0.45);display: inline-block;position: fixed;top: 0;bottom: 0;left: 0;right: 0;width: 367px;height: 286px;margin: auto;" class="box col-sm-offset-6">


                                <form name="login" class="form-horizontal" action="/WebTicket/acao?parametro=login" method="post">
                                    <div style="padding-top: 40px; padding-left: 40px; padding-right: 40px;" class="box-body">
                                        <div  class="form-group">
                                            <label for="login" class="col-sm-2 control-label" >Login</label>
                                            <div style="float:none;width: 100%" class="col-sm-10">

                                                <input id="loginemail" type="email" class="form-control" name="login" value="">

                                            </div>
                                        </div>

                                        <div class="form-group">

                                            <label for="senha" class="col-sm-2 control-label">Senha</label>
                                            <div style="float:none;width: 100%" class="col-sm-10">
                                                <input id="loginsenha" type="password" class="form-control" name="senha" value="">
                                            </div>
                                        </div>




                                        <div style="padding-top: 13px">
                                            <input id="LoginButton" style="width: 287px" type="submit" class="btn btn-info pull-right" name="enviar" value="Login"> 
                                        </div>

                                </form>

                            </div>

                        </div>
                        <!--/.col (right) -->
                    </div>
                    <!-- /.row -->
                </section>
                <!-- /.content -->
            </div>

    </body>
    <%
        if (request.getParameterMap().containsKey("m") && (request.getParameter("m").equals("2"))) {
    %>

    <%if (request.getParameter("m").equals("2")) {
    %>
    <script>
        $(window).on("load", function () {
            swal("Oops", "O usuário não foi encontrado. Por Favor, verifique o login e a senha e tente novamente", "error");
        });
    </script>
    <%
        }
    %>


    <%
        }
    %>
</html>
