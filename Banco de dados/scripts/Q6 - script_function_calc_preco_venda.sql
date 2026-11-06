
DELIMITER //
CREATE FUNCTION `fn_calc_preco_venda`(codigo_preco int, preco_custo decimal(10,2)) 
RETURNS decimal(10,2)
DETERMINISTIC
begin
	declare calcValor decimal(10,2);
	
    case codigo_preco
		when 1 then
			set calcValor = preco_custo + (preco_custo * 0.04);
		when 2 then
			set calcValor = preco_custo + (preco_custo * 0.08);
		when 3 then
			set calcValor = preco_custo + (preco_custo * 0.10);
		else
			set calcValor = preco_custo;
	end case;
    
    return calcValor;    
end //

delimiter ;