<%@page import="DAO.UsuarioDAO"%>
<%@page import="entidade.Usuario"%>
<%@page import="DAO.CidadeDAO"%>
<%@page import="entidade.Cidade"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>



<section class="content-header">

    <div style="margin-top: -37px;" class="box box-info">
        <div class="box-header">
            <h3 class="box-title">Lista de usuários</h3>
        </div>

        <div class="box-body">
            <table id="tableUsuario" class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOME</th>
                        <th>LOGIN</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Usuario user = new Usuario();
                        user.setNome("");
                        user.setLogin("");
                        UsuarioDAO usuarioDAO = new UsuarioDAO();

                        ArrayList<Usuario> usuarios = usuarioDAO.listar(user);

                        for (int i = 0; i < usuarios.size(); i++) {
                    %>

                    <tr>
                        <td><%=usuarios.get(i).getId()%></td>
                        <td><%=usuarios.get(i).getNome()%></td>
                        <td><%=usuarios.get(i).getLogin()%></td>
                        <td><button title="Editar Usuário" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editUser(this)" ><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Usuário" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeUser(this)" value="<%=usuarios.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
<script>
    $(function () {
        $('#tableUsuario').DataTable();
        $('#tableUsuario2').DataTable({
            'paging': true,
            'lengthChange': false,
            'searching': false,
            'ordering': true,
            'info': true,
            'autoWidth': false
        });
    });
</script>   
<!--</body>-->
