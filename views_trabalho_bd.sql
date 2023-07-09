-- DROP VIEW EXTRATO;
-- DROP VIEW Informacoes_CLiente;

CREATE OR REPLACE VIEW EXTRATO AS
SELECT c.id_cliente, o.id_operacao, o.valor, o.data_hora, t.tipo,
s.status AS status_saque,
CASE WHEN t.tipo = 'Investimento' THEN i.tipo ELSE NULL END AS tipo_investimento,
CASE WHEN t.tipo = 'Investimento' THEN i.taxa_rendimento ELSE NULL END AS taxa_rendimento,
CASE WHEN t.tipo = 'Investimento' THEN i.prazo ELSE NULL END AS prazo,
CASE WHEN t.tipo = 'Empréstimo' THEN e.taxa_juros ELSE NULL END AS taxa_juros,
CASE WHEN t.tipo = 'Empréstimo' THEN e.parcelas ELSE NULL END AS parcelas,
CASE WHEN t.tipo = 'Transferência' THEN tr.id_destino ELSE NULL END AS id_destino,
CASE WHEN t.tipo = 'Transferência' THEN tr.status ELSE NULL END AS status_transferencia,
CASE WHEN t.tipo = 'Deposito' THEN d.status ELSE NULL END AS status_deposito
FROM cliente c
JOIN pessoa p ON c.id_pessoa = p.id_pessoa
JOIN conta co ON c.id_cliente = co.id_cliente
JOIN operacao o ON co.id_conta = o.id_conta
JOIN (
  SELECT id_operacao, 'Depósito' AS tipo FROM deposito
  UNION ALL
  SELECT id_operacao, 'Saque' AS tipo FROM saque
  UNION ALL
  SELECT id_operacao, 'Investimento' AS tipo FROM investimento
  UNION ALL
  SELECT id_operacao, 'Empréstimo' AS tipo FROM emprestimo
  UNION ALL
  SELECT id_operacao, 'Transferência' AS tipo FROM transferencia
) t ON o.id_operacao = t.id_operacao
LEFT JOIN deposito d ON o.id_operacao = d.id_operacao
LEFT JOIN saque s ON o.id_operacao = s.id_operacao
LEFT JOIN investimento i ON o.id_operacao = i.id_operacao
LEFT JOIN emprestimo e ON o.id_operacao = e.id_operacao
LEFT JOIN transferencia tr ON o.id_operacao = tr.id_operacao;


CREATE OR REPLACE VIEW Informacoes_Cliente AS
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
-- SELECT * FROM EXTRATO WHERE id_cliente = 4;