select * from pessoa;

select * from endereco;


call pr_pessoa(
'
{
    "nome": "João da Silva",
    "cpf": "12345678901",
    "data_nascimento": "1990-05-15",
    "sexo": "M",
    "email": "joao.silva@email.com",
    "telefone": "79999990001",
    "ativo": "S",
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

call pr_pessoa(
'
{
    "nome": "Maria Oliveira Santos",
    "cpf": "23456789012",
    "data_nascimento": "1992-08-20",
    "sexo": "F",
    "email": "maria.santos@email.com",
    "telefone": "79999990002",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49020000",
        "numero": "789",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Carlos Eduardo Souza",
    "cpf": "34567890123",
    "data_nascimento": "1988-03-12",
    "sexo": "M",
    "email": "carlos.souza@email.com",
    "telefone": "79999990003",
    "ativo": "S",
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
      },
      {
        "cep": "49020000",
        "numero": "789",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Ana Paula Mendes",
    "cpf": "45678901234",
    "data_nascimento": "1995-11-07",
    "sexo": "F",
    "email": "ana.mendes@email.com",
    "telefone": "79999990004",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49040000",
        "numero": "88",
        "complemento": "Apto 302"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Pedro Henrique Lima",
    "cpf": "56789012345",
    "data_nascimento": "1985-01-25",
    "sexo": "M",
    "email": "pedro.lima@email.com",
    "telefone": "79999990005",
    "ativo": "S",
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

call pr_pessoa(
'
{
    "nome": "Juliana Costa Almeida",
    "cpf": "67890123456",
    "data_nascimento": "1993-06-18",
    "sexo": "F",
    "email": "juliana.almeida@email.com",
    "telefone": "79999990006",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49060000",
        "numero": "230",
        "complemento": "Casa"
      },
      {
        "cep": "49030000",
        "numero": "321",
        "complemento": "Casa"
      },
      {
        "cep": "49031000",
        "numero": "55",
        "complemento": "Sala 02"
      },
      {
        "cep": "49020000",
        "numero": "789",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Rafael Martins Rocha",
    "cpf": "78901234567",
    "data_nascimento": "1989-09-30",
    "sexo": "M",
    "email": "rafael.rocha@email.com",
    "telefone": "79999990007",
    "ativo": "S",
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

call pr_pessoa(
'
{
    "nome": "Fernanda Cristina Alves",
    "cpf": "89012345678",
    "data_nascimento": "1991-12-04",
    "sexo": "F",
    "email": "fernanda.alves@email.com",
    "telefone": "79999990008",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49080000",
        "numero": "77",
        "complemento": "Apto 104"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Lucas Gabriel Ferreira",
    "cpf": "90123456789",
    "data_nascimento": "1996-04-22",
    "sexo": "M",
    "email": "lucas.ferreira@email.com",
    "telefone": "79999990009",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49090000",
        "numero": "501",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Camila Rodrigues Silva",
    "cpf": "11234567890",
    "data_nascimento": "1994-07-13",
    "sexo": "F",
    "email": "camila.silva@email.com",
    "telefone": "79999990010",
    "ativo": "S",
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

call pr_pessoa(
'
{
    "nome": "Bruno Carvalho Santos",
    "cpf": "22345678901",
    "data_nascimento": "1987-10-09",
    "sexo": "M",
    "email": "bruno.santos@email.com",
    "telefone": "79999990011",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49110000",
        "numero": "321",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Patricia Regina Gomes",
    "cpf": "33456789012",
    "data_nascimento": "1990-02-28",
    "sexo": "F",
    "email": "patricia.gomes@email.com",
    "telefone": "79999990012",
    "ativo": "S",
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

call pr_pessoa(
'
{
    "nome": "Diego Fernandes Costa",
    "cpf": "44567890123",
    "data_nascimento": "1986-05-19",
    "sexo": "M",
    "email": "diego.costa@email.com",
    "telefone": "79999990013",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49130000",
        "numero": "710",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Larissa Beatriz Moura",
    "cpf": "55678901234",
    "data_nascimento": "1997-03-16",
    "sexo": "F",
    "email": "larissa.moura@email.com",
    "telefone": "79999990014",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49140000",
        "numero": "82",
        "complemento": "Apto 103"
      }
    ]
  }');

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

call pr_pessoa(
'
{
    "nome": "Renata Maria Torres",
    "cpf": "77890123456",
    "data_nascimento": "1993-01-29",
    "sexo": "F",
    "email": "renata.torres@email.com",
    "telefone": "79999990016",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49160000",
        "numero": "205",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Gustavo Henrique Barros",
    "cpf": "88901234567",
    "data_nascimento": "1989-11-21",
    "sexo": "M",
    "email": "gustavo.barros@email.com",
    "telefone": "79999990017",
    "ativo": "S",
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

call pr_pessoa(
'
{
    "nome": "Beatriz Helena Cardoso",
    "cpf": "99012345678",
    "data_nascimento": "1995-09-17",
    "sexo": "F",
    "email": "beatriz.cardoso@email.com",
    "telefone": "79999990018",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49180000",
        "numero": "510",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Thiago Roberto Vieira",
    "cpf": "10123456789",
    "data_nascimento": "1984-06-26",
    "sexo": "M",
    "email": "thiago.vieira@email.com",
    "telefone": "79999990019",
    "ativo": "S",
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

call pr_pessoa(
'
{
    "nome": "Amanda Caroline Freitas",
    "cpf": "21234567890",
    "data_nascimento": "1996-10-05",
    "sexo": "F",
    "email": "amanda.freitas@email.com",
    "telefone": "79999990020",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49200000",
        "numero": "127",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Ricardo Antonio Melo",
    "cpf": "32345678901",
    "data_nascimento": "1982-04-17",
    "sexo": "M",
    "email": "ricardo.melo@email.com",
    "telefone": "79999990021",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49210000",
        "numero": "220",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Carolina Mendes Rocha",
    "cpf": "43456789012",
    "data_nascimento": "1998-02-11",
    "sexo": "F",
    "email": "carolina.rocha@email.com",
    "telefone": "79999990022",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49220000",
        "numero": "315",
        "complemento": "Apto 201"
      },
      {
        "cep": "49221000",
        "numero": "70",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Felipe Augusto Martins",
    "cpf": "54567890123",
    "data_nascimento": "1991-06-23",
    "sexo": "M",
    "email": "felipe.martins@email.com",
    "telefone": "79999990023",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49230000",
        "numero": "410",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Vanessa Cristina Lopes",
    "cpf": "65678901234",
    "data_nascimento": "1989-12-19",
    "sexo": "F",
    "email": "vanessa.lopes@email.com",
    "telefone": "79999990024",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49240000",
        "numero": "512",
        "complemento": "Casa"
      },
      {
        "cep": "49241000",
        "numero": "33",
        "complemento": "Apto 402"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Eduardo Henrique Castro",
    "cpf": "76789012345",
    "data_nascimento": "1985-07-08",
    "sexo": "M",
    "email": "eduardo.castro@email.com",
    "telefone": "79999990025",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49250000",
        "numero": "620",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Natália Fernanda Souza",
    "cpf": "87890123456",
    "data_nascimento": "1994-05-27",
    "sexo": "F",
    "email": "natalia.souza@email.com",
    "telefone": "79999990026",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49260000",
        "numero": "715",
        "complemento": "Apto 105"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "André Luiz Pereira",
    "cpf": "98901234567",
    "data_nascimento": "1987-09-14",
    "sexo": "M",
    "email": "andre.pereira@email.com",
    "telefone": "79999990027",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49270000",
        "numero": "801",
        "complemento": "Casa"
      },
      {
        "cep": "49271000",
        "numero": "90",
        "complemento": "Fundos"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Priscila Helena Ramos",
    "cpf": "10912345678",
    "data_nascimento": "1992-11-03",
    "sexo": "F",
    "email": "priscila.ramos@email.com",
    "telefone": "79999990028",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49280000",
        "numero": "145",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Marcela Cristina Dias",
    "cpf": "21023456789",
    "data_nascimento": "1990-03-09",
    "sexo": "F",
    "email": "marcela.dias@email.com",
    "telefone": "79999990029",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49290000",
        "numero": "255",
        "complemento": "Apto 303"
      },
      {
        "cep": "49291000",
        "numero": "61",
        "complemento": "Casa"
      }
    ]
  }');

call pr_pessoa(
'
{
    "nome": "Roberto Carlos Fernandes",
    "cpf": "32134567890",
    "data_nascimento": "1981-10-16",
    "sexo": "M",
    "email": "roberto.fernandes@email.com",
    "telefone": "79999990030",
    "ativo": "S",
    "enderecos": [
      {
        "cep": "49300000",
        "numero": "340",
        "complemento": "Casa"
      }
    ]
  }');
