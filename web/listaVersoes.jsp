<%@page import="DAO.VersaoDAO"%>
<%@page import="entidade.Versao"%>
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
                text: "Tem certeza que deseja remover essa versão?",
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
                        url: '/WebTicket/acao?parametro=exVersao&id=' + value,
                        data: $('form').serialize()
                    }).done(function (retorno) {
                        var resultado = $.trim(retorno);
                        if (resultado !== "ok") {
                            swal("Erro ao remover versão!", resultado, "error");
                        } else {
                            swal("Versão removida com sucesso!", "", "success");
                            $("#listadeVersao").load("listaVersoes.jsp");
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
            $('#idversao').val(td[0].innerText);
            $('#versaoDescricao').val(td[1].innerText);
            var select = $('#selectProjetoVersao').children();
            
            for(var x =0;x<select.length;x++){
                if(select[x].text===td[2].innerText){
                    $('#selectProjetoVersao').val(select[x].value).change(); 
                }
            }
        }
    </script>
        
        

        <div class="box box-info">
            <div class="box-header">
                <h3 class="box-title">Lista de versões</h3>
            </div>

            <div class="box-body">
                <table id="tableVersao" class="table table-bordered table-striped table-hover">
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
                            Versao ver = new Versao();
                            Projeto proj = new Projeto();
                            ver.setProjeto(proj);
                            ver.setDescricao("");
                            ArrayList<Versao> versoes = new VersaoDAO().listar(ver);

                            for (int i = 0; i < versoes.size(); i++) {
                        %>

                        <tr>
                            <td><%=versoes.get(i).getId()%></td>
                            <td><%=versoes.get(i).getDescricao()%></td>
                            <td><%=versoes.get(i).getProjeto().getDescricao()%></td>
                            <td>
                             <button title="Editar Versão" style="background-color: #3c8dbc !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="editUser(this)"><i class="fa fa-pencil-square-o"></i></button>
                            <button title="Excluir Versão" style="background-color: #dd4b39 !important;border-radius: 4px;border: none;width: 28px;height: 22px;color: #FFFFFF;" onclick="removeUser(this)" value="<%=versoes.get(i).getId()%>"><i class="fa fa-trash"></i></button>
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
            $('#tableVersao').DataTable()
            $('#tableVersao2').DataTable({
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

