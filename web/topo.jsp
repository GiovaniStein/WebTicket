<%@page import="entidade.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Web Ticket</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
        <link rel="stylesheet" href="bower_components/bootstrap-daterangepicker/daterangepicker.css">
        <link rel="stylesheet" href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
        <link rel="stylesheet" href="plugins/iCheck/all.css">
        <link rel="stylesheet" href="bower_components/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css">
        <link rel="stylesheet" href="plugins/timepicker/bootstrap-timepicker.min.css">
        <link rel="stylesheet" href="bower_components/select2/dist/css/select2.min.css">
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">

        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <script src="js/sweetalert2.js" type="text/javascript"></script>
        <link href="js/sweetalert2.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
    </head>

    <body style="overflow: hidden;"
          class="hold-transition skin-blue sidebar-mini" >
        <header class="main-header">
            <!-- Logo -->
            <a style="background-color: #1a3246"
               href="inicio.jsp"
               class="logo">
                <span style="text-align: left"
                      class="logo-lg"><b>Web</b>Ticket</span>
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav style="background-color: #1a3246"
                 class="navbar navbar-static-top">
                <!-- Sidebar toggle button-->
                <a href="#"
                   class="sidebar-toggle"
                   data-toggle="push-menu"
                   role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <li class="dropdown user user-menu">
                            <a href="#"
                               class="dropdown-toggle"
                               data-toggle="dropdown">
                                <%
                                    Usuario logado = new Usuario();
                                    logado.setId(Integer.parseInt(session.getAttribute("usuarioLogado").toString()));
                                    System.out.println(logado.getId() + "....id");
                                    logado.setNome("");
                                    logado.setLogin("");
                                    logado.setSituacao('A');
                                    UsuarioDAO usuaDAO = new UsuarioDAO();
                                    ArrayList<Usuario> users = usuaDAO.listar(logado);
                                %>
                            </a>
                        </li>
                        <!-- Control Sidebar Toggle Button -->
                        <li>
                            <a href="/WebTicket/acao?parametro=logout">Sair</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>