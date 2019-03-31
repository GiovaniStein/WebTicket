<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script type="text/javascript">

            // Via JQuery
            $(document).ready(function () {
                $('#cadastraMovimentacao').click(function (event) {
                    event.preventDefault();
                    var values = $('#cadMovimentacao').serialize();
                    
                    
                    var id = $('#idTarefa').val();
                    
                    var v = values+"&idTarefa="+id;
                     console.log('values ', v);
                    if (valida_form() === true) {
                        $.ajax({
                            type: "POST",
                            url: "/WebTicket/acao?parametro=cadMovimentacao",
                            data: v
                        }).done(function (retorno) {
                            var resultado = $.trim(retorno);
                            if (resultado !== "ok") {
                                swal("Houve um erro!", resultado, "error");
                                //$('#idDescricao').focus();
                            } else {
                                swal("Sucesso ao Salvar!", "", "success");
                                $('#cadMovimentacao').each(function () {
                                    this.reset();
                                });
                                var modal = document.getElementById('myModal');
                                $('#listaMovimentacoes').load('listaMovimentacoes.jsp',{ "id": id });
                                document.getElementsByClassName("close")[0].click();
                               
                               
                            }
                        });
                        return false;

                    } else {
                        swal("Preencha os campos corretamente!");
                    }
                }
                );
            });
        </script>
        <script type="text/javascript">

            function valida_form() {
                if ((document.getElementById("editorMovimentacao").value === null || document.getElementById("editorMovimentacao").value === "")) {
                    return false;
                } else {
                    return true;
                }
            }
        </script>




    </head>
    <body>



        <form id="cadMovimentacao" name="cadMovimentacao" class="form-horizontal" action="" method="post">
            <div class="form-group">
                <label for="movimentacao" class="col-sm-1 control-label">Movimentação</label>
                <div class="col-xs-12">
                    <textarea style="width: 100%;height: 284px;" id="editorMovimentacao" name="movimentacao"  rows="5" cols="5"></textarea>
                   
                </div>
            </div>


            <input id="cadastraMovimentacao" style="float: right;width: 95px;background-color: #1087dd;margin-top: 10px;" type="submit" class="btn btn-dropbox pull-right-container" name="enviar" value="Salvar"> 


        </form>
      
       
    </body>


</html>
