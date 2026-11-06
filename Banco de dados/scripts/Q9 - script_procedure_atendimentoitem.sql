select * from pessoa;
select * from item;
select * from produto;
select * from estoque;
select * from atendimento;
select * from atendimentoitem;

drop procedure pr_atendimento;

delimiter //
create procedure pr_atendimento(in p_idpessoa int, in p_itens_selecionados json)
begin
	-- DECLARAÇÃO DE VARIÁVEL PARA PEGAR O ID GERADO
    declare idatendimento_gerado int;
    
    -- Aqui captura qualquer erro e desfaz a transação
    declare exit handler for sqlexception
    begin
		rollback;
        resignal;
    end;
    
    start transaction;
    
    -- INSERIR OS DADOS NA TABELA DE ATENDIMENTO
    insert into atendimento
		(idpessoa, data_atendimento, status_atendimento)
	values
		(p_idpessoa, curdate(), 'A');  
        
	-- PEGANDO O ID GERADO DA TABELA atendimento
    set idatendimento_gerado = last_insert_id();
    
    -- INSERINDO OS DADOS, EM LOTE SET-BASED, NA TABELA ATENDIMENTO_SERVICO
    insert into atendimentoitem
		(idatendimento, iditem, idfuncionario, quantidade_itens, valorunitario_entrada)
	select
		idatendimento_gerado, iditem, idfuncionario, quantidade_itens, valorunitario_entrada
	from 
		json_table(
			p_itens_selecionados, 
            '$[*]'columns(
				iditem int path '$.iditem',
				idfuncionario int path '$.idfuncionario',
				quantidade_itens int path '$.quantidade_itens',
				valorunitario_entrada decimal(10,2) path '$.valorunitario_entrada'
			) 
		) as carrinho;
    
    -- CONFIRMAR 
    commit;
end //
delimiter ;
