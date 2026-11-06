select * from produto;
create view vw_produto_categoria as
select 
	i.iditem, i.item, i.descricao_item, p.codigo_preco, i.preco, p.preco_venda, p.unidade,
	c.categoria, e.quantidade_estoque, i.ativo_produto_servico
from 
	item i
inner join
	produto p
    on i.iditem = p.iditem
inner join 
	estoque e
    on p.iditem = e.iditem
inner join
	categoria c 
	on i.idcategoria = c.idcategoria;

-- TESTANDO
select * from vw_produto_categoria;