<%@page import="DAO.ClienteDAO"%>
<%@page import="entidade.Cliente"%>

<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>



    <section class="content-header">
        
        
         <script>
        function removeUser(element) {
            var value = $(element).val();
            swal({
                title: 'Cuidado!',
                text: "Tem certeza que deseja remover esse cliente?",
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
                        url: '/WebTicket/acao?parametro=exCliente&id=' + value,
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Erro ao remover cliente!", resultado, "error");
                        } else {
                            swal("Cliente removido com sucesso!", "", "success");
                             $("#listadeCliente").load("listaClientes.jsp");
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
            var type = "";
            $('#idCliente').val(td[0].innerText);
            $('#clienteNome').val(td[1].innerText);
            if(td[2].innerText.length===11){
                $('#cpf').val(td[2].innerText);
                type = "F";
            }
            if(td[2].innerText.length===14){
                $('#cnpj').val(td[2].innerText);
                type = "J";
            }
            
            $('#clienteEndereco').val(td[3].innerText);
            var select = $('#tipo').children();
            
            for(var x =0;x<select.length;x++){
                if(select[x].value===type){
                    $('#tipo').val(select[x].value).change(); 
                }
            }
            
           
             select = $('#clienteCidade').children();
            
            for(var x =0;x<select.length;x++){
                if(select[x].text===td[4].innerText){
                    $('#clienteCidade').val(select[x].value).change(); 
                }
            }
            
             $('#clienteTelefone').val(td[5].innerText);
            
            
        }
    </script>

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
                             <button title="Editar Cliente" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editUser(this)" ><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Cliente" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" id="valuesuser" onclick="removeUser(this)" value="<%=clientes.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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



