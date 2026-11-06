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
-- Table structure for table `atendimentoitem`
--

DROP TABLE IF EXISTS `atendimentoitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atendimentoitem` (
  `idatendimento` int NOT NULL,
  `iditem` int NOT NULL,
  `idfuncionario` int NOT NULL,
  `quantidade_itens` int NOT NULL,
  `valorunitario_entrada` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idatendimento`,`iditem`),
  KEY `fk_item_has_atendimento_atendimento1_idx` (`idatendimento`),
  KEY `fk_item_has_atendimento_item1_idx` (`iditem`),
  KEY `fk_atendimentoitem_funcionario1_idx` (`idfuncionario`),
  CONSTRAINT `fk_atendimentoitem_funcionario1` FOREIGN KEY (`idfuncionario`) REFERENCES `funcionario` (`idpessoa`),
  CONSTRAINT `fk_item_has_atendimento_atendimento1` FOREIGN KEY (`idatendimento`) REFERENCES `atendimento` (`idatendimento`),
  CONSTRAINT `fk_item_has_atendimento_item1` FOREIGN KEY (`iditem`) REFERENCES `item` (`iditem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atendimentoitem`
--

LOCK TABLES `atendimentoitem` WRITE;
/*!40000 ALTER TABLE `atendimentoitem` DISABLE KEYS */;
INSERT INTO `atendimentoitem` VALUES (10,28,8,1,27.00),(10,40,8,3,44.00),(11,28,8,1,27.00),(11,40,8,3,44.00),(13,28,8,1,27.00),(13,40,8,3,44.00),(15,21,5,2,52.49),(15,35,12,19,75.60),(16,3,22,42,150.00),(16,5,17,1,11.00),(16,7,47,4,100.00),(16,17,13,37,120.00),(16,21,5,2,52.49),(16,35,12,19,75.60),(18,3,22,42,150.00),(18,5,17,1,11.00),(18,7,47,4,100.00),(18,17,13,37,120.00),(18,21,5,2,52.49),(18,35,12,19,75.60),(19,3,22,42,150.00),(19,5,17,1,11.00),(19,7,47,4,100.00),(19,17,13,37,120.00),(19,21,5,2,52.49),(19,35,12,19,75.60);
/*!40000 ALTER TABLE `atendimentoitem` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_debito_estoque_atendimento_item` AFTER INSERT ON `atendimentoitem` FOR EACH ROW begin
	declare estoque_atual int;
    declare disponibilidade char;
    declare tpitem char;
        
    -- 	ATRIBUINDO O VALOR DO ESTOQUE ATUAL NA VARIÁVEL
    select
		quantidade_estoque
	into
		estoque_atual
	from
		estoque
	where
		iditem = new.iditem
	for update;
  /*      
	-- CAPTURANDO A DISPOSNIBILIDADE DO PRODUTO POR MEIO DE SEU STATUS
    select
		ativo_produto_servico
	into 
		disponibilidade
	from
		item
	where
			iditem = new.iditem
	for update;
    
     -- 	ATRIBUINDO O TIPO DO ITEM NA VARIÁVEL
    select
		tipo_item
	into
		tpitem
	from
		item
	where
		iditem = new.iditem
	for update;
    
    */
    
    SELECT
		ativo_produto_servico,
		tipo_item
	INTO
		disponibilidade,
		tpitem
	FROM 
		item
	WHERE 
		iditem = NEW.iditem
	FOR UPDATE;
    
    -- Verificar a disponibilidade do produto
    if disponibilidade <> 'S' then
		signal sqlstate '45000'
        set message_text = 'Produto indisponível';
	end if ; 
    
    -- Verificar se o produto existe no estoque
    if tpitem is null then
		signal sqlstate '45000'
        set message_text = 'Produto não econtrado';
	end if ; 
    
    -- Verificar se a quantidade em estoque é insuficiente
    if estoque_atual < new.quantidade_itens then
		signal sqlstate '45000'
        set message_text = 'Produto insuficiente no estoque';
    end if ;
       
	-- VERIFICANDO TIPO PRODUTO OU SERVIÇO
    if tpitem = 'P' then
		update
			estoque
		set
			quantidade_estoque = quantidade_estoque - new.quantidade_itens
		where
			iditem = new.iditem;	
	end if;
	
end */;;
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
