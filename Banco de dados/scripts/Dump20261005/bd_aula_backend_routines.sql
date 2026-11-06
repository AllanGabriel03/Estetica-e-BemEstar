-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bd_aula_backend
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `vw_pessoa_endereco`
--

DROP TABLE IF EXISTS `vw_pessoa_endereco`;
/*!50001 DROP VIEW IF EXISTS `vw_pessoa_endereco`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_pessoa_endereco` AS SELECT 
 1 AS `idpessoa`,
 1 AS `nome`,
 1 AS `cpf`,
 1 AS `telefone`,
 1 AS `email`,
 1 AS `cep`,
 1 AS `numero`,
 1 AS `complemento`,
 1 AS `ativo_pessoa`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_funcionario_endereco`
--

DROP TABLE IF EXISTS `vw_funcionario_endereco`;
/*!50001 DROP VIEW IF EXISTS `vw_funcionario_endereco`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_funcionario_endereco` AS SELECT 
 1 AS `idpessoa`,
 1 AS `nome`,
 1 AS `cpf`,
 1 AS `telefone`,
 1 AS `email`,
 1 AS `cargo`,
 1 AS `cep`,
 1 AS `numero`,
 1 AS `complemento`,
 1 AS `data_admissao`,
 1 AS `ativo_pessoa`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_servico_categoria`
--

DROP TABLE IF EXISTS `vw_servico_categoria`;
/*!50001 DROP VIEW IF EXISTS `vw_servico_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_servico_categoria` AS SELECT 
 1 AS `iditem`,
 1 AS `item`,
 1 AS `descricao_item`,
 1 AS `preco`,
 1 AS `categoria`,
 1 AS `ativo_produto_servico`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_atendimento`
--

DROP TABLE IF EXISTS `vw_atendimento`;
/*!50001 DROP VIEW IF EXISTS `vw_atendimento`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_atendimento` AS SELECT 
 1 AS `idatendimento`,
 1 AS `data_atendimento`,
 1 AS `status_atendimento`,
 1 AS `nome`,
 1 AS `telefone`,
 1 AS `email`,
 1 AS `cpf`,
 1 AS `item`,
 1 AS `quantidade_itens`,
 1 AS `valorunitario_entrada`,
 1 AS `nome_funcionario`,
 1 AS `cargo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_produto_categoria`
--

DROP TABLE IF EXISTS `vw_produto_categoria`;
/*!50001 DROP VIEW IF EXISTS `vw_produto_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_produto_categoria` AS SELECT 
 1 AS `iditem`,
 1 AS `item`,
 1 AS `descricao_item`,
 1 AS `codigo_preco`,
 1 AS `preco`,
 1 AS `preco_venda`,
 1 AS `unidade`,
 1 AS `categoria`,
 1 AS `quantidade_estoque`,
 1 AS `ativo_produto_servico`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_pessoa_endereco`
--

/*!50001 DROP VIEW IF EXISTS `vw_pessoa_endereco`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_pessoa_endereco` AS select `p`.`idpessoa` AS `idpessoa`,`p`.`nome` AS `nome`,`p`.`cpf` AS `cpf`,`p`.`telefone` AS `telefone`,`p`.`email` AS `email`,`e`.`cep` AS `cep`,`e`.`numero` AS `numero`,`e`.`complemento` AS `complemento`,`p`.`ativo_pessoa` AS `ativo_pessoa` from (`pessoa` `p` left join `endereco` `e` on((`p`.`idpessoa` = `e`.`idpessoa`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_funcionario_endereco`
--

/*!50001 DROP VIEW IF EXISTS `vw_funcionario_endereco`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_funcionario_endereco` AS select `p`.`idpessoa` AS `idpessoa`,`p`.`nome` AS `nome`,`p`.`cpf` AS `cpf`,`p`.`telefone` AS `telefone`,`p`.`email` AS `email`,`f`.`cargo` AS `cargo`,`e`.`cep` AS `cep`,`e`.`numero` AS `numero`,`e`.`complemento` AS `complemento`,`f`.`data_admissao` AS `data_admissao`,`p`.`ativo_pessoa` AS `ativo_pessoa` from ((`pessoa` `p` left join `funcionario` `f` on((`p`.`idpessoa` = `f`.`idpessoa`))) join `endereco` `e` on((`f`.`idpessoa` = `e`.`idpessoa`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_servico_categoria`
--

/*!50001 DROP VIEW IF EXISTS `vw_servico_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_servico_categoria` AS select `i`.`iditem` AS `iditem`,`i`.`item` AS `item`,`i`.`descricao_item` AS `descricao_item`,`i`.`preco` AS `preco`,`c`.`categoria` AS `categoria`,`i`.`ativo_produto_servico` AS `ativo_produto_servico` from (`item` `i` join `categoria` `c` on((`i`.`idcategoria` = `c`.`idcategoria`))) where (`i`.`tipo_item` = 'S') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_atendimento`
--

/*!50001 DROP VIEW IF EXISTS `vw_atendimento`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_atendimento` AS select `a`.`idatendimento` AS `idatendimento`,`a`.`data_atendimento` AS `data_atendimento`,`a`.`status_atendimento` AS `status_atendimento`,`p`.`nome` AS `nome`,`p`.`telefone` AS `telefone`,`p`.`email` AS `email`,`p`.`cpf` AS `cpf`,`i`.`item` AS `item`,`ai`.`quantidade_itens` AS `quantidade_itens`,`ai`.`valorunitario_entrada` AS `valorunitario_entrada`,`pf`.`nome` AS `nome_funcionario`,`f`.`cargo` AS `cargo` from (((((`atendimento` `a` join `pessoa` `p` on((`a`.`idpessoa` = `p`.`idpessoa`))) join `atendimentoitem` `ai` on((`a`.`idatendimento` = `ai`.`idatendimento`))) join `item` `i` on((`i`.`iditem` = `ai`.`iditem`))) join `funcionario` `f` on((`ai`.`idfuncionario` = `f`.`idpessoa`))) join `pessoa` `pf` on((`pf`.`idpessoa` = `f`.`idpessoa`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_produto_categoria`
--

/*!50001 DROP VIEW IF EXISTS `vw_produto_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_produto_categoria` AS select `i`.`iditem` AS `iditem`,`i`.`item` AS `item`,`i`.`descricao_item` AS `descricao_item`,`p`.`codigo_preco` AS `codigo_preco`,`i`.`preco` AS `preco`,`p`.`preco_venda` AS `preco_venda`,`p`.`unidade` AS `unidade`,`c`.`categoria` AS `categoria`,`e`.`quantidade_estoque` AS `quantidade_estoque`,`i`.`ativo_produto_servico` AS `ativo_produto_servico` from (((`item` `i` join `produto` `p` on((`i`.`iditem` = `p`.`iditem`))) join `estoque` `e` on((`p`.`iditem` = `e`.`iditem`))) join `categoria` `c` on((`i`.`idcategoria` = `c`.`idcategoria`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'bd_aula_backend'
--

--
-- Dumping routines for database 'bd_aula_backend'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_calc_preco_venda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calc_preco_venda`(codigo_preco int, preco_custo decimal(10,2)) RETURNS decimal(10,2)
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pr_atendimento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_atendimento`(in p_idpessoa int, in p_itens_selecionados json)
begin
	-- DECLARAÇÃO DE VARIÁVEL PARA PEGAR O ID GERADO
    declare idatendimento_gerado int;
    
    -- Aqui captura qualquer erro e desfaz a transação
    declare exit handler for sqlexception
    begin
		rollback;
        resignal;
    end;
    
    start transaction;
    
    -- INSERIR OS DADOS NA TABELA DE ATENDIMENTO
    insert into atendimento
		(idpessoa, data_atendimento, status_atendimento)
	values
		(p_idpessoa, curdate(), 'A');  
        
	-- PEGANDO O ID GERADO DA TABELA atendimento
    set idatendimento_gerado = last_insert_id();
    
    -- INSERINDO OS DADOS, EM LOTE SET-BASED, NA TABELA ATENDIMENTO_SERVICO
    insert into atendimentoitem
		(idatendimento, iditem, idfuncionario, quantidade_itens, valorunitario_entrada)
	select
		idatendimento_gerado, iditem, idfuncionario, quantidade_itens, valorunitario_entrada
	from 
		json_table(
			p_itens_selecionados, 
            '$[*]'columns(
				iditem int path '$.iditem',
				idfuncionario int path '$.idfuncionario',
				quantidade_itens int path '$.quantidade_itens',
				valorunitario_entrada decimal(10,2) path '$.valorunitario_entrada'
			) 
		) as carrinho;
    
    -- CONFIRMAR 
    commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pr_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_funcionario`(in pessoa json)
begin
	declare idpessoa_gerado int;

	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
    end;
    
    start transaction;
    
	insert into pessoa
		(nome, cpf, data_nascimento, sexo, email, telefone, ativo_pessoa)
	select
		nome, cpf, data_nascimento, sexo, email, telefone, ativo_pessoa
	from
		json_table(pessoa,'$' columns(
			nome varchar(100) path '$.nome',
            cpf bigint(11) path '$.cpf',
            data_nascimento date path '$.data_nascimento',
            sexo char(1) path '$.sexo',
            email varchar(100) path '$.email',
            telefone bigint(11) path '$.telefone',
            ativo_pessoa char(1) path '$.ativo')			
        ) as p;
        
	set idpessoa_gerado = last_insert_id();
    
    insert into funcionario
		(idpessoa, cargo, data_admissao)
	select
		idpessoa_gerado, cargo, data_admissao
	from
		json_table(pessoa,'$' columns(
            cargo varchar(20) path '$.cargo',
            data_admissao date path '$.data_admissao')
        ) as f;
    
    insert into endereco
		(idpessoa, cep, numero, complemento)
	select
		idpessoa_gerado, cep, numero, complemento
	from
		json_table(pessoa, '$.enderecos[*]' columns(
			cep int path '$.cep',
            numero char(8) path '$.numero',
            complemento varchar(150) path '$.complemento')
        ) as e;
    commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pr_pessoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_pessoa`(in pessoa json)
begin
	declare idpessoa_gerado int;

	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
    end;
    
    start transaction;
    
	insert into pessoa
		(nome, cpf, data_nascimento, sexo, email, telefone, ativo_pessoa)
	select
		nome, cpf, data_nascimento, sexo, email, telefone, ativo_pessoa
	from
		json_table(pessoa,'$' columns(
			nome varchar(100) path '$.nome',
            cpf bigint(11) path '$.cpf',
            data_nascimento date path '$.data_nascimento',
            sexo char(1) path '$.sexo',
            email varchar(100) path '$.email',
            telefone bigint(11) path '$.telefone',
            ativo_pessoa char(1) path '$.ativo')			
        ) as p;
        
	set idpessoa_gerado = last_insert_id();
    
    insert into endereco
		(idpessoa, cep, numero, complemento)
	select
		idpessoa_gerado, cep, numero, complemento
	from
		json_table(pessoa, '$.enderecos[*]' columns(
			cep int path '$.cep',
            numero char(8) path '$.numero',
            complemento varchar(150) path '$.complemento')
        ) as e;
    commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pr_produto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_produto`(in produto json)
begin
	declare iditem_gerado int;
    declare preco_item decimal(10,2);

	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
    end;
    
    start transaction;
    
	insert into item
		(idcategoria, item, descricao_item, preco, tipo_item, ativo_produto_servico)
	select
		idcategoria, item, descricao_item, preco, tipo_item, ativo_produto_servico
	from
		json_table(produto,'$' columns(
			idcategoria int path '$.idcategoria',
            item varchar(40) path '$.item',
            descricao_item varchar(200) path '$.descricao_item',
			preco decimal(10,2) path '$.preco',
            tipo_item char(1) path '$.tipo_item',
            ativo_produto_servico char(1) path '$.ativo_produto_servico')			
        ) as i;
        
	set iditem_gerado = last_insert_id();

    SELECT preco
    INTO preco_item
    FROM item
    WHERE iditem = iditem_gerado;
    
    insert into produto
		(iditem, codigo_preco, preco_venda, unidade)
	select
		iditem_gerado, codigo_preco, fn_calc_preco_venda(codigo_preco, preco_item), unidade
	from
		json_table(produto,'$' columns(
			codigo_preco int path '$.codigo_preco',
            unidade char(10) path '$.unidade')
        ) as p;
    
    commit;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-05 20:21:24
