<%@page import="entidade.Projeto"%>
<%@page import="DAO.ModuloDAO"%>
<%@page import="entidade.Modulo"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>



<section class="content-header">



    <script>
        function removeUser(element) {
            var value = $(element).val();
            swal({
                title: 'Cuidado!',
                text: "Tem certeza que deseja remover esse modulo?",
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
                        url: '/WebTicket/acao?parametro=exModulo&id=' + value,
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Erro ao remover modulo!", resultado, "error");
                        } else {
                            swal("Modulo removido com sucesso!", "", "success");
                            $("#listadeModulos").load("listaModulos.jsp");
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
            $('#idmodulo').val(td[0].innerText);
            $('#moduloDescricao').val(td[1].innerText);
            var select = $('#selectProjeto').children();
            
            for(var x =0;x<select.length;x++){
                if(select[x].text===td[2].innerText){
                    $('#selectProjeto ').val(select[x].value).change(); 
                }
            }
        }
    </script>

    <div class="box box-info">
        <div class="box-header">
            <h3 class="box-title">Lista de módulos</h3>
        </div>

        <div class="box-body">
            <table id="tableModulo" class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOME</th>
                        <th>PROJETO</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Modulo mod = new Modulo();
                        Projeto proj = new Projeto();
                        mod.setProjeto(proj);
                        mod.setDescricao("");
                        ArrayList<Modulo> modulos = new ModuloDAO().listar(mod);

                        for (int i = 0; i < modulos.size(); i++) {
                    %>

                    <tr>
                        <td><%=modulos.get(i).getId()%></td>
                        <td><%=modulos.get(i).getDescricao()%></td>
                        <td><%=modulos.get(i).getProjeto().getDescricao()%></td>
                        <td>
                            <button title="Editar Modulo" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editUser(this)"><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Modulo" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeUser(this)" value="<%=modulos.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
        $('#tableModulo').DataTable()
        $('#tableModulo2').DataTable({
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
