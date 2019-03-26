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
                text: "Tem certeza que deseja remover esse projeto?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sim',
                cancelButtonText: 'N�o'
            }).then(function (isConfirm) {
                if (isConfirm.value) {
                    $.ajax({
                        type: "GET",
                        url: '/WebTicket/acao?parametro=exProjeto&id='+value,
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Erro ao remover projeto!", resultado, "error");
                        } else {
                            swal("Projeto removido com sucesso!", "", "success");
                             $("#listadeProjetos").load("listaProjetos.jsp");
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
            $('#idprojeto').val(td[0].innerText);
            $('#descricaoProjeto').val(td[1].innerText);
        }
    </script>
    

    <div class="box box-info">
        <div class="box-header">
            <h3 class="box-title">Lista de projetos</h3>
        </div>

        <div class="box-body">
            <table id="tableProjeto" class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOME</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Projeto projeto = new Projeto();
                        projeto.setDescricao("");
                        ArrayList<Projeto> projetos = new ProjetoDAO().listar(projeto);

                        for (int i = 0; i < projetos.size(); i++) {
                    %>

                    <tr>
                        <td><%=projetos.get(i).getId()%></td>
                        <td><%=projetos.get(i).getDescricao()%></td>
                        <td>
                            <button title="Editar Projeto" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editUser(this)"><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Projeto" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeUser(this)" value="<%=projetos.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
        $('#tableProjeto').DataTable()
        $('#tableProjeto2').DataTable({
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