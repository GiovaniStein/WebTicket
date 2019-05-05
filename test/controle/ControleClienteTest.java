package controle;

import entidade.Cidade;
import entidade.Cliente;
import java.util.ArrayList;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
@Suite.SuiteClasses({})
public class ControleClienteTest {

    static Cliente cliente;
    static Cidade cid;
    static ControleCliente controleClienteMock;

    @BeforeClass
    public static void setUpClass() throws Exception {
        cliente = new Cliente();
        cid = new Cidade();
        controleClienteMock = mock(ControleCliente.class);

        cliente.setId(1);
        cliente.setRazaoSocial("Mock name");
        cliente.setTipoCadastro('F');
        cliente.setTelefone("(99)9999-9999");
        cliente.setEndereco("Mock address");
        cliente.setCpfCnpj("00673362051");
        cid.setId(1);
        cliente.setCidade(cid);
        cliente.setSituacao('A');

        ArrayList<Cliente> lista = new ArrayList<>();
        lista.add(cliente);

        when(controleClienteMock.salvar(cliente)).thenReturn(1);
        when(controleClienteMock.listar(cliente)).thenReturn(lista);
        when(controleClienteMock.consultarId(cliente.getId())).thenReturn(lista);
    }

    @Test
    public void testSalvar() {
        int retorno = controleClienteMock.salvar(cliente);
        assertNotNull(cliente);
        assertEquals(retorno, 1);
    }

    @Test
    public void testListar() {
        ArrayList<Cliente> retorno = controleClienteMock.listar(cliente);
        assertNotNull(cliente);
        assertEquals(1, retorno.get(0).getId());
    }

    @Test
    public void testConsultarId() {
        ArrayList<Cliente> retorno = controleClienteMock.consultarId(cliente.getId());
        assertNotNull(cliente);
        assertEquals(1, retorno.get(0).getId());
    }
}
