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
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `iditem` int NOT NULL AUTO_INCREMENT,
  `idcategoria` int NOT NULL,
  `item` varchar(40) NOT NULL,
  `descricao_item` varchar(200) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `tipo_item` char(1) NOT NULL,
  `ativo_produto_servico` char(1) NOT NULL,
  PRIMARY KEY (`iditem`),
  KEY `fk_produto_servico_categoria1_idx` (`idcategoria`),
  CONSTRAINT `fk_produto_servico_categoria1` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,1,'Limpeza de Pele Profunda','Limpeza de pele profunda com higienizacao, esfoliacao, extracao e hidratacao.',120.00,'S','S'),(2,1,'Limpeza de Pele Express','Limpeza facial rapida para remocao de impurezas e oleosidade.',80.00,'S','S'),(3,2,'Tratamento Facial Hidratante','Tratamento facial para hidratacao e revitalizacao da pele.',150.00,'S','S'),(4,2,'Tratamento Facial Antiacne','Tratamento facial direcionado para controle da oleosidade e acne.',160.00,'S','S'),(5,3,'Tratamento Corporal Modelador','Tratamento corporal estetico para modelagem e definicao do contorno corporal.',180.00,'S','S'),(6,3,'Tratamento Corporal Redutor','Tratamento estetico corporal para auxiliar na reducao de medidas.',200.00,'S','S'),(7,4,'Massagem Relaxante','Massagem corporal relaxante para alivio de tensoes musculares.',100.00,'S','S'),(8,4,'Massagem Modeladora','Massagem corporal com tecnicas de modelagem e estimulacao circulatoria.',130.00,'S','S'),(9,5,'Depilacao Pernas','Depilacao completa das pernas com cera.',90.00,'S','S'),(10,5,'Depilacao Axilas','Depilacao das axilas com cera.',35.00,'S','S'),(11,6,'Design de Sobrancelhas','Modelagem e definicao das sobrancelhas de acordo com o formato do rosto.',45.00,'S','S'),(12,6,'Design de Sobrancelhas com Henna','Design de sobrancelhas com aplicacao de henna.',65.00,'S','S'),(13,7,'Micropigmentacao de Sobrancelhas','Procedimento estetico para definicao e preenchimento das sobrancelhas.',450.00,'S','S'),(14,8,'Extensao de Cilios','Aplicacao de extensao de cilios para alongamento e volume.',180.00,'S','S'),(15,9,'Lash Lifting','Procedimento para curvatura e realce dos cilios naturais.',150.00,'S','S'),(16,10,'Peeling Facial','Procedimento de renovacao da pele por meio de peeling facial.',180.00,'S','S'),(17,11,'Drenagem Linfatica','Massagem corporal com tecnica de drenagem linfatica.',120.00,'S','S'),(18,12,'Radiofrequencia Facial','Procedimento estetico facial utilizando tecnologia de radiofrequencia.',180.00,'S','S'),(19,12,'Radiofrequencia Corporal','Procedimento estetico corporal utilizando tecnologia de radiofrequencia.',220.00,'S','S'),(20,13,'Tratamento Capilar Hidratante','Tratamento capilar para hidratacao e recuperacao dos fios.',100.00,'S','S'),(21,1,'Protetor Solar Facial FPS 60','Protetor solar facial FPS 60 com toque seco',48.60,'P','S'),(22,1,'Sabonete Facial Espuma','Sabonete facial em espuma para limpeza da pele',33.28,'P','S'),(23,1,'Gel de Limpeza Facial','Gel de limpeza facial para pele oleosa',50.00,'P','S'),(24,2,'Serum Vitamina C','Serum facial antioxidante com vitamina C',71.50,'P','S'),(25,2,'Serum Acido Hialuronico','Serum hidratante com acido hialuronico',80.00,'P','S'),(26,3,'Creme Hidratante Corporal','Creme hidratante corporal para uso diario',30.00,'P','S'),(27,3,'Esfoliante Corporal','Esfoliante corporal com particulas naturais',50.00,'P','S'),(28,4,'Oleo Corporal Relaxante','Oleo corporal para massagens relaxantes',60.00,'P','S'),(29,5,'Cera Depilatoria Facial','Cera depilatoria para procedimentos faciais',30.00,'P','S'),(30,6,'Henna para Sobrancelhas','Henna profissional para design de sobrancelhas',25.00,'P','S'),(31,7,'Pigmento para Micropigmentacao','Pigmento profissional para micropigmentacao',100.00,'P','S'),(32,8,'Cola para Extensao de Cilios','Cola profissional para extensao de cilios',95.80,'P','S'),(33,9,'Serum para Lash Lifting','Serum profissional para procedimento de lash lifting',65.00,'P','S'),(34,10,'Peeling Quimico Facial','Peeling facial para renovacao e revitalizacao da pele',120.00,'P','S'),(35,11,'Creme para Drenagem Linfatica','Creme corporal para procedimentos de drenagem',70.00,'P','S'),(36,12,'Mascara Facial Hidratante','Mascara facial hidratante para tratamento estetico',45.00,'P','S'),(37,15,'Shampoo Profissional','Shampoo profissional para cuidados capilares',42.00,'P','S'),(38,16,'Mascara Capilar Hidratante','Mascara capilar para hidratacao e nutricao',75.00,'P','S'),(39,17,'Base Facial Liquida','Base facial liquida para maquiagem profissional',20.50,'P','S'),(40,18,'Protetor Labial FPS 30','Protetor labial hidratante com FPS 30',54.00,'P','S');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
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
