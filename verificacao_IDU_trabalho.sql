-- Deve funcionar
INSERT INTO trabalho_bd.Pessoa (cpf, nome, endereco, email, telefone, data_nasc, sexo)
VALUES ('12345678921', 'João da Silva', 'Rua A, 123', 'joao@example.com', '(00) 1234-5678', '1990-01-01', 'M');

-- Não deve funcionar
INSERT INTO trabalho_bd.Pessoa (cpf, nome, endereco, email, telefone, data_nasc, sexo)
VALUES ('1234567890A', 'Maria Santos', 'Rua B, 456', 'maria@example.com', '(00) 9876-5432', '1995-05-10', 'F');

-- Não deve funcionar
UPDATE trabalho_bd.Pessoa
SET cpf = '98765432199'
WHERE id_pessoa = 1;

-- Não deve funcionar
UPDATE trabalho_bd.Pessoa
SET cpf = '987654321A'
WHERE id_pessoa = 1;

-- Não deve funcionar
DELETE FROM trabalho_bd.Pessoa
WHERE id_pessoa = 1;

-- Deve funcionar
INSERT INTO trabalho_bd.Banco (nome_banco, telefone, cnpj)
VALUES ('Banco A', '(00) 1234-5678', '12345677901234');

-- Não deve funcionar (CNPJ inválido)
INSERT INTO trabalho_bd.Banco (nome_banco, telefone, cnpj)
VALUES ('Banco B', '(00) 9876-5432', '1234567890A');

-- Deve funcionar
INSERT INTO trabalho_bd.Agencia (nome_agencia, endereco, telefone, id_banco)
VALUES ('Agencia 1', 'Rua X, 456', '(00) 9876-5432', 1);

-- Deve funcionar
INSERT INTO trabalho_bd.Cliente (id_pessoa, id_agencia, senha)
VALUES (1, 1, 'senha123');

-- Não deve funcionar (tentativa de inserir cliente com id_pessoa inexistente)
INSERT INTO trabalho_bd.Cliente (id_pessoa, id_agencia, senha)
VALUES (999, 1, 'senha123');

-- Deve funcionar
UPDATE trabalho_bd.Agencia
SET nome_agencia = 'Agencia Atualizada'
WHERE id_agencia = 1;

-- Não deve funcionar (tentativa de atualizar o id_banco para um valor inexistente)
UPDATE trabalho_bd.Agencia
SET id_banco = 999
WHERE id_agencia = 1;

-- Não deve funcionar (tentativa de excluir uma agência que possui referência em Cliente)
DELETE FROM trabalho_bd.Agencia
WHERE id_agencia = 1;

-- Deve funcionar
INSERT INTO trabalho_bd.Conta (numero, saldo, limite, id_cliente, status)
VALUES ('123459789', 1000.00, 500.00, 1, 'Ativa');

-- Deve funcionar
INSERT INTO trabalho_bd.Cartao (numero, validade, cvv, bandeira, limite, id_conta)
VALUES ('1234567890123456', '12/25', '123', 'Visa', 2000.00, 1);

-- Deve funcionar
INSERT INTO trabalho_bd.Fatura (vencimento, pagamento, status, id_cartao)
VALUES ('2023-07-10', '2023-07-11', 'Paga', 1);

-- Não deve funcionar (tentativa de inserir fatura com id_cartao inexistente)
INSERT INTO trabalho_bd.Fatura (vencimento, pagamento, status, id_cartao)
VALUES ('2023-07-15', NULL, 'Aguardando pagamento', 999);

-- Deve funcionar
UPDATE trabalho_bd.Cartao
SET bandeira = 'MasterCard'
WHERE id_cartao = 1;

-- Não deve funcionar (tentativa de atualizar o id_conta para um valor inexistente)
UPDATE trabalho_bd.Cartao
SET id_conta = 999
WHERE id_cartao = 1;

-- Não deve funcionar (tentativa de excluir um cartão que possui referência em Fatura)
DELETE FROM trabalho_bd.Cartao
WHERE id_cartao = 1;

-- Deve funcionar
INSERT INTO trabalho_bd.Compra (valor, divisao, data_hora, estabelecimento)
VALUES (100.00, 1, '2023-07-10 10:00:00', 'Loja A');

-- Deve funcionar
INSERT INTO trabalho_bd.FaturaCompra (id_fatura, id_compra, valor_parcela)
VALUES (2, 1, 100.00);

-- Deve funcionar
INSERT INTO trabalho_bd.Operacao (valor, data_hora, id_conta, tipo_op)
VALUES (500.00, '2023-07-10 12:00:00', 1, 'D');

-- Deve funcionar
INSERT INTO trabalho_bd.Deposito (id_operacao, status)
VALUES (1, 'Concluído');

-- Não deve funcionar (tentativa de inserir um saque com uma operação inexistente)
INSERT INTO trabalho_bd.Saque (id_operacao, status)
VALUES (999, 'Em processamento');

-- Deve funcionar
INSERT INTO trabalho_bd.Investimento (id_operacao, tipo, taxa_rendimento, prazo)
VALUES (6, 'Poupança', 0.05, 365);

-- Deve funcionar
INSERT INTO trabalho_bd.Emprestimo (id_operacao, taxa_juros, parcelas)
VALUES (6, 0.1, 12);

-- Deve funcionar
INSERT INTO trabalho_bd.Transferencia (id_operacao, id_destino, status)
VALUES (6, 2, 'Em processamento');

-- Não deve funcionar (tentativa de inserir uma transferência com uma operação inexistente)
INSERT INTO trabalho_bd.Transferencia (id_operacao, id_destino, status)
VALUES (999, 2, 'Em processamento');