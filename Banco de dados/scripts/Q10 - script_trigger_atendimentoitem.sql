select * from pessoa;
select * from item;
select * from produto;
select * from estoque;
select * from atendimento;
select * from atendimentoitem;

drop trigger tr_debito_estoque_atendimento_item;

delimiter //
create trigger tr_debito_estoque_atendimento_item
after insert on atendimentoitem
for each row
begin
	declare estoque_atual int;
    declare disponibilidade char;
    declare tpitem char;
        
    -- 	ATRIBUINDO O VALOR DO ESTOQUE ATUAL NA VARIÁVEL
    select
		quantidade_estoque
	into
		estoque_atual
	from
		estoque
	where
		iditem = new.iditem
	for update;
  /*      
	-- CAPTURANDO A DISPOSNIBILIDADE DO PRODUTO POR MEIO DE SEU STATUS
    select
		ativo_produto_servico
	into 
		disponibilidade
	from
		item
	where
			iditem = new.iditem
	for update;
    
     -- 	ATRIBUINDO O TIPO DO ITEM NA VARIÁVEL
    select
		tipo_item
	into
		tpitem
	from
		item
	where
		iditem = new.iditem
	for update;
    
    */
    
    SELECT
		ativo_produto_servico,
		tipo_item
	INTO
		disponibilidade,
		tpitem
	FROM 
		item
	WHERE 
		iditem = NEW.iditem
	FOR UPDATE;
    
    -- Verificar a disponibilidade do produto
    if disponibilidade <> 'S' then
		signal sqlstate '45000'
        set message_text = 'Produto indisponível';
	end if ; 
    
    -- Verificar se o produto existe no estoque
    if tpitem is null then
		signal sqlstate '45000'
        set message_text = 'Produto não econtrado';
	end if ; 
    
    -- Verificar se a quantidade em estoque é insuficiente
    if estoque_atual < new.quantidade_itens then
		signal sqlstate '45000'
        set message_text = 'Produto insuficiente no estoque';
    end if ;
       
	-- VERIFICANDO TIPO PRODUTO OU SERVIÇO
    if tpitem = 'P' then
		update
			estoque
		set
			quantidade_estoque = quantidade_estoque - new.quantidade_itens
		where
			iditem = new.iditem;	
	end if;
	
end //
delimiter ;