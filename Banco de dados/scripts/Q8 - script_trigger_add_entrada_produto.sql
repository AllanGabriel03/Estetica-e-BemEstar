select * from estoque;
select * from entrada_produto;
select * from produto;
select * from item;

DROP TRIGGER tr_entrada_produto;

delimiter //
create trigger tr_entrada_produto
after insert on entrada_produto
for each row
begin
	-- DECLARANDO UMA VARIÁVEL PARA PEGAR TIPO PRODUTO OU SERVIÇO
    declare tp_prod_serv int;
	-- DECLARANDO UMA VARIÁVEL PARA PEGAR O CÓDIGO PREÇO
    declare cod_preco int;    
    
	-- ALTERANDO O PRECO DA TABELA ITEM
    update 
		item
	set 
        preco = new.valor_unitario_entrada
	where
		iditem = new.iditem;
    
    -- ATRIBUINDO O CODIGO DO PREÇO NA VARÁVEL
    select 
		codigo_preco
	into
		cod_preco
	from
		produto
	where
		iditem = new.iditem;

    -- ALTERANDO O PRECO VENDA
    update 
		produto
	set 
        preco_venda = fn_calc_preco_venda(cod_preco, new.valor_unitario_entrada)
	where
		iditem = new.iditem;
        
	-- ALTERANDO A QUANTIDADE NO ESTOQUE
	update
			estoque
		set
			quantidade_estoque = quantidade_estoque + new.quantidade_entrada
		where
			iditem = new.iditem;
		
end //
delimiter ;