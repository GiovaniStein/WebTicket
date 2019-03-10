<%@page import="DAO.MotivoDAO"%>
<%@page import="entidade.Motivo"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>



<section class="content-header">

    <script>
        function removeUser(element) {
            var value = $(element).val();
            swal({
                title: 'Cuidado!',
                text: "Tem certeza que deseja remover esse motivo?",
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
                        url: '/WebTicket/acao?parametro=exMotivo&id=' + value,
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Erro ao remover motivo!", resultado, "error");
                        } else {
                            swal("Motivo removido com sucesso!", "", "success");
                            $("#listadeMotivo").load("listaMotivos.jsp");
                        }
                    });
                    return false;
                }
            });
        }
    </script>

    <script>
        function editUser(element) {
            var element = $(element);
            var row = element.parent().parent();
            var td = row[0].children;
            $('#idmotivo').val(td[0].innerText);
            $('#motivoDescricao').val(td[1].innerText);
        }
    </script>



    <div class="box box-info">
        <div class="box-header">
            <h3 class="box-title">Lista de motivos</h3>
        </div>

        <div class="box-body">
            <table id="tableMotivo" class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOME</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Motivo motivo = new Motivo();
                        motivo.setDescricao("");
                        ArrayList<Motivo> motivos = new MotivoDAO().listar(motivo);

                        for (int i = 0; i < motivos.size(); i++) {
                    %>

                    <tr>
                        <td><%=motivos.get(i).getId()%></td>
                        <td><%=motivos.get(i).getDescricao()%></td>
                        <td> 
                            <button title="Editar Motivo" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editUser(this)"><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Motivo" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeUser(this)" value="<%=motivos.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
        $(function () {
            $('#tableMotivo').DataTable()
            $('#tableMotivo2').DataTable({
                'paging': true,
                'lengthChange': false,
                'searching': false,
                'ordering': true,
                'info': true,
                'autoWidth': false
            })
        })
    </script>    

</section>



