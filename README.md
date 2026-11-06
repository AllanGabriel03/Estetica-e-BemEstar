# Estética & Bem-Estar

Projeto **full stack** de uma loja de estética, com catálogo de produtos e
serviços, carrinho de compras, pedidos por cliente, login por CPF, painel
administrativo separado da loja e controle de estoque.

Desenvolvido como trabalho de curso (disciplina de back-end), combinando
**Angular 22** no front-end e **ASP.NET Core 8** no back-end, com persistência
em **MySQL/MariaDB**.

## Tecnologias

| Camada | Tecnologias |
| --- | --- |
| Frontend | Angular 22, TypeScript, HTML/CSS, Reactive Forms, HttpClient, RxJS |
| Backend | ASP.NET Core 8 Web API, Entity Framework Core 8, Pomelo MySQL |
| Banco | MySQL / MariaDB (`bd_aula_backend`) |
| Documentação da API | Swagger (Swashbuckle) |

## Funcionalidades

### Loja Virtual

- **Catálogo** de produtos (`/catalogo`) e serviços (`/servicos`) com filtro por categoria e busca.
- **Carrinho** com seleção do profissional responsável, validação de estoque,
  resumo lateral (quantidade e total) e mensagens na tela.
- **Cadastro** de cliente com validação de CPF único e endereço.
- **Login** por CPF apenas, com sessão em `localStorage`.
- **Meus Pedidos**: lista apenas os pedidos do cliente logado, com itens,
  profissional, valores, total e situação.

### Painel Administrativo

Acessível em `/admin`, sem exigir autenticação (controle complementar didático).

- **Dashboard**: totais de clientes, funcionários, produtos, serviços, categorias,
  pedidos por situação, itens em estoque, estoque baixo e valor total dos pedidos.
- **Clientes**: listagem, busca, consulta/edição por ID, exclusão bloqueada quando há pedidos.
- **Funcionários**: CRUD completo (pessoa + funcionário), com cargo e data de admissão.
- **Produtos**: CRUD, busca, filtro por categoria, consulta por ID, desativação/reativação e exclusão.
- **Serviços**: CRUD, busca, filtro por categoria, consulta por ID, desativação/reativação e exclusão.
- **Categorias**: CRUD, busca e consulta por ID (categorias com itens vinculados não podem ser excluídas).
- **Pedidos**: listagem com filtro por situação, busca, consulta por ID, detalhe por ID e alteração de situação.
- **Estoque**: posição atual, alerta de estoque baixo, consulta por ID do produto e registro de entradas com unidade opcional.

### Situações dos pedidos

| Código | Situação |
| --- | --- |
| `A` | Aberto |
| `P` | Em processamento |
| `F` | Concluído |
| `C` | Cancelado |

Transições permitidas: `A → P` ou `A → C`; `P → F` ou `P → C`.
Pedidos concluídos (`F`) ou cancelados (`C`) não podem ser alterados.

## Estrutura do projeto

```
projeto_estetica/
├── AplicacaoBackAula/        # Backend ASP.NET Core 8
│   └── AplicacaoBackAula/
│       ├── Controllers/     # Endpoints da API
│       ├── DTO/             # Objetos de transferência
│       ├── Models/          # Entidades (EF Core)
│       ├── Program.cs       # Configuração da aplicação
│       └── appsettings.json # Connection string
├── estetica/                # Frontend Angular 22
│   ├── src/app/
│   │   ├── loja/            # Componentes da Loja Virtual
│   │   ├── administrativo/  # Componentes do Painel Administrativo (+ layout do painel)
│   │   ├── layout/          # Layout da Loja Virtual
│   │   ├── services/        # Integração com a API
│   │   ├── models/          # Tipos compartilhados
│   │   └── menu/            # Menu da loja
│   ├── public/              # Ícones e arquivos estáticos (ex.: carrinho-de-compras.png)
│   └── README.md            # README específico do frontend
├── Banco de dados/          # Scripts SQL (estrutura, seed e migração)
└── README.md                # Este arquivo
```

## Pré-requisitos

- **Node.js** (versão LTS) e **npm**
- **.NET SDK 8.0**
- **MySQL** ou **MariaDB** (porta padrão usada: `3309`)
- (Opcional) **MySQL Workbench** para executar os scripts SQL

## Como rodar

### 1. Banco de dados

Crie a estrutura e os dados de demonstração:

```bash
mysql -u root -p < "Banco de dados/bd_aula_backend_vfinal.sql"
mysql -u root -p < "Banco de dados/seed_dados.sql"
```

O arquivo `seed_dados.sql` já contém categorias, produtos, serviços,
funcionários, clientes, endereços, estoque e pedidos de exemplo.

Se o banco já existia antes do login por CPF, execute também:

```sql
-- Banco de dados/migracao_login_cpf.sql
USE bd_aula_backend;
ALTER TABLE pessoa MODIFY cpf VARCHAR(11) NOT NULL;
ALTER TABLE pessoa ADD CONSTRAINT uq_pessoa_cpf UNIQUE (cpf);
```

Ajuste a connection string em `AplicacaoBackAula/AplicacaoBackAula/appsettings.json`
(porta, usuário e senha do seu MySQL). Por padrão:

```json
"connection": "server=localhost; port=3309;database=bd_aula_backend;user=root;password=;"
```

### 2. Backend

```bash
cd AplicacaoBackAula/AplicacaoBackAula
dotnet run --urls "http://localhost:5000"
```

> Importante: a API precisa rodar em `http://localhost:5000`, pois o frontend
> está configurado para esse endereço. O comando acima força a porta.
> Execute sempre a partir da pasta do projeto (onde está o `appsettings.json`),
> para que a connection string seja encontrada.

A API sobe em `http://localhost:5000` e o Swagger em `http://localhost:5000/swagger`.

### 3. Frontend

```bash
cd estetica
npm install
npm start
```

Acesse `http://localhost:4200`.

## Login de teste

| CPF | Cliente |
| --- | --- |
| `55566677788` | Ana Beatriz Oliveira (possui pedidos) |

Também é possível entrar com qualquer cliente da base ou criar um novo em **Cadastro**.
O login usa **somente o CPF**. Clientes e funcionários são gerenciados apenas no
Painel Administrativo.

## Rotas do frontend

### Loja

| Rota | Descrição |
| --- | --- |
| `/catalogo` | Produtos |
| `/servicos` | Serviços |
| `/carrinho` | Carrinho e finalização |
| `/cadastro` | Cadastro de cliente |
| `/login` | Login por CPF |
| `/pedidos` | Meus pedidos (protegida) |

### Painel Administrativo

| Rota | Descrição |
| --- | --- |
| `/admin` | Dashboard |
| `/admin/clientes` | Lista de clientes |
| `/admin/clientes/:id` | Edição/consulta de cliente |
| `/admin/funcionarios` | Gestão de funcionários |
| `/admin/produtos` | Gestão de produtos |
| `/admin/servicos` | Gestão de serviços |
| `/admin/categorias` | Gestão de categorias |
| `/admin/pedidos` | Lista e filtro de pedidos |
| `/admin/pedidos/:id` | Detalhe e alteração de situação |
| `/admin/estoque` | Estoque e entradas |

As rotas antigas `/clientes`, `/funcionarios` e `/estoque` redirecionam para o painel.

## Endpoints principais

| Método | Endpoint | Descrição |
| --- | --- | --- |
| `POST` | `/api/PessoaEndereco/login` | Login por CPF |
| `GET` | `/api/PessoaEndereco?apenasClientes=true` | Clientes (sem funcionários) |
| `GET` | `/api/PessoaEndereco/{id}` | Cliente por ID (404 se não existir) |
| `POST/PUT/DELETE` | `/api/PessoaEndereco` | CRUD de clientes |
| `GET` | `/api/Item?tipo=P&idCategoria=1&busca=...` | Catálogo filtrado |
| `GET` | `/api/Item/{id}` | Item do catálogo por ID |
| `GET/POST/PUT/DELETE` | `/api/ProdutoItem` | CRUD de produtos |
| `GET/POST/PUT/DELETE` | `/api/Servico` | CRUD de serviços |
| `GET/POST/PUT/DELETE` | `/api/Categorium` | CRUD de categorias |
| `GET/POST/PUT/DELETE` | `/api/Funcionario` | CRUD de funcionários |
| `GET` | `/api/Atendimento?idPessoa=5&status=A` | Pedidos com filtros |
| `GET` | `/api/Atendimento/{id}` | Pedido por ID (404 se não existir) |
| `POST` | `/api/Atendimento` | Registrar pedido (ajusta estoque) |
| `PATCH` | `/api/Atendimento/{id}/status` | Alterar situação com validação de transição |
| `DELETE` | `/api/Atendimento/{id}` | Excluir pedido (devolve estoque) |
| `GET` | `/api/Estoque` | Posição de estoque |
| `GET` | `/api/Estoque/{id}` | Estoque do produto por ID (404 se não existir) |
| `GET` | `/api/Estoque/entradas` | Últimas entradas |
| `POST` | `/api/Estoque/entrada` | Registrar entrada de produto |
| `GET` | `/api/Dashboard` | Resumo do painel administrativo |

## Observações

- A sessão usa `localStorage` sem JWT, adequada ao escopo didático do projeto.
- A API está liberada para CORS em qualquer origem (`AllowAnyOrigin`), também por simplicidade.
- O banco de exemplo já vem com produtos, serviços, funcionários e pedidos para demonstração.
- Triggers de estoque não são necessários: o backend é a fonte de consistência das
  quantidades ao registrar pedidos, excluir pedidos e lançar entradas.
- O ícone do carrinho (`estetica/public/carrinho-de-compras.png`) é servido
  automaticamente pela pasta `public` do Angular.
