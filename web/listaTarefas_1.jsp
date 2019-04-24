<%@page import="entidade.Cidade"%>
<%@page import="DAO.TarefaDAO"%>
<%@page import="entidade.Fase"%>
<%@page import="entidade.Usuario"%>
<%@page import="entidade.Modulo"%>
<%@page import="entidade.Tarefa"%>
<%@page import="DAO.ClienteDAO"%>
<%@page import="entidade.Cliente"%>

<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>


<style>
    /* The Modal (background) */
    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 9999999; /* Sit on top */
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
        height: 100%;
        top: -6%;
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


<section class="content-header">


    <script>
        function removeUser(element) {
            var value = $(element).val();
            swal({
                title: 'Cuidado!',
                text: "Tem certeza que deseja remover essa tarefa?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sim',
                cancelButtonText: 'Não'
            }).then(function (isConfirm) {
                if (isConfirm.value) {
                    $.ajax({
                        type: "GET",
                        url: '/WebTicket/acao?parametro=exTarefa&id=' + value,
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Erro ao remover tarefa!", resultado, "error");
                        } else {
                            swal("Tarefa removida com sucesso!", "", "success");
                            $("#listaTarefasContainer").load("listaTarefas.jsp");
                            $("#buttonPesquisar").click();
                        }
                    });
                    return false;
                }
            });
        }
    </script>



    <script type="text/javascript">
        // Via JQuery
        function editTarefa(element) {
            var value = $(element).val();
            window.location.href = "/WebTicket/acao?parametro=edTarefa&id=" + value;
        }
        ;
    </script>




    <div class="box box-info">
        <div class="box-header">
            <h3 class="box-title">Lista de tarefas</h3>
        </div>

        <div class="box-body">
            <div data-tarefaid="0" id="myModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <%@include file = "detalheTarefa.jsp"%>
                </div>
            </div>


            <table id="example1" class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>TÍTULO</th>
                        <th>AUTOR</th>
                        <th>RESPONSÁVEL</th>
                        <th>FASE</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Cliente clien = new Cliente();
                        clien.setRazaoSocial("");
                        clien.setTelefone("");
                        clien.setCpfCnpj("");
                        clien.setEndereco("");

                        Tarefa tarefa = new Tarefa();
                        Cidade cidade = new Cidade();
                        Cliente cliente = new Cliente();
                        cliente.setCidade(cidade);
                        Usuario aut = new Usuario();
                        Usuario respons = new Usuario();

                        Fase fas = new Fase();
                        tarefa.setCliente(cliente);
                        tarefa.setUsuarioByIdUsuarioAutor(aut);
                        tarefa.setUsuarioByIdUsuarioResponsavel(respons);
                        tarefa.setFase(fas);

                        // ArrayList<Tarefa>  tarefas = new TarefaDAO().listarComParametro(tar);
                        try {
                            tarefas.get(0).getUsuarioByIdUsuarioAutor();
                            System.out.println("tamanho - " + tarefas.size());
                        } catch (Exception e) {
                            System.out.println("Errrooooooooooooooooooooooo " + e);
                        }

                        for (int i = 0; i < tarefas.size(); i++) {
                    %>


                    <tr>
                        <td><%=tarefas.get(i).getId()%></td>
                        <td><%=tarefas.get(i).getTitulo()%></td>
                        <td><%=tarefas.get(i).getUsuarioByIdUsuarioAutor().getNome()%></td>
                        <td><%=tarefas.get(i).getUsuarioByIdUsuarioResponsavel().getNome()%></td>
                        <td><%=tarefas.get(i).getFase().getDescricao()%></td>
                        <td><button title="Editar Tarefa" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editTarefa(this)" value="<%=tarefas.get(i).getId()%>"><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Tarefa" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeUser(this)" value="<%=tarefas.get(i).getId()%>"><i class="fa fa-trash"></i></button>
                            <button id="myBtn" onclick="readTarefa(this)" title="Visualizar Tarefa" style="background-color: #3c41bc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;"  value="<%=tarefas.get(i).getId()%>"><i class="fa fa-eye"></i></button>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>

        function readTarefa(element) {
            var value = $(element).val();
            var modal = document.getElementById('myModal');
            modal.style.display = "block";


            var values = {};
            $.ajax({
                type: "GET",
                url: "/WebTicket/acao?parametro=taskInformation&id=" + value,
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                values = JSON.parse(resultado);
                $('#tasktitle')[0].innerHTML = values.titulo;
                $('#taskdescription')[0].innerHTML = values.descricao;
                $('#taskclient')[0].innerHTML = values.cliente;
                $('#taskproject')[0].innerHTML = values.projeto;
                $('#taskmodule')[0].innerHTML = values.modulo;
                console.log('movimentacoes ',values.movimentacoes);
                var data = values.movimentacoes;
                var cityTable = makeTable($('#tasktablecontainer'), data);
            });


            var span = document.getElementsByClassName("close")[0];
            span.onclick = function () {
                modal.style.display = "none";
                $("#taskmov > tr").remove();
            }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target === modal) {
                    modal.style.display = "none";
                    $("#taskmov > tr").remove();
                }
            }
        }
        ;


        // Get the modal

    </script>
    <script>
        function makeTable(container, data) {
            var table = $("#taskmov").addClass('CSSTableGenerator');
            var row = $("<tr/>");
            row.append($("<th" + "/>").text('Movimentações'));
            table.append(row);
            $.each(data, function (rowIndex, r) {
                var row = $("<tr/>");
                row.append($("<td" + "/>").text(r));
                table.append(row);
            });
            return container.append(table);
        }
    </script>



</section>


