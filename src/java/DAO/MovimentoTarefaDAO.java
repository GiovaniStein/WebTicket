
package DAO;

import apoio.HibernateUtil;
import entidade.Cliente;
import entidade.MovimentoTarefa;
import entidade.Tarefa;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;


public class MovimentoTarefaDAO extends DAO{
    MovimentoTarefa movimentoTarefa;
     public ArrayList<MovimentoTarefa> listar(MovimentoTarefa movimentoTarefa) {
        this.movimentoTarefa = movimentoTarefa;
        List resultado = null;

        ArrayList<MovimentoTarefa> lista = new ArrayList<>();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            
                sql = "from MovimentoTarefa  "
                        + " where id_tarefa = "+movimentoTarefa.getTarefa().getId()
                        + " and situacao ='A'";
                        
            
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);

            resultado = q.list();

            for (Object o : resultado) {
                MovimentoTarefa mov = ((MovimentoTarefa) ((Object) o));
                lista.add(mov);
            }

        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }
    
     
        public ArrayList<MovimentoTarefa> consultarId(int id) {
        //this.projeto = projeto;
        List resultado = null;

        ArrayList<MovimentoTarefa> listas = new ArrayList<>();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";

            sql = "from MovimentoTarefa  "
                    + "where "
                    + " id =" + id;

            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);

            resultado = q.list();

            for (Object o : resultado) {
                MovimentoTarefa movimento = ((MovimentoTarefa) ((Object) o));
                listas.add(movimento);
            }

        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return listas;

    }
     
     
     
}
