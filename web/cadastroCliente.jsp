<%@page import="DAO.CidadeDAO"%>
<%@page import="DAO.ProjetoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Cidade"%>
<%@page import="entidade.Cliente"%>
<!DOCTYPE html>

<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>



<!-- Content Wrapper. Contains page content -->
<div style="height: 300px;overflow: auto;min-height: 768px;"
     class="content-wrapper">

    <%  Cliente cliente = (Cliente) request.getAttribute("objcli");

        if (cliente == null) {
            cliente = new Cliente();
            cliente.setSituacao('A');
            cliente.setRazaoSocial("");
            cliente.setCpfCnpj("");
            cliente.setEndereco("");
            cliente.setTelefone("");
            Cidade cidade = new Cidade();
            cliente.setCidade(cidade);
        }
    %>

    <!-- Main content -->
    <section class="content">
        <div class="row">

            <!-- right column -->
            <div class="col-md-12">

                <!-- Horizontal Form -->
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">Cadastro de cliente</h3>
                    </div>
                    <form id="formCliente"
                          name="cadCliente"
                          class="form-horizontal"
                          action=""
                          method="post">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="id"
                                       class="col-sm-2 control-label">ID</label>
                                <div class="col-sm-2">
                                    <%
                                        if (cliente.getId() > 0) {
                                    %>
                                    <input id="idCliente"
                                           style="width: 95px"
                                           type="text"
                                           class="col-md-2 form-control"
                                           name="id"
                                           value="<%= cliente.getId()%>" 
                                           readonly>
                                    <%
                                    } else {
                                    %>
                                    <input id="idCliente"
                                           style="width: 95px"
                                           type="text"
                                           class="form-control"
                                           name="id"
                                           value=""
                                           readonly>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="nome"
                                       class="col-sm-2 control-label">Nome*</label>
                                <div class="col-sm-7">
                                    <input id="clienteNome"
                                           type="text"
                                           class="form-control"
                                           name="nome"
                                           value="<%=cliente.getRazaoSocial()%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Tipo*</label>
                                <div class="col-sm-3">
                                    <select class="form-control"
                                            id="tipo"
                                            name="tipo"
                                            required>
                                        <%
                                            if (cliente.getId() == 0) {
                                        %>
                                        <option value="0">Selecione</option>
                                        <option value="F">Pessoa física</option>
                                        <option value="J">Pessoa jurídica</option>
                                        <%
                                        } else if (cliente.getTipoCadastro() == 'F') {
                                        %>
                                        <option value="F" <%= cliente.getCpfCnpj().trim().equals("") ? "selected" : ""%>>Pessoa física</option>
                                        <%
                                        } else if (cliente.getTipoCadastro() == 'J') {
                                        %>
                                        <option value="J" <%= cliente.getCpfCnpj().trim().equals("") ? "selected" : ""%>>Pessoa jurídica</option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div id="grupo_cnpj">
                                    <label class="col-sm-1 control-label">CNPJ*</label>
                                    <div class="col-sm-3">
                                        <input type="text"
                                               class="form-control"
                                               name="cnpj"
                                               id="cnpj"
                                               value="<%= cliente.getCpfCnpj()%>"
                                               data-inputmask='"mask": "99.999.999/9999-99"'
                                               data-mask>
                                    </div>
                                </div>
                                <div id="grupo_cpf">
                                    <label class="col-sm-1 control-label">CPF*</label>
                                    <div class="col-sm-3">
                                        <input type="text"
                                               class="form-control"
                                               name="cpf"
                                               id="cpf"
                                               value="<%= cliente.getCpfCnpj()%>"
                                               data-inputmask='"mask": "999.999.999-99"'
                                               data-mask>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="telefone"
                                       class="col-sm-2 control-label">Telefone</label>
                                <div class="col-sm-3">
                                    <%
                                        if (cliente.getTelefone() != null
                                                || cliente.getTelefone() != "") {
                                    %>
                                    <input id="clienteTelefone"
                                           type="text"
                                           class="form-control"
                                           name="telefone"
                                           value="<%=cliente.getTelefone()%>"
                                           data-inputmask="'mask': ['(99) 9999-9999[9]']"
                                           data-mask>        
                                    <%
                                    } else {
                                    %>
                                    <input id="clienteTelefone"
                                           type="text"
                                           class="form-control" 
                                           data-inputmask="'mask': ['(99) 9999-9999[9]']"
                                           data-mask>        
                                    <%
                                        }
                                    %>
                                </div>
                                <label for="cidade"
                                       class="col-sm-1 control-label">Cidade*</label>
                                <div class="col-sm-3">
                                    <select id="clienteCidade"
                                            class="form-control select2"
                                            name="cidade">
                                        <option value="0"
                                                selected>Selecione</option>
                                        <%
                                            Cidade cid = new Cidade();
                                            cid.setDescricao("");
                                            cid.setSituacao('A');
                                            ArrayList<Cidade> cidades = new CidadeDAO().listar(cid);
                                            for (int i = 0; i < cidades.size(); i++) {
                                                if (cliente.getCidade().getId() == cidades.get(i).getId()) {
                                        %>
                                        <option value="<%=cidades.get(i).getId()%>"
                                                selected><%=cidades.get(i).getDescricao()%></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%=cidades.get(i).getId()%>"><%=cidades.get(i).getDescricao()%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="endereco"
                                       class="col-sm-2 control-label">Endereço</label>
                                <div class="col-sm-7">
                                    <input id="clienteEndereco"
                                           type="text"
                                           class="form-control"
                                           name="endereco"
                                           value="<%=cliente.getEndereco()%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <input id="cadastraCliente"
                                   style="float: right;width: 95px;background-color: #1087dd;"
                                   type="submit"
                                   class="btn btn-dropbox pull-right-container"
                                   name="enviar"
                                   value="Salvar">
                        </div>
                    </form>
                </div>
            </div>
            <!--/.col (right) -->
        </div>
        <!-- /.row -->
    </section>
    <div id="listadeCliente">
        <%@include file = "listaClientes.jsp"%>
    </div>
</div>

<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script src="bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="bower_components/select2/dist/js/select2.full.js"></script>
<script src="plugins/input-mask/jquery.inputmask.js"></script>
<script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
<script src="bower_components/moment/min/moment.min.js"></script>
<script src="bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<script src="bower_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
<script src="plugins/timepicker/bootstrap-timepicker.min.js"></script>
<script src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="plugins/iCheck/icheck.min.js"></script>
<script src="bower_components/fastclick/lib/fastclick.js"></script>
<script src="dist/js/adminlte.min.js"></script>
<script src="dist/js/demo.js"></script>
<script src="js/CrudActionsCliente.js" type="text/javascript" charset="utf-8"></script>

