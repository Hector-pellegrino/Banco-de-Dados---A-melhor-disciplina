select * from livros;

select nome from autores where nascimento < '1900-00-00';

select livros.titulo, autores.nome from livros
inner join autores 
on livros.autor_id = autores.id and autores.nome = 'J.K. Rowling';

select alunos.nome, matriculas.curso
from alunos
inner join matriculas 
on alunos.id = matriculas.aluno_id and matriculas.curso = 'Engenharia de Software';
