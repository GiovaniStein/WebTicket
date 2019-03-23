<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="DAO.MovimentoTarefaDAO"%>
<%@page import="entidade.MovimentoTarefa"%>
<%@page import="entidade.Cidade"%>
<%@page import="DAO.TarefaDAO"%>
<%@page import="entidade.Fase"%>
<%@page import="entidade.Usuario"%>
<%@page import="entidade.Modulo"%>
<%@page import="entidade.Tarefa"%>
<%@page import="DAO.ClienteDAO"%>
<%@page import="entidade.Cliente"%>

<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>



<section class="content-header">

    <div class="box box-info">
        <div class="box-header">
            <h3 class="box-title">Lista de movimentacoes</h3>
        </div>

        <div class="box-body">
            <table id="tableMovimentacao" class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>DESCRIÇÃO</th>
                        <th>USUÁRIO</th>
                        <th>DATA DA MOVIMENTAÇÃO</th>

                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
            
                        MovimentoTarefa movimentoTarefa = new MovimentoTarefa();
                         //Tarefa tarefa = new Tarefa();

                        movimentoTarefa.setTarefa(tar);
                        Usuario usuario = new Usuario();
                        
                        usuario.setId(Integer.parseInt(session.getAttribute("usuarioLogado").toString()));
                        
                        movimentoTarefa.setUsuario(usuario);
                        
                        movimentoTarefa.setDatahoraMovimento(new Date());
                        movimentoTarefa.setSituacao('A');


                        ArrayList<MovimentoTarefa> movimentacoes = new MovimentoTarefaDAO().listar(movimentoTarefa);

                        for (int i = 0; i < movimentacoes.size(); i++) {
                            SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                     
                        String str = fmt.format(movimentacoes.get(i).getDatahoraMovimento());
                         
                    %>

                    <tr>
                        ><td><%=movimentacoes.get(i).getId()%></td>
                        <td><%=movimentacoes.get(i).getDescricao()%></td>
                        <td><%=movimentacoes.get(i).getUsuario().getNome()%></td>
                        <td><%=str%></td>

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
            $('#tableMovimentacao').DataTable()
            $('#tableMovimentacao2').DataTable({
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


