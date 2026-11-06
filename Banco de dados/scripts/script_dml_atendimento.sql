select * from vw_pessoa_endereco;

select * from vw_servico_categoria;

select * from vw_produto_categoria;

select * from vw_funcionario_endereco;

select * from vw_atendimento where idatendimento = 23;


-- Executando uma procedure
call pr_atendimento(27,
	'
		[
			{"iditem": 1, "idfuncionario": 7, "quantidade_itens": 1, "valorunitario_entrada": 52.49},
            {"iditem": 2, "idfuncionario": 17, "quantidade_itens": 1, "valorunitario_entrada": 11.00},
			{"iditem": 7, "idfuncionario": 16, "quantidade_itens": 1, "valorunitario_entrada": 100.00},
            {"iditem": 31, "idfuncionario": 13, "quantidade_itens": 1, "valorunitario_entrada": 120.00},
            {"iditem": 3, "idfuncionario": 20, "quantidade_itens": 1, "valorunitario_entrada": 150.00}
            
        ]
    '
);

-- Executando uma procedure
call pr_atendimento(6,
	'
		[
			{"iditem": 4, "idfuncionario": 8, "quantidade_itens": 3, "valorunitario_entrada": 44.00},
            {"iditem": 21, "idfuncionario": 8, "quantidade_itens": 1, "valorunitario_entrada": 27.00}
		]
    '
);

-- Executando uma procedure
call pr_atendimento(2,
	'
		[
			{"iditem": 6, "idfuncionario": 16, "quantidade_itens": 1, "valorunitario_entrada": 132.00},
            {"iditem": 29, "idfuncionario": 13, "quantidade_itens": 1, "valorunitario_entrada": 33.00}
        ]
    '
);






select 
	* 
from
	produto_servico ps
inner join estoque e
	on ps.idproduto_servico = e.idproduto_servico
where
	ps.tipo_produto_servico = 's';
    

UPDATE estoque e
JOIN produto_servico ps
    ON ps.idproduto_servico = e.idproduto_servico
SET e.quantidade = 1
WHERE ps.tipo_produto_servico = 's';
