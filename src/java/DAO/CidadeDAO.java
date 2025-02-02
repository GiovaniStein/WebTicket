package DAO;

import apoio.HibernateUtil;
import entidade.Cidade;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;

public class CidadeDAO extends DAO {

    Cidade cidade;

    public ArrayList<Cidade> listar(Cidade cidade) {
        this.cidade = cidade;
        List resultado = null;
        ArrayList<Cidade> lista = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";

            if (cidade.getDescricao().equals("") || cidade.getDescricao() == null) {
                sql = "from Cidade "
                        + "where "
                        + "situacao = 'A' "
                        + "order by descricao";
            } else {
                sql = "from Cidade "
                        + "where "
                        + "upper(descricao) like '%" + cidade.getDescricao().toUpperCase() + "%' "
                        + "and situacao = 'A' "
                        + "order by descricao";
            }
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Cidade cid = ((Cidade) ((Object) o));
                lista.add(cid);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }

    public ArrayList<Cidade> consultarId(int id) {
        List resultado = null;
        ArrayList<Cidade> lista = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            sql = "from Cidade "
                    + "where "
                    + "id = " + id;
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Cidade cid = ((Cidade) ((Object) o));
                lista.add(cid);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }
}
