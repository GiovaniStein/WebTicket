package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class Filtro extends HttpServlet implements Filter {

    ArrayList<String> excecoes = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Filtro</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Filtro at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        excecoes.add("/WebTicket/index.jsp");
        excecoes.add("/WebTicket/acao");
        excecoes.add("/WebTicket/bower_components/bootstrap/dist/css/bootstrap.min.css");
        excecoes.add("/WebTicket/bower_components/font-awesome/css/font-awesome.min.css");
        excecoes.add("/WebTicket/bower_components/Ionicons/css/ionicons.min.css");
        excecoes.add("/WebTicket/dist/css/AdminLTE.min.css");
        excecoes.add("/WebTicket/dist/css/skins/_all-skins.min.css");
        excecoes.add("/WebTicket/bower_components/bootstrap-daterangepicker/daterangepicker.css");
        excecoes.add("/WebTicket/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css");
        excecoes.add("/WebTicket/bower_components/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css");
        excecoes.add("/WebTicket/plugins/timepicker/bootstrap-timepicker.min.css");
        excecoes.add("/WebTicket/bower_components/select2/dist/css/select2.min.css");
        excecoes.add("/WebTicket/dist/css/AdminLTE.min.css");
        excecoes.add("/WebTicket/bower_components/jquery/dist/jquery.min.js");
        excecoes.add("/WebTicket/bower_components/bootstrap/dist/js/bootstrap.min.js");
        excecoes.add("/WebTicket/bower_components/select2/dist/js/select2.full.js");
        excecoes.add("/WebTicket/plugins/input-mask/jquery.inputmask.js");
        excecoes.add("/WebTicket/plugins/input-mask/jquery.inputmask.date.extensions.js");
        excecoes.add("/WebTicket/plugins/input-mask/jquery.inputmask.extensions.js");
        excecoes.add("/WebTicket/bower_components/moment/min/moment.min.js");
        excecoes.add("/WebTicket/bower_components/bootstrap-daterangepicker/daterangepicker.js");
        excecoes.add("/WebTicket/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js");
        excecoes.add("/WebTicket/bower_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js");
        excecoes.add("/WebTicket/plugins/timepicker/bootstrap-timepicker.min.js");
        excecoes.add("/WebTicket/bower_components/jquery-slimscroll/jquery.slimscroll.min.js");
        excecoes.add("/WebTicket/bower_components/fastclick/lib/fastclick.js");
        excecoes.add("/WebTicket/dist/js/adminlte.min.js");
        excecoes.add("/WebTicket/dist/js/demo.js");
        excecoes.add("/WebTicket/images/ic_launcher.jpg");
        excecoes.add("/WebTicket/images/ic_launcher.png");
        excecoes.add("/WebTicket/js/jquery-3.3.1.min.js");
        excecoes.add("/WebTicket/js/sweetalert2.js");
        excecoes.add("/WebTicket/js/sweetalert2.css");
        excecoes.add("/WebTicket/js/ckeditor.js");
        excecoes.add("/WebTicket/js/config.js");
        excecoes.add("/WebTicket/js/editor.css");
        excecoes.add("/WebTicket/js/Chart.bundle.js");
        excecoes.add("/WebTicket/js/Chart.bundle.min.js");
        excecoes.add("/WebTicket/js/canvasjs.min.js");
        excecoes.add("/WebTicket/js/Chart.js");
        excecoes.add("/WebTicket/js/Chart.min.css");
        excecoes.add("/WebTicket/js/Chart.min.js");
        excecoes.add("/WebTicket/js/CrudActionsCidade.js");
        excecoes.add("/WebTicket/js/CrudActionsCliente.js");
        excecoes.add("/WebTicket/js/CrudActionsProjeto.js");
        excecoes.add("/WebTicket/js/CrudActionsFase.js");
        excecoes.add("/WebTicket/js/CrudActionsMotivo.js");
        excecoes.add("/WebTicket/js/CrudActionsModulo.js");
        excecoes.add("/WebTicket/js/CrudActionsPrioridade.js");
        excecoes.add("/WebTicket/js/CrudActionsVercao.js");
        excecoes.add("/WebTicket/js/CrudActionsUsuario.js");
        excecoes.add("/WebTicket/js/CrudActionsTarefa.js");
        excecoes.add("/WebTicket/js/CrudActionsEditTarefa.js");
        excecoes.add("/WebTicket/js/CrudActionsMovimentacao.js");
        excecoes.add("/WebTicket/js/ChartsData.js");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;

        if (excecoes.contains(req.getRequestURI())) {
            request.setAttribute("parametro", "login");
            chain.doFilter(request, response);
        } else {
            HttpSession sessao = ((HttpServletRequest) request).getSession();

            if (sessao.getAttribute("usuarioLogado") == null) {
                ((HttpServletResponse) response).sendRedirect("index.jsp");
            } else {
                System.out.println("Destino: " + req.getRequestURI());
                chain.doFilter(request, response);
            }
        }
    }
}
