
-- -----------------------------------------------------
-- Table usuario
-- -----------------------------------------------------
CREATE TABLE usuario (
  id serial,
  nome VARCHAR(150) NOT NULL,
  login VARCHAR(100) NOT NULL unique,
  senha VARCHAR(200) NOT NULL,
repetir_senha VARCHAR(200),
  situacao CHAR(1) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table projeto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS projeto (
  id serial,
  descricao VARCHAR(60) NOT NULL,
  situacao CHAR(1) NOT NULL,
  PRIMARY KEY (id));
-- tste

-- -----------------------------------------------------
-- Table versao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS versao (
  id serial,
  id_projeto INT NOT NULL,
  descricao VARCHAR(45) NOT NULL,
  situacao CHAR(1) NOT NULL,
  PRIMARY KEY (id),
  -- INDEX fk_versao_projeto1_idx (id_projeto),
  CONSTRAINT fk_versao_projeto1
    FOREIGN KEY (id_projeto)
    REFERENCES projeto (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table prioridade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS prioridade (
  id serial,
  descricao VARCHAR(45) NOT NULL,
  situacao CHAR(1) NOT NULL,
  PRIMARY KEY (id))
;


-- -----------------------------------------------------
-- Table motivo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS motivo (
  id serial,
  descricao VARCHAR(45) NOT NULL,
  situacao CHAR(1) NOT NULL,
  PRIMARY KEY (id))
;


-- -----------------------------------------------------
-- Table cidade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cidade (
  id serial,
  descricao VARCHAR(150) NULL,
  situacao CHAR(1) NOT NULL,
  PRIMARY KEY (id))
;


-- -----------------------------------------------------
-- Table cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cliente (
  id serial,
  id_cidade INT NOT NULL,
  razao_social VARCHAR(150) NOT NULL,
  cpf_cnpj VARCHAR(18) NULL,
  tipo_cadastro CHAR(1) NOT NULL,
  clientecol VARCHAR(45) NULL,
  endereco VARCHAR(150) NULL,
  telefone VARCHAR(15) NULL,
  situacao CHAR(1) NOT NULL,
  PRIMARY KEY (id),
  --INDEX fk_cliente_cidade1_idx (id_cidade),
  CONSTRAINT fk_cliente_cidade1
    FOREIGN KEY (id_cidade)
    REFERENCES cidade (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table fase
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS fase (
  id serial,
  descricao VARCHAR(45) NOT NULL,
  situacao CHAR(1) NOT NULL,
  PRIMARY KEY (id))
;


-- -----------------------------------------------------
-- Table modulo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS modulo (
  id serial,
  id_projeto INT NOT NULL,
  descricao VARCHAR(45) NOT NULL,
  situacao CHAR(1) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_modulo_projeto
    FOREIGN KEY (id_projeto)
    REFERENCES projeto (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table tarefa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tarefa (
  id serial,
  id_cliente INT NOT NULL,
  id_projeto INT NOT NULL,
  id_motivo INT NOT NULL,
  id_prioridade INT NOT NULL,
  id_fase INT NOT NULL,
  id_modulo INT NOT NULL,
  id_versao_bug INT NOT NULL,
  id_versao_correcao INT NOT NULL,
  id_usuario_autor INT NOT NULL,
  id_usuario_responsavel INT NOT NULL,
  titulo VARCHAR(150) NOT NULL,
  descricao text NULL,
  datahora_criacao TIMESTAMP NOT NULL,
  datahora_previsao DATE NOT NULL,
  
  situacao CHAR(1) NOT NULL,
  PRIMARY KEY (id),
 
  CONSTRAINT fk_tarefa_projeto1
    FOREIGN KEY (id_projeto)
    REFERENCES projeto (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tarefa_motivo1
    FOREIGN KEY (id_motivo)
    REFERENCES motivo (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tarefa_versao1
    FOREIGN KEY (id_versao_bug)
    REFERENCES versao (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tarefa_versao2
    FOREIGN KEY (id_versao_correcao)
    REFERENCES versao (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tarefa_prioridade1
    FOREIGN KEY (id_prioridade)
    REFERENCES prioridade (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tarefa_cliente1
    FOREIGN KEY (id_cliente)
    REFERENCES cliente (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tarefa_fase1
    FOREIGN KEY (id_fase)
    REFERENCES fase (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tarefa_usuario1
    FOREIGN KEY (id_usuario_autor)
    REFERENCES usuario (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tarefa_usuario2
    FOREIGN KEY (id_usuario_responsavel)
    REFERENCES usuario (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tarefa_modulo1
    FOREIGN KEY (id_modulo)
    REFERENCES modulo (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table movimento_tarefa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS movimento_tarefa (
  id serial,
  id_tarefa INT NOT NULL,
  id_usuario INT NOT NULL,
  descricao text NOT NULL,
  datahora_movimento TIMESTAMP NOT NULL,
  situacao CHAR(1) NOT NULL,
  anexo VARCHAR(45) NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_movimento_tarefa_tarefa
    FOREIGN KEY (id_tarefa)
    REFERENCES tarefa (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT fk_movimento_tarefa_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table tarefa_usuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tarefa_usuario (
  id serial,
  id_tarefa INT NOT NULL,
  id_usuario INT NOT NULL,
  PRIMARY KEY (id),
--  INDEX fk_tarefa_has_usuario_usuario1_idx (id_usuario),
--  INDEX fk_tarefa_has_usuario_tarefa1_idx (id_tarefa),
  CONSTRAINT fk_tarefa_has_usuario_tarefa1
    FOREIGN KEY (id_tarefa)
    REFERENCES tarefa (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tarefa_has_usuario_usuario1
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;





insert into usuario values(default,'Andrei','andreimileto@gmail.com','65eca8a8310be44510c71765db3e0e98d9a3ac555e480041383c4592390b8118bd4c2556deb77846ae327836033a7257b8ea5cc51425554c633de40f54b94d2d','65eca8a8310be44510c71765db3e0e98d9a3ac555e480041383c4592390b8118bd4c2556deb77846ae327836033a7257b8ea5cc51425554c633de40f54b94d2d','A');