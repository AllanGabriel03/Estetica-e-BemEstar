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
-- Table structure for table `entrada_produto`
--

DROP TABLE IF EXISTS `entrada_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrada_produto` (
  `identrada_produto` int NOT NULL AUTO_INCREMENT,
  `iditem` int NOT NULL,
  `data_entrada_produto` date NOT NULL,
  `quantidade_entrada` int NOT NULL,
  `unidade` char(10) NOT NULL,
  `valor_unitario_entrada` decimal(10,2) NOT NULL,
  PRIMARY KEY (`identrada_produto`,`iditem`),
  KEY `fk_entrada_produto_estoque1_idx` (`iditem`),
  CONSTRAINT `fk_entrada_produto_estoque1` FOREIGN KEY (`iditem`) REFERENCES `estoque` (`iditem`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrada_produto`
--

LOCK TABLES `entrada_produto` WRITE;
/*!40000 ALTER TABLE `entrada_produto` DISABLE KEYS */;
INSERT INTO `entrada_produto` VALUES (1,21,'2026-09-01',55,'UN',48.60),(2,22,'2026-09-02',30,'UN',33.28),(3,23,'2026-09-03',500,'UN',50.00),(4,24,'2026-09-04',10,'UN',71.50),(5,25,'2026-09-05',180,'UN',80.00),(6,26,'2026-09-06',250,'UN',30.00),(7,27,'2026-09-07',20,'UN',50.00),(8,28,'2026-09-08',5,'UN',60.00),(9,29,'2026-09-09',40,'UN',30.00),(10,30,'2026-09-10',300,'UN',25.00),(11,31,'2026-09-11',3,'UN',100.00),(12,32,'2026-09-12',200,'UN',95.80),(13,33,'2026-09-15',150,'UN',65.00),(14,34,'2026-09-16',100,'UN',120.00),(15,35,'2026-09-18',120,'UN',70.00),(16,36,'2026-09-20',20,'UN',45.00),(17,37,'2026-09-22',25,'UN',42.00),(18,38,'2026-09-24',15,'UN',75.00),(19,39,'2026-09-26',400,'UN',20.50),(20,40,'2026-09-28',105,'UN',54.00);
/*!40000 ALTER TABLE `entrada_produto` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_entrada_produto` AFTER INSERT ON `entrada_produto` FOR EACH ROW begin
	-- DECLARANDO UMA VARIÁVEL PARA PEGAR TIPO PRODUTO OU SERVIÇO
    declare tp_prod_serv int;
	-- DECLARANDO UMA VARIÁVEL PARA PEGAR O CÓDIGO PREÇO
    declare cod_preco int;    
    
	-- ALTERANDO O PRECO DA TABELA ITEM
    update 
		item
	set 
        preco = new.valor_unitario_entrada
	where
		iditem = new.iditem;
    
    -- ATRIBUINDO O CODIGO DO PREÇO NA VARÁVEL
    select 
		codigo_preco
	into
		cod_preco
	from
		produto
	where
		iditem = new.iditem;

    -- ALTERANDO O PRECO VENDA
    update 
		produto
	set 
        preco_venda = fn_calc_preco_venda(cod_preco, new.valor_unitario_entrada)
	where
		iditem = new.iditem;
        
	-- ALTERANDO A QUANTIDADE NO ESTOQUE
	update
			estoque
		set
			quantidade_estoque = quantidade_estoque + new.quantidade_entrada
		where
			iditem = new.iditem;
		
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
