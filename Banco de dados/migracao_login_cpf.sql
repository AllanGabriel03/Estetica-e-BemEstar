-- Migracao: login por CPF
-- 1) CPF passa a ser texto (preserva zeros a esquerda e formatacao de 11 digitos)
-- 2) CPF unico por pessoa
-- Execute uma vez no banco bd_aula_backend.

USE bd_aula_backend;

ALTER TABLE pessoa MODIFY cpf VARCHAR(11) NOT NULL;

ALTER TABLE pessoa ADD CONSTRAINT uq_pessoa_cpf UNIQUE (cpf);
