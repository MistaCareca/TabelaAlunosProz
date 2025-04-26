-- Criação do banco de dados PROZ
CREATE DATABASE PROZ;
USE PROZ;

-- Criação da tabela ALUNO original
CREATE TABLE ALUNO (
    MATRICULA INT PRIMARY KEY,
    PRIMEIRO_NOME VARCHAR(100) NOT NULL,
    ULTIMO_NOME VARCHAR(100) NOT NULL,
    NOTA DECIMAL(3,1) CHECK (NOTA >= 0 AND NOTA <= 10),
    DISCIPLINA VARCHAR(100),
    SERIE VARCHAR(10)
);

-- Inserção dos dados na tabela ALUNO
INSERT INTO ALUNO (MATRICULA, PRIMEIRO_NOME, ULTIMO_NOME, NOTA, DISCIPLINA, SERIE) 
VALUES 
    (5542, 'Vitória', 'Claudino', 7.0, 'Matemática', '2º ano'),
    (6215, 'Luiz', 'Silva', 8.0, 'Português', '1º ano'),
    (4521, 'André', 'Carvalho', 9.5, 'Matemática', '3º ano'),
    (3285, 'Alan', 'Vilela', 8.0, 'História', '1º ano'),
    (4598, 'Figueiredo', 'Santos', 9.0, 'Geografia', '2º ano');

-- 4. Criação da tabela PROFESSOR
CREATE TABLE PROFESSOR (
    ID_Professor INT PRIMARY KEY,
    PRIMEIRO_NOME VARCHAR(100) NOT NULL,
    ULTIMO_NOME VARCHAR(100) NOT NULL
);

-- Inserindo dados na tabela PROFESSOR
INSERT INTO PROFESSOR (ID_Professor, PRIMEIRO_NOME, ULTIMO_NOME)
VALUES 
    (1, 'Vitória', 'Claudino'),
    (2, 'João', 'Oliveira'),
    (3, 'Luiz', 'Silva');

-- 1. Alunos aprovados (nota > 7.0)
SELECT * 
FROM ALUNO 
WHERE NOTA > 7
ORDER BY NOTA DESC;

-- 2. Alunos do 1º ano com nota >= 8.0
SELECT * 
FROM ALUNO 
WHERE NOTA >= 8
AND SERIE = '1º ano';

-- 3. Exibir apenas nomes e notas
SELECT NOTA,
CONCAT(PRIMEIRO_NOME, ' ', ULTIMO_NOME) AS Nome 
FROM ALUNO
ORDER BY Nome;

-- 5. Criar tabela ALUNO_NOMES com apenas primeiro e último nome
CREATE TABLE ALUNO_NOMES (
    PRIMEIRO_NOME VARCHAR(100),
    ULTIMO_NOME VARCHAR(100)
);

-- Inserir os dados de nomes da tabela ALUNO
INSERT INTO ALUNO_NOMES (PRIMEIRO_NOME, ULTIMO_NOME)
SELECT PRIMEIRO_NOME, ULTIMO_NOME
FROM ALUNO;

-- 6. União entre ALUNO_NOMES e PROFESSOR
SELECT CONCAT(PRIMEIRO_NOME, ' ', ULTIMO_NOME) AS Nome
FROM ALUNO_NOMES
UNION
SELECT CONCAT(PRIMEIRO_NOME, ' ', ULTIMO_NOME)
FROM PROFESSOR;

-- 7. Interseção entre ALUNO_NOMES e PROFESSOR
SELECT CONCAT(a.PRIMEIRO_NOME, ' ', a.ULTIMO_NOME) AS Nome
FROM ALUNO_NOMES a
INNER JOIN PROFESSOR p
ON a.PRIMEIRO_NOME = p.PRIMEIRO_NOME AND a.ULTIMO_NOME = p.ULTIMO_NOME;

-- 8. Diferença entre ALUNO_NOMES e PROFESSOR
SELECT CONCAT(a.PRIMEIRO_NOME, ' ', a.ULTIMO_NOME) AS Nome
FROM ALUNO_NOMES a
LEFT JOIN PROFESSOR p
ON a.PRIMEIRO_NOME = p.PRIMEIRO_NOME AND a.ULTIMO_NOME = p.ULTIMO_NOME
WHERE p.ID_Professor IS NULL;