# PROZ - Sistema de Gerenciamento de Alunos e Professores

## Introdução
Este projeto é uma atividade prática do curso **Proz Talento Cloud**, desenvolvida para consolidar conhecimentos em SQL. O sistema **PROZ** gerencia informações de alunos e professores por meio de um banco de dados relacional, utilizando o script `tabelaAluno.sql`. A atividade aborda conceitos como criação de tabelas, inserção de dados, consultas com filtros, junções e operações de conjunto (união, interseção e diferença).

---

## Objetivos da Atividade
- Criar o banco de dados **PROZ** com tabelas para alunos e professores.
- Inserir dados de alunos com base em uma tabela fornecida (matrícula, nome, nota, disciplina e série).
- Executar consultas específicas:
  - Listar alunos aprovados (nota > 7.0).
  - Filtrar alunos do 1º ano com nota ≥ 8.0.
  - Exibir nomes completos e notas dos alunos.
- Criar tabelas derivadas com nomes de alunos e professores.
- Realizar operações de conjunto entre nomes de alunos e professores.

---

## Estrutura do Banco de Dados

### Tabelas

#### 1. ALUNO
Armazena informações completas dos alunos.

| Coluna          | Tipo                | Restrições                          | Descrição                          |
|-----------------|---------------------|-------------------------------------|------------------------------------|
| MATRICULA       | INT                 | PRIMARY KEY                         | Identificador único do aluno       |
| PRIMEIRO_NOME   | VARCHAR(100)        | NOT NULL                            | Primeiro nome do aluno             |
| ULTIMO_NOME     | VARCHAR(100)        | NOT NULL                            | Sobrenome do aluno                 |
| NOTA            | DECIMAL(3,1)        | CHECK (NOTA >= 0 AND NOTA <= 10)    | Nota do aluno (ex.: 9.5)           |
| DISCIPLINA      | VARCHAR(100)        |                                     | Disciplina cursada                 |
| SERIE           | VARCHAR(10)         |                                     | Série escolar (ex.: 2º ano)        |

#### 2. PROFESSOR
Armazena informações dos professores.

| Coluna          | Tipo                | Restrições                          | Descrição                          |
|-----------------|---------------------|-------------------------------------|------------------------------------|
| ID_PROFESSOR    | INT                 | PRIMARY KEY                         | Identificador único do professor   |
| PRIMEIRO_NOME   | VARCHAR(100)        | NOT NULL                            | Primeiro nome do professor         |
| ULTIMO_NOME     | VARCHAR(100)        | NOT NULL                            | Sobrenome do professor             |

#### 3. ALUNO_NOMES
Contém apenas os nomes dos alunos, extraídos da tabela **ALUNO**.

| Coluna          | Tipo                | Restrições                          | Descrição                          |
|-----------------|---------------------|-------------------------------------|------------------------------------|
| PRIMEIRO_NOME   | VARCHAR(100)        |                                     | Primeiro nome do aluno             |
| ULTIMO_NOME     | VARCHAR(100)        |                                     | Sobrenome do aluno                 |

---

## Conteúdo do Script SQL (`tabelaAluno.sql`)

O script `tabelaAluno.sql` inclui:

1. **Criação do Banco de Dados e Tabelas**:
   - Criação do banco **PROZ**.
   - Definição das tabelas **ALUNO**, **PROFESSOR** e **ALUNO_NOMES**.

2. **Inserção de Dados**:
   - 5 registros na tabela **ALUNO**, conforme tabela fornecida.
   - 3 registros fictícios na tabela **PROFESSOR**.
   - Extração de nomes da tabela **ALUNO** para **ALUNO_NOMES**.

3. **Consultas e Operações**:
   - Alunos com nota > 7.0 (aprovados).
   - Alunos do 1º ano com nota ≥ 8.0.
   - Exibição de nomes completos e notas.
   - Operações de conjunto:
     - **União**: Nomes distintos de **ALUNO_NOMES** e **PROFESSOR**.
     - **Interseção**: Nomes comuns às duas tabelas.
     - **Diferença**: Nomes exclusivos de **ALUNO_NOMES**.

**Nota**: Em SGBDs como MySQL, que não suportam `INTERSECT` ou `EXCEPT`, o script usa `JOIN` como alternativa.

---

## Pré-requisitos
- **SGBD**: MySQL, PostgreSQL, SQL Server ou similar.
- **Ferramentas**: Cliente SQL (ex.: MySQL Workbench, DBeaver) ou linha de comando.
- **Conhecimento**: Comandos básicos de SQL (CREATE, INSERT, SELECT, JOIN).

---

4. **Verificar Resultados**:
   - As consultas são executadas automaticamente, e os resultados aparecem no console ou cliente SQL.

---

## Dados Inseridos

### Tabela ALUNO
| MATRICULA | PRIMEIRO_NOME | ULTIMO_NOME | NOTA | DISCIPLINA   | SERIE   |
|-----------|---------------|-------------|------|--------------|---------|
| 5542      | Vitória       | Claudino    | 7.0  | Matemática   | 2º ano  |
| 6215      | Luiz          | Silva       | 8.0  | Português    | 1º ano  |
| 4521      | André         | Carvalho    | 9.5  | Matemática   | 3º ano  |
| 3285      | Alan          | Vilela      | 8.0  | História     | 1º ano  |
| 4598      | Figueiredo    | Santos      | 9.0  | Geografia    | 2º ano  |

### Tabela PROFESSOR
| ID_PROFESSOR | PRIMEIRO_NOME | ULTIMO_NOME |
|--------------|---------------|-------------|
| 1            | Vitória       | Claudino    |
| 2            | João          | Oliveira    |
| 3            | Luiz          | Silva       |

---

## Consultas Realizadas

1. **Alunos Aprovados (Nota > 7.0)**:
   - SQL: `SELECT * FROM ALUNO WHERE NOTA > 7.0;`

2. **Alunos do 1º Ano com Nota ≥ 8.0**:
   - SQL: `SELECT * FROM ALUNO WHERE SERIE = '1º ano' AND NOTA >= 8.0;`

3. **Nomes Completos e Notas**:
   - SQL: `SELECT CONCAT(PRIMEIRO_NOME, ' ', ULTIMO_NOME) AS NOME_COMPLETO, NOTA FROM ALUNO;`

4. **Operações de Conjunto**:
   - **União**:
     ```sql
     SELECT PRIMEIRO_NOME, ULTIMO_NOME FROM ALUNO_NOMES
     UNION
     SELECT PRIMEIRO_NOME, ULTIMO_NOME FROM PROFESSOR;
     ```
   - **Interseção** (usando JOIN no MySQL):
     ```sql
     SELECT A.PRIMEIRO_NOME, A.ULTIMO_NOME
     FROM ALUNO_NOMES A
     INNER JOIN PROFESSOR P
     ON A.PRIMEIRO_NOME = P.PRIMEIRO_NOME AND A.ULTIMO_NOME = P.ULTIMO_NOME;
     ```
   - **Diferença** (usando LEFT JOIN no MySQL):
     ```sql
     SELECT A.PRIMEIRO_NOME, A.ULTIMO_NOME
     FROM ALUNO_NOMES A
     LEFT JOIN PROFESSOR P
     ON A.PRIMEIRO_NOME = P.PRIMEIRO_NOME AND A.ULTIMO_NOME = P.ULTIMO_NOME
     WHERE P.ID_PROFESSOR IS NULL;
     ```

---

## Resultados Esperados

- **Alunos Aprovados**: Luiz Silva, André Carvalho, Alan Vilela, Figueiredo Santos.
- **Alunos do 1º Ano (Nota ≥ 8.0)**: Luiz Silva, Alan Vilela.
- **União**: Vitória Claudino, Luiz Silva, André Carvalho, Alan Vilela, Figueiredo Santos, João Oliveira.
- **Interseção**: Vitória Claudino, Luiz Silva.
- **Diferença**: André Carvalho, Alan Vilela, Figueiredo Santos.

---
