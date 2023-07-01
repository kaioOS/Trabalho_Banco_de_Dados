SELECT * FROM trabalho_bd.Pessoa;
SELECT * FROM trabalho_bd.Banco;
SELECT * FROM trabalho_bd.Agencia ; 
SELECT * FROM trabalho_bd.Cliente ;
SELECT * FROM trabalho_bd.Funcionario ;
SELECT * FROM trabalho_bd.Conta;
SELECT * FROM trabalho_bd.Cartao ;


SELECT * FROM trabalho_bd.Fatura ;
SELECT * FROM trabalho_bd.Compra ;
SELECT * FROM trabalho_bd.FaturaCompra ;
SELECT * FROM trabalho_bd.Operacao ;
SELECT * FROM trabalho_bd.Deposito ;
SELECT * FROM trabalho_bd.Saque ;
SELECT * FROM trabalho_bd.Investimento ;
SELECT * FROM trabalho_bd.Emprestimo ;
SELECT * FROM trabalho_bd.Transferencia ;


SELECT p.nome,p.cpf,ct.saldo FROM (Pessoa p INNER JOIN Cliente c on (p.id_pessoa = c.id_pessoa) INNER JOIN Conta ct on (c.id_cliente = ct.id_cliente)) WHERE p.cpf = "?" ;
SELECT * FROM trabalho_bd.Conta c inner join trabalho_bd.Operacao o on (c.id_conta = o.id_conta)  INNER JOIN trabalho_bd.Saque s on (o.id_operacao = s.id_operacao); 