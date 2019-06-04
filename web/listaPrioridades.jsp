<%@page import="DAO.PrioridadeDAO"%>
<%@page import="entidade.Prioridade"%>
<%@page import="DAO.ProjetoDAO"%>
<%@page import="entidade.Projeto"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>



    <section class="content-header">
        
         <script>
       
    </script>

    <script>
        
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
                            <button title="Editar Prioridade" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editPrioridade(this)" ><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Prioridade" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removePrioridade(this)" value="<%=prioridades.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
