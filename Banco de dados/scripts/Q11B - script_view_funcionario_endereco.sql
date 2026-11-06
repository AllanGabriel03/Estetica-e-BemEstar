select * from pessoa;

select * from endereco;

select * from funcionario;

create view vw_funcionario_endereco as
	select
		p.idpessoa, p.nome, p.cpf,p.telefone, p.email, f.cargo,
        e.cep, e.numero, e.complemento, f.data_admissao,  p.ativo_pessoa
	from
		pessoa p
	left join
		funcionario f
        on p.idpessoa = f.idpessoa
	inner join
		endereco e
        on f.idpessoa = e.idpessoa;
        
-- TESTANDO
select * from vw_funcionario_endereco;
		
