CREATE DATABASE funcoes;
use funcoes;

create table nomes (
	nome varchar(50)
);

insert into nomes
values ('Roberta'), ('Roberto'), ('Maria Clara'), ('João');

select upper(nome) from nomes;

select length(nome) from nomes;

select concat('Sr.', nome) as masculino from nomes where nome like '%o' ;

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


