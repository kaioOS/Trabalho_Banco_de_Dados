/* 
	Kaio de Oliveira e Sousa (202165080AC)
	Artur Welerson Sott Meyer (202065552C)
*/

-- DROP SCHEMA trabalho_bd;
-- CREATE SCHEMA trabalho_bd;

    
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
    
    -- Criação da tabela Pessoa
	CREATE TABLE trabalho_bd.Pessoa (
	   id_pessoa INTEGER AUTO_INCREMENT PRIMARY KEY, -- Faz com que o id seja criado automaticamente e sempre incrementado de 1 em 1
	   cnpj VARCHAR(14) UNIQUE,
	   cpf VARCHAR(11) UNIQUE,
	   nome VARCHAR(100) NOT NULL,
	   endereco VARCHAR(100) NOT NULL,
	   email VARCHAR(100) NOT NULL,
	   telefone VARCHAR(20) NOT NULL,
	   data_nasc DATE NOT NULL,
	   sexo CHAR(1) NOT NULL,
	   
	   CONSTRAINT validate_cpf_cnpj CHECK (
		   (cpf IS NOT NULL AND cnpj IS NULL AND validate_cpf(cpf)) OR
		   (cnpj IS NOT NULL AND cpf IS NULL AND validate_cnpj(cnpj))
		), -- Verifica o padrão do CPF ou CNPJ preenchido
	   CONSTRAINT CHK_Data CHECK (data_nasc = STR_TO_DATE(data_nasc, '%d/%m/%Y')), -- Faz com que a data seja feita no padrão DD/MM/AAAA
	   CONSTRAINT FK_Sexo FOREIGN KEY (sexo) REFERENCES trabalho_bd.SexoPermitido (valor)
	  );
	  
	-- Criação da tabela Banco
	CREATE TABLE trabalho_bd.Banco (
	  id_banco INTEGER AUTO_INCREMENT PRIMARY KEY,
	  nome VARCHAR(100)  NOT NULL,
	  telefone VARCHAR(20)  NOT NULL,
	  cnpj VARCHAR(14) UNIQUE NOT NULL
	);

	-- Criação da tabela Agencia
	CREATE TABLE trabalho_bd.Agencia (
	  id_agencia INTEGER AUTO_INCREMENT PRIMARY KEY,
	  nome VARCHAR(100) NOT NULL,
	  endereco VARCHAR(200) NOT NULL,
	  telefone VARCHAR(20) NOT NULL,
	  id_banco INTEGER NOT NULL,
	  FOREIGN KEY (id_banco) REFERENCES trabalho_bd.Banco(id_banco)
	);

	-- Criação da tabela Cliente
	CREATE TABLE trabalho_bd.Cliente (
	  id_cliente INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_pessoa INTEGER NOT NULL,
	  id_agencia INTEGER NOT NULL,
	  FOREIGN KEY (id_pessoa) REFERENCES trabalho_bd.Pessoa(id_pessoa),
	  FOREIGN KEY (id_agencia) REFERENCES trabalho_bd.Agencia(id_agencia)
	);

	-- Criação da tabela Funcinario
	CREATE TABLE trabalho_bd.Funcionario (
	  id_funcionario INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_pessoa INTEGER NOT NULL,
	  cargo VARCHAR(100) NOT NULL,
	  salario DECIMAL(10,2) NOT NULL,
	  data_admissao DATE NOT NULL,
	  id_gerente INTEGER,
	  id_agencia INTEGER NOT NULL,
	  FOREIGN KEY (id_pessoa) REFERENCES trabalho_bd.Pessoa(id_pessoa),
	  FOREIGN KEY (id_gerente) REFERENCES trabalho_bd.Funcionario(id_funcionario),
	  FOREIGN KEY (id_agencia) REFERENCES trabalho_bd.Agencia(id_agencia),
	  
	  CONSTRAINT CHK_Data CHECK (data_admissao = STR_TO_DATE(data_admissao, '%d/%m/%Y')) -- Faz com que a data seja feita no padrão DD/MM/AAAA
	);

	-- Criação da tabela Conta
	CREATE TABLE trabalho_bd.Conta (
	  id_conta INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
      numero VARCHAR(20) UNIQUE NOT NULL,
	  status VARCHAR(20) DEFAULT 'Ativo',
	  saldo DECIMAL(10,2) DEFAULT 0,
	  limite DECIMAL(10,2) NOT NULL,
	  id_cliente INTEGER NOT NULL,
	  FOREIGN KEY (id_cliente) REFERENCES trabalho_bd.Cliente(id_cliente)
	);

	-- Criação da tabela Cartão
	CREATE TABLE trabalho_bd.Cartao (
	  id_cartao INTEGER AUTO_INCREMENT PRIMARY KEY,
	  numero VARCHAR(16) UNIQUE NOT NULL,
	  validade VARCHAR(5) NOT NULL,
	  cvv VARCHAR(3) NOT NULL,
	  bandeira VARCHAR(50) NOT NULL,
	  limite DECIMAL(10,2) NOT NULL,
	  id_conta INTEGER NOT NULL,
	  FOREIGN KEY (id_conta) REFERENCES trabalho_bd.Conta(id_conta),

	  CONSTRAINT CHK_Validade CHECK (validade REGEXP '^(0[1-9]|1[0-2])/[0-9]{2}$') -- Faz com que a data siga o padrão DD/MM/AAAA
	);
    
	-- Criação da tabela Fatura
	CREATE TABLE trabalho_bd.Fatura (
	  id_fatura INTEGER AUTO_INCREMENT PRIMARY KEY,
	  vencimento DATE NOT NULL,
	  pagamento DATE,
	  status VARCHAR(20) DEFAULT 'Aguardando pagamento',
	  id_cartao INTEGER NOT NULL,
	  FOREIGN KEY (id_cartao) REFERENCES trabalho_bd.Cartao(id_cartao),
	  
	  CONSTRAINT CHK_Vencimento CHECK (vencimento = STR_TO_DATE(vencimento, '%d/%m/%Y')),
	  CONSTRAINT CHK_Pagamento CHECK (pagamento = STR_TO_DATE(pagamento, '%d/%m/%Y')),
      CONSTRAINT FKf_status FOREIGN KEY (status) REFERENCES trabalho_bd.StatusFatura(valor)
	);

	-- Criação da tabela Compra
	CREATE TABLE trabalho_bd.Compra (
	  id_compra INTEGER AUTO_INCREMENT PRIMARY KEY,
	  valor DECIMAL(10,2) NOT NULL,
	  divisao INTEGER NOT NULL,
	  data_hora DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	  estabelecimento VARCHAR(100) NOT NULL
	);

	-- Criação da tabela FaturaCompra
	CREATE TABLE trabalho_bd.FaturaCompra (
	  id_fatura INTEGER  NOT NULL,
	  id_compra INTEGER  NOT NULL,
	  valor_parcela DECIMAL(10,2)  NOT NULL,
      PRIMARY KEY (id_fatura,id_compra),
	  FOREIGN KEY (id_fatura) REFERENCES trabalho_bd.Fatura(id_fatura),
	  FOREIGN KEY (id_compra) REFERENCES trabalho_bd.Compra(id_compra)
	);

	-- Criação da tabela Operação
	CREATE TABLE trabalho_bd.Operacao (
	  id_operacao INTEGER AUTO_INCREMENT PRIMARY KEY,
	  valor DECIMAL(10,2)  NOT NULL,
	  data_hora DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	  id_conta INTEGER  NOT NULL,
	  FOREIGN KEY (id_conta) REFERENCES trabalho_bd.Conta(id_conta)
	);

	-- Criação da tabela Depósito
	CREATE TABLE trabalho_bd.Deposito (
	  id_deposito INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_operacao INTEGER  NOT NULL,
	  status VARCHAR(20) DEFAULT 'Em processamento',
	  FOREIGN KEY (id_operacao) REFERENCES trabalho_bd.Operacao(id_operacao),
      CONSTRAINT FKd_status FOREIGN KEY (status) REFERENCES trabalho_bd.StatusMovimentacao(valor)
	);

	-- Criação da tabela Saque
	CREATE TABLE trabalho_bd.Saque (
	  id_saque INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_operacao INTEGER NOT NULL,
	  status VARCHAR(20) DEFAULT 'Em processamento',
	  FOREIGN KEY (id_operacao) REFERENCES trabalho_bd.Operacao(id_operacao),
      CONSTRAINT FKs_status FOREIGN KEY (status) REFERENCES trabalho_bd.StatusMovimentacao(valor)
	);

	-- Criação da tabela Investimento
	CREATE TABLE trabalho_bd.Investimento (
	  id_investimento INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_operacao INTEGER NOT NULL,
	  tipo VARCHAR(50) NOT NULL,
	  taxa_rendimento DECIMAL(5,2) NOT NULL,
	  prazo INTEGER  NOT NULL,
	  FOREIGN KEY (id_operacao) REFERENCES trabalho_bd.Operacao(id_operacao)
	);

	-- Criação da tabela Empréstimo
	CREATE TABLE trabalho_bd.Emprestimo (
	  id_emprestimo INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_operacao INTEGER  NOT NULL,
	  taxa_juros DECIMAL(5,2)  NOT NULL,
	  parcelas INTEGER  NOT NULL,
	  FOREIGN KEY (id_operacao) REFERENCES trabalho_bd.Operacao(id_operacao)
	);

	-- Criação da tabela Transferência
	CREATE TABLE trabalho_bd.Transferencia (
	  id_transferencia INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_operacao INTEGER  NOT NULL,
	  id_destino INTEGER  NOT NULL,
	  status VARCHAR(20) DEFAULT 'Em processamento',
	  FOREIGN KEY (id_operacao) REFERENCES trabalho_bd.Operacao(id_operacao),
	  FOREIGN KEY (id_destino) REFERENCES trabalho_bd.Conta(id_conta),
      CONSTRAINT FKt_status FOREIGN KEY (status) REFERENCES trabalho_bd.StatusMovimentacao(valor)
	);



-- Funções e Triggers
	-- Criação da função de validação de CPF
	DELIMITER //
		CREATE FUNCTION validate_cpf(cpf VARCHAR(11))
		RETURNS BOOLEAN
		BEGIN
		  DECLARE is_valid BOOLEAN DEFAULT FALSE;

		  IF LENGTH(cpf) = 11 THEN
			SET cpf = REPLACE(REPLACE(REPLACE(cpf, '.', ''), '-', ''), '/', '');
			IF LENGTH(cpf) = 11 AND cpf REGEXP '^[0-9]+$' THEN
			  SET is_valid = TRUE;
			END IF;
		  END IF;

		  RETURN is_valid;
		END //
	DELIMITER ;

	-- Criação da função de validação de CNPJ
	DELIMITER //
		CREATE FUNCTION validate_cnpj(cnpj VARCHAR(14))
		RETURNS BOOLEAN
		BEGIN
		  DECLARE is_valid BOOLEAN DEFAULT FALSE;

		  IF LENGTH(cnpj) = 14 THEN
			SET cnpj = REPLACE(REPLACE(REPLACE(cnpj, '.', ''), '-', ''), '/', '');
			IF LENGTH(cnpj) = 14 AND cnpj REGEXP '^[0-9]+$' THEN
			  SET is_valid = TRUE;
			END IF;
		  END IF;

		  RETURN is_valid;
		END //
	DELIMITER ;

	-- Criação da trigger para acionar a validação
	DELIMITER //
		CREATE TRIGGER validate_pessoa_cpf_cnpj BEFORE INSERT ON trabalho_bd.Pessoa
		FOR EACH ROW
		BEGIN
		  DECLARE is_cpf_valid BOOLEAN;
		  DECLARE is_cnpj_valid BOOLEAN;

		  IF NEW.cpf IS NOT NULL THEN
			SET is_cpf_valid = validate_cpf(NEW.cpf);
			IF NOT is_cpf_valid THEN
			  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CPF inválido.';
			END IF;
		  END IF;

		  IF NEW.cnpj IS NOT NULL THEN
			SET is_cnpj_valid = validate_cnpj(NEW.cnpj);
			IF NOT is_cnpj_valid THEN
			  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CNPJ inválido.';
			END IF;
		  END IF;
		END //
	DELIMITER ;
    
    -- Valida o cnpj preeenchido no banco
    DELIMITER //
    
		CREATE TRIGGER validate_banco_cnpj BEFORE INSERT ON trabalho_bd.Banco
		FOR EACH ROW
		BEGIN
		  DECLARE is_cnpj_valid BOOLEAN;
		   IF NEW.cnpj IS NOT NULL THEN
			SET is_cnpj_valid = validate_cnpj(NEW.cnpj);
			IF NOT is_cnpj_valid THEN
			  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CNPJ inválido.';
			END IF;
		  END IF;
		END //
      
	DELIMITER ;
    
    -- Limitar apenas o preenchimento do cpf ou cnpj
	DELIMITER //

		CREATE TRIGGER check_cpf_cnpj BEFORE INSERT ON trabalho_bd.Pessoa
		FOR EACH ROW
		BEGIN
			IF (NEW.cpf IS NULL AND NEW.cnpj IS NULL) OR (NEW.cpf IS NOT NULL AND NEW.cnpj IS NOT NULL) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Preencha apenas o CPF ou o CNPJ.';
			END IF;
		END //

	DELIMITER ;
    
    DELIMITER //
		CREATE TRIGGER validar_validade
		BEFORE INSERT ON trabalho_bd.Cartao
		FOR EACH ROW
		BEGIN
			IF NEW.validade IS NOT NULL THEN
				IF NOT NEW.validade REGEXP '^(0[1-9]|1[0-2])\/[0-9]{2}$' THEN
					SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT = 'Formato de validade inválido. Utilize o formato MM/AA.';
				END IF;
			END IF;
		END //
	DELIMITER ;



