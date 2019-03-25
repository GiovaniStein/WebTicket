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
            <h3 class="box-title">Lista de tarefas</h3>
        </div>

        <div class="box-body">
            <table id="example1" class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>TÍTULO</th>
                        <th>AUTOR</th>
                        <th>RESPONSÁVEL</th>
                        <th>FASE</th>
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

                        Tarefa tarefa = new Tarefa();
                        Cidade cidade = new Cidade();
                        Cliente cliente = new Cliente();
                        cliente.setCidade(cidade);
                        Usuario aut = new Usuario();
                        Usuario respons = new Usuario();

                        Fase fas = new Fase();
                        tarefa.setCliente(cliente);
                        tarefa.setUsuarioByIdUsuarioAutor(aut);
                        tarefa.setUsuarioByIdUsuarioResponsavel(respons);
                        tarefa.setFase(fas);

                        // ArrayList<Tarefa>  tarefas = new TarefaDAO().listarComParametro(tar);
                        try {
                            tarefas.get(0).getUsuarioByIdUsuarioAutor();
                            System.out.println("tamanho - "+tarefas.size());
                        } catch (Exception e) {
                            System.out.println("Errrooooooooooooooooooooooo "+e);
                        }

                        for (int i = 0; i < tarefas.size(); i++) {
                    %>

                    <tr>
                        <td><%=tarefas.get(i).getId()%></td>
                        <td><%=tarefas.get(i).getTitulo()%></td>
                        <td><%=tarefas.get(i).getUsuarioByIdUsuarioAutor().getNome()%></td>
                        <td><%=tarefas.get(i).getUsuarioByIdUsuarioResponsavel().getNome()%></td>
                        <td><%=tarefas.get(i).getFase().getDescricao()%></td>
                        <td><a href="/HelpWeb/acao?parametro=edTarefa&id=<%=tarefas.get(i).getId()%>"><span class="label label-primary pull-left-container">Editar</span></a>
                            <a href="/HelpWeb/acao?parametro=exTarefa&id=<%=tarefas.get(i).getId()%>"  onclick="return confirm('Tem certeza que deseja excluir a tarefa?');"><span class="label label-danger pull-right-container">Excluir</span></a>
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

