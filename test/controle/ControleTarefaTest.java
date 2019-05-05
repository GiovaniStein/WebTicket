package controle;

import entidade.Cliente;
import entidade.Fase;
import entidade.Modulo;
import entidade.Motivo;
import entidade.Prioridade;
import entidade.Projeto;
import entidade.Tarefa;
import entidade.Usuario;
import entidade.Versao;
import java.util.ArrayList;
import java.util.Date;
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
public class ControleTarefaTest {

    static Cliente cliente;
    static Fase fase;
    static Modulo modulo;
    static Motivo motivo;
    static Prioridade prioridade;
    static Projeto projeto;
    static Tarefa tarefa;
    static Versao versaoBug;
    static Versao versaoCorrecao;
    static Usuario autor;
    static Usuario responsavel;
    static ControleTarefa controleTarefaMock;

    @BeforeClass
    public static void setUpClass() throws Exception {
        cliente = new Cliente();
        fase = new Fase();
        modulo = new Modulo();
        motivo = new Motivo();
        prioridade = new Prioridade();
        projeto = new Projeto();
        tarefa = new Tarefa();
        versaoBug = new Versao();
        versaoCorrecao = new Versao();
        autor = new Usuario();
        responsavel = new Usuario();
        controleTarefaMock = mock(ControleTarefa.class);

        tarefa.setId(1);
        cliente.setId(1);
        tarefa.setCliente(cliente);
        tarefa.setDescricao("Mock description");
        fase.setId(1);
        tarefa.setFase(fase);
        modulo.setId(1);
        tarefa.setModulo(modulo);
        motivo.setId(1);
        tarefa.setMotivo(motivo);
        prioridade.setId(1);
        tarefa.setPrioridade(prioridade);
        projeto.setId(1);
        tarefa.setProjeto(projeto);
        tarefa.setSituacao('A');
        tarefa.setTitulo("Mock title");
        Date data = new Date();
        tarefa.setDatahoraPrevisao(data);
        tarefa.setDatahoraCriacao(new Date());
        versaoBug.setId(1);
        tarefa.setVersaoByIdVersaoBug(versaoBug);
        versaoCorrecao.setId(1);
        tarefa.setVersaoByIdVersaoCorrecao(versaoCorrecao);
        responsavel.setId(1);
        tarefa.setUsuarioByIdUsuarioResponsavel(responsavel);
        autor.setId(1);
        tarefa.setUsuarioByIdUsuarioAutor(autor);

        ArrayList<Tarefa> lista = new ArrayList<>();
        lista.add(tarefa);

        when(controleTarefaMock.salvar(tarefa)).thenReturn(1);
        when(controleTarefaMock.listar(tarefa)).thenReturn(lista);
        when(controleTarefaMock.consultarId(tarefa.getId())).thenReturn(lista);
    }

    @Test
    public void testSalvar() {
        int retorno = controleTarefaMock.salvar(tarefa);
        assertNotNull(tarefa);
        assertEquals(retorno, 1);
    }

    @Test
    public void testListar() {
        ArrayList<Tarefa> retorno = controleTarefaMock.listar(tarefa);
        assertNotNull(tarefa);
        assertEquals(1, retorno.get(0).getId());
    }

    @Test
    public void testConsultarId() {
        ArrayList<Tarefa> retorno = controleTarefaMock.consultarId(tarefa.getId());
        assertNotNull(tarefa);
        assertEquals(1, retorno.get(0).getId());
    }
}
