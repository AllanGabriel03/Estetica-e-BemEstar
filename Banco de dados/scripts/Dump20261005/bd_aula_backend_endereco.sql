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
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `endereco` (
  `idendereco` int NOT NULL AUTO_INCREMENT,
  `idpessoa` int NOT NULL,
  `cep` char(8) NOT NULL,
  `numero` char(10) NOT NULL,
  `complemento` varchar(150) NOT NULL,
  PRIMARY KEY (`idendereco`),
  KEY `fk_endereco_pessoa1_idx` (`idpessoa`),
  CONSTRAINT `fk_endereco_pessoa1` FOREIGN KEY (`idpessoa`) REFERENCES `pessoa` (`idpessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (1,1,'49000000','123','Casa'),(2,1,'49010000','456','Apartamento 101'),(4,2,'49000000','123','Casa'),(5,2,'49010000','456','Apartamento 101'),(7,3,'49020000','789','Casa'),(8,4,'49050000','145','Casa'),(9,4,'49051000','210','Apto 501'),(11,5,'49060000','230','Casa'),(12,5,'49012000','230','Apartamento'),(14,6,'49060000','230','Casa'),(15,6,'49030000','321','Casa'),(16,6,'49031000','55','Sala 02'),(17,6,'49020000','789','Casa'),(21,7,'49100000','612','Casa'),(22,7,'49101000','45','Apto 202'),(23,8,'49060000','230','Casa'),(24,8,'49012000','230','Apartamento'),(26,9,'49000000','123','Casa'),(27,9,'49010000','456','Apto 101'),(29,10,'49020000','789','Casa'),(30,11,'49030000','321','Casa'),(31,11,'49031000','55','Sala 02'),(33,12,'49040000','88','Apto 302'),(34,13,'49050000','145','Casa'),(35,13,'49051000','210','Apto 501'),(37,14,'49060000','230','Casa'),(38,15,'49070000','412','Casa'),(39,15,'49071000','90','Fundos'),(41,16,'49080000','77','Apto 104'),(42,17,'49090000','501','Casa'),(43,18,'49100000','612','Casa'),(44,18,'49101000','45','Apto 202'),(46,19,'49110000','321','Casa'),(47,20,'49120000','159','Casa'),(48,20,'49121000','300','Apto 401'),(50,21,'49130000','710','Casa'),(51,22,'49140000','82','Apto 103'),(52,23,'49150000','900','Casa'),(53,23,'49151000','120','Comercial'),(55,24,'49160000','205','Casa'),(56,25,'49170000','333','Apto 201'),(57,25,'49171000','44','Casa'),(59,26,'49180000','510','Casa'),(60,27,'49190000','615','Casa'),(61,27,'49191000','80','Apto 302'),(63,28,'49200000','127','Casa'),(64,29,'49000000','123','Casa'),(65,29,'49010000','456','Apto 101'),(67,30,'49020000','789','Casa'),(68,31,'49030000','321','Casa'),(69,31,'49031000','55','Sala 02'),(71,32,'49040000','88','Apto 302'),(72,33,'49050000','145','Casa'),(73,33,'49051000','210','Apto 501'),(75,34,'49060000','230','Casa'),(76,35,'49070000','412','Casa'),(77,35,'49071000','90','Fundos'),(79,36,'49080000','77','Apto 104'),(80,37,'49090000','501','Casa'),(81,38,'49100000','612','Casa'),(82,38,'49101000','45','Apto 202'),(84,39,'49110000','321','Casa'),(85,40,'49120000','159','Casa'),(86,40,'49121000','300','Apto 401'),(88,41,'49130000','710','Casa'),(89,42,'49140000','82','Apto 103'),(90,43,'49150000','900','Casa'),(91,43,'49151000','120','Comercial'),(93,44,'49160000','205','Casa'),(94,45,'49170000','333','Apto 201'),(95,45,'49171000','44','Casa'),(97,46,'49180000','510','Casa'),(98,47,'49190000','615','Casa'),(99,47,'49191000','80','Apto 302'),(101,48,'49200000','127','Casa'),(102,79,'49000000','123','Casa'),(103,79,'49010000','456','Apto 101'),(105,80,'49020000','789','Casa'),(106,81,'49030000','321','Casa'),(107,81,'49031000','55','Sala 02'),(108,81,'49020000','789','Casa'),(109,82,'49040000','88','Apto 302'),(110,83,'49050000','145','Casa'),(111,83,'49051000','210','Apto 501'),(113,84,'49060000','230','Casa'),(114,84,'49030000','321','Casa'),(115,84,'49031000','55','Sala 02'),(116,84,'49020000','789','Casa'),(120,85,'49070000','412','Casa'),(121,85,'49071000','90','Fundos'),(123,86,'49080000','77','Apto 104'),(124,87,'49090000','501','Casa'),(125,88,'49100000','612','Casa'),(126,88,'49101000','45','Apto 202'),(128,89,'49110000','321','Casa'),(129,90,'49120000','159','Casa'),(130,90,'49121000','300','Apto 401'),(132,91,'49130000','710','Casa'),(133,92,'49140000','82','Apto 103'),(134,93,'49150000','900','Casa'),(135,93,'49151000','120','Comercial'),(137,94,'49160000','205','Casa'),(138,95,'49170000','333','Apto 201'),(139,95,'49171000','44','Casa'),(141,96,'49180000','510','Casa'),(142,97,'49190000','615','Casa'),(143,97,'49191000','80','Apto 302'),(145,98,'49200000','127','Casa'),(146,99,'49210000','220','Casa'),(147,100,'49220000','315','Apto 201'),(148,100,'49221000','70','Casa'),(150,101,'49230000','410','Casa'),(151,102,'49240000','512','Casa'),(152,102,'49241000','33','Apto 402'),(154,103,'49250000','620','Casa'),(155,104,'49260000','715','Apto 105'),(156,105,'49270000','801','Casa'),(157,105,'49271000','90','Fundos'),(159,106,'49280000','145','Casa'),(160,107,'49290000','255','Apto 303'),(161,107,'49291000','61','Casa'),(163,108,'49300000','340','Casa');
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-05 20:21:24
