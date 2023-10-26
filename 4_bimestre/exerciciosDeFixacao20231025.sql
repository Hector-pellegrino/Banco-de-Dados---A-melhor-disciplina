-- ecercicico 1 --

CREATE TRIGGER msg_auditoria
	AFTER INSERT
	ON Clientes FOR EACH ROW
	INSERT INTO Auditoria (mensagem, data_hora)
	VALUES ('INSERT FEITO', NOW());

INSERT INTO Clientes (nome)
VALUES ('VEIGA');
SELECT * FROM Auditoria;

-- ecercicico 2 --

CREATE TRIGGER tentativa_exclusão
	BEFORE DELETE
	ON Clientes FOR EACH ROW
	INSERT INTO Auditoria (mensagem, data_hora)
	VALUES ('TENTATIVA DE EXCLUSÃO FEITA', NOW());
    
DELETE FROM Clientes where nome = 'VEIGA';

SELECT * FROM Auditoria where mensagem = 'TENTATIVA DE EXCLUSÃO FEITA';

-- ecercicico 3 --
CREATE TRIGGER atualizar_nome
	AFTER UPDATE
	ON Clientes FOR EACH ROW
	INSERT INTO Auditoria (mensagem, data_hora)
	VALUES (concat(OLD.nome, ' ', NEW.nome), NOW());

UPDATE Clientes
SET nome = 'RAPHAEL'
WHERE nome = 'VEIGA' ;

SELECT * FROM Clientes;
SELECT * FROM Auditoria;

-- exercicio 4 -- 

DELIMITER //
CREATE TRIGGER not_null
AFTER UPDATE
ON Clientes FOR EACH ROW
BEGIN 
	DECLARE new_nome VARCHAR(255);
    SET new_nome = (SELECT nome from Clientes);
	IF new_nome = '' then
		UPDATE Clientes
		SET nome = OLD.nome;
        INSERT INTO Auditoria (mensagem, data_hora)
		VALUES ('UPDATE para NULL', NOW());
    end if;
END;
//
DELIMITER ;

UPDATE Clientes
SET nome = ''
WHERE nome = 'RAPHAEL' ;

-- exercicio 5 -- 

DELIMITER //
CREATE TRIGGER pedido
BEFORE INSERT 
ON Pedidos FOR EACH ROW
begin
DECLARE estoque2 INT;
UPDATE Produtos 
SET estoque = estoque - NEW.quantidade 
WHERE id = NEW.produto_id;
SET estoque2 = (SELECT estoque FROM Produtos WHERE id = NEW.produto_id);
IF estoque2 < 5 THEN
		INSERT INTO Auditoria (mensagem, data_hora) 
        VALUES ('ESTOQUE COM MENOS DE 5', NOW());
END IF;
end;
//
DELIMITER ;

insert into produtos 
values (null, 'camisa', 6);

insert into Pedidos
value (null, 1, 2);
