delimiter //
create procedure sp_ListarAutores ()
begin
select nome from autor;
end;
//
delimiter ;
call sp_listarautores;
