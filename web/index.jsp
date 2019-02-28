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



        <!--  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">-->
    </head>

    <body class="hold-transition skin-blue sidebar-mini">
        <div style="background-color: #ffffff" class="wrapper">

            <header class="main-header">
                <!-- Logo -->
                <a style="background-color: #1a3246" href="" class="logo">
                    <!-- mini logo for sidebar mini 50x50 pixels -->
                    <!--      <span class="logo-mini"><b>A</b>LT</span>-->
                    <!-- logo for regular state and mobile devices -->
                    <span class="logo-lg"><b>Web</b> Ticket</span>
                    -->
                </a>
                <!-- Header Navbar: style can be found in header.less -->
                <nav style="background-color: #1a3246" class="navbar navbar-static-top">

                </nav>
            </header>


            <!-- Content Wrapper. Contains page content -->


            <!--content-wrapper-->
            <div  class="form-horizontal">
                <!--content-wrapper-->


                <br>
                <br>

                <!-- Main content -->
                <section  class="box-header">
                    <div class="row">

                        <div class="col-md-6">
                            <!-- Horizontal Form -->

                            <!--box box-info-->
                            <div style="box-shadow: 0 1px 1px rgba(0, 0, 0, 0.45);display: inline-block;position: fixed;top: 0;bottom: 0;left: 0;right: 0;width: 367px;height: 322px;margin: auto;" class="box col-sm-offset-6">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Web Ticket - Login</h3>
                                </div>
                             

                                <form name="login" class="form-horizontal" action="/WebTicket/acao?parametro=login" method="post">
                                    <div class="box-body">
                                        <div style="margin-top: 23px;" class="form-group">
                                            <label for="login" class="col-sm-2 control-label" >Login</label>

                                            <div class="col-sm-10">

                                                <input type="email" class="form-control" name="login" value="">


                                            </div>
                                        </div>
                                        <div style="margin-top: 23px;" class="form-group">
                                            <label for="senha" class="col-sm-2 control-label">Senha</label>

                                            <div class="col-sm-10">
                                                <input type="password" class="form-control" name="senha" value="">

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-2 col-sm-10">

                                            </div>
                                        </div>


                                        <%
                                            if (request.getParameterMap().containsKey("m") && (request.getParameter("m").equals("2"))) {
                                        %>
                                        <div class="alert alert-danger alert-dismissible">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                            <h4><i class="icon fa fa-ban"></i> Erro!</h4>
                                            <%if (request.getParameter("m").equals("2")) {
                                            %>
                                            Erro ao fazer login!
                                            Usuário ou senha inválida.
                                            <%
                                                }
                                            %>

                                        </div>
                                        <%
                                            }
                                        %>

                                        <div class="box-footer">

                                            <input style="width: 95px" type="submit" class="btn btn-info pull-right" name="enviar" value="Login"> 

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
</html>
