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
