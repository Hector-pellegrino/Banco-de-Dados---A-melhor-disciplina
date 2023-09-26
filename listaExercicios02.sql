delimiter //
create procedure sp_ListarAutores ()
begin
select nome from autor;
end;
//
delimiter ;
call sp_listarautores;

delimiter //
create procedure sp_LivrosPorCategoria(NomeCategoria VARCHAR(100))
begin
select titulo as Livro, nome as Categoria
from livro inner join categoria
where categoria.Nome = NomeCategoria and livro.Categoria_ID = categoria.Categoria_ID;
end;
//
delimiter ;
call sp_LivrosPorCategoria('Romance');
