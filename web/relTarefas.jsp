<%@page import="entidade.Tarefa"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="DAO.TarefaDAO"%>

<%@page import="apoio.ConexaoBD"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

        
   
        <h1>Hello World!</h1>
        <%
            try {
                    byte[] bytes = new TarefaDAO().gerarRelatorio();
            
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
            outStream.flush();
            outStream.close();
                } catch (Exception e) {
                    System.out.println("erro ao gerar relatorio jsp "+e);
                }
            
        %>