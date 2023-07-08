-- DROP VIEW EXTRATO;
-- DROP VIEW Informacoes_CLiente;

CREATE VIEW Extrato AS
SELECT o.id_operacao, o.valor, o.data_hora, o.id_conta, c.numero AS numero_conta, o.tipo_op AS tipo_operação, c.saldo
FROM trabalho_bd.operacao o
JOIN trabalho_bd.conta c ON o.id_conta = c.id_conta;


CREATE VIEW Informacoes_Cliente AS
SELECT
p.nome, p.cpf, p.cnpj, p.endereco, p.email, p.data_nasc, p.telefone, p.sexo, 
ct.numero AS numero_conta, ct.saldo, ct.limite AS limite_conta, ct.status,
ca.numero AS numero_cartao, ca.validade, ca.cvv, ca.bandeira, ca.limite AS limite_cartao,
b.nome_banco, 
a.nome_agencia
FROM trabalho_bd.pessoa p 
INNER JOIN trabalho_bd.cliente c ON (p.id_pessoa = c.id_pessoa)
INNER JOIN trabalho_bd.conta ct ON (c.id_cliente = ct.id_cliente)
INNER JOIN trabalho_bd.cartao ca ON (ct.id_conta = ca.id_conta)
INNER JOIN trabalho_bd.agencia a ON (c.id_agencia = a.id_agencia)
INNER JOIN trabalho_bd.banco b ON (a.id_banco = b.id_banco);

-- SELECT * FROM Informacoes_Cliente;
-- SELECT * FROM Extrato;