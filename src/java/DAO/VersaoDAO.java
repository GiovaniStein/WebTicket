package DAO;

import apoio.HibernateUtil;
import apoio.ProjectUtils;
import entidade.RestEntity;
import entidade.Versao;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;

public class VersaoDAO extends DAO {

    Versao versao;
    List<Object[]> listResult;
    
    
   

    public int countVersion() {
        this.versao = versao;

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            sql = "from Versao";
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            return q.list().size();
        } catch (HibernateException he) {
            he.printStackTrace();
            return 0;
        }

    }
    
    
   

    public ArrayList<Versao> listar(Versao versao) {
        this.versao = versao;
        List resultado = null;
        ArrayList<Versao> lista = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            sql = "from Versao "
                    + "where "
                    + "situacao = 'A' "
                    + "order by descricao";
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);

            resultado = q.list();

            for (Object o : resultado) {
                Versao ver = ((Versao) ((Object) o));
                lista.add(ver);
            }

        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }

    public ArrayList<Versao> consultarId(int id) {
        List resultado = null;
        ArrayList<Versao> listas = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            sql = "from Versao "
                    + "where "
                    + "id = " + id;
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Versao versao = ((Versao) ((Object) o));
                listas.add(versao);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return listas;
    }
    public ArrayList<RestEntity> consultarIdProjeto(int id) {
        List resultado = null;
        ArrayList<RestEntity> listas = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            sql = "from Versao v "
                    + "where "
                    + "situacao = 'A' "
                    + " and "
                    + "v.projeto.id = " + id;
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Versao versao = ((Versao) ((Object) o));
                RestEntity entity = new RestEntity(versao.getId(), ProjectUtils.stringToCharCodeArray(versao.getDescricao()));
                listas.add(entity);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return listas;
    }
}
