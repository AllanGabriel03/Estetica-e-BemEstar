
create view vw_servico_categoria as
select
	i.iditem, i.item, i.descricao_item, i.preco, c.categoria, i.ativo_produto_servico
from 
	item i
inner join
	categoria c
    on i.idcategoria = c.idcategoria
    where i.tipo_item = 'S';
    
-- TESTANDO
select * from vw_servico_categoria;	