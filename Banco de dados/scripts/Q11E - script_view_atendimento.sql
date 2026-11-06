drop view vw_atendimento;

create view vw_atendimento as
select
   a.idatendimento, a.data_atendimento, a.status_atendimento, p.nome, p.telefone, p.email, p.cpf,
   i.item, ai.quantidade_itens, ai.valorunitario_entrada, pf.nome as 'nome_funcionario', f.cargo    
from
	atendimento a
inner join
	pessoa p
	on a.idpessoa = p.idpessoa
inner join
	atendimentoitem ai	
    on a.idatendimento = ai.idatendimento
inner join
	item i 
    on i.iditem = ai.iditem
inner join	
	funcionario f
    on ai.idfuncionario = f.idpessoa
inner join
	pessoa pf
    on pf.idpessoa = f.idpessoa;
    



-- TESTANDO
select * from vw_atendimento;