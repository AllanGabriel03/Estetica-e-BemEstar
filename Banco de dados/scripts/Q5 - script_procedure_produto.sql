
delimiter //
create procedure pr_produto(in produto json)
begin
	declare iditem_gerado int;
    declare preco_item decimal(10,2);

	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
    end;
    
    start transaction;
    
	insert into item
		(idcategoria, item, descricao_item, preco, tipo_item, ativo_produto_servico)
	select
		idcategoria, item, descricao_item, preco, tipo_item, ativo_produto_servico
	from
		json_table(produto,'$' columns(
			idcategoria int path '$.idcategoria',
            item varchar(40) path '$.item',
            descricao_item varchar(200) path '$.descricao_item',
			preco decimal(10,2) path '$.preco',
            tipo_item char(1) path '$.tipo_item',
            ativo_produto_servico char(1) path '$.ativo_produto_servico')			
        ) as i;
        
	set iditem_gerado = last_insert_id();

    SELECT preco
    INTO preco_item
    FROM item
    WHERE iditem = iditem_gerado;
    
    insert into produto
		(iditem, codigo_preco, preco_venda, unidade)
	select
		iditem_gerado, codigo_preco, fn_calc_preco_venda(codigo_preco, preco_item), unidade
	from
		json_table(produto,'$' columns(
			codigo_preco int path '$.codigo_preco',
            unidade char(10) path '$.unidade')
        ) as p;
    
    commit;

end //
delimiter ;

-- TESTANDO
select * from item;

select * from produto;

select * from estoque;



-- 01
CALL pr_produto('{
    "idcategoria": 1,
    "item": "Protetor Solar Facial FPS 60",
    "descricao_item": "Protetor solar facial FPS 60 com toque seco",
    "preco": 45.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 2,
    "unidade": "UN"
}');

-- 02
CALL pr_produto('{
    "idcategoria": 1,
    "item": "Sabonete Facial Espuma",
    "descricao_item": "Sabonete facial em espuma para limpeza da pele",
    "preco": 32.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 1,
    "unidade": "UN"
}');

-- 03
CALL pr_produto('{
    "idcategoria": 1,
    "item": "Gel de Limpeza Facial",
    "descricao_item": "Gel de limpeza facial para pele oleosa",
    "preco": 38.50,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 2,
    "unidade": "UN"
}');

-- 04
CALL pr_produto('{
    "idcategoria": 2,
    "item": "Serum Vitamina C",
    "descricao_item": "Serum facial antioxidante com vitamina C",
    "preco": 65.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 3,
    "unidade": "UN"
}');

-- 05
CALL pr_produto('{
    "idcategoria": 2,
    "item": "Serum Acido Hialuronico",
    "descricao_item": "Serum hidratante com acido hialuronico",
    "preco": 72.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 2,
    "unidade": "UN"
}');

-- 06
CALL pr_produto('{
    "idcategoria": 3,
    "item": "Creme Hidratante Corporal",
    "descricao_item": "Creme hidratante corporal para uso diario",
    "preco": 42.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 1,
    "unidade": "UN"
}');

-- 07
CALL pr_produto('{
    "idcategoria": 3,
    "item": "Esfoliante Corporal",
    "descricao_item": "Esfoliante corporal com particulas naturais",
    "preco": 48.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 2,
    "unidade": "UN"
}');

-- 08
CALL pr_produto('{
    "idcategoria": 4,
    "item": "Oleo Corporal Relaxante",
    "descricao_item": "Oleo corporal para massagens relaxantes",
    "preco": 55.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 3,
    "unidade": "UN"
}');

-- 09
CALL pr_produto('{
    "idcategoria": 5,
    "item": "Cera Depilatoria Facial",
    "descricao_item": "Cera depilatoria para procedimentos faciais",
    "preco": 28.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 1,
    "unidade": "UN"
}');

-- 10
CALL pr_produto('{
    "idcategoria": 6,
    "item": "Henna para Sobrancelhas",
    "descricao_item": "Henna profissional para design de sobrancelhas",
    "preco": 35.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 2,
    "unidade": "UN"
}');

-- 11
CALL pr_produto('{
    "idcategoria": 7,
    "item": "Pigmento para Micropigmentacao",
    "descricao_item": "Pigmento profissional para micropigmentacao",
    "preco": 85.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 3,
    "unidade": "UN"
}');

-- 12
CALL pr_produto('{
    "idcategoria": 8,
    "item": "Cola para Extensao de Cilios",
    "descricao_item": "Cola profissional para extensao de cilios",
    "preco": 78.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 2,
    "unidade": "UN"
}');

-- 13
CALL pr_produto('{
    "idcategoria": 9,
    "item": "Serum para Lash Lifting",
    "descricao_item": "Serum profissional para procedimento de lash lifting",
    "preco": 62.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 1,
    "unidade": "UN"
}');

-- 14
CALL pr_produto('{
    "idcategoria": 10,
    "item": "Peeling Quimico Facial",
    "descricao_item": "Peeling facial para renovacao e revitalizacao da pele",
    "preco": 95.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 3,
    "unidade": "UN"
}');

-- 15
CALL pr_produto('{
    "idcategoria": 11,
    "item": "Creme para Drenagem Linfatica",
    "descricao_item": "Creme corporal para procedimentos de drenagem",
    "preco": 58.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 2,
    "unidade": "UN"
}');

-- 16
CALL pr_produto('{
    "idcategoria": 12,
    "item": "Mascara Facial Hidratante",
    "descricao_item": "Mascara facial hidratante para tratamento estetico",
    "preco": 44.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 1,
    "unidade": "UN"
}');

-- 17
CALL pr_produto('{
    "idcategoria": 15,
    "item": "Shampoo Profissional",
    "descricao_item": "Shampoo profissional para cuidados capilares",
    "preco": 39.90,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 2,
    "unidade": "UN"
}');

-- 18
CALL pr_produto('{
    "idcategoria": 16,
    "item": "Mascara Capilar Hidratante",
    "descricao_item": "Mascara capilar para hidratacao e nutricao",
    "preco": 52.00,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 3,
    "unidade": "UN"
}');

-- 19
CALL pr_produto('{
    "idcategoria": 17,
    "item": "Base Facial Liquida",
    "descricao_item": "Base facial liquida para maquiagem profissional",
    "preco": 59.90,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 2,
    "unidade": "UN"
}');

-- 20
CALL pr_produto('{
    "idcategoria": 18,
    "item": "Protetor Labial FPS 30",
    "descricao_item": "Protetor labial hidratante com FPS 30",
    "preco": 24.90,
    "tipo_item": "P",
    "ativo_produto_servico": "S",
    "codigo_preco": 1,
    "unidade": "UN"
}');
