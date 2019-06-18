package DAO;

import apoio.HibernateUtil;
import entidade.Fase;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;

public class FaseDAO extends DAO {

    Fase fase;

    public ArrayList<Fase> getAll() {
        List resultado = null;
        ArrayList<Fase> lista = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "from Fase f where f.situacao = 'A'";
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Fase fas = ((Fase) ((Object) o));
                lista.add(fas);
            }

        } catch (HibernateException he) {
            he.printStackTrace();
        }
        return lista;
    }

    public ArrayList<Fase> listar(Fase fase) {
        this.fase = fase;
        List resultado = null;
        ArrayList<Fase> lista = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "from Fase "
                    + "where "
                    + "situacao = 'A' "
                    + "order by descricao";
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Fase fas = ((Fase) ((Object) o));
                lista.add(fas);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }

    public ArrayList<Fase> consultarId(int id) {
        List resultado = null;
        ArrayList<Fase> listas = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            sql = "from Fase "
                    + "where "
                    + "id = " + id;
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Fase fas = ((Fase) ((Object) o));
                listas.add(fas);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return listas;
    }
}
