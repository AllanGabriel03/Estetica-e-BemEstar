select * from pessoa;

select * from funcionario;

select * from endereco;


call pr_funcionario(
'{
    "nome": "Juliana Martins Costa",
    "cpf": "12345678901",
    "data_nascimento": "1988-05-14",
    "sexo": "F",
    "email": "juliana.costa@email.com",
    "telefone": "79999990001",
    "ativo": "S",
    "cargo": "Esteticista",
    "data_admissao": "2020-02-10",
    "enderecos": [
      {
        "cep": "49000000",
        "numero": "123",
        "complemento": "Casa"
      },
      {
        "cep": "49010000",
        "numero": "456",
        "complemento": "Apto 101"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Mariana Oliveira Santos",
    "cpf": "23456789012",
    "data_nascimento": "1991-08-22",
    "sexo": "F",
    "email": "mariana.santos@email.com",
    "telefone": "79999990002",
    "ativo": "S",
    "cargo": "Biomedica",
    "data_admissao": "2019-06-15",
    "enderecos": [
      {
        "cep": "49020000",
        "numero": "789",
        "complemento": "Casa"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Camila Ferreira Almeida",
    "cpf": "34567890123",
    "data_nascimento": "1993-03-18",
    "sexo": "F",
    "email": "camila.almeida@email.com",
    "telefone": "79999990003",
    "ativo": "S",
    "cargo": "Fisioterapeuta",
    "data_admissao": "2021-01-20",
    "enderecos": [
      {
        "cep": "49030000",
        "numero": "321",
        "complemento": "Casa"
      },
      {
        "cep": "49031000",
        "numero": "55",
        "complemento": "Sala 02"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Patricia Regina Gomes",
    "cpf": "45678901234",
    "data_nascimento": "1987-11-07",
    "sexo": "F",
    "email": "patricia.gomes@email.com",
    "telefone": "79999990004",
    "ativo": "S",
    "cargo": "Massoterapeuta",
    "data_admissao": "2022-04-11",
    "enderecos": [
      {
        "cep": "49040000",
        "numero": "88",
        "complemento": "Apto 302"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Renata Cristina Alves",
    "cpf": "56789012345",
    "data_nascimento": "1990-01-25",
    "sexo": "F",
    "email": "renata.alves@email.com",
    "telefone": "79999990005",
    "ativo": "S",
    "cargo": "Esteticista",
    "data_admissao": "2018-09-03",
    "enderecos": [
      {
        "cep": "49050000",
        "numero": "145",
        "complemento": "Casa"
      },
      {
        "cep": "49051000",
        "numero": "210",
        "complemento": "Apto 501"
      }
    ]
  }');

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
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Amanda Caroline Rocha",
    "cpf": "78901234567",
    "data_nascimento": "1995-09-30",
    "sexo": "F",
    "email": "amanda.rocha@email.com",
    "telefone": "79999990007",
    "ativo": "S",
    "cargo": "Dermatologista",
    "data_admissao": "2021-07-19",
    "enderecos": [
      {
        "cep": "49070000",
        "numero": "412",
        "complemento": "Casa"
      },
      {
        "cep": "49071000",
        "numero": "90",
        "complemento": "Fundos"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Larissa Cristina Mendes",
    "cpf": "89012345678",
    "data_nascimento": "1992-12-04",
    "sexo": "F",
    "email": "larissa.mendes@email.com",
    "telefone": "79999990008",
    "ativo": "S",
    "cargo": "Cosmetologa",
    "data_admissao": "2023-02-13",
    "enderecos": [
      {
        "cep": "49080000",
        "numero": "77",
        "complemento": "Apto 104"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Bruna Helena Ferreira",
    "cpf": "90123456789",
    "data_nascimento": "1996-04-22",
    "sexo": "F",
    "email": "bruna.ferreira@email.com",
    "telefone": "79999990009",
    "ativo": "S",
    "cargo": "Esteticista",
    "data_admissao": "2024-01-15",
    "enderecos": [
      {
        "cep": "49090000",
        "numero": "501",
        "complemento": "Casa"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Carolina Rodrigues Silva",
    "cpf": "11234567890",
    "data_nascimento": "1989-07-13",
    "sexo": "F",
    "email": "carolina.silva@email.com",
    "telefone": "79999990010",
    "ativo": "S",
    "cargo": "Gerente",
    "data_admissao": "2020-08-24",
    "enderecos": [
      {
        "cep": "49100000",
        "numero": "612",
        "complemento": "Casa"
      },
      {
        "cep": "49101000",
        "numero": "45",
        "complemento": "Apto 202"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Beatriz Helena Santos",
    "cpf": "22345678901",
    "data_nascimento": "1993-10-09",
    "sexo": "F",
    "email": "beatriz.santos@email.com",
    "telefone": "79999990011",
    "ativo": "S",
    "cargo": "Recepcionista",
    "data_admissao": "2017-03-27",
    "enderecos": [
      {
        "cep": "49110000",
        "numero": "321",
        "complemento": "Casa"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Daniela Regina Moura",
    "cpf": "33456789012",
    "data_nascimento": "1990-02-28",
    "sexo": "F",
    "email": "daniela.moura@email.com",
    "telefone": "79999990012",
    "ativo": "S",
    "cargo": "Nutricionista",
    "data_admissao": "2019-10-14",
    "enderecos": [
      {
        "cep": "49120000",
        "numero": "159",
        "complemento": "Casa"
      },
      {
        "cep": "49121000",
        "numero": "300",
        "complemento": "Apto 401"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Isabela Fernandes Costa",
    "cpf": "44567890123",
    "data_nascimento": "1986-05-19",
    "sexo": "F",
    "email": "isabela.costa@email.com",
    "telefone": "79999990013",
    "ativo": "S",
    "cargo": "Psicologa",
    "data_admissao": "2018-12-03",
    "enderecos": [
      {
        "cep": "49130000",
        "numero": "710",
        "complemento": "Casa"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Leticia Beatriz Moura",
    "cpf": "55678901234",
    "data_nascimento": "1997-03-16",
    "sexo": "F",
    "email": "leticia.moura@email.com",
    "telefone": "79999990014",
    "ativo": "S",
    "cargo": "Esteticista",
    "data_admissao": "2023-06-05",
    "enderecos": [
      {
        "cep": "49140000",
        "numero": "82",
        "complemento": "Apto 103"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Vanessa Maria Torres",
    "cpf": "66789012345",
    "data_nascimento": "1983-08-11",
    "sexo": "F",
    "email": "vanessa.torres@email.com",
    "telefone": "79999990015",
    "ativo": "S",
    "cargo": "Administradora",
    "data_admissao": "2016-05-02",
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

call pr_funcionario(
'{
    "nome": "Sabrina Maria Oliveira",
    "cpf": "77890123456",
    "data_nascimento": "1993-01-29",
    "sexo": "F",
    "email": "sabrina.oliveira@email.com",
    "telefone": "79999990016",
    "ativo": "S",
    "cargo": "Recepcionista",
    "data_admissao": "2021-09-13",
    "enderecos": [
      {
        "cep": "49160000",
        "numero": "205",
        "complemento": "Casa"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Aline Cristina Barros",
    "cpf": "88901234567",
    "data_nascimento": "1989-11-21",
    "sexo": "F",
    "email": "aline.barros@email.com",
    "telefone": "79999990017",
    "ativo": "S",
    "cargo": "Fisioterapeuta",
    "data_admissao": "2022-02-07",
    "enderecos": [
      {
        "cep": "49170000",
        "numero": "333",
        "complemento": "Apto 201"
      },
      {
        "cep": "49171000",
        "numero": "44",
        "complemento": "Casa"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Gabriela Helena Cardoso",
    "cpf": "99012345678",
    "data_nascimento": "1995-09-17",
    "sexo": "F",
    "email": "gabriela.cardoso@email.com",
    "telefone": "79999990018",
    "ativo": "S",
    "cargo": "Biomedica",
    "data_admissao": "2024-03-18",
    "enderecos": [
      {
        "cep": "49180000",
        "numero": "510",
        "complemento": "Casa"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Monique Alves Vieira",
    "cpf": "10123456789",
    "data_nascimento": "1984-06-26",
    "sexo": "F",
    "email": "monique.vieira@email.com",
    "telefone": "79999990019",
    "ativo": "S",
    "cargo": "Massoterapeuta",
    "data_admissao": "2018-01-22",
    "enderecos": [
      {
        "cep": "49190000",
        "numero": "615",
        "complemento": "Casa"
      },
      {
        "cep": "49191000",
        "numero": "80",
        "complemento": "Apto 302"
      }
    ]
  }');

call pr_funcionario(
'{
    "nome": "Nicole Caroline Freitas",
    "cpf": "21234567890",
    "data_nascimento": "1996-10-05",
    "sexo": "F",
    "email": "nicole.freitas@email.com",
    "telefone": "79999990020",
    "ativo": "S",
    "cargo": "Esteticista",
    "data_admissao": "2023-08-21",
    "enderecos": [
      {
        "cep": "49200000",
        "numero": "127",
        "complemento": "Casa"
      }
    ]
  }');
