

INSERT INTO trabalho_bd.Pessoa (cnpj, cpf, nome, endereco, email, telefone, data_nasc, sexo)
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

INSERT INTO trabalho_bd.Banco (nome_banco, telefone, cnpj)
VALUES
	('Banco A', '1111111111', '12345678901234'),
	('Banco B', '2222222222', '98765432109876'),
	('Banco C', '3333333333', '34567890123456'),
	('Banco D', '4444444444', '76543210987654'),
	('Banco E', '5555555555', '56789012345678');

INSERT INTO trabalho_bd.Agencia (nome_agencia, endereco, telefone, id_banco)
VALUES
	('Agência A1', 'Rua X, 123', '1111111111', 1),
	('Agência A2', 'Rua Y, 456', '2222222222', 1),
	('Agência B1', 'Avenida Z, 789', '3333333333', 2),
	('Agência B2', 'Avenida W, 987', '4444444444', 2),
	('Agência C1', 'Rua K, 321', '5555555555', 3);
    
INSERT INTO trabalho_bd.Cliente (id_pessoa, id_agencia, senha)
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

INSERT INTO trabalho_bd.Conta (numero, status, saldo, limite, id_cliente)
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

INSERT INTO trabalho_bd.Funcionario (id_pessoa, cargo, salario, data_admissao, id_gerente, id_agencia)
VALUES
	(1, 'Gerente', 5000.00, '2010-01-01', 1, 1),
	(2, 'Atendente', 2000.00, '2015-05-01', 1, 1),
	(3, 'Gerente', 5500.00, '2008-03-01', 1, 2),
	(4, 'Atendente', 1800.00, '2013-07-01', 3, 2),
	(5, 'Gerente', 5200.00, '2009-02-01', 1, 3);

INSERT INTO trabalho_bd.Conta (numero, status,saldo, limite, id_cliente)
VALUES
	('12345679', 'Ativa', 1000.00, 500.00, 1),
	('23456789', 'Ativa',1500.00, 1000.00, 2),
	('34567890', 'Ativa',2000.00, 1500.00, 3),
	('45678901', 'Ativa',500.00, 200.00, 4),
	('56789012', 'Ativa',800.00, 300.00, 5);

INSERT INTO trabalho_bd.Agencia (nome_agencia, endereco, telefone, id_banco)
VALUES
	('Agência 1', 'Endereço 1', '1111111111', 1),
	('Agência 2', 'Endereço 2', '2222222222', 2),
	('Agência 3', 'Endereço 3', '3333333333', 3),
	('Agência 4', 'Endereço 4', '4444444444', 4),
	('Agência 5', 'Endereço 5', '5555555555', 5);

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
INSERT INTO trabalho_bd.Operacao (valor, id_conta,tipo_op)
VALUES
	(501.00, 1, 'S'), 
	(1000.00, 2, 'D'),
    (250.00, 3, 'S'),
    (800.00, 4, 'D'),
    (1500.00, 5, 'D');
-- UPDATE trabalho_bd.Conta SET saldo = saldo + saldo WHERE id_conta = '2' ;


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
     (2, 1, 'Em processamento'),
     (3, 3, 'Concluído'),
     (4, 1, 'Concluído'),
     (5, 2, 'Negado');


DELIMITER //

CREATE FUNCTION criar_pessoas_aleatorias(n INT)
RETURNS INT
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= n DO
        -- Inserir pessoa na tabela Pessoa
        INSERT INTO Pessoa (cnpj, cpf, nome, endereco, email, telefone, data_nasc, sexo)
        VALUES (FLOOR(RAND() * (99999999999999 - 10000000000000 + 1) + 10000000000000), NULL, CONCAT('Pessoa', i), CONCAT('Endereço', i), CONCAT('pessoa', i, '@example.com'), CONCAT('99999999', LPAD(i, 2, '0')), DATE_SUB(CURRENT_DATE(), INTERVAL FLOOR(RAND() * 365 * 60) DAY), CASE WHEN FLOOR(RAND() * 2) = 0 THEN 'M' ELSE 'F' END);
        
        SET i = i + 1;
    END WHILE;
    
    RETURN i - 1;
END //

DELIMITER ;

SELECT criar_pessoas_aleatorias(500);
