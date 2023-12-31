-- exercicio 1 --

DELIMITER //

CREATE FUNCTION total_livros_por_genero(genero VARCHAR(255)) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE livro_id INT;
    DECLARE total INT;
    
    DECLARE cursor_livros CURSOR FOR
	SELECT Livro.id
	FROM Livro
	INNER JOIN Genero ON Livro.id_genero = Genero.id
	WHERE Genero.nome_genero = genero;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    SET total = 0;
    OPEN cursor_livros;
    livros_loop: LOOP
        FETCH cursor_livros INTO livro_id;
        IF done THEN
            LEAVE livros_loop;
        END IF;
        
        SET total = total + 1;
    END LOOP;
    
    CLOSE cursor_livros;
    
    RETURN total;
END//

DELIMITER ;

-- testando --
SELECT total_livros_por_genero('Romance');

-- exercicio 2 --

DELIMITER //

CREATE FUNCTION listar_livros_por_autor(primeiro_nome VARCHAR(150), ultimo_nome VARCHAR(150))
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN
    DECLARE lista_titulos VARCHAR(1000) DEFAULT '';
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE livro_titulo VARCHAR(150);
    
    DECLARE cursor_livro_autor CURSOR FOR
        SELECT Livro_Autor.id_livro
        FROM Livro_Autor
        INNER JOIN Autor ON Livro_Autor.id_autor = Autor.id
        WHERE Autor.primeiro_nome = primeiro_nome AND Autor.ultimo_nome = ultimo_nome;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor_livro_autor;
    livro_autor_loop: LOOP
        FETCH cursor_livro_autor INTO livro_titulo;
        IF done THEN
            LEAVE livro_autor_loop;
        END IF;
        
        SELECT titulo INTO livro_titulo FROM Livro WHERE id = livro_titulo;
        SET lista_titulos = CONCAT(lista_titulos, livro_titulo, ',');
    END LOOP;
    
    CLOSE cursor_livro_autor;
    
    RETURN lista_titulos;
END//

DELIMITER ;

-- testando --
SELECT listar_livros_por_autor('Maria', 'Fernandes');

 -- exercicio 3 --
 
DELIMITER //

CREATE FUNCTION atualizar_resumos()
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE livro_id INT;
    DECLARE resumo_novo VARCHAR(200);
    DECLARE feito VARCHAR(100) DEFAULT '';
    
    DECLARE cursor_resumo_livro CURSOR FOR
        SELECT id, resumo FROM Livro;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor_resumo_livro;
    resumo_loop: LOOP
        FETCH cursor_resumo_livro INTO livro_id, resumo_novo;
        IF done THEN
			SET feito = CONCAT('FEITO');
            LEAVE resumo_loop;
        END IF;
        
        SET resumo_novo = CONCAT(resumo_novo, ' Este é um excelente livro!');
        
        UPDATE Livro
        SET resumo = resumo_novo
        WHERE id = livro_id;
    END LOOP;
    
    CLOSE cursor_resumo_livro;
    
    RETURN feito;
END//

DELIMITER ;

-- testando --
SELECT atualizar_resumos();
SELECT resumo FROM Livro;

-- exercicio 4 --

DELIMITER //

CREATE FUNCTION media_livros_por_editora()
RETURNS DECIMAL(6,2)
DETERMINISTIC
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE t_livro INT DEFAULT 0;
    DECLARE t_editora INT DEFAULT 0;
    DECLARE media_livros_por_editora DECIMAL(6,2) DEFAULT 0;
    
    DECLARE cursor_editora CURSOR FOR
        SELECT id FROM Editora;
    
	DECLARE cursor_livro CURSOR FOR
	    SELECT COUNT(*)
	    FROM Livro
	    WHERE id_editora = t_editora;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cursor_editora;
    editora_loop: LOOP
        FETCH cursor_editora INTO t_editora;
        IF done THEN
            LEAVE editora_loop;
        END IF;
        
        OPEN cursor_livro;
        FETCH cursor_livro INTO t_livro;
        CLOSE cursor_livro;
        
        SET media_livros_por_editora = media_livros_por_editora + (t_livro / (SELECT COUNT(*) FROM Editora));
    END LOOP;
    
    CLOSE cursor_editora;
    
    RETURN media_livros_por_editora;
END//

DELIMITER ;

-- testando --
SELECT media_livros_por_editora();

-- exercicio 5 --

DELIMITER //

CREATE FUNCTION autores_sem_livros()
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE contagem_autor INT;
    DECLARE lista_autores VARCHAR(1000) DEFAULT '';

    DECLARE cursor_autor CURSOR FOR
        SELECT id FROM Autor;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cursor_autor;
    autor_loop: LOOP
        FETCH cursor_autor INTO contagem_autor;
        IF done THEN
            LEAVE autor_loop;
        END IF;
        IF (SELECT COUNT(*) FROM Livro_Autor WHERE id_autor = contagem_autor) = 0 THEN
            SET lista_autores = CONCAT(lista_autores, (SELECT CONCAT(primeiro_nome, ultimo_nome) FROM Autor WHERE id = contagem_autor), ',');
        END IF;
    END LOOP;
    
    CLOSE cursor_autor;
    
    RETURN lista_autores;
END//

DELIMITER ;

-- testando --
INSERT INTO Autor (primeiro_nome, ultimo_nome, data_nascimento, nacionalidade) VALUES
('Cristiano', 'Ronaldo', '1985-02-05', 'Português'),
('Raphael', 'Veiga', '1995-06-19', 'Brasileiro');
SELECT autores_sem_livros();
