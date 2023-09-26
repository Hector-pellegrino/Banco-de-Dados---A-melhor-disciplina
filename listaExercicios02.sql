-- exercicio 1
delimiter //
create procedure sp_ListarAutores ()
begin
select nome from autor;
end;
//
delimiter ;
call sp_listarautores;

-- exercicio 2
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

-- exercicio 3
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

-- exercicio 4
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

-- exercicio 5
delimiter //
CREATE PROCEDURE sp_LivrosAteAno(IN ano INT)
BEGIN
select titulo as Livro, Ano_Publicacao
from livro
WHERE Ano_Publicacao <= ano;
END //
delimiter ;
CALL sp_LivrosAteAno(2006);

-- exercicio 6
delimiter //
create procedure sp_TitulosPorCategoria(NomeCategoria VARCHAR(100))
begin
select titulo as Livro, nome as Categoria
from livro inner join categoria
where categoria.Nome = NomeCategoria and livro.Categoria_ID = categoria.Categoria_ID;
end;
//
delimiter ;
call sp_TitulosPorCategoria('Ciencia')

-- exercicio 7
delimiter //
CREATE PROCEDURE sp_AdicionarLivro(IN Novo_Titulo VARCHAR(255), IN Novo_Editora_ID INT, IN Novo_Ano_Publicacao INT, IN Novo_Numero_Paginas INT, IN Novo_Categoria_ID INT, OUT resultado Varchar(100))
begin 
	DECLARE testarSeExiste INT;
	SELECT COUNT(*) INTO testarSeExiste FROM Livro WHERE Titulo = Novo_Titulo;
	IF testarSeExiste > 0 THEN 
		SET resultado = 'Erro: Livro existente';
	ELSE
		INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
		VALUES (Novo_Titulo, Novo_Editora_ID, Novo_Ano_Publicacao, Novo_Numero_Paginas, Novo_Categoria_ID);
		SET resultado = 'Livro adicionado com sucesso';
	END IF;
end;
delimiter ;
CALL sp_AdicionarLivro('Livro Palmeiras', 1, 1914, 300, 4, @resultado);
SELECT @resultado;

-- exercicio 8
delimiter //

CREATE PROCEDURE sp_AutorMaisAntigo(OUT AutorMaisAntigo VARCHAR(255))
BEGIN
	DECLARE data_nasc DATE;
	SELECT MIN(Data_Nascimento) INTO data_nasc FROM Autor;
	SELECT Nome INTO AutorMaisAntigo
	FROM Autor
	WHERE Data_Nascimento = data_nasc;
END //

delimiter ;
CALL sp_AutorMaisAntigo(@AutorMaisAntigo);
SELECT @AutorMaisAntigo;

-- exercicio 9
delimiter //
-- criando a procedure e colocando "AutorMaisAntigo" como parâmetro de saída
CREATE PROCEDURE sp_AutorMaisAntigo(OUT AutorMaisAntigo VARCHAR(255)) 
BEGIN
-- declarei a variável "data_nasc" e depois guardei dentro dela a data de nascimento mais antiga registrada na tabela autor utilizando a função de agregação "MIN()" que encontra o menor valor
    DECLARE data_nasc DATE;
    SELECT MIN(Data_Nascimento) INTO data_nasc FROM Autor;
-- selecionei o nome do autor quando a data de nascimento dele for igual a variável "data_nasc" (que contém a data de nascimento mais antiga) e guardei dentro do parâmetro de saída para que seja o resultado quando a stored procedure for chamada 
    SELECT Nome INTO AutorMaisAntigo
    FROM Autor
    WHERE Data_Nascimento = data_nasc;
END //

delimiter ;

-- exercicio 10
delimiter //

CREATE PROCEDURE sp_LivrosESeusAutores()
BEGIN
    SELECT Livro.Titulo, Autor.Nome, Autor.Sobrenome
    FROM Livro
    INNER JOIN Autor_Livro ON Livro.Livro_ID = Autor_Livro.Livro_ID
    INNER JOIN Autor ON Autor_Livro.Autor_ID = Autor.Autor_ID;
END //

delimiter ;
CALL sp_LivrosESeusAutores();
