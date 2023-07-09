-- Índices na tabela Pessoa
CREATE INDEX idx_pessoa_cpf ON Pessoa (cpf);
CREATE INDEX idx_pessoa_cnpj ON Pessoa (cnpj);

-- Índices na tabela Cliente
CREATE INDEX idx_cliente_id_pessoa ON Cliente (id_pessoa);

-- Índice na tabela Conta
CREATE INDEX idx_conta_id_cliente ON Conta (id_cliente);