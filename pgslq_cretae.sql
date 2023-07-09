/* 
	Kaio de Oliveira e Sousa (202165080AC)
	Artur Welerson Sott Meyer (202065552C)
*/

  DROP SCHEMA public CASCADE;
  CREATE SCHEMA public;
    
-- DDL
	-- Tabela com status de movimentações
    CREATE TABLE StatusMovimentacao(
		valor VARCHAR(20),
        PRIMARY KEY (valor)
    );
    INSERT INTO StatusMovimentacao (valor) VALUES ('Em processamento'), ('Negado'),('Concluído');
    
    -- Tabela de status das faturas
    CREATE TABLE StatusFatura(
		valor VARCHAR(20),
        PRIMARY KEY (valor)
    );
    INSERT INTO StatusFatura (valor) VALUES ('Aguardando pagamento'), ('Vencida'),('Paga');
    
    -- Tabela com sexos permitidos
	CREATE TABLE SexoPermitido (
	  valor CHAR(1),
	  PRIMARY KEY (valor)
	);
    INSERT INTO SexoPermitido (valor) VALUES ('M'), ('F');
    
    -- Tabela com status de conta permitidos
     CREATE TABLE StatusConta(
		valor VARCHAR(20),
        PRIMARY KEY (valor)
    );
    INSERT INTO StatusConta (valor) VALUES ('Ativa'), ('Inativa'),('Bloqueada');
    
    -- Tabela com tipos de operação permitidos
     CREATE TABLE TiposOperacao(
		valor CHAR(1),
        PRIMARY KEY (valor)
    );
    INSERT INTO TiposOperacao (valor) VALUES ('D'),('S'),('E'),('I'),('T');
    
    
    -- Criação da tabela Pessoa
	CREATE TABLE Pessoa (
	   id_pessoa SERIAL PRIMARY KEY, -- Faz com que o id seja criado automaticamente e sempre incrementado de 1 em 1
	   cnpj VARCHAR(14) UNIQUE,
	   cpf VARCHAR(11) UNIQUE,
	   nome VARCHAR(100) NOT NULL,
	   endereco VARCHAR(100) NOT NULL,
	   email VARCHAR(100) NOT NULL,
	   telefone VARCHAR(20) NOT NULL,
	   data_nasc DATE NOT NULL,
	   sexo CHAR(1) NOT NULL,
	   
	   -- CONSTRAINT CHK_Data_Nasc CHECK (data_nasc = STR_TO_DATE(data_nasc, '%d/%m/%Y')), -- Faz com que a data seja feita no padrão DD/MM/AAAA
	   CONSTRAINT FK_Sexo FOREIGN KEY (sexo) REFERENCES SexoPermitido (valor)
	  );
	  
	-- Criação da tabela Banco
	CREATE TABLE Banco (
	  id_banco SERIAL PRIMARY KEY,
	  nome_banco VARCHAR(100)  NOT NULL,
	  telefone VARCHAR(20)  NOT NULL,
	  cnpj VARCHAR(14) UNIQUE NOT NULL
	);

	-- Criação da tabela Agencia
	CREATE TABLE Agencia (
	  id_agencia SERIAL PRIMARY KEY,
	  nome_agencia VARCHAR(100) NOT NULL,
	  endereco VARCHAR(200) NOT NULL,
	  telefone VARCHAR(20) NOT NULL,
	  id_banco INTEGER NOT NULL,
	  FOREIGN KEY (id_banco) REFERENCES Banco(id_banco)
	);

	-- Criação da tabela Cliente
	CREATE TABLE Cliente (
	  id_cliente SERIAL PRIMARY KEY,
	  id_pessoa INTEGER NOT NULL,
	  id_agencia INTEGER NOT NULL,
      senha varchar(50) DEFAULT '12345' NOT NULL,
	  FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa),
	  FOREIGN KEY (id_agencia) REFERENCES Agencia(id_agencia)
	);

	-- Criação da tabela Funcinario
	CREATE TABLE Funcionario (
	  id_funcionario SERIAL PRIMARY KEY,
	  id_pessoa INTEGER NOT NULL,
	  cargo VARCHAR(100) NOT NULL,
	  salario DECIMAL(10,2) NOT NULL,
	  data_admissao DATE NOT NULL,
	  id_gerente INTEGER,
	  id_agencia INTEGER NOT NULL,
	  FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa),
	  FOREIGN KEY (id_gerente) REFERENCES Funcionario(id_funcionario),
	  FOREIGN KEY (id_agencia) REFERENCES Agencia(id_agencia) -- ,
	  
	  -- CONSTRAINT CHK_Data CHECK (data_admissao = STR_TO_DATE(data_admissao, '%d/%m/%Y')) -- Faz com que a data seja feita no padrão DD/MM/AAAA
	);
    
	-- Criação da tabela Conta
	CREATE TABLE Conta (
	  id_conta SERIAL PRIMARY KEY NOT NULL,
      numero VARCHAR(20) UNIQUE NOT NULL,
	  status VARCHAR(20) DEFAULT 'Ativo',
	  saldo DECIMAL(10,2) NOT NULL DEFAULT 0,
	  limite DECIMAL(10,2) NOT NULL,
	  id_cliente INTEGER NOT NULL,
      
	  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
      CONSTRAINT FKc_Status FOREIGN KEY (status) REFERENCES StatusConta (valor)
	);

	-- Criação da tabela Cartão
	CREATE TABLE Cartao (
	  id_cartao SERIAL PRIMARY KEY,
	  numero VARCHAR(16) UNIQUE NOT NULL,
	  validade VARCHAR(5) NOT NULL,
	  cvv VARCHAR(3) NOT NULL,
	  bandeira VARCHAR(50) NOT NULL,
	  limite DECIMAL(10,2) NOT NULL,
	  id_conta INTEGER NOT NULL,
	  FOREIGN KEY (id_conta) REFERENCES Conta(id_conta),

	  CONSTRAINT CHK_Validade CHECK (validade ~ '^(0[1-9]|1[0-2])/[0-9]{2}$') 
	);
    
	-- Criação da tabela Fatura
	CREATE TABLE Fatura (
	  id_fatura SERIAL PRIMARY KEY,
	  vencimento DATE NOT NULL,
	  pagamento DATE,
	  status VARCHAR(20) DEFAULT 'Aguardando pagamento',
	  id_cartao INTEGER NOT NULL,
	  FOREIGN KEY (id_cartao) REFERENCES Cartao(id_cartao),
	  
      CONSTRAINT FKf_status FOREIGN KEY (status) REFERENCES StatusFatura(valor)
	);

	-- Criação da tabela Compra
	CREATE TABLE Compra (
	  id_compra SERIAL PRIMARY KEY,
	  valor DECIMAL(10,2) NOT NULL,
	  divisao INTEGER NOT NULL,
	  data_hora date DEFAULT CURRENT_TIMESTAMP,
	  estabelecimento VARCHAR(100) NOT NULL
	);

	-- Criação da tabela FaturaCompra
	CREATE TABLE FaturaCompra (
	  id_fatura INTEGER NOT NULL,
	  id_compra INTEGER NOT NULL,
	  valor_parcela DECIMAL(10,2)  NOT NULL,
      PRIMARY KEY (id_fatura,id_compra),
	  FOREIGN KEY (id_fatura) REFERENCES Fatura(id_fatura),
	  FOREIGN KEY (id_compra) REFERENCES Compra(id_compra)
	);

	-- Criação da tabela Operação
	CREATE TABLE Operacao (
	  id_operacao SERIAL PRIMARY KEY,
	  valor DECIMAL(10,2) NOT NULL,
	  data_hora date DEFAULT CURRENT_TIMESTAMP,
	  id_conta INTEGER  NOT NULL,
      tipo_op CHAR(1) NOT NULL,
      
	  FOREIGN KEY (id_conta) REFERENCES Conta(id_conta),
      CONSTRAINT FK_TipoOperacao FOREIGN KEY (tipo_op) REFERENCES TiposOperacao (valor)
	);

	-- Criação da tabela Depósito
	CREATE TABLE Deposito (
	  id_operacao INTEGER PRIMARY KEY,
	  status VARCHAR(20) DEFAULT 'Em processamento',
      
	  FOREIGN KEY (id_operacao) REFERENCES Operacao(id_operacao),
      CONSTRAINT FKd_status FOREIGN KEY (status) REFERENCES StatusMovimentacao(valor)
	);

	-- Criação da tabela Saque
	CREATE TABLE Saque (
	  id_operacao INTEGER PRIMARY KEY,
	  status VARCHAR(20) DEFAULT 'Em processamento',
      
	  FOREIGN KEY (id_operacao) REFERENCES Operacao(id_operacao),
      CONSTRAINT FKs_status FOREIGN KEY (status) REFERENCES StatusMovimentacao(valor)
      
	);

	-- Criação da tabela Investimento
	CREATE TABLE Investimento (
	  id_operacao INTEGER PRIMARY KEY,
	  tipo VARCHAR(50) NOT NULL,
	  taxa_rendimento DECIMAL(5,2) NOT NULL,
	  prazo INTEGER  NOT NULL,
	  FOREIGN KEY (id_operacao) REFERENCES Operacao(id_operacao)
	);

	-- Criação da tabela Empréstimo
	CREATE TABLE Emprestimo (
	  id_operacao INTEGER PRIMARY KEY,
	  taxa_juros DECIMAL(5,2)  NOT NULL,
	  parcelas INTEGER  NOT NULL,
	  FOREIGN KEY (id_operacao) REFERENCES Operacao(id_operacao)
	);

	-- Criação da tabela Transferência
	CREATE TABLE Transferencia (
	  id_operacao INTEGER PRIMARY KEY,
	  id_destino INT NOT NULL,
	  status VARCHAR(20) DEFAULT 'Em processamento',
	  FOREIGN KEY (id_operacao) REFERENCES Operacao(id_operacao),
	  FOREIGN KEY (id_destino) REFERENCES Conta(id_conta),
      CONSTRAINT FKt_status FOREIGN KEY (status) REFERENCES StatusMovimentacao(valor)
	);

	-- Funções
	CREATE OR REPLACE FUNCTION validate_cpf(cpf VARCHAR(11))
	RETURNS BOOLEAN AS $$
	BEGIN
	  IF LENGTH(cpf) = 11 THEN
		cpf := REPLACE(REPLACE(REPLACE(cpf, '.', ''), '-', ''), '/', '');
		IF LENGTH(cpf) = 11 AND cpf ~ '^[0-9]+$' THEN
		  RETURN TRUE;
		ELSE
		  RETURN FALSE;
		END IF;
	  ELSE
		RETURN FALSE;
	  END IF;
	END;
	$$ LANGUAGE plpgsql;


	CREATE OR REPLACE FUNCTION validate_cnpj(cnpj VARCHAR(14))
	RETURNS BOOLEAN AS $$
	BEGIN
	  IF LENGTH(cnpj) = 14 THEN
		cnpj := REPLACE(REPLACE(REPLACE(cnpj, '.', ''), '-', ''), '/', '');
		IF LENGTH(cnpj) = 14 AND cnpj ~ '^[0-9]+$' THEN
		  RETURN TRUE;
		ELSE
		  RETURN FALSE;
		END IF;
	  ELSE
		RETURN FALSE;
	  END IF;
	END;
	$$ LANGUAGE plpgsql;


	-- Triggers
	CREATE OR REPLACE FUNCTION validate_pessoa_cpf_cnpj()
	RETURNS TRIGGER AS $$
	BEGIN
	  IF NEW.cpf IS NOT NULL THEN
		IF NOT validate_cpf(NEW.cpf) THEN
		  RAISE EXCEPTION 'CPF inválido.';
		END IF;
	  END IF;

	  IF NEW.cnpj IS NOT NULL THEN
		IF NOT validate_cnpj(NEW.cnpj) THEN
		  RAISE EXCEPTION 'CNPJ inválido.';
		END IF;
	  END IF;

	  RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;


	CREATE TRIGGER validate_pessoa_cpf_cnpj
	BEFORE INSERT ON Pessoa
	FOR EACH ROW
	EXECUTE FUNCTION validate_pessoa_cpf_cnpj();


	CREATE TRIGGER validate_pessoa_cpf_cnpj_up
	BEFORE UPDATE ON Pessoa
	FOR EACH ROW
	EXECUTE FUNCTION validate_pessoa_cpf_cnpj();


	CREATE OR REPLACE FUNCTION validate_banco_cnpj()
	RETURNS TRIGGER AS $$
	BEGIN
	  IF NEW.cnpj IS NOT NULL THEN
		IF NOT validate_cnpj(NEW.cnpj) THEN
		  RAISE EXCEPTION 'CNPJ inválido.';
		END IF;
	  END IF;
	  RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;


	CREATE TRIGGER validate_banco_cnpj
	BEFORE INSERT ON Banco
	FOR EACH ROW
	EXECUTE FUNCTION validate_banco_cnpj();


	CREATE OR REPLACE FUNCTION check_cpf_cnpj()
	RETURNS TRIGGER AS $$
	BEGIN
	  IF (NEW.cpf IS NULL AND NEW.cnpj IS NULL) OR (NEW.cpf IS NOT NULL AND NEW.cnpj IS NOT NULL) THEN
		RAISE EXCEPTION 'Preencha apenas o CPF ou o CNPJ.';
	  END IF;
	  RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;


	CREATE TRIGGER check_cpf_cnpj
	BEFORE INSERT ON Pessoa
	FOR EACH ROW
	EXECUTE FUNCTION check_cpf_cnpj();


	CREATE TRIGGER check_cpf_cnpj_up
	BEFORE UPDATE ON Pessoa
	FOR EACH ROW
	EXECUTE FUNCTION check_cpf_cnpj();


	CREATE OR REPLACE FUNCTION validar_validade()
	  RETURNS TRIGGER AS $$
	BEGIN
	  IF NEW.validade IS NOT NULL THEN
		IF NOT NEW.validade ~ '^(0[1-9]|1[0-2])\/[0-9]{2}$' THEN
		  RAISE EXCEPTION 'Invalid validity format. Please use the format MM/YY.';
		END IF;
	  END IF;
	  RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;


	CREATE TRIGGER validar_validade
	BEFORE INSERT ON Cartao
	FOR EACH ROW
	EXECUTE FUNCTION validar_validade();


	CREATE OR REPLACE FUNCTION atualiza_saldo()
	RETURNS TRIGGER AS $$
	BEGIN
	  IF NEW.tipo_op = 'D' THEN
		INSERT INTO Deposito(id_operacao) VALUES (NEW.id_operacao);
		UPDATE Conta SET saldo = saldo + NEW.valor WHERE id_conta = NEW.id_conta;
		UPDATE Deposito SET status = 'Concluído' WHERE id_operacao = NEW.id_operacao;
	  END IF;

	  IF NEW.tipo_op = 'S' THEN
		INSERT INTO Saque(id_operacao) VALUES (NEW.id_operacao);
		UPDATE Conta SET saldo = saldo - NEW.valor WHERE id_conta = NEW.id_conta;
		UPDATE Saque SET status = 'Concluído' WHERE id_operacao = NEW.id_operacao;
	  END IF;

	  IF NEW.tipo_op = 'I' THEN
		UPDATE Conta SET saldo = saldo - NEW.valor WHERE id_conta = NEW.id_conta;
	  END IF;

	  IF NEW.tipo_op = 'E' THEN
		UPDATE Conta SET saldo = saldo + NEW.valor WHERE id_conta = NEW.id_conta;
	  END IF;

	  RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;


	CREATE TRIGGER atualiza_saldo
	AFTER INSERT ON Operacao
	FOR EACH ROW
	EXECUTE FUNCTION atualiza_saldo();


	CREATE OR REPLACE FUNCTION saldo_positivo()
	RETURNS TRIGGER AS $$
	BEGIN
	  IF NEW.saldo < 0 THEN
		RAISE EXCEPTION 'O saldo deve ser positivo.';
	  END IF;
	  RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;


	CREATE TRIGGER saldo_positivo
	BEFORE INSERT ON Conta
	FOR EACH ROW
	EXECUTE FUNCTION saldo_positivo();


	CREATE TRIGGER saldo_positivo_up
	BEFORE UPDATE ON Conta
	FOR EACH ROW
	EXECUTE FUNCTION saldo_positivo();


	CREATE OR REPLACE FUNCTION operacao_maior()
	RETURNS TRIGGER AS $$
	BEGIN
	  IF NEW.valor <= 0 THEN
		RAISE EXCEPTION 'O valor da operação deve ser maior que zero.';
	  END IF;
	  RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;


	CREATE TRIGGER operacao_maior
	BEFORE UPDATE ON Operacao
	FOR EACH ROW
	EXECUTE FUNCTION operacao_maior();


	CREATE TRIGGER operacao_maior_up
	BEFORE INSERT ON Operacao
	FOR EACH ROW
	EXECUTE FUNCTION operacao_maior();


	CREATE OR REPLACE FUNCTION fazer_transferencia()
	RETURNS TRIGGER AS $$
	BEGIN
	  IF (SELECT saldo FROM Operacao o INNER JOIN Conta c ON c.id_conta = o.id_conta AND o.id_operacao = NEW.id_operacao) > (SELECT valor FROM operacao WHERE id_operacao = NEW.id_operacao) THEN
		UPDATE conta SET saldo = saldo - (SELECT valor FROM operacao WHERE id_operacao = NEW.id_operacao)
		WHERE id_conta = (SELECT id_conta FROM operacao WHERE id_operacao = NEW.id_operacao);

		UPDATE Conta SET saldo = saldo + (SELECT valor FROM operacao WHERE id_operacao = NEW.id_operacao)
		WHERE id_conta = NEW.id_destino;

		UPDATE Operacao SET valor = valor WHERE NEW.id_operacao = id_operacao;
		NEW.status = 'Concluído';
	  END IF;

	  RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;


	CREATE TRIGGER fazer_transferencia
	BEFORE INSERT ON Transferencia
	FOR EACH ROW
	EXECUTE FUNCTION fazer_transferencia();

	
	-- Criar uma função que atualiza a coluna data_hora
	CREATE OR REPLACE FUNCTION update_data_hora()
	RETURNS TRIGGER AS $$
	BEGIN
	  NEW.data_hora = CURRENT_TIMESTAMP;
	  RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;


	

	INSERT INTO Pessoa (cnpj, cpf, nome, endereco, email, telefone, data_nasc, sexo)
	VALUES
		('12345678901205', NULL, 'João Silva', 'Rua A, 123', 'joao@example.com', '1234567890', '1990-01-01', 'M'),
		(NULL, '12345678901', 'Maria Souza', 'Avenida B, 456', 'maria@example.com', '9876543210', '1995-05-10', 'F'),
		('98765432109876', NULL, 'Pedro Santos', 'Rua C, 789', 'pedro@example.com', '4567890123', '1985-07-15', 'M'),
		(NULL, '98765432109', 'Ana Oliveira', 'Avenida D, 789', 'ana@example.com', '3210987654', '1998-09-20', 'F'),
		(NULL, '56789012345', 'José Pereira', 'Rua E, 456', 'jose@example.com', '0123456789', '1992-03-25', 'M'),
		(NULL, '56789012346', 'Monica Lima', 'Rua P, 305', 'monica@example.com', '0123456789', '1970-01-20', 'F'),
		 (NULL, '12345678911', 'Carolina Santos', 'Rua P, 123', 'carolina@example.com', '1234567890', '1993-11-05', 'F'),
		('98765432101245', NULL, 'Gustavo Oliveira', 'Avenida Q, 456', 'gustavo@example.com', '9876543210', '1988-08-20', 'M'),
		(NULL, '98765432112', 'Larissa Lima', 'Rua R, 789', 'larissa@example.com', '4567890123', '1991-03-15', 'F'),
		(NULL, '56789012356', 'Thiago Pereira', 'Rua S, 456', 'thiago@example.com', '0123456789', '1995-12-10', 'M'),
		('12345678901323', NULL, 'Isabela Silva', 'Avenida T, 789', 'isabela@example.com', '3210987654', '1999-09-25', 'F'),
		(NULL, '12345678914', 'Mateus Souza', 'Rua U, 123', 'mateus@example.com', '1234567890', '1986-06-07', 'M'),
		('98765432101456', NULL, 'Fernanda Santos', 'Avenida V, 456', 'fernanda@example.com', '9876543210', '1992-01-30', 'F'),
		(NULL, '98765432115', 'Rafael Lima', 'Rua W, 789', 'rafael@example.com', '4567890123', '1994-07-14', 'M'),
		(NULL, '56789012367', 'Bianca Pereira', 'Rua X, 456', 'bianca@example.com', '0123456789', '1998-04-18', 'F'),
		('12345678901589', NULL, 'Vinicius Silva', 'Avenida Y, 789', 'vinicius@example.com', '3210987654', '1987-03-22', 'M'),
		  (NULL, '12345678923', 'Aline Santos', 'Rua Z, 123', 'aline@example.com', '1234567890', '1996-09-12', 'F'),
		('98765432101678', NULL, 'Raul Oliveira', 'Avenida AA, 456', 'raul@example.com', '9876543210', '1990-12-28', 'M'),
		(NULL, '98765432134', 'Leticia Lima', 'Rua BB, 789', 'leticia@example.com', '4567890123', '1993-08-05', 'F'),
		(NULL, '56789012378', 'Roberto Pereira', 'Rua CC, 456', 'roberto@example.com', '0123456789', '1997-05-25', 'M'),
		('12345678901765', NULL, 'Mariana Silva', 'Avenida DD, 789', 'mariana@example.com', '3210987654', '1992-04-15', 'F'),
		(NULL, '12345678945', 'Renato Souza', 'Rua EE, 123', 'renato@example.com', '1234567890', '1988-11-20', 'M'),
		('98765432101987', NULL, 'Patricia Santos', 'Avenida FF, 456', 'patricia@example.com', '9876543210', '1994-10-10', 'F'),
		(NULL, '98765432156', 'Eduardo Lima', 'Rua GG, 789', 'eduardo@example.com', '4567890123', '1985-07-08', 'M'),
		(NULL, '56789012389', 'Carla Pereira', 'Rua HH, 456', 'carla@example.com', '0123456789', '1999-02-03', 'F'),
		('12345678902100', NULL, 'Fernando Silva', 'Avenida II, 789', 'fernando@example.com', '3210987654', '1989-01-14', 'M');

	 -- UPDATE trabalho_bd.Pessoa SET cnpj = '98765432109875' WHERE cpf = '12345678901' ;

	INSERT INTO Banco (nome_banco, telefone, cnpj)
	VALUES
		('Banco A', '1111111111', '12345678901234'),
		('Banco B', '2222222222', '98765432109876'),
		('Banco C', '3333333333', '34567890123456'),
		('Banco D', '4444444444', '76543210987654'),
		('Banco E', '5555555555', '56789012345678');

	INSERT INTO Agencia (nome_agencia, endereco, telefone, id_banco)
	VALUES
		('Agência A1', 'Rua X, 123', '1111111111', 1),
		('Agência A2', 'Rua Y, 456', '2222222222', 1),
		('Agência B1', 'Avenida Z, 789', '3333333333', 2),
		('Agência B2', 'Avenida W, 987', '4444444444', 2),
		('Agência C1', 'Rua K, 321', '5555555555', 3);

	INSERT INTO Cliente (id_pessoa, id_agencia, senha)
	VALUES
		(1, 1, '12345'),
		(2, 1, '12345'),
		(3, 2, '12345'),
		(4, 3, '12345'),
		(5, 3, '12345'),
		(6, 1, '12345'),
		(7, 2, '12345'),
		(8, 3, '12345'),
		(9, 1, '12345'),
		(10, 2, '12345'),
		(11, 1, '12345'),
		(12, 2, '12345'),
		(13, 3, '12345'),
		(14, 1, '12345'),
		(15, 2, '12345'),
		(16, 3, '12345'),
		(17, 1, '12345'),
		(18, 2, '12345'),
		(19, 3, '12345'),
		(20, 1, '12345'),
		(21, 2, '12345'),
		(22, 1, '12345'),
		(23, 2, '12345'),
		(24, 3, '12345'),
		(25, 1, '12345'),
		(26, 2, '12345');

	INSERT INTO Conta (numero, status, saldo, limite, id_cliente)
	VALUES
		('12345677', 'Ativa', 1000.00, 500.00, 1),
		('23456700', 'Ativa', 1500.00, 1000.00, 2),
		('34567897', 'Ativa', 2000.00, 1500.00, 3),
		('45678903', 'Ativa', 500.00, 200.00, 4),
		('56789014', 'Ativa', 800.00, 300.00, 5),
		('67890127', 'Ativa', 1200.00, 600.00, 6),
		('78901238', 'Ativa', 2500.00, 2000.00, 7),
		('89012340', 'Ativa', 600.00, 300.00, 8),
		('90123451', 'Ativa', 1800.00, 1500.00, 9),
		('01234562', 'Ativa', 3000.00, 1000.00, 10),
		('12345673', 'Ativa', 900.00, 400.00, 11),
		('23456740', 'Ativa', 1700.00, 1200.00, 12),
		('34567467', 'Ativa', 2200.00, 1800.00, 13),
		('45678801', 'Ativa', 400.00, 150.00, 14),
		('56789512', 'Ativa', 700.00, 250.00, 15),
		('67890323', 'Ativa', 1100.00, 500.00, 16),
		('78901034', 'Ativa', 2400.00, 2000.00, 17),
		('89012375', 'Ativa', 550.00, 250.00, 18),
		('90123256', 'Ativa', 1700.00, 1300.00, 19),
		('01234267', 'Ativa', 2800.00, 900.00, 20),
		('12345178', 'Ativa', 800.00, 350.00, 21),
		('23456189', 'Ativa', 1600.00, 1100.00, 22),
		('34567292', 'Ativa', 2100.00, 1700.00, 23),
		('45678090', 'Ativa', 350.00, 120.00, 24),
		('56789519', 'Ativa', 650.00, 200.00, 25),
		('67890128', 'Ativa', 1000.00, 450.00, 26);

	INSERT INTO Funcionario (id_pessoa, cargo, salario, data_admissao, id_gerente, id_agencia)
	VALUES
		(1, 'Gerente', 5000.00, '2010-01-01', 1, 1),
		(2, 'Atendente', 2000.00, '2015-05-01', 1, 1),
		(3, 'Gerente', 5500.00, '2008-03-01', 1, 2),
		(4, 'Atendente', 1800.00, '2013-07-01', 3, 2),
		(5, 'Gerente', 5200.00, '2009-02-01', 1, 3);

	INSERT INTO Conta (numero, status,saldo, limite, id_cliente)
	VALUES
		('12345679', 'Ativa', 1000.00, 500.00, 1),
		('23456789', 'Ativa',1500.00, 1000.00, 2),
		('34567890', 'Ativa',2000.00, 1500.00, 3),
		('45678901', 'Ativa',500.00, 200.00, 4),
		('56789012', 'Ativa',800.00, 300.00, 5);

	INSERT INTO Agencia (nome_agencia, endereco, telefone, id_banco)
	VALUES
		('Agência 1', 'Endereço 1', '1111111111', 1),
		('Agência 2', 'Endereço 2', '2222222222', 2),
		('Agência 3', 'Endereço 3', '3333333333', 3),
		('Agência 4', 'Endereço 4', '4444444444', 4),
		('Agência 5', 'Endereço 5', '5555555555', 5);

	INSERT INTO Cartao (numero, validade, cvv, bandeira, limite, id_conta)
	VALUES
		('1111111111111115', '12/25', '123', 'Visa', 2000.00, 1),
		('2222222222222222', '12/26', '456', 'Mastercard', 3000.00, 2),
		('3333333333333333', '09/24', '789', 'American Express', 4000.00, 3),
		('4444444444444444', '03/27', '012', 'Elo', 5000.00, 4),
		('5555555555555555', '11/23', '345', 'Diners Club', 2500.00, 5);

	-- Inserts para a tabela Fatura
	INSERT INTO Fatura (vencimento, pagamento, status, id_cartao)
	VALUES
		('2023-06-15', '2023-06-20', 'Paga', 1),
		('2023-06-10', '2023-06-25', 'Aguardando pagamento', 2),
		('2023-06-05', '2023-06-15', 'Paga', 3),
		('2023-06-12', '2023-06-18', 'Vencida', 4),
		('2023-06-08', '2023-06-22', 'Aguardando pagamento', 5);

	-- Inserts para a tabela Compra
	INSERT INTO Compra (valor, divisao, estabelecimento)
	VALUES
		(50.00, 1,  'Loja A'),
		(100.00, 1, 'Loja B'),
		(75.50, 1, 'Loja C'),
		(200.00, 3, 'Loja D'),
		(120.00, 1,'Loja E');

	-- Inserts para a tabela FaturaCompra
	INSERT INTO FaturaCompra (id_fatura, id_compra, valor_parcela)
	VALUES
		(1, 1, 50.00),
		(1, 2, 50.00),
		(2, 3, 100.00),
		(3, 4, 75.00),
		(4, 5, 40.00);

	-- Inserts para a tabela Operacao
	INSERT INTO Operacao (valor, id_conta,tipo_op)
	VALUES
		(501.00, 1, 'S'), 
		(1000.00, 2, 'D'),
		(250.00, 3, 'S'),
		(800.00, 4, 'D'),
		(1500.00, 5, 'D');
	-- UPDATE trabalho_bd.Conta SET saldo = saldo + saldo WHERE id_conta = '2' ;


	-- Inserts para a tabela Investimento
	INSERT INTO Investimento (id_operacao, tipo, taxa_rendimento, prazo)
	VALUES
		(1, 'Poupança', 2.5, 12),
		(2, 'Tesouro Direto', 4.2, 24),
		(3, 'Ações', 6.8, 36),
		(4, 'CDB', 3.9, 18),
		(5, 'Fundos Imobiliários', 5.5, 24);

	-- Inserts para a tabela Empréstimo
	INSERT INTO Emprestimo (id_operacao, taxa_juros, parcelas)
	VALUES
		(1, 8.5, 6),
		(2, 10.2, 12),
		(3, 12.8, 24),
		(4, 9.9, 18),
		(5, 11.5, 24);

	-- Inserts para a tabela Transferência
	 INSERT INTO Transferencia (id_operacao, id_destino, status)
	 VALUES
		 (1, 2, 'Concluído'),
		 (2, 1, 'Em processamento'),
		 (3, 3, 'Concluído'),
		 (4, 1, 'Concluído'),
		 (5, 2, 'Negado');


	CREATE OR REPLACE FUNCTION criar_pessoas_aleatorias(n INT)
    RETURNS INT AS $$
    DECLARE
        i INT := 1;
        pessoa_id INT;
        ultima_pessoa Pessoa%ROWTYPE;
        conta_id INT;
    BEGIN
        WHILE i <= n LOOP
            -- Inserir pessoa na tabela Pessoa
            INSERT INTO Pessoa (cnpj, cpf, nome, endereco, email, telefone, data_nasc, sexo)
            VALUES (FLOOR(RANDOM() * (99999999999999 - 10000000000000 + 1) + 10000000000000)::BIGINT, NULL, CONCAT('Pessoa', i), CONCAT('Endereço', i), CONCAT('pessoa', i, '@example.com'), CONCAT('99999999', LPAD(i::TEXT, 2, '0')), CURRENT_DATE - (FLOOR(RANDOM() * 365 * 60) || ' days')::INTERVAL, CASE WHEN FLOOR(RANDOM() * 2) = 0 THEN 'M' ELSE 'F' END)
            RETURNING * INTO ultima_pessoa;

            pessoa_id := ultima_pessoa.id_pessoa;

            -- Criar um cliente para a pessoa
            INSERT INTO Cliente (id_pessoa, id_agencia, senha)
            VALUES (pessoa_id, 1, '12345')
            RETURNING id_cliente INTO conta_id;

            -- Criar uma conta para o cliente
            INSERT INTO Conta (numero, status, saldo, limite, id_cliente)
            VALUES (CONCAT(LPAD(conta_id::TEXT, 8, '0'), LPAD(i::TEXT, 2, '0')), 'Ativa', 0.00, 0.00, conta_id);

            i := i + 1;
        END LOOP;

        RETURN i - 1;
    END;
    $$ LANGUAGE plpgsql;

	SELECT criar_pessoas_aleatorias(100000);
	
	SELECT * FROM Pessoa;
	SELECT COUNT(*) FROM Pessoa;

	-- Índices na tabela Pessoa
	--CREATE INDEX idx_pessoa_cpf ON Pessoa (cpf);
	--CREATE INDEX idx_pessoa_cnpj ON Pessoa (cnpj);

	-- Índices na tabela Cliente
	--CREATE INDEX idx_cliente_id_pessoa ON Cliente (id_pessoa);

	-- Índice na tabela Conta
	--CREATE INDEX idx_conta_id_cliente ON Conta (id_cliente);

	EXPLAIN SELECT p.nome,p.cpf, p.cnpj,ct.saldo,ct.id_conta 
	FROM Cliente c INNER JOIN Conta ct on c.id_cliente = ct.id_cliente 
	INNER JOIN Pessoa p on c.id_pessoa = p.id_pessoa 
		and (p.cpf = '13323093792836' OR p.cnpj = '13323093792836') 
	WHERE c.senha = '12345';

