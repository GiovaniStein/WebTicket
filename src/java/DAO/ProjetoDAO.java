package DAO;

import apoio.HibernateUtil;
import entidade.Projeto;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;

public class ProjetoDAO extends DAO {

    Projeto projeto;

    public int countProject() {
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "from Projeto where situacao = 'A'";
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            return q.list().size();
        } catch (HibernateException he) {
            he.printStackTrace();
            return 0;
        }

    }

    public ArrayList<Projeto> getAll() {
        List resultado = null;
        ArrayList<Projeto> lista = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "from Projeto p where p.situacao = 'A' order by p.descricao";
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Projeto proj = ((Projeto) ((Object) o));
                lista.add(proj);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }

    public ArrayList<Projeto> listar(Projeto projeto) {
        this.projeto = projeto;
        List resultado = null;
        ArrayList<Projeto> lista = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";

            if (projeto.getDescricao().equals("") || projeto.getDescricao() == null) {
                sql = "from Projeto "
                        + "where "
                        + "situacao = 'A' "
                        + "order by descricao";
            } else {
                sql = "from Projeto "
                        + "where "
                        + "upper(descricao) like '%" + projeto.getDescricao().toUpperCase() + "%' "
                        + "and situacao = 'A' "
                        + "order by descricao";
            }
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Projeto proj = ((Projeto) ((Object) o));
                lista.add(proj);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }

    public ArrayList<Projeto> consultarId(int id) {
        //this.projeto = projeto;
        List resultado = null;
        ArrayList<Projeto> listas = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            sql = "from Projeto "
                    + "where "
                    + "id = " + id;
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Projeto proj = ((Projeto) ((Object) o));
                listas.add(proj);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return listas;
    }
}
