package DAO;

import apoio.HibernateUtil;
import entidade.Modulo;
import entidade.Projeto;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

public class ModuloDAO2 extends DAO {

    Modulo modulo;
    List<Object[]> listResult;

    public ArrayList<Modulo> listar(Modulo modulo) {
        this.modulo = modulo;
        ArrayList<Modulo> listaModulo = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql;

            if (modulo.getDescricao().equals("") || modulo.getDescricao() == null) {
                sql = "from Modulo m , Projeto p "
                        + "where p.id = m.id and "
                        + "m.situacao = 'A' "
                        + "order by m.descricao";
            } else {
                sql = "from Modulo m , Projeto p "
                        + "where p.id = m.id and "
                        + "m.situacao = 'A' "
                        + "order by m.descricao";
            }
            Query query = session.createQuery(sql);
            List<Object[]> listResult = query.list();

            for (Object[] aRow : listResult) {
                Modulo modu = (Modulo) aRow[0];
                Projeto proj = (Projeto) aRow[1];
                System.out.println(modu.getDescricao() + " - " + proj.getDescricao());
                listaModulo.add(modu);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return listaModulo;
    }

    public ArrayList<Modulo> consultarId(int id) {
        List resultado = null;
        ArrayList<Modulo> listas = new ArrayList<>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            sql = "from Modulo "
                    + "where "
                    + "id = " + id;
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);
            resultado = q.list();

            for (Object o : resultado) {
                Modulo modulo = ((Modulo) ((Object) o));
                listas.add(modulo);
            }
        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return listas;
    }
}
