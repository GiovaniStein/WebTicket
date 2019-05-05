package DAO;

import apoio.HibernateUtil;
import entidade.Motivo;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;

public class MotivoDAO extends DAO {

    Motivo motivo;

    public ArrayList<Motivo> listar(Motivo motivo) {
        this.motivo = motivo;
        List resultado = null;
        ArrayList<Motivo> lista = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";

            if (motivo.getDescricao().equals("") || motivo.getDescricao() == null) {
                sql = "from Motivo "
                        + "where "
                        + "situacao = 'A' "
                        + "order by descricao";
            } else {
                sql = "from Motivo "
                        + "where "
                        + "upper(descricao) like '%" + motivo.getDescricao().toUpperCase() + "%' "
                        + "and situacao = 'A' "
                        + "order by descricao";
            }
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Motivo mot = ((Motivo) ((Object) o));
                lista.add(mot);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }

    public ArrayList<Motivo> consultarId(int id) {
        List resultado = null;
        ArrayList<Motivo> listas = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            sql = "from Motivo "
                    + "where "
                    + "id = " + id;
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Motivo motiv = ((Motivo) ((Object) o));
                listas.add(motiv);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return listas;
    }
}
