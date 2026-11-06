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
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `idpessoa` int NOT NULL,
  `cargo` varchar(20) NOT NULL,
  `data_admissao` date NOT NULL,
  PRIMARY KEY (`idpessoa`),
  CONSTRAINT `fk_funcionario_pessoa` FOREIGN KEY (`idpessoa`) REFERENCES `pessoa` (`idpessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (2,'Analista','2026-10-02'),(3,'Biomedica','2019-06-15'),(4,'Esteticista','2018-09-03'),(5,'Recepcionista','2020-11-09'),(8,'Recepcionista','2020-11-09'),(9,'Esteticista','2020-02-10'),(10,'Biomedica','2019-06-15'),(11,'Fisioterapeuta','2021-01-20'),(12,'Massoterapeuta','2022-04-11'),(13,'Esteticista','2018-09-03'),(14,'Recepcionista','2020-11-09'),(15,'Dermatologista','2021-07-19'),(16,'Cosmetologa','2023-02-13'),(17,'Esteticista','2024-01-15'),(18,'Gerente','2020-08-24'),(19,'Recepcionista','2017-03-27'),(20,'Nutricionista','2019-10-14'),(21,'Psicologa','2018-12-03'),(22,'Esteticista','2023-06-05'),(23,'Administradora','2016-05-02'),(24,'Recepcionista','2021-09-13'),(25,'Fisioterapeuta','2022-02-07'),(26,'Biomedica','2024-03-18'),(27,'Massoterapeuta','2018-01-22'),(28,'Esteticista','2023-08-21'),(29,'Esteticista','2020-02-10'),(30,'Biomedica','2019-06-15'),(31,'Fisioterapeuta','2021-01-20'),(32,'Massoterapeuta','2022-04-11'),(33,'Esteticista','2018-09-03'),(34,'Recepcionista','2020-11-09'),(35,'Dermatologista','2021-07-19'),(36,'Cosmetologa','2023-02-13'),(37,'Esteticista','2024-01-15'),(38,'Gerente','2020-08-24'),(39,'Recepcionista','2017-03-27'),(40,'Nutricionista','2019-10-14'),(41,'Psicologa','2018-12-03'),(42,'Esteticista','2023-06-05'),(43,'Administradora','2016-05-02'),(44,'Recepcionista','2021-09-13'),(45,'Fisioterapeuta','2022-02-07'),(46,'Biomedica','2024-03-18'),(47,'Massoterapeuta','2018-01-22'),(48,'Esteticista','2023-08-21');
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
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
