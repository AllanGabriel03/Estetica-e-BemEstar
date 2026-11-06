drop procedure pr_pessoa;

delimiter //
create procedure pr_funcionario(in pessoa json)
begin
	declare idpessoa_gerado int;

	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
    end;
    
    start transaction;
    
	insert into pessoa
		(nome, cpf, data_nascimento, sexo, email, telefone, ativo_pessoa)
	select
		nome, cpf, data_nascimento, sexo, email, telefone, ativo_pessoa
	from
		json_table(pessoa,'$' columns(
			nome varchar(100) path '$.nome',
            cpf bigint(11) path '$.cpf',
            data_nascimento date path '$.data_nascimento',
            sexo char(1) path '$.sexo',
            email varchar(100) path '$.email',
            telefone bigint(11) path '$.telefone',
            ativo_pessoa char(1) path '$.ativo')			
        ) as p;
        
	set idpessoa_gerado = last_insert_id();
    
    insert into funcionario
		(idpessoa, cargo, data_admissao)
	select
		idpessoa_gerado, cargo, data_admissao
	from
		json_table(pessoa,'$' columns(
            cargo varchar(20) path '$.cargo',
            data_admissao date path '$.data_admissao')
        ) as f;
    
    insert into endereco
		(idpessoa, cep, numero, complemento)
	select
		idpessoa_gerado, cep, numero, complemento
	from
		json_table(pessoa, '$.enderecos[*]' columns(
			cep int path '$.cep',
            numero char(8) path '$.numero',
            complemento varchar(150) path '$.complemento')
        ) as e;
    commit;
end //

delimiter ;

-- TESTANDO
select * from pessoa;

select * from funcionario;

select * from endereco;

-- EXECUTAR A PROCEDURE

call pr_funcionario(
'{
    "nome": "Fernanda Beatriz Lima",
    "cpf": "67890123456",
    "data_nascimento": "1994-06-18",
    "sexo": "F",
    "email": "fernanda.lima@email.com",
    "telefone": "79999990006",
    "ativo": "S",
    "cargo": "Recepcionista",
    "data_admissao": "2020-11-09",
    "enderecos": [
      {
        "cep": "49060000",
        "numero": "230",
        "complemento": "Casa"
      },
       {
        "cep": "49012000",
        "numero": "230",
        "complemento": "Apartamento"
      }
      
    ]
  }');