<%@page import="DAO.FaseDAO"%>
<%@page import="entidade.Fase"%>
<%@page import="DAO.CidadeDAO"%>
<%@page import="entidade.Cidade"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>



<section class="content-header">

    <script>
        function removeUser(element) {
            var value = $(element).val();
            swal({
                title: 'Cuidado!',
                text: "Tem certeza que deseja remover essa fase?",
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
                        url: '/WebTicket/acao?parametro=exFase&id=' + value,
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Erro ao remover fase!", resultado, "error");
                        } else {
                            swal("Fase removida com sucesso!", "", "success");
                            $("#listadeFase").load("listaFases.jsp");
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
            $('#idfase').val(td[0].innerText);
            $('#faseDescricao').val(td[1].innerText);
        }
    </script>

    <div class="box box-info">
        <div class="box-header">
            <h3 class="box-title">Lista de fases</h3>
        </div>

        <div class="box-body">
            <table id="tablefase" class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOME</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Fase fas = new Fase();
                        fas.setDescricao("");
                        ArrayList<Fase> fases = new FaseDAO().listar(fas);

                        for (int i = 0; i < fases.size(); i++) {
                    %>

                    <tr>
                        <td><%=fases.get(i).getId()%></td>
                        <td><%=fases.get(i).getDescricao()%></td>
                        <td>
                            <button title="Editar Fase" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editUser(this)" ><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Fase" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeUser(this)" value="<%=fases.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
            $('#tablefase').DataTable()
            $('#tablefase2').DataTable({
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




<!--</body>-->
