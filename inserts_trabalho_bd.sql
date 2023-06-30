

INSERT INTO trabalho_bd.Pessoa (cnpj, cpf, nome, endereco, email, telefone, data_nasc, sexo)
VALUES
	('12345678901235', NULL, 'João Silva', 'Rua A, 123', 'joao@example.com', '1234567890', '1990-01-01', 'M'),
	(NULL, '12345678901', 'Maria Souza', 'Avenida B, 456', 'maria@example.com', '9876543210', '1995-05-10', 'F'),
	('98765432109876', NULL, 'Pedro Santos', 'Rua C, 789', 'pedro@example.com', '4567890123', '1985-07-15', 'M'),
	(NULL, '98765432109', 'Ana Oliveira', 'Avenida D, 789', 'ana@example.com', '3210987654', '1998-09-20', 'F'),
	(NULL, '56789012345', 'José Pereira', 'Rua E, 456', 'jose@example.com', '0123456789', '1992-03-25', 'M');

INSERT INTO trabalho_bd.Banco (nome, telefone, cnpj)
VALUES
	('Banco A', '1111111111', '12345678901234'),
	('Banco B', '2222222222', '98765432109876'),
	('Banco C', '3333333333', '34567890123456'),
	('Banco D', '4444444444', '76543210987654'),
	('Banco E', '5555555555', '56789012345678');

INSERT INTO trabalho_bd.Agencia (nome, endereco, telefone, id_banco)
VALUES
	('Agência A1', 'Rua X, 123', '1111111111', 1),
	('Agência A2', 'Rua Y, 456', '2222222222', 1),
	('Agência B1', 'Avenida Z, 789', '3333333333', 2),
	('Agência B2', 'Avenida W, 987', '4444444444', 2),
	('Agência C1', 'Rua K, 321', '5555555555', 3);

INSERT INTO trabalho_bd.Cliente (id_pessoa, id_agencia)
VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 3),
	(5, 3);

INSERT INTO trabalho_bd.Funcionario (id_pessoa, cargo, salario, data_admissao, id_gerente, id_agencia)
VALUES
	(1, 'Gerente', 5000.00, '2010-01-01', 1, 1),
	(2, 'Atendente', 2000.00, '2015-05-01', 1, 1),
	(3, 'Gerente', 5500.00, '2008-03-01', 1, 2),
	(4, 'Atendente', 1800.00, '2013-07-01', 3, 2),
	(5, 'Gerente', 5200.00, '2009-02-01', 1, 3);

INSERT INTO trabalho_bd.Conta (numero, status,saldo, limite, id_cliente)
VALUES
	('12345678', 'ativa',1000.00, 500.00, 1),
	('23456789', 'ativa',1500.00, 1000.00, 2),
	('34567890', 'ativa',2000.00, 1500.00, 3),
	('45678901', 'ativa',500.00, 200.00, 4),
	('56789012', 'ativa',800.00, 300.00, 5);

INSERT INTO trabalho_bd.Agencia (nome, endereco, telefone, id_banco)
VALUES
	('Agência 1', 'Endereço 1', '1111111111', 1),
	('Agência 2', 'Endereço 2', '2222222222', 2),
	('Agência 3', 'Endereço 3', '3333333333', 3),
	('Agência 4', 'Endereço 4', '4444444444', 4),
	('Agência 5', 'Endereço 5', '5555555555', 5);

INSERT INTO trabalho_bd.Cliente (id_pessoa, id_agencia)
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5);



INSERT INTO trabalho_bd.Cartao (numero, validade, cvv, bandeira, limite, id_conta)
VALUES
	('1111111111111115', '12/25', '123', 'Visa', 2000.00, 1),
	('2222222222222222', '12/26', '456', 'Mastercard', 3000.00, 2),
	('3333333333333333', '09/24', '789', 'American Express', 4000.00, 3),
	('4444444444444444', '03/27', '012', 'Elo', 5000.00, 4),
	('5555555555555555', '11/23', '345', 'Diners Club', 2500.00, 5);

-- Inserts para a tabela Fatura
INSERT INTO trabalho_bd.Fatura (vencimento, pagamento, status, id_cartao)
VALUES
    ('2023-06-15', '2023-06-20', 'Paga', 1),
    ('2023-06-10', '2023-06-25', 'Aguardando pagamento', 2),
    ('2023-06-05', '2023-06-15', 'Paga', 3),
    ('2023-06-12', '2023-06-18', 'Vencida', 4),
    ('2023-06-08', '2023-06-22', 'Aguardando pagamento', 5);

-- Inserts para a tabela Compra
INSERT INTO trabalho_bd.Compra (valor, divisao, estabelecimento)
VALUES
    (50.00, 1,  'Loja A'),
    (100.00, 1, 'Loja B'),
    (75.50, 1, 'Loja C'),
    (200.00, 3, 'Loja D'),
    (120.00, 1,'Loja E');

-- Inserts para a tabela FaturaCompra
INSERT INTO trabalho_bd.FaturaCompra (id_fatura, id_compra, valor_parcela)
VALUES
    (1, 1, 50.00),
    (1, 2, 50.00),
    (2, 3, 100.00),
    (3, 4, 75.00),
    (4, 5, 40.00);

-- Inserts para a tabela Operacao
INSERT INTO trabalho_bd.Operacao (valor, id_conta)
VALUES
    (500.00, 1),
    (1000.00,  2),
    (250.00,  3),
    (800.00,  4),
    (1500.00,  5);

-- Inserts para a tabela Deposito
INSERT INTO trabalho_bd.Deposito (id_operacao, status)
VALUES
    (1, 'Concluído'),
    (2, 'Em processamento'),
    (3, 'Concluído'),
    (4, 'Concluído'),
    (5, 'Negado');

-- Inserts para a tabela Saque
INSERT INTO trabalho_bd.Saque (id_operacao, status)
VALUES
    (1, 'Concluído'),
    (2, 'Concluído'),
    (3, 'Negado'),
    (4, 'Concluído'),
    (5, 'Em processamento');

-- Inserts para a tabela Investimento
INSERT INTO trabalho_bd.Investimento (id_operacao, tipo, taxa_rendimento, prazo)
VALUES
    (1, 'Poupança', 2.5, 12),
    (2, 'Tesouro Direto', 4.2, 24),
    (3, 'Ações', 6.8, 36),
    (4, 'CDB', 3.9, 18),
    (5, 'Fundos Imobiliários', 5.5, 24);

-- Inserts para a tabela Empréstimo
INSERT INTO trabalho_bd.Emprestimo (id_operacao, taxa_juros, parcelas)
VALUES
    (1, 8.5, 6),
    (2, 10.2, 12),
    (3, 12.8, 24),
    (4, 9.9, 18),
    (5, 11.5, 24);

-- Inserts para a tabela Transferência
INSERT INTO trabalho_bd.Transferencia (id_operacao, id_destino, status)
VALUES
    (1, 2, 'Concluído'),
    (2, 3, 'Em processamento'),
    (3, 4, 'Concluído'),
    (4, 5, 'Concluído'),
    (5, 1, 'Negado');

