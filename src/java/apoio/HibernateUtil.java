package apoio;

import java.net.URL;
import javax.swing.JOptionPane;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

public class HibernateUtil {

    private static ServiceRegistry registry;
    private static SessionFactory sessionFactory;

    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try {
                //Carrega o arquivo de configuracao do Hibernate
                URL cfg = HibernateUtil.class.getResource("/hibernate.cfg.xml");
                Configuration c = new Configuration().configure(cfg);
                sessionFactory = c.buildSessionFactory();
            } catch (HibernateException e) {
                JOptionPane.showMessageDialog(null,
                        "Erro ao conectar com o banco de dados "
                        + e.getMessage());
            }
        }
        // MemoryHelper.forceGc();
        return sessionFactory;
    }

    //To shut down
    public static void shutdown() {
        if (registry != null) {
            StandardServiceRegistryBuilder.destroy(registry);
        }
        if (sessionFactory != null) {
            sessionFactory.close();
            sessionFactory = null;
        }
    }
}
