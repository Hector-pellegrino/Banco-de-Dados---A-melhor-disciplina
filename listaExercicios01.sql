select * from livros;

select nome from autores where nascimento < '1900-00-00';

select livros.titulo, autores.nome from livros
inner join autores 
on livros.autor_id = autores.id and autores.nome = 'J.K. Rowling';

select alunos.nome, matriculas.curso
from alunos
inner join matriculas 
on alunos.id = matriculas.aluno_id and matriculas.curso = 'Engenharia de Software';

select produto, SUM(receita) as receita_total
from vendas
group by produto;

select autores.nome, COUNT(livros.id) as qtd_livros
from autores
left join livros 
on autores.id = livros.autor_id
group by autores.id;

select curso, COUNT(aluno_id) as qtd_alunos
from matriculas 
group by curso;

select produto, AVG(receita) as media
from vendas
group by produto;

select produto, SUM(receita) as receita
from vendas
group by produto
having receita > 10000;

select autores.nome, COUNT(livros.id) as qtd_livros
from autores
inner join livros 
on autores.id = livros.autor_id
group by autores.id
having qtd_livros > 2;

select livros.titulo, autores.nome
from livros
inner join autores on livros.autor_id = autores.id;

select alunos.nome, matriculas.curso
from alunos
inner join matriculas on alunos.id = matriculas.aluno_id; 

select autores.nome, livros.titulo
from autores
left join livros on autores.id = livros.autor_id;
