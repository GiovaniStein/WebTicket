
package DAO;

import apoio.ConexaoBD;
import apoio.HibernateUtil;
import entidade.Projeto;
import entidade.Usuario;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import org.hibernate.HibernateException;
import org.hibernate.Session;


public class UsuarioDAO extends DAO {

    Usuario usuario;

    public ArrayList<Usuario> listar(Usuario usuario) {
        this.usuario = usuario;
        List resultado = null;

        ArrayList<Usuario> lista = new ArrayList<>();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "from Usuario  "
                   // + "where ( upper(nome)  like '" + usuario.getNome().toUpperCase() + "%' "
                    + "where upper(login)  like '" +usuario.getLogin().toUpperCase()+"%' "
                    + "and situacao ='A'"
                    + " order by login";
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);

            resultado = q.list();

            for (Object o : resultado) {
                Usuario user = ((Usuario) ((Object) o));
                lista.add(user);
            }
            
            

        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }
    
    
    public int CountUsers() {
        this.usuario = usuario;
        List resultado = null;

        ArrayList<Usuario> lista = new ArrayList<>();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "from Usuario";
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            return q.list().size();

        } catch (HibernateException he) {
            he.printStackTrace();
            return 0;
        }
     
    }
    
    public ArrayList<Usuario> listarTodos(Usuario usuario) {
        this.usuario = usuario;
        List resultado = null;

        ArrayList<Usuario> lista = new ArrayList<>();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "from Usuario  "
                   // + "where ( upper(nome)  like '" + usuario.getNome().toUpperCase() + "%' "
                    + "where login like '" +usuario.getLogin()+"%' "
                    + " order by login";
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);

            resultado = q.list();

            for (Object o : resultado) {
                Usuario user = ((Usuario) ((Object) o));
                lista.add(user);
            }
            
            

        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }

    
     public ArrayList<Usuario> consultarId(int id) {
        this.usuario= usuario;
        List resultado = null;

        ArrayList<Usuario> lista = new ArrayList<>();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";

            sql = "from Usuario "
                    + "where "
                    + " id =" + id;

            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);

            resultado = q.list();

            for (Object o : resultado) {
                Usuario user = ((Usuario) ((Object) o));
                lista.add(user);
            }

        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;


    }
      public byte[] gerarRelatorio() {
        try {
            
            Connection conn = new ConexaoBD().getInstance().getConnection();
             
            JasperReport relatorio = JasperCompileManager.compileReport(getClass().getResourceAsStream("/relatorios/relUsuarios.jrxml"));

            Map parameters = new HashMap();
            
            byte[] bytes = JasperRunManager.runReportToPdf(relatorio, parameters, conn);

            return bytes;
        } catch (Exception e) {
            System.out.println("erro ao gerar relatorio: " + e);
        }
        return null;
    }
    
}
