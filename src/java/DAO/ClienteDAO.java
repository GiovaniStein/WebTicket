
package DAO;

import apoio.HibernateUtil;
import entidade.Cliente;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;


public class ClienteDAO extends DAO{
    Cliente cliente;
     public ArrayList<Cliente> listar(Cliente cliente) {
        this.cliente = cliente;
        List resultado = null;

        ArrayList<Cliente> lista = new ArrayList<>();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";
            if (cliente.getRazaoSocial().equals("") || cliente.getRazaoSocial() == null) {
                sql = "from Cliente  "
                        + "where "
                        + "situacao ='A'"
                        + " order by razao_social";
            } else {
                sql = "from Cliente  "
                        + "where "
                        + "cpf_cnpj = '" + cliente.getCpfCnpj()+"' "
                        + "and situacao ='A'"
                        + " order by razao_social";
            }
            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);

            resultado = q.list();

            for (Object o : resultado) {
                Cliente cli = ((Cliente) ((Object) o));
                lista.add(cli);
            }

        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return lista;
    }
    
     
        public ArrayList<Cliente> consultarId(int id) {
        //this.projeto = projeto;
        List resultado = null;

        ArrayList<Cliente> listas = new ArrayList<>();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            String sql = "";

            sql = "from Cliente  "
                    + "where "
                    + " id =" + id;

            String sel = sql;
            System.out.println(sel);
            org.hibernate.Query q = session.createQuery(sql);

            resultado = q.list();

            for (Object o : resultado) {
                Cliente cliente = ((Cliente) ((Object) o));
                listas.add(cliente);
            }

        } catch (HibernateException he) {
            he.printStackTrace();
        }// finally {
//            session.close();
//        }
        return listas;

    }
     
     
     
}
