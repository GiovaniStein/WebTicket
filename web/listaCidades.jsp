<%@page import="DAO.CidadeDAO"%>
<%@page import="entidade.Cidade"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>



<section class="content-header">
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
                        <td><button title="Editar Cidade" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editCity(this)" ><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Cidade" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeCity(this)" value="<%=cidades.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
