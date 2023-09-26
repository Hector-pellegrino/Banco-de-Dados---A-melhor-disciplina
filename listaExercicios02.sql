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


delimiter //
create procedure sp_ContarLivrosPorCategoria(NomeCategoria VARCHAR(100))
begin
select nome as Categoria, COUNT(*) AS QUANTIDADE
from livro inner join categoria
where categoria.Nome = NomeCategoria and livro.Categoria_ID = categoria.Categoria_ID
group by categoria.Nome;
end;
//
delimiter ; 
call sp_ContarLivrosPorCategoria('Romance');

delimiter //
create procedure sp_VerificarLivrosCategoria( IN NomeCategoria VARCHAR(100), OUT possui VARCHAR(100))
begin
    DECLARE Quantidade INT;
	SELECT COUNT(*) INTO Quantidade 
    FROM Livro INNER JOIN Categoria 
    ON Categoria.Categoria_ID = Livro.Categoria_ID 
    WHERE Categoria.Nome = NomeCategoria 
    GROUP BY Nome;
    IF Quantidade > 0 THEN SET possui = 'Possui';
    ELSE SET possui = 'Não possui';
	end if;
end
//
delimiter ;
call sp_VerificarLivrosCategoria('Palmeiras', @livros);
SELECT @livros;

DELIMITER //
CREATE PROCEDURE sp_LivrosAteAno(IN ano INT)
BEGIN
select titulo as Livro, Ano_Publicacao
from livro
WHERE Ano_Publicacao <= ano;
END //
DELIMITER ;
CALL sp_LivrosAteAno(2006);
