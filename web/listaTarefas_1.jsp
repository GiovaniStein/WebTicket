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
                            $("#listadeTarefas").load("listaTarefas_1.jsp");
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
            window.location.href = "/WebTicket/acao?parametro=edTarefa&id="+value;  
    };
    </script>

    <div class="box box-info">
        <div class="box-header">
            <h3 class="box-title">Lista de tarefas</h3>
        </div>

        <div class="box-body">
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
                            System.out.println("tamanho - "+tarefas.size());
                        } catch (Exception e) {
                            System.out.println("Errrooooooooooooooooooooooo "+e);
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
                        </td>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

</section>
<aside class="control-sidebar control-sidebar-dark">

</aside>

<div class="control-sidebar-bg">

</div>

