
# DBT Proof of Concept (POC)

## Descrição

Este repositório contém um projeto de estudo focado no uso do DBT (Data Build Tool). O objetivo deste projeto foi explorar e entender o funcionamento do DBT em um ambiente de modelagem de dados, com foco em transformações, testes de dados e geração de documentação.

O projeto utiliza **PostgreSQL** como banco de dados, em execução em um container **Docker Compose**.

## Tecnologias Utilizadas

- [DBT](https://www.getdbt.com/) - Ferramenta de transformação de dados
- [PostgreSQL](https://www.postgresql.org/) - Banco de dados utilizado
- [Docker Compose](https://docs.docker.com/compose/) - Para orquestrar o ambiente de banco de dados

## Estrutura do Projeto

```bash
.
├── models
│   ├── marts
│   │   ├── dm_brand.sql
│   │   ├── ...
│   ├── staging
│   │   ├── stg_brand.sql
│   │   ├── ...
├── seeds
│   └── seed_store_rank.csv
├── tests
│   ├── test_ft_order.sql
│   ├── test_ft_stock.sql
├── docker-compose.yml
├── dbt_project.yml
└── README.md
```

### Descrição dos Diretórios

- **models/**: Contém os modelos SQL do DBT, divididos em "marts" e "staging".
- **seeds/**: Contém o arquivo `seed_store_rank.csv`, utilizado para carregar dados estáticos.
- **tests/**: Testes customizados para validação de dados nos modelos factuais.
- **docker-compose.yml**: Arquivo de configuração do Docker Compose para subir o banco de dados PostgreSQL.
- **dbt_project.yml**: Arquivo de configuração do projeto DBT.

## Como Configurar o Ambiente

### Pré-requisitos

- Docker e Docker Compose instalados: [Instalação do Docker](https://docs.docker.com/get-docker/)

### Passos para configurar o banco de dados com Docker Compose

1. Subir o container Docker com o PostgreSQL usando o Docker Compose:
   ```bash
   docker-compose up -d
   ```

2. Configure a conexão com o banco de dados no arquivo `profiles.yml` do DBT:

   ```yaml
   default:
     outputs:
       dev:
         type: postgres
         host: localhost
         user: admin
         password: admin
         dbname: poc_dbt
         port: 5432
         schema: public
     target: dev
   ```

## Como Executar o Projeto

### Passos para executar as transformações no DBT

1. **Carregar dados de seed:**
   ```bash
   dbt seed
   ```

2. **Executar as transformações:**
   ```bash
   dbt run
   ```

3. **Rodar os testes de validação:**
   ```bash
   dbt test
   ```

4. **Gerar a documentação:**
   ```bash
   dbt docs generate
   ```

5. **Visualizar a documentação:**
   ```bash
   dbt docs serve
   ```

## Testes Customizados

Existem dois testes customizados localizados na pasta `tests/`:

1. **Testes para o modelo `ft_order`** (`test_ft_order.sql`):
   Verifica se a soma da coluna `quantity` para o `order_id = 2` é igual a 3.

   ```sql
   with validation as (
       select sum(quantity) as sum_val
       from {{ ref('ft_order') }}
       where order_id = 2
   )
   
   select * from validation where sum_val != 3;
   ```

2. **Testes para o modelo `ft_stock`** (`test_ft_stock.sql`):
   Verifica se a soma da coluna `quantity` para `fk_store = 1` é igual a 4532.

   ```sql
   with validation as (
       select sum(quantity) as sum_val
       from {{ ref('ft_stock') }}
       where fk_store = 1
   )
   
   select * from validation where sum_val != 4532;
   ```

## Resultado Esperado

Este projeto demonstra as principais funcionalidades do DBT, incluindo:

- **Transformações de Dados**: Criação de modelos de dados transformados a partir dos dados brutos.
- **Testes de Qualidade de Dados**: Validação dos dados transformados com testes incorporados.
- **Documentação**: Geração e visualização de documentação interativa para os modelos de dados.
