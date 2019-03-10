<%@page import="DAO.PrioridadeDAO"%>
<%@page import="entidade.Prioridade"%>
<%@page import="DAO.ProjetoDAO"%>
<%@page import="entidade.Projeto"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>



    <section class="content-header">
        
         <script>
        function removeUser(element) {
            var value = $(element).val();
            swal({
                title: 'Cuidado!',
                text: "Tem certeza que deseja remover essa prioridade?",
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
                        url: '/WebTicket/acao?parametro=exPrioridade&id='+value,
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Erro ao remover prioridade!", resultado, "error");
                        } else {
                            swal("Prioridade removida com sucesso!", "", "success");
                            $("#listadePrioridade").load("listaPrioridades.jsp");
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
            $('#idprioridade').val(td[0].innerText);
            $('#prioridadeDescricao').val(td[1].innerText);
        }
    </script>

        <div class="box box-info">
            <div class="box-header">
                <h3 class="box-title">Lista de projetos</h3>
            </div>

            <div class="box-body">
                <table id="tabelaPrioridade" class="table table-bordered table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NOME</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Prioridade prioridade = new Prioridade();
                            prioridade.setDescricao("");
                            ArrayList<Prioridade> prioridades = new PrioridadeDAO().listar(prioridade);

                            for (int i = 0; i < prioridades.size(); i++) {
                        %>

                        <tr>
                            <td><%=prioridades.get(i).getId()%></td>
                            <td><%=prioridades.get(i).getDescricao()%></td>
                            <td>
                            <button title="Editar Prioridade" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editUser(this)" ><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Prioridade" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeUser(this)" value="<%=prioridades.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
<script>
        $(function () {
            $('#tabelaPrioridade').DataTable()
            $('#tabelaPrioridade2').DataTable({
                'paging': true,
                'lengthChange': false,
                'searching': false,
                'ordering': true,
                'info': true,
                'autoWidth': false
            })
        })
</script>    
<!--</body>-->
