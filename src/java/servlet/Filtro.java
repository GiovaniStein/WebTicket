
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

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    ArrayList<String> excessoes = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
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
        excessoes.add("/WebTicket/index.jsp");
        excessoes.add("/WebTicket/acao");
        excessoes.add("/WebTicket/bower_components/bootstrap/dist/css/bootstrap.min.css");
        excessoes.add("/WebTicket/bower_components/font-awesome/css/font-awesome.min.css");
        excessoes.add("/WebTicket/bower_components/Ionicons/css/ionicons.min.css");
        excessoes.add("/WebTicket/dist/css/AdminLTE.min.css");
        excessoes.add("/WebTicket/dist/css/skins/_all-skins.min.css");
        excessoes.add("/WebTicket/bower_components/bootstrap-daterangepicker/daterangepicker.css");
        excessoes.add("/WebTicket/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css");
        excessoes.add("/WebTicket/bower_components/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css");
        excessoes.add("/WebTicket/plugins/timepicker/bootstrap-timepicker.min.css");
        excessoes.add("/WebTicket/bower_components/select2/dist/css/select2.min.css");
        excessoes.add("/WebTicket/dist/css/AdminLTE.min.css");
        excessoes.add("/WebTicket/bower_components/jquery/dist/jquery.min.js");
        excessoes.add("/WebTicket/bower_components/bootstrap/dist/js/bootstrap.min.js");
        excessoes.add("/WebTicket/bower_components/select2/dist/js/select2.full.js");
        excessoes.add("/WebTicket/plugins/input-mask/jquery.inputmask.js");
        excessoes.add("/WebTicket/plugins/input-mask/jquery.inputmask.date.extensions.js");
        excessoes.add("/WebTicket/plugins/input-mask/jquery.inputmask.extensions.js");
        excessoes.add("/WebTicket/bower_components/moment/min/moment.min.js");
        excessoes.add("/WebTicket/bower_components/bootstrap-daterangepicker/daterangepicker.js");
        excessoes.add("/WebTicket/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js");
        excessoes.add("/WebTicket/bower_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js");
        excessoes.add("/WebTicket/plugins/timepicker/bootstrap-timepicker.min.js");
        excessoes.add("/WebTicket/bower_components/jquery-slimscroll/jquery.slimscroll.min.js");
        excessoes.add("/WebTicket/bower_components/fastclick/lib/fastclick.js");
        excessoes.add("/WebTicket/dist/js/adminlte.min.js");
        excessoes.add("/WebTicket/dist/js/demo.js");
        excessoes.add("/WebTicket/images/ic_launcher.jpg");
        excessoes.add("/WebTicket/images/ic_launcher.png");
        excessoes.add("/WebTicket/js/jquery-3.3.1.min.js");
        excessoes.add("/WebTicket/js/sweetalert2.js");
        excessoes.add("/WebTicket/js/sweetalert2.css");
        
        
//         excessoes.add("/WebTicket/");
//         excessoes.add("/WebTicket/");
//         excessoes.add("/WebTicket/");
//         excessoes.add("/WebTicket/");
//         excessoes.add("/WebTicket/");
//         excessoes.add("/WebTicket/");

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;

// verifica se URL requisitada consta na lista de URLs permitidas
        // caso afirmativo, envia para página de Login
        if (excessoes.contains(req.getRequestURI())) {
            request.setAttribute("parametro", "login");
            chain.doFilter(request, response);
        } else {
            HttpSession sessao = ((HttpServletRequest) request).getSession();

            // caso não pertença a lista, verifica se há usuário na sessão
            // se não houver, encaminha para o Login
            if (sessao.getAttribute("usuarioLogado") == null) {
                ((HttpServletResponse) response).sendRedirect("index.jsp");
            } else {
                // se usuário estiver logado, apenas abra a página solicitada
                System.out.println("Destino: " + req.getRequestURI());
                chain.doFilter(request, response);
            }
        }
    }

}
