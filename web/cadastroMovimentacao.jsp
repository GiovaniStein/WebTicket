<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>



    </head>
    <body>



        <form  id="cadMovimentacao" name="cadMovimentacao" class="form-horizontal" action="" method="post">
            <div class="form-group">
                <label for="movimentacao" class="col-sm-1 control-label">Movimentação</label>
                <div class="col-xs-12">
                    <textarea style="width: 100%;height: 300px; max-height: 300px" id="editorMovimentacao" name="movimentacao"  rows="5" cols="5"></textarea>
                   
                </div>
            </div>


            <input id="cadastraMovimentacao" style="float: right;width: 95px;background-color: #1087dd;margin-top: 10px;" type="submit" class="btn btn-dropbox pull-right-container" name="enviar" value="Salvar"> 


        </form>
       <script src="js/CrudActionsMovimentacao.js" type="text/javascript" charset="utf-8"></script>
    </body>
    

</html>


