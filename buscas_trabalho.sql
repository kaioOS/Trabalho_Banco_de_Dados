SELECT Pessoa.nome, Conta.saldo
FROM Pessoa
JOIN Cliente ON Pessoa.id_pessoa = Cliente.id_pessoa
JOIN Conta ON Cliente.id_cliente = Conta.id_cliente
JOIN Agencia ON Cliente.id_agencia = Agencia.id_agencia
JOIN Banco ON Agencia.id_banco = Banco.id_banco
WHERE Banco.nome_banco = 'Banco A';

SELECT Agencia.nome_agencia, Agencia.telefone
FROM Agencia
INNER JOIN Funcionario ON Agencia.id_agencia = Funcionario.id_agencia
WHERE Funcionario.salario > 5000;

SELECT Pessoa.nome, Pessoa.endereco
FROM Pessoa
LEFT JOIN Cliente ON Pessoa.id_pessoa = Cliente.id_pessoa
LEFT JOIN Funcionario ON Pessoa.id_pessoa = Funcionario.id_pessoa
WHERE Cliente.id_cliente IS NULL AND Funcionario.id_funcionario IS NULL;

SELECT Pessoa.nome, Funcionario.cargo
FROM Pessoa
RIGHT JOIN Funcionario ON Pessoa.id_pessoa = Funcionario.id_pessoa
WHERE Funcionario.id_funcionario IN (SELECT id_gerente FROM Funcionario WHERE id_gerente IS NOT NULL);

SELECT Pessoa.nome, Compra.valor
FROM Pessoa
JOIN Cliente ON Pessoa.id_pessoa = Cliente.id_pessoa
JOIN Conta ON Cliente.id_cliente = Conta.id_cliente
JOIN Cartao ON Conta.id_conta = Cartao.id_conta
JOIN Fatura ON Cartao.id_cartao = Fatura.id_cartao
JOIN FaturaCompra ON Fatura.id_fatura = FaturaCompra.id_fatura
JOIN Compra ON FaturaCompra.id_compra = Compra.id_compra
WHERE Compra.estabelecimento = 'Loja A';

SELECT Pessoa.nome, Conta.saldo
FROM Pessoa
JOIN Cliente ON Pessoa.id_pessoa = Cliente.id_pessoa
JOIN Conta ON Cliente.id_cliente = Conta.id_cliente
WHERE Conta.id_conta IN (
  SELECT id_conta FROM Cartao GROUP BY id_conta HAVING COUNT(id_cartao) > 1);

SELECT AVG(FaturaCompra.valor_parcela) AS media_faturas_z
FROM FaturaCompra
JOIN Fatura ON FaturaCompra.id_fatura = Fatura.id_fatura
JOIN Cartao ON Fatura.id_cartao = Cartao.id_cartao
WHERE Cartao.bandeira = 'Z';

SELECT Banco.nome_banco, COUNT(Agencia.id_agencia)
FROM Banco
JOIN Agencia ON Banco.id_banco = Agencia.id_banco
GROUP BY Banco.nome_banco
ORDER BY COUNT(Agencia.id_agencia) DESC
LIMIT 1;

SELECT Pessoa.nome, Operacao.valor, Investimento.taxa_rendimento 
FROM Pessoa 
JOIN Cliente ON Pessoa.id_pessoa = Cliente.id_pessoa 
JOIN Conta ON Cliente.id_cliente = Conta.id_cliente 
JOIN Operacao ON Conta.id_conta = Operacao.id_conta 
JOIN Investimento ON Operacao.id_operacao = Investimento.id_operacao 
WHERE Investimento.taxa_rendimento IN (SELECT MAX(taxa_rendimento) FROM Investimento);

SELECT Pessoa.nome, Operacao.valor, Emprestimo.taxa_juros 
FROM Pessoa 
JOIN Cliente ON Pessoa.id_pessoa = Cliente.id_pessoa 
JOIN Conta ON Cliente.id_cliente = Conta.id_cliente 
JOIN Operacao ON Conta.id_conta = Operacao.id_conta 
JOIN Emprestimo ON Operacao.id_operacao = Emprestimo.id_operacao 
WHERE Emprestimo.taxa_juros IN (SELECT MIN(taxa_juros) FROM Emprestimo);

SELECT Pessoa.nome, Operacao.valor, Emprestimo.taxa_juros 
FROM Pessoa 
JOIN Cliente ON Pessoa.id_pessoa = Cliente.id_pessoa 
JOIN Conta ON Cliente.id_cliente = Conta.id_cliente 
JOIN Operacao ON Conta.id_conta = Operacao.id_conta 
JOIN Emprestimo ON Operacao.id_operacao = Emprestimo.id_operacao 
WHERE Emprestimo.taxa_juros IN (SELECT MIN(taxa_juros) FROM Emprestimo);

SELECT Pessoa.nome, Conta.numero 
FROM Pessoa 
JOIN Cliente ON Pessoa.id_pessoa = Cliente.id_pessoa 
JOIN Conta ON Cliente.id_cliente = Conta.id_cliente 
WHERE Conta.id_conta NOT IN (SELECT id_conta FROM Saque, Operacao);

SELECT Pessoa.nome, Conta.numero 
FROM Pessoa 
JOIN Cliente ON Pessoa.id_pessoa = Cliente.id_pessoa 
JOIN Conta ON Cliente.id_cliente = Conta.id_cliente 
WHERE Conta.id_conta IN (
  SELECT O1.id_conta 
  FROM Saque S1, Operacao O1 
  WHERE EXISTS (
    SELECT * 
    FROM Deposito D1, Operacao O2 
    WHERE O2.id_conta = O1.id_conta 
    AND DATE(O2.data_hora) = DATE(O1.data_hora)
  )
);
              
SELECT Pessoa.nome FROM Pessoa 
JOIN Cliente ON Pessoa.id_pessoa = Cliente.id_pessoa 
JOIN Conta ON Cliente.id_cliente = Conta.id_cliente 
JOIN Cartao ON Conta.id_conta = Cartao.id_conta 
GROUP BY Pessoa.nome 
HAVING COUNT(DISTINCT Cartao.bandeira) = (SELECT COUNT(DISTINCT bandeira) FROM Cartao);