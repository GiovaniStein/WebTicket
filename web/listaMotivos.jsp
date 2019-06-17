<%@page import="DAO.MotivoDAO"%>
<%@page import="entidade.Motivo"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>



<section class="content-header">

    <script>
       
    </script>

    <script>
       
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
                            <button title="Editar Motivo" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editMotivo(this)"><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Motivo" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeMotivo(this)" value="<%=motivos.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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



