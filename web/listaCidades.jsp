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
                text: "Tem certeza que deseja remover essa cidade?",
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
                        url: value,
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Erro ao remover cidade!", resultado, "error");
                        } else {
                            swal("Cidade removida com sucesso!", "", "success");
                            $("#listadeCidades").load("listaCidades.jsp");
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
            $('#idCidade').val(td[0].innerText);
            $('#idDescricao').val(td[1].innerText);
        }
    </script>

    <div class="box box-info">
        <div class="box-header">
            <h3 class="box-title">Lista de cidades</h3>
        </div>

        <div class="box-body">
            <table id="tableCidade" class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOME</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Cidade cidade = new Cidade();
                        cidade.setDescricao("");
                        ArrayList<Cidade> cidades = new CidadeDAO().listar(cidade);

                        for (int i = 0; i < cidades.size(); i++) {
                    %>

                    <tr>
                        <td><%=cidades.get(i).getId()%></td>
                        <td><%=cidades.get(i).getDescricao()%></td>
                        <td><button title="Editar Cidade" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editUser(this)" value="/WebTicket/acao?parametro=edCidade&id=<%=cidades.get(i).getId()%>"><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Cidade" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeUser(this)" value="/WebTicket/acao?parametro=exCidade&id=<%=cidades.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
            $('#tableCidade').DataTable();
            $('#tableCidade2').DataTable({
                'paging': true,
                'lengthChange': false,
                'searching': false,
                'ordering': true,
                'info': true,
                'autoWidth': false
            });
        });
    </script> 

</section>

<!--</body>-->
