-- Comentário --
-- CREATE DATABASE IF NOT EXISTS mundo; --> Criação do Banco de dados -- 

-- Criação de Tabelas -- 
CREATE TABLE IF NOT EXISTS pais(
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50) NOT NULL DEFAULT'',
    continente ENUM('Ásia', 'Europa', 'América', 'África', 'Oceania', 'Antártida') 
	NOT NULL DEFAULT 'América', 
	codigo CHAR(3) NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS estados(
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50) NOT NULL DEFAULT'',
	sigla CHAR(2) NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS cidade(
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL DEFAULT '',
    populacao INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE IF NOT EXISTS ponto_tur(
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL DEFAULT '',
	populacao INT(11) NOT NULL DEFAULT '0',
	tipo ENUM ('Atrativo','Serviço', 'Equipamento', 'Infraestrtutura','Instituição','Restaurante'),
	publicado ENUM('Não','Sim') NOT NULL DEFAULT 'Não');
    
CREATE TABLE IF NOT EXISTS coordernada(
	latitude FLOAT(10.6), lingitude FLOAT(10.6)
);

-- INSERÇÃO DE DADOS --

INSERT INTO pais (nome, continente, codigo)
	VALUES ('Brasil','América','BRA'),
    ('Índia','Ásia', 'IDN'),('China','Ásia','CHI'),('Japão', 'Ásia', 'JPN');
    
INSERT INTO estados(nome, sigla) 
	VALUES ('Mato Grosso', 'MT'), ('Mato Grosso do Sul','MS');
    
INSERT INTO cidade(nome,populacao)
	VALUES ('Sorocaba', 700000),('Delí',26000000),('Xangai', 22000000),('Tóquio', 38000000); 

INSERT INTO ponto_tur (nome,tipo)
	VALUES ('Quinzinho de Barros', 'Instituição'),('Parque Estadual do Jalapão', 'Atrativo'),
    ('Torre Eiffel', 'Atrativo'), ('Fogo de Chão','Restaurante');
    
INSERT INTO estados (nome, sigla)
	VALUES('Não é um estado', 'NO');

-- EDIÇÃO DE DADOS
UPDATE pais 
	SET codigo = 'IND' WHERE id =2; -- > Corrige a sigla IDN da índia para IND
    
DELETE FROM  estados
	WHERE id =13; -- > Exclui 'Brasilia' através do ID
    
DELETE FROM estados
	WHERE nome=	'Não é um estado' and id=29; -- Tentei com o nome apenas mas esta em safe mode. Adicionando o numero do ID posso deletar

-- CONSULTA DE DADOS --

SELECT nome FROM estados
ORDER BY nome  ASC; -- > Ordem CRESCENTE

-- SELECT nome FROM clientes ORDER BY nome DESC; > Ordem DECRESCENTE

-- RENAME TABLE nome_antigo TO nome_novo; > Renomeia apenas o nome da coluna