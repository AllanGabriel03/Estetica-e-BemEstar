drop procedure pr_pessoa;

delimiter //
create procedure pr_pessoa(in pessoa json)
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

select * from endereco;

call pr_pessoa(
'
{
    "nome": "Marcelo Augusto Nunes",
    "cpf": "66789012345",
    "data_nascimento": "1983-08-11",
    "sexo": "M",
    "email": "marcelo.nunes@email.com",
    "telefone": "79999990015",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49150000",
        "numero": "900",
        "complemento": "Casa"
      },
      {
        "cep": "49151000",
        "numero": "120",
        "complemento": "Comercial"
      }
    ]
  }');