-- DROP VIEW EXTRATO;
CREATE VIEW extrato AS SELECT o.id_conta,o.tipo_op,o.valor  AS tipo_de_operacao FROM trabalho_bd.Operacao o 
	LEFT JOIN trabalho_bd.saque s on (o.id_operacao = s.id_operacao)
	LEFT JOIN trabalho_bd.deposito d on (o.id_operacao = d.id_operacao)
	LEFT JOIN trabalho_bd.investimento i on (i.id_operacao = s.id_operacao)
	LEFT JOIN trabalho_bd.emprestimo e on (e.id_operacao = s.id_operacao)
	LEFT JOIN trabalho_bd.transferencia t on (t.id_operacao = s.id_operacao);
    
SELECT * FROM extrato;