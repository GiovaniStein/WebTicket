<%@page import="entidade.Usuario"%>
<%@page import="DAO.CidadeDAO"%>
<%@page import="DAO.ProjetoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Cidade"%>
<%@page import="entidade.Cliente"%>
<!DOCTYPE html>

<%@include file = "topo.jsp"%>
<%@include file = "barraLateral.jsp"%>

<%  Usuario usuario = (Usuario) request.getAttribute("objuser");

    if (usuario == null) {
        usuario = new Usuario();
        usuario.setSituacao('A');
        usuario.setNome("");
        usuario.setLogin("");
        usuario.setSenha("");
        usuario.setRepetirSenha("");
    }
%>

<!-- Content Wrapper. Contains page content -->
<div style="height: 300px;overflow: auto;min-height: 768px;"
     class="content-wrapper">

    <!-- Main content -->
    <section class="content">
        <div class="row">

            <!-- right column -->
             <div class="col-md-12">

                <!-- Horizontal Form -->
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">Cadastro de usuário</h3>
                    </div>
                    <form id="formusuario"
                          name="cadCliente"
                          class="form-horizontal">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="id"
                                       class="col-sm-2 control-label">ID</label>
                                <div class="col-md-3">
                                    <%
                                        if (usuario.getId() > 0) {
                                    %>
                                    <input id="idUsuario"
                                           style="width: 95px"
                                           type="text"
                                           class="form-control"
                                           name="id"
                                           value="<%= usuario.getId()%>"
                                           readonly>
                                    <%
                                    } else {
                                    %>
                                    <input id="idUsuario"
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
                                    <input autofocus
                                           id="nomeUsuario"
                                           type="text"
                                           class="form-control"
                                           name="nome"
                                           value="<%=usuario.getNome()%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="login"
                                       class="col-sm-2 control-label">Login</label>
                                <div class="col-sm-7">
                                    <%
                                        if (usuario.getLogin() != null || usuario.getLogin() != "") {
                                    %>
                                    <input id="loginUsuario"
                                           type="email"
                                           class="form-control"
                                           name="login"
                                           value="<%=usuario.getLogin()%>">        
                                    <%
                                    } else {
                                    %>
                                    <input id="loginUsuario"
                                           type="email"
                                           class="form-control">
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="senha"
                                       class="col-sm-2 control-label">Senha</label>
                                <div class="col-sm-7">
                                    <input id="senhaUsuario"
                                           type="password"
                                           class="form-control"
                                           name="senha"
                                           value="<%=usuario.getSenha()%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="repetirSenha"
                                       class="col-sm-2 control-label">Repetir senha</label>
                                <div class="col-sm-7">
                                    <input id="repetirSenhaUsuario"
                                           type="password"
                                           class="form-control"
                                           name="repetirSenha"
                                           value="<%=usuario.getRepetirSenha()%>">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <input id="cadastraUsuario"
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
    <div id="listadeUsuarios">  
        <%@include file = "listaUsuarios.jsp"%>
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
<script src="js/CrudActionsUsuario.js" type="text/javascript" charset="utf-8"></script>