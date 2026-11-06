select * from pessoa;

select * from endereco;

select * from funcionario;

create view vw_pessoa_endereco as
	SELECT 
		p.idpessoa, p.nome, p.cpf,p.telefone, p.email, e.cep, e.numero, e.complemento,  p.ativo_pessoa
	FROM 
		pessoa p
	LEFT JOIN 
		funcionario f
		ON f.idpessoa = p.idpessoa
	inner join
		endereco e
        on p.idpessoa = e.idpessoa
	WHERE f.idpessoa IS NULL;
    
-- TESTANDO
select * from vw_pessoa_endereco;