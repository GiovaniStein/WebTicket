<%@page import="DAO.TarefaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title >JSP Page</title>
    </head>
    <body>
        <h1 id="tasktitle"></h1>
        <div style="height: 85%;max-height: 85%;overflow: auto;">
            <div style="display: inline-flex;padding-top: 20px">
                <span style="font-weight: bold;">Cliente : </span>
                <div id="taskclient"></div>
                <span style="padding-left: 20px;font-weight: bold;">Projeto : </span>
                <div id="taskproject"></div>
                <span style="padding-left: 20px;font-weight: bold;">Módulo : </span>
                <div id="taskmodule"></div> 
            </div>

            <div style="padding-top: 50px;min-height: 200px;" id="taskdescription"></div>

            <div class="box-body"  id="tasktablecontainer" style="padding-top: 20px">
                <table class="table table-bordered table-striped table-hover" id="taskmov">

                </table>

            </div>


        </div>


    </body>
   
    

</html>

