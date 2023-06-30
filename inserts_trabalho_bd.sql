Insert INTO trabalho_bd.Pessoa(cnpj,nome, endereco, email, telefone, data_nasc, sexo)
values('12345678911000', 'jorger', 'rua teste', 'teste@gmail.com', '32-01234-5678', '2000-02-15', 'M');
SELECT * FROM trabalho_bd.Pessoa;

INSERT INTO trabalho_bd.Banco(nome,telefone,cnpj)
VALUES ('Br',12345678910,'1234567891021');
SELECT * FROM trabalho_bd.Banco;


INSERT INTO trabalho_bd.Pessoa (cnpj, cpf, nome, endereco, email, telefone, data_nasc, sexo)
VALUES
('12345678901234', NULL, 'João Silva', 'Rua A, 123', 'joao@example.com', '1234567890', '1990-01-01', 'M'),
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

INSERT INTO trabalho_bd.Banco (nome, telefone, cnpj)
VALUES
('Banco A', '1111111111', '12345678901234'),
('Banco B', '2222222222', '23456789012345'),
('Banco C', '3333333333', '34567890123456'),
('Banco D', '4444444444', '45678901234567'),
('Banco E', '5555555555', '56789012345678');

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

INSERT INTO trabalho_bd.Funcionario (id_pessoa, cargo, salario, data_admissao, id_gerente, id_agencia)
VALUES
(6, 'Gerente Geral', 5000.00, '2023-01-01', NULL, 1),
(7, 'Gerente de Contas', 3500.00, '2023-01-01', 6, 1),
(8, 'Caixa', 2500.00, '2023-01-01', 6, 1),
(9, 'Gerente Geral', 5000.00, '2023-01-01', NULL, 2),
(10, 'Gerente de Contas', 3500.00, '2023-01-01', 9, 2);

INSERT INTO trabalho_bd.Conta (numero, saldo, limite, id_cliente)
VALUES
('67890123', 1200.00, 800.00, 1),
('78901234', 1800.00, 1500.00, 2),
('89012345', 2200.00, 2000.00, 3),
('90123456', 700.00, 300.00, 4),
('01234567', 1000.00, 500.00, 5);

INSERT INTO trabalho_bd.Cartao (numero, validade, cvv, bandeira, limite, id_conta)
VALUES
('1111111111111111', '06/25', '123', 'Visa', 2000.00, 1),
('2222222222222222', '12/26', '456', 'Mastercard', 3000.00, 2),
('3333333333333333', '09/24', '789', 'American Express', 4000.00, 3),
('4444444444444444', '03/27', '012', 'Elo', 5000.00, 4),
('5555555555555555', '11/23', '345', 'Diners Club', 2500.00, 5);