<%@page import="DAO.ClienteDAO"%>
<%@page import="entidade.Cliente"%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>



    <section class="content-header">
        <div class="box box-info">
            <div class="box-header">
                <h3 class="box-title">Lista de clientes</h3>
            </div>

            <div class="box-body">
                <table id="tableCliente" class="table table-bordered table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NOME</th>
                            <th>CPF/CNPJ</th>
                            <th>Endereço</th>
                            <th>Cidade</th>
                            <th>Telefone</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Cliente clien = new Cliente();
                            clien.setRazaoSocial("");
                            clien.setTelefone("");
                            clien.setCpfCnpj("");
                            clien.setEndereco("");
                            ArrayList<Cliente> clientes = new ClienteDAO().listar(clien);

                            for (int i = 0; i < clientes.size(); i++) {
                        %>

                        <tr>
                            <td><%=clientes.get(i).getId()%></td>
                            <td><%=clientes.get(i).getRazaoSocial() %></td>
                            <td><%=clientes.get(i).getCpfCnpj()%></td>
                            <td><%=clientes.get(i).getEndereco()%></td>
                            <td><%=clientes.get(i).getCidade().getDescricao()%></td>
                            <td><%=clientes.get(i).getTelefone()%></td>
                            <td>
                             <button title="Editar Cliente" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editCliente(this)" ><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Cliente" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeCliente(this)" value="<%=clientes.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
            $('#tableCliente').DataTable()
            $('#tableCliente2').DataTable({
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



