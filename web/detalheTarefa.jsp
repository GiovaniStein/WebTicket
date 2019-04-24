<%@page import="DAO.TarefaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title >JSP Page</title>
    </head>
    <body>
        <h1  style="-webkit-line-clamp: 1;-webkit-box-orient: vertical;word-wrap: break-word;display: -webkit-box;width: 100%;overflow: hidden;" id="tasktitle"></h1>
        <div style="height: 85%;max-height: 85%;overflow: auto;">
            <div style="display: inline-flex;padding-top: 20px">
                <span style="font-weight: bold;">Cliente : </span>
                <div id="taskclient"></div>
                <span style="padding-left: 20px;font-weight: bold;">Projeto : </span>
                <div id="taskproject"></div>
                <span style="padding-left: 20px;font-weight: bold;">Módulo : </span>
                <div id="taskmodule"></div> 
                <span style="padding-left: 20px;font-weight: bold;">Data Criação : </span>
                <div id="taskcreatedate"></div>
            </div>

            <div style="padding-top: 50px;min-height: 200px;max-height: 300px;overflow: auto;" id="taskdescription"></div>

            <div class="box-body"  id="tasktablecontainer" style="padding-top: 30px">
                <table style="table-layout: fixed; width: 100%" class="table table-bordered table-striped table-hover" id="taskmov">

                </table>

            </div>


        </div>


    </body>
   
    

</html>

