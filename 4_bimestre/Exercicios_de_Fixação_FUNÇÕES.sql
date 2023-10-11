CREATE DATABASE funcoes;
use funcoes;

create table nomes (
	nome varchar(50)
);

insert into nomes
values ('Roberta'), ('Roberto'), ('Maria Clara'), ('João');

select upper(nome) from nomes;

select length(nome) from nomes;

select
	case
		WHEN nome LIKE '%a' THEN CONCAT('Sra. ', nome) 
		ELSE CONCAT('Sr. ', nome)
	end as Senhores_e_senhoras
from nomes;

-- exercicio 2 --

CREATE TABLE produtos (
    produto VARCHAR(50),
    preco DECIMAL(6, 2),
    quantidade INT
);

INSERT INTO produtos
VALUES
    ('Chuteira', 599.99, 40),
    ('Camisa Palmeiras', 399.99, 50),
    ('short Palmeiras', 75.50, 100),
    ('Meiao Palmeiras', 49.99, 30);

SELECT produto, ROUND(preco, 2) AS preço FROM produtos;

SELECT ABS(quantidade) AS quantidade_abs FROM produtos;

SELECT AVG(preco) AS media FROM produtos;

-- exercicio 3 --
select * from eventos;
create table eventos (
	data_evento DATE
);

INSERT INTO eventos
VALUES 
	('1985-02-05'), ('1995-06-19'), ('2006-09-26');

INSERT INTO eventos
VALUES 
	(NOW());

SELECT DATEDIFF('2006-09-26','1995-06-19' ) as dias;

SELECT data_evento,DAYNAME(data_evento) as dia_da_semana from eventos;

-- exercicio 4 --
SELECT
    produto,
    quantidade,
    IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS estoque
FROM produtos;

SELECT
    produto,
    preco,
    CASE
        WHEN preco <= 50.00 THEN 'Barato'
        WHEN preco > 50.00 AND preco <= 100.00 THEN 'Médio'
        ELSE 'Caro'
    END AS categoria_de_preco
FROM produtos;

-- exercicio 5 --

DELIMITER //

CREATE FUNCTION TOTAL_VALOR (preco DECIMAL(6, 2), quantidade INT)
RETURNS DECIMAL(8, 2)
DETERMINISTIC
BEGIN 
    RETURN preco * quantidade;
END;

//

SELECT
    produto,
    preco,
    quantidade,
    TOTAL_VALOR(preco, quantidade) AS total_valor
FROM produtos;	

-- exercicio 6 --

SELECT COUNT(*) AS total_produtos FROM produtos;

SELECT MAX(preco) AS maior_preco FROM produtos;

SELECT MIN(preco) AS menor_preco FROM produtos;

SELECT SUM(IF(quantidade > 0, quantidade, 0)) AS total_estoque FROM produtos;
