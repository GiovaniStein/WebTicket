<%@page import="entidade.Projeto"%>
<%@page import="DAO.ModuloDAO"%>
<%@page import="entidade.Modulo"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>



<section class="content-header">


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
                            <button title="Editar Modulo" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editModulo(this)"><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Modulo" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeModulo(this)" value="<%=modulos.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
