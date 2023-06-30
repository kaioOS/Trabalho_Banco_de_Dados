/* 
	Kaio de Oliveira e Sousa (202165080AC)
	Artur Welerson Sott Meyer (202065552C)
*/

-- DROP SCHEMA trabalho_bd;
-- CREATE SCHEMA trabalho_bd;

    
-- DDL
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
       (cnpj IS NOT NULL AND cpf IS NULL AND validate_cnpj(cnpj))), -- Faz com que apenas o CPF ou CNPJ seja preenchido mas obrigando que um dos dois esteja
	   CONSTRAINT CHK_Data CHECK (data_nasc = STR_TO_DATE(data_nasc, '%d/%m/%Y')), -- Faz com que a data seja feita no padrão DD/MM/AAAA
	   CONSTRAINT FK_Sexo FOREIGN KEY (sexo) REFERENCES SexoPermitido (valor)
	  );
	  
	-- Criação da tabela Banco
	CREATE TABLE trabalho_bd.Banco (
	  id_banco INTEGER AUTO_INCREMENT PRIMARY KEY,
	  nome VARCHAR(100),
	  telefone VARCHAR(20),
	  cnpj VARCHAR(14)
	);

	-- Criação da tabela Agencia
	CREATE TABLE trabalho_bd.Agencia (
	  id_agencia INTEGER AUTO_INCREMENT PRIMARY KEY,
	  nome VARCHAR(100),
	  endereco VARCHAR(200),
	  telefone VARCHAR(20),
	  id_banco INTEGER,
	  FOREIGN KEY (id_banco) REFERENCES trabalho_bd.Banco(id_banco)
	);

	-- Criação da tabela Cliente
	CREATE TABLE trabalho_bd.Cliente (
	  id_cliente INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_pessoa INTEGER,
	  id_agencia INTEGER,
	  FOREIGN KEY (id_pessoa) REFERENCES trabalho_bd.Pessoa(id_pessoa),
	  FOREIGN KEY (id_agencia) REFERENCES trabalho_bd.Agencia(id_agencia)
	);

	-- Criação da tabela Funcinario
	CREATE TABLE trabalho_bd.Funcionario (
	  id_funcionario INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_pessoa INTEGER,
	  cargo VARCHAR(100),
	  salario DECIMAL(10,2),
	  data_admissao DATE,
	  id_gerente INTEGER,
	  id_agencia INTEGER,
	  FOREIGN KEY (id_pessoa) REFERENCES trabalho_bd.Pessoa(id_pessoa),
	  FOREIGN KEY (id_gerente) REFERENCES trabalho_bd.Funcionario(id_funcionario),
	  FOREIGN KEY (id_agencia) REFERENCES trabalho_bd.Agencia(id_agencia),
	  
	  CONSTRAINT CHK_Data CHECK (data_admissao = STR_TO_DATE(data_admissao, '%d/%m/%Y')) -- Faz com que a data seja feita no padrão DD/MM/AAAA
	);

	-- Criação da tabela Conta
	CREATE TABLE trabalho_bd.Conta (
	  id_conta INTEGER AUTO_INCREMENT PRIMARY KEY,
	  status VARCHAR(20),
	  saldo DECIMAL(10,2),
	  limite DECIMAL(10,2),
	  id_cliente INTEGER,
	  FOREIGN KEY (id_cliente) REFERENCES trabalho_bd.Cliente(id_cliente)
	);

	-- Criação da tabela Cartão
	CREATE TABLE trabalho_bd.Cartao (
	  id_cartao INTEGER AUTO_INCREMENT PRIMARY KEY,
	  numero VARCHAR(16),
	  validade DATE,
	  cvv VARCHAR(3),
	  bandeira VARCHAR(50),
	  limite DECIMAL(10,2),
	  id_conta INTEGER,
	  FOREIGN KEY (id_conta) REFERENCES trabalho_bd.Conta(id_conta),

	  CONSTRAINT CHK_Validade CHECK (validade REGEXP '^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/[0-9]{2}$') -- Faz com que a data siga o padrão DD/MM/AAAA
	);
	-- Criação da tabela Fatura
	CREATE TABLE trabalho_bd.Fatura (
	  id_fatura INTEGER AUTO_INCREMENT PRIMARY KEY,
	  vencimento DATE,
	  pagamento DATE,
	  status VARCHAR(20),
	  id_cartao INTEGER,
	  FOREIGN KEY (id_cartao) REFERENCES trabalho_bd.Cartao(id_cartao),
	  
	  CONSTRAINT CHK_Vencimento CHECK (vencimento = STR_TO_DATE(vencimento, '%d/%m/%Y')),
	  CONSTRAINT CHK_Pagamento CHECK (pagamento = STR_TO_DATE(pagamento, '%d/%m/%Y'))
	);

	-- Criação da tabela Compra
	CREATE TABLE trabalho_bd.Compra (
	  id_compra INTEGER AUTO_INCREMENT PRIMARY KEY,
	  valor DECIMAL(10,2),
	  divisao INTEGER,
	  data_hora DATETIME,
	  estabelecimento VARCHAR(100)
	);

	-- Criação da tabela FaturaCompra
	CREATE TABLE trabalho_bd.FaturaCompra (
	  id_fatura INTEGER,
	  id_compra INTEGER,
	  valor_parcela DECIMAL(10,2),
	  FOREIGN KEY (id_fatura) REFERENCES trabalho_bd.Fatura(id_fatura),
	  FOREIGN KEY (id_compra) REFERENCES trabalho_bd.Compra(id_compra)
	);

	-- Criação da tabela Operação
	CREATE TABLE trabalho_bd.Operacao (
	  id_operacao INTEGER AUTO_INCREMENT PRIMARY KEY,
	  valor DECIMAL(10,2),
	  data_hora DATETIME,
	  id_conta INTEGER,
	  FOREIGN KEY (id_conta) REFERENCES trabalho_bd.Conta(id_conta)
	);

	-- Criação da tabela Depósito
	CREATE TABLE trabalho_bd.Deposito (
	  id_deposito INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_operacao INTEGER,
	  status VARCHAR(20),
	  FOREIGN KEY (id_operacao) REFERENCES trabalho_bd.Operacao(id_operacao)
	);

	-- Criação da tabela Saque
	CREATE TABLE trabalho_bd.Saque (
	  id_saque INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_operacao INTEGER,
	  status VARCHAR(20),
	  FOREIGN KEY (id_operacao) REFERENCES trabalho_bd.Operacao(id_operacao)
	);

	-- Criação da tabela Investimento
	CREATE TABLE trabalho_bd.Investimento (
	  id_investimento INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_operacao INTEGER,
	  tipo VARCHAR(50),
	  taxa_rendimento DECIMAL(5,2),
	  prazo INTEGER,
	  FOREIGN KEY (id_operacao) REFERENCES trabalho_bd.Operacao(id_operacao)
	);

	-- Criação da tabela Empréstimo
	CREATE TABLE trabalho_bd.Emprestimo (
	  id_emprestimo INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_operacao INTEGER,
	  taxa_juros DECIMAL(5,2),
	  parcelas INTEGER,
	  FOREIGN KEY (id_operacao) REFERENCES trabalho_bd.Operacao(id_operacao)
	);

	-- Criação da tabela Transferência
	CREATE TABLE trabalho_bd.Transferencia (
	  id_transferencia INTEGER AUTO_INCREMENT PRIMARY KEY,
	  id_operacao INTEGER,
	  id_destino INTEGER,
	  status VARCHAR(20),
	  FOREIGN KEY (id_operacao) REFERENCES trabalho_bd.Operacao(id_operacao),
	  FOREIGN KEY (id_destino) REFERENCES trabalho_bd.Conta(id_conta)
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


