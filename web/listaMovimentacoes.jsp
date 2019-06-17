<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="DAO.MovimentoTarefaDAO"%>
<%@page import="entidade.MovimentoTarefa"%>
<%@page import="entidade.Cidade"%>
<%@page import="DAO.TarefaDAO"%>
<%@page import="entidade.Fase"%>
<%@page import="entidade.Usuario"%>
<%@page import="entidade.Modulo"%>
<%@page import="entidade.Tarefa"%>
<%@page import="DAO.ClienteDAO"%>
<%@page import="entidade.Cliente"%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>



<section class="content-header">
    <style>
        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4);/* Black w/ opacity */
            max-width: 100%;
        }

        /* Modal Content */
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 800px;
            height: 436px;
            top: 8%;
        }

        /* The Close Button */
        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }
    </style>

    
   


    <!-- Content Wrapper. Contains page content -->

    <div class="box box-info">
        <%
            System.out.println("id " + request.getRequestURL());
            int id = Integer.valueOf((request.getParameter("id")));
            TarefaDAO tarefadao = new TarefaDAO();
            Tarefa tarefa = tarefadao.consultarId(id).get(0);
        %>


        <div class="box-header">
            <h3 class="box-title">Lista de movimentacoes</h3>
        </div>

        <div class="box-body">


            <table id="tableMovimentacao" class="table table-bordered table-striped table-hover">

                <%                                                       if (tarefa.getId() > 0) {%>
                <button  style="float: right;background-color: #1087dd;" class="btn btn-dropbox pull-right-container" id="myBtn">
                    <i class="fa fa-plus" aria-hidden="true"></i>
                </button>
                <%} else {
                %>

                <button  style="float: right;background-color: #1087dd;" class="btn btn-dropbox pull-right-container" id="myBtn" disabled="true">
                    <i class="fa fa-plus" aria-hidden="true"></i>
                </button>
                <%
                    }
                %>


                <div id="myModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <%@include  file = "cadastroMovimentacao.jsp"%>
                    </div>
                </div>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>DESCRIÇÃO</th>
                        <th>USUÁRIO</th>
                        <th>DATA DA MOVIMENTAÇÃO</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        MovimentoTarefa movimentoTarefa = new MovimentoTarefa();
                        //Tarefa tarefa = new Tarefa();

                        movimentoTarefa.setTarefa(tarefa);
                        Usuario usuario = new Usuario();

                        usuario.setId(Integer.parseInt(session.getAttribute("usuarioLogado").toString()));

                        movimentoTarefa.setUsuario(usuario);

                        movimentoTarefa.setDatahoraMovimento(new Date());
                        movimentoTarefa.setSituacao('A');

                        ArrayList<MovimentoTarefa> movimentacoes = new MovimentoTarefaDAO().listar(movimentoTarefa);

                        for (int i = 0; i < movimentacoes.size(); i++) {
                            SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

                            String str = fmt.format(movimentacoes.get(i).getDatahoraMovimento());

                    %>

                    <tr>
                        <td><%=movimentacoes.get(i).getId()%></td>
                        <td><%=movimentacoes.get(i).getDescricao()%></td>
                        <td><%=movimentacoes.get(i).getUsuario().getNome()%></td>
                        <td><%=str%></td>

                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        $(function () {
            $('#tableMovimentacao').DataTable()
            $('#tableMovimentacao2').DataTable({
                'paging': true,
                'lengthChange': false,
                'searching': false,
                'ordering': true,
                'info': true,
                'autoWidth': false
            })
        })
    </script>  


    <script>
        // Get the modal
        var modal = document.getElementById('myModal');

        // Get the button that opens the modal
        var btn = document.getElementById("myBtn");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks the button, open the modal 
        btn.onclick = function () {

            modal.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

</section>


