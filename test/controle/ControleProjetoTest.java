package controle;

import entidade.Projeto;
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
public class ControleProjetoTest {

    static Projeto proj;
    static ControleProjeto controleProjetoMock;

    @BeforeClass
    public static void setUpClass() throws Exception {
        proj = new Projeto();
        controleProjetoMock = mock(ControleProjeto.class);

        proj.setId(1);
        proj.setDescricao("Mock description");
        proj.setSituacao('A');

        ArrayList<Projeto> lista = new ArrayList<>();
        lista.add(proj);

        when(controleProjetoMock.salvar(proj)).thenReturn(1);
        when(controleProjetoMock.listar(proj)).thenReturn(lista);
        when(controleProjetoMock.consultarId(proj.getId())).thenReturn(lista);
    }

    @Test
    public void testSalvar() {
        int retorno = controleProjetoMock.salvar(proj);
        assertNotNull(proj);
        assertEquals(retorno, 1);
    }

    @Test
    public void testListar() {
        ArrayList<Projeto> retorno = controleProjetoMock.listar(proj);
        assertNotNull(proj);
        assertEquals(1, retorno.get(0).getId());
    }

    @Test
    public void testConsultarId() {
        ArrayList<Projeto> retorno = controleProjetoMock.consultarId(proj.getId());
        assertNotNull(proj);
        assertEquals(1, retorno.get(0).getId());
    }
}
