select * from produto;

select * from estoque;

delimiter //
create trigger tr_addestoque
after insert on produto
for each row
begin
	insert into estoque
		(iditem, quantidade_estoque)
	values
		(new.iditem, 0);
end //
delimiter ;