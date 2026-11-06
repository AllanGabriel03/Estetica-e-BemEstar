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
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa` (
  `idpessoa` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` bigint unsigned NOT NULL,
  `data_nascimento` date NOT NULL,
  `sexo` char(1) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` bigint unsigned NOT NULL,
  `ativo_pessoa` char(1) NOT NULL,
  PRIMARY KEY (`idpessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (1,'João da Silva',12345678901,'1990-05-15','M','joao@email.com',79999999999,'S'),(2,'João da Silva',12345678901,'1990-05-15','M','joao@email.com',79999999999,'S'),(3,'Mariana Oliveira Santos',23456789012,'1991-08-22','F','mariana.santos@email.com',79999990002,'S'),(4,'Renata Cristina Alves',56789012345,'1990-01-25','F','renata.alves@email.com',79999990005,'S'),(5,'Fernanda Beatriz Lima',67890123456,'1994-06-18','F','fernanda.lima@email.com',79999990006,'S'),(6,'Juliana Costa Almeida',67890123456,'1993-06-18','F','juliana.almeida@email.com',79999990006,'S'),(7,'Camila Rodrigues Silva',11234567890,'1994-07-13','F','camila.silva@email.com',79999990010,'S'),(8,'Fernanda Beatriz Lima',67890123456,'1994-06-18','F','fernanda.lima@email.com',79999990006,'S'),(9,'Juliana Martins Costa',12345678901,'1988-05-14','F','juliana.costa@email.com',79999990001,'S'),(10,'Mariana Oliveira Santos',23456789012,'1991-08-22','F','mariana.santos@email.com',79999990002,'S'),(11,'Camila Ferreira Almeida',34567890123,'1993-03-18','F','camila.almeida@email.com',79999990003,'S'),(12,'Patricia Regina Gomes',45678901234,'1987-11-07','F','patricia.gomes@email.com',79999990004,'S'),(13,'Renata Cristina Alves',56789012345,'1990-01-25','F','renata.alves@email.com',79999990005,'S'),(14,'Fernanda Beatriz Lima',67890123456,'1994-06-18','F','fernanda.lima@email.com',79999990006,'S'),(15,'Amanda Caroline Rocha',78901234567,'1995-09-30','F','amanda.rocha@email.com',79999990007,'S'),(16,'Larissa Cristina Mendes',89012345678,'1992-12-04','F','larissa.mendes@email.com',79999990008,'S'),(17,'Bruna Helena Ferreira',90123456789,'1996-04-22','F','bruna.ferreira@email.com',79999990009,'S'),(18,'Carolina Rodrigues Silva',11234567890,'1989-07-13','F','carolina.silva@email.com',79999990010,'S'),(19,'Beatriz Helena Santos',22345678901,'1993-10-09','F','beatriz.santos@email.com',79999990011,'S'),(20,'Daniela Regina Moura',33456789012,'1990-02-28','F','daniela.moura@email.com',79999990012,'S'),(21,'Isabela Fernandes Costa',44567890123,'1986-05-19','F','isabela.costa@email.com',79999990013,'S'),(22,'Leticia Beatriz Moura',55678901234,'1997-03-16','F','leticia.moura@email.com',79999990014,'S'),(23,'Vanessa Maria Torres',66789012345,'1983-08-11','F','vanessa.torres@email.com',79999990015,'S'),(24,'Sabrina Maria Oliveira',77890123456,'1993-01-29','F','sabrina.oliveira@email.com',79999990016,'S'),(25,'Aline Cristina Barros',88901234567,'1989-11-21','F','aline.barros@email.com',79999990017,'S'),(26,'Gabriela Helena Cardoso',99012345678,'1995-09-17','F','gabriela.cardoso@email.com',79999990018,'S'),(27,'Monique Alves Vieira',10123456789,'1984-06-26','F','monique.vieira@email.com',79999990019,'S'),(28,'Nicole Caroline Freitas',21234567890,'1996-10-05','F','nicole.freitas@email.com',79999990020,'S'),(29,'Juliana Martins Costa',12345678901,'1988-05-14','F','juliana.costa@email.com',79999990001,'S'),(30,'Mariana Oliveira Santos',23456789012,'1991-08-22','F','mariana.santos@email.com',79999990002,'S'),(31,'Camila Ferreira Almeida',34567890123,'1993-03-18','F','camila.almeida@email.com',79999990003,'S'),(32,'Patricia Regina Gomes',45678901234,'1987-11-07','F','patricia.gomes@email.com',79999990004,'S'),(33,'Renata Cristina Alves',56789012345,'1990-01-25','F','renata.alves@email.com',79999990005,'S'),(34,'Fernanda Beatriz Lima',67890123456,'1994-06-18','F','fernanda.lima@email.com',79999990006,'S'),(35,'Amanda Caroline Rocha',78901234567,'1995-09-30','F','amanda.rocha@email.com',79999990007,'S'),(36,'Larissa Cristina Mendes',89012345678,'1992-12-04','F','larissa.mendes@email.com',79999990008,'S'),(37,'Bruna Helena Ferreira',90123456789,'1996-04-22','F','bruna.ferreira@email.com',79999990009,'S'),(38,'Carolina Rodrigues Silva',11234567890,'1989-07-13','F','carolina.silva@email.com',79999990010,'S'),(39,'Beatriz Helena Santos',22345678901,'1993-10-09','F','beatriz.santos@email.com',79999990011,'S'),(40,'Daniela Regina Moura',33456789012,'1990-02-28','F','daniela.moura@email.com',79999990012,'S'),(41,'Isabela Fernandes Costa',44567890123,'1986-05-19','F','isabela.costa@email.com',79999990013,'S'),(42,'Leticia Beatriz Moura',55678901234,'1997-03-16','F','leticia.moura@email.com',79999990014,'S'),(43,'Vanessa Maria Torres',66789012345,'1983-08-11','F','vanessa.torres@email.com',79999990015,'S'),(44,'Sabrina Maria Oliveira',77890123456,'1993-01-29','F','sabrina.oliveira@email.com',79999990016,'S'),(45,'Aline Cristina Barros',88901234567,'1989-11-21','F','aline.barros@email.com',79999990017,'S'),(46,'Gabriela Helena Cardoso',99012345678,'1995-09-17','F','gabriela.cardoso@email.com',79999990018,'S'),(47,'Monique Alves Vieira',10123456789,'1984-06-26','F','monique.vieira@email.com',79999990019,'S'),(48,'Nicole Caroline Freitas',21234567890,'1996-10-05','F','nicole.freitas@email.com',79999990020,'S'),(79,'João da Silva',12345678901,'1990-05-15','M','joao.silva@email.com',79999990001,'S'),(80,'Maria Oliveira Santos',23456789012,'1992-08-20','F','maria.santos@email.com',79999990002,'S'),(81,'Carlos Eduardo Souza',34567890123,'1988-03-12','M','carlos.souza@email.com',79999990003,'S'),(82,'Ana Paula Mendes',45678901234,'1995-11-07','F','ana.mendes@email.com',79999990004,'S'),(83,'Pedro Henrique Lima',56789012345,'1985-01-25','M','pedro.lima@email.com',79999990005,'S'),(84,'Juliana Costa Almeida',67890123456,'1993-06-18','F','juliana.almeida@email.com',79999990006,'S'),(85,'Rafael Martins Rocha',78901234567,'1989-09-30','M','rafael.rocha@email.com',79999990007,'S'),(86,'Fernanda Cristina Alves',89012345678,'1991-12-04','F','fernanda.alves@email.com',79999990008,'S'),(87,'Lucas Gabriel Ferreira',90123456789,'1996-04-22','M','lucas.ferreira@email.com',79999990009,'S'),(88,'Camila Rodrigues Silva',11234567890,'1994-07-13','F','camila.silva@email.com',79999990010,'S'),(89,'Bruno Carvalho Santos',22345678901,'1987-10-09','M','bruno.santos@email.com',79999990011,'S'),(90,'Patricia Regina Gomes',33456789012,'1990-02-28','F','patricia.gomes@email.com',79999990012,'S'),(91,'Diego Fernandes Costa',44567890123,'1986-05-19','M','diego.costa@email.com',79999990013,'S'),(92,'Larissa Beatriz Moura',55678901234,'1997-03-16','F','larissa.moura@email.com',79999990014,'S'),(93,'Marcelo Augusto Nunes',66789012345,'1983-08-11','M','marcelo.nunes@email.com',79999990015,'S'),(94,'Renata Maria Torres',77890123456,'1993-01-29','F','renata.torres@email.com',79999990016,'S'),(95,'Gustavo Henrique Barros',88901234567,'1989-11-21','M','gustavo.barros@email.com',79999990017,'S'),(96,'Beatriz Helena Cardoso',99012345678,'1995-09-17','F','beatriz.cardoso@email.com',79999990018,'S'),(97,'Thiago Roberto Vieira',10123456789,'1984-06-26','M','thiago.vieira@email.com',79999990019,'S'),(98,'Amanda Caroline Freitas',21234567890,'1996-10-05','F','amanda.freitas@email.com',79999990020,'S'),(99,'Ricardo Antonio Melo',32345678901,'1982-04-17','M','ricardo.melo@email.com',79999990021,'S'),(100,'Carolina Mendes Rocha',43456789012,'1998-02-11','F','carolina.rocha@email.com',79999990022,'S'),(101,'Felipe Augusto Martins',54567890123,'1991-06-23','M','felipe.martins@email.com',79999990023,'S'),(102,'Vanessa Cristina Lopes',65678901234,'1989-12-19','F','vanessa.lopes@email.com',79999990024,'S'),(103,'Eduardo Henrique Castro',76789012345,'1985-07-08','M','eduardo.castro@email.com',79999990025,'S'),(104,'Natália Fernanda Souza',87890123456,'1994-05-27','F','natalia.souza@email.com',79999990026,'S'),(105,'André Luiz Pereira',98901234567,'1987-09-14','M','andre.pereira@email.com',79999990027,'S'),(106,'Priscila Helena Ramos',10912345678,'1992-11-03','F','priscila.ramos@email.com',79999990028,'S'),(107,'Marcela Cristina Dias',21023456789,'1990-03-09','F','marcela.dias@email.com',79999990029,'S'),(108,'Roberto Carlos Fernandes',32134567890,'1981-10-16','M','roberto.fernandes@email.com',79999990030,'S');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
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
