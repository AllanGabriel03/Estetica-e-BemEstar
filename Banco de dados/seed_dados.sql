-- Dados de demonstracao do projeto Estetica & Bem-Estar
USE bd_aula_backend;
SET FOREIGN_KEY_CHECKS = 0;
-- MySQL dump 10.13  Distrib 26.7.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bd_aula_backend
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `categoria`
--

/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` (`idcategoria`, `categoria`) VALUES (1,'Cuidados com a Pele');
INSERT INTO `categoria` (`idcategoria`, `categoria`) VALUES (2,'Cabelos');
INSERT INTO `categoria` (`idcategoria`, `categoria`) VALUES (3,'Aromaterapia');
INSERT INTO `categoria` (`idcategoria`, `categoria`) VALUES (4,'Est├®tica Facial');
INSERT INTO `categoria` (`idcategoria`, `categoria`) VALUES (5,'Est├®tica Corporal');
INSERT INTO `categoria` (`idcategoria`, `categoria`) VALUES (6,'Massagens');
INSERT INTO `categoria` (`idcategoria`, `categoria`) VALUES (7,'Depila├º├úo e Sobrancelhas');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;

--
-- Dumping data for table `item`
--

/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (1,1,'S├®rum Facial Vitamina C 30ml','S├®rum antioxidante que uniformiza o tom da pele e estimula o vi├ºo.',89.90,'P','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (2,1,'Protetor Solar Facial FPS 50','Protetor solar facial de toque seco, indicado para todos os tipos de pele.',59.90,'P','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (3,1,'Hidratante Corporal de Karit├®','Hidratante corporal com manteiga de karit├®, 200ml, hidrata├º├úo por 24 horas.',42.50,'P','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (4,1,'Gel de Limpeza Facial 150ml','Gel de limpeza suave que remove impurezas sem ressecar a pele.',38.00,'P','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (5,2,'Shampoo Hidratante de Argan 300ml','Shampoo com ├│leo de argan para cabelos secos e opacos.',45.90,'P','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (6,2,'M├íscara Capilar Reconstrutora','M├íscara de tratamento intensivo, 250g, reconstr├│i e devolve a maciez dos fios.',62.00,'P','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (7,3,'├ôleo Essencial de Lavanda 10ml','├ôleo essencial 100% puro com aroma calmante, ideal para relaxamento.',34.90,'P','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (8,3,'Vela Arom├ítica Relaxante','Vela de soja com fragr├óncia de baunilha e s├óndalo, dura├º├úo de 40 horas.',39.90,'P','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (9,3,'Difusor de Ambiente com Varetas','Difusor de 250ml com fragr├óncia de capim-lim├úo e gengibre.',54.90,'P','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (10,1,'Esfoliante Corporal Caf├® e Coco','Esfoliante corporal de 200g que renova a pele e melhora a circula├º├úo.',48.00,'P','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (11,4,'Limpeza de Pele Profunda','Higieniza├º├úo, esfolia├º├úo, extra├º├úo e m├íscara calmante. Dura├º├úo de 90 minutos.',120.00,'S','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (12,4,'Peeling de Diamante','Esfolia├º├úo mec├ónica que remove c├®lulas mortas e suaviza manchas e linhas finas.',150.00,'S','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (13,6,'Massagem Relaxante 60min','Massagem com ├│leos arom├íticos para aliviar o estresse e a tens├úo muscular.',130.00,'S','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (14,6,'Massagem Modeladora','Massagem de manobras firmes que auxilia na redu├º├úo de medidas e no contorno corporal.',150.00,'S','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (15,5,'Drenagem Linf├ítica','T├®cnica manual que reduz incha├ºo e reten├º├úo de l├¡quidos. Sess├úo de 60 minutos.',140.00,'S','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (16,7,'Depila├º├úo com Cera - Pernas','Depila├º├úo completa das pernas com cera de baixa temperatura.',70.00,'S','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (17,7,'Design de Sobrancelhas','Design personalizado com pin├ºa e finaliza├º├úo com henna opcional.',40.00,'S','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (18,5,'Esfolia├º├úo e Hidrata├º├úo Corporal','Esfolia├º├úo com sais e hidrata├º├úo profunda para pele macia e luminosa.',110.00,'S','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (19,2,'Hidrata├º├úo Capilar Profissional','Tratamento de hidrata├º├úo profunda com finaliza├º├úo, para todos os tipos de cabelo.',95.00,'S','S');
INSERT INTO `item` (`iditem`, `idcategoria`, `item`, `descricao_item`, `preco`, `tipo_item`, `ativo_produto_servico`) VALUES (20,5,'Day Spa Completo','Pacote com esfolia├º├úo, massagem relaxante, hidrata├º├úo e banho de ofur├┤. 3 horas.',280.00,'S','S');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;

--
-- Dumping data for table `produto`
--

/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` (`iditem`, `codigo_preco`, `preco_venda`, `unidade`) VALUES (1,1001,89.90,'UN');
INSERT INTO `produto` (`iditem`, `codigo_preco`, `preco_venda`, `unidade`) VALUES (2,1002,59.90,'UN');
INSERT INTO `produto` (`iditem`, `codigo_preco`, `preco_venda`, `unidade`) VALUES (3,1003,42.50,'UN');
INSERT INTO `produto` (`iditem`, `codigo_preco`, `preco_venda`, `unidade`) VALUES (4,1004,38.00,'UN');
INSERT INTO `produto` (`iditem`, `codigo_preco`, `preco_venda`, `unidade`) VALUES (5,1005,45.90,'UN');
INSERT INTO `produto` (`iditem`, `codigo_preco`, `preco_venda`, `unidade`) VALUES (6,1006,62.00,'UN');
INSERT INTO `produto` (`iditem`, `codigo_preco`, `preco_venda`, `unidade`) VALUES (7,1007,34.90,'UN');
INSERT INTO `produto` (`iditem`, `codigo_preco`, `preco_venda`, `unidade`) VALUES (8,1008,39.90,'UN');
INSERT INTO `produto` (`iditem`, `codigo_preco`, `preco_venda`, `unidade`) VALUES (9,1009,54.90,'UN');
INSERT INTO `produto` (`iditem`, `codigo_preco`, `preco_venda`, `unidade`) VALUES (10,1010,48.00,'UN');
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;

--
-- Dumping data for table `estoque`
--

/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` (`iditem`, `quantidade_estoque`) VALUES (1,29);
INSERT INTO `estoque` (`iditem`, `quantidade_estoque`) VALUES (2,38);
INSERT INTO `estoque` (`iditem`, `quantidade_estoque`) VALUES (3,39);
INSERT INTO `estoque` (`iditem`, `quantidade_estoque`) VALUES (4,50);
INSERT INTO `estoque` (`iditem`, `quantidade_estoque`) VALUES (5,35);
INSERT INTO `estoque` (`iditem`, `quantidade_estoque`) VALUES (6,25);
INSERT INTO `estoque` (`iditem`, `quantidade_estoque`) VALUES (7,58);
INSERT INTO `estoque` (`iditem`, `quantidade_estoque`) VALUES (8,29);
INSERT INTO `estoque` (`iditem`, `quantidade_estoque`) VALUES (9,19);
INSERT INTO `estoque` (`iditem`, `quantidade_estoque`) VALUES (10,29);
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;

--
-- Dumping data for table `entrada_produto`
--

/*!40000 ALTER TABLE `entrada_produto` DISABLE KEYS */;
INSERT INTO `entrada_produto` (`identrada_produto`, `iditem`, `data_entrada_produto`, `quantidade_entrada`, `unidade`, `valor_unitario_entrada`) VALUES (1,1,'2026-09-01',30,'UN',45.00);
INSERT INTO `entrada_produto` (`identrada_produto`, `iditem`, `data_entrada_produto`, `quantidade_entrada`, `unidade`, `valor_unitario_entrada`) VALUES (2,2,'2026-09-01',40,'UN',30.00);
INSERT INTO `entrada_produto` (`identrada_produto`, `iditem`, `data_entrada_produto`, `quantidade_entrada`, `unidade`, `valor_unitario_entrada`) VALUES (3,3,'2026-09-03',40,'UN',21.00);
INSERT INTO `entrada_produto` (`identrada_produto`, `iditem`, `data_entrada_produto`, `quantidade_entrada`, `unidade`, `valor_unitario_entrada`) VALUES (4,4,'2026-09-03',50,'UN',19.00);
INSERT INTO `entrada_produto` (`identrada_produto`, `iditem`, `data_entrada_produto`, `quantidade_entrada`, `unidade`, `valor_unitario_entrada`) VALUES (5,5,'2026-09-08',35,'UN',23.00);
INSERT INTO `entrada_produto` (`identrada_produto`, `iditem`, `data_entrada_produto`, `quantidade_entrada`, `unidade`, `valor_unitario_entrada`) VALUES (6,6,'2026-09-08',25,'UN',31.00);
INSERT INTO `entrada_produto` (`identrada_produto`, `iditem`, `data_entrada_produto`, `quantidade_entrada`, `unidade`, `valor_unitario_entrada`) VALUES (7,7,'2026-09-10',60,'UN',17.00);
INSERT INTO `entrada_produto` (`identrada_produto`, `iditem`, `data_entrada_produto`, `quantidade_entrada`, `unidade`, `valor_unitario_entrada`) VALUES (8,8,'2026-09-10',30,'UN',20.00);
INSERT INTO `entrada_produto` (`identrada_produto`, `iditem`, `data_entrada_produto`, `quantidade_entrada`, `unidade`, `valor_unitario_entrada`) VALUES (9,9,'2026-09-15',20,'UN',27.00);
INSERT INTO `entrada_produto` (`identrada_produto`, `iditem`, `data_entrada_produto`, `quantidade_entrada`, `unidade`, `valor_unitario_entrada`) VALUES (10,10,'2026-09-15',30,'UN',24.00);
/*!40000 ALTER TABLE `entrada_produto` ENABLE KEYS */;

--
-- Dumping data for table `pessoa`
--

/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (1,'Camila Rodrigues Souza','11122233344','1991-03-12','F','camila.souza@spaviva.com.br',79991110001,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (2,'Rafael Almeida Santos','22233344455','1988-07-25','M','rafael.santos@spaviva.com.br',79991110002,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (3,'Juliana Mendes Costa','33344455566','1993-11-02','F','juliana.costa@spaviva.com.br',79991110003,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (4,'Patr├¡cia Lima Barros','44455566677','1995-05-18','F','patricia.barros@spaviva.com.br',79991110004,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (5,'Ana Beatriz Oliveira','55566677788','1990-01-30','F','ana.oliveira@email.com',79988880005,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (6,'Mariana Ferreira Lopes','66677788899','1985-09-14','F','mariana.lopes@email.com',79988880006,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (7,'Carlos Eduardo Nascimento','77788899900','1982-12-05','M','carlos.nascimento@email.com',79988880007,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (8,'Fernanda Gomes Ribeiro','88899900011','1997-04-22','F','fernanda.ribeiro@email.com',79988880008,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (9,'Luciana Martins Ara├║jo','99900011122','1979-08-09','F','luciana.araujo@email.com',79988880009,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (10,'Pedro Henrique Cardoso','12312312399','1994-02-27','M','pedro.cardoso@email.com',79988880010,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (11,'Renata Silva Prado','23423423400','1987-06-16','F','renata.prado@email.com',79988880011,'S');
INSERT INTO `pessoa` (`idpessoa`, `nome`, `cpf`, `data_nascimento`, `sexo`, `email`, `telefone`, `ativo_pessoa`) VALUES (12,'Tatiane Moreira Dias','34534534511','2000-10-03','F','tatiane.dias@email.com',79988880012,'N');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;

--
-- Dumping data for table `funcionario`
--

/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` (`idpessoa`, `cargo`, `data_admissao`) VALUES (1,'Esteticista','2022-02-01');
INSERT INTO `funcionario` (`idpessoa`, `cargo`, `data_admissao`) VALUES (2,'Massoterapeuta','2021-06-15');
INSERT INTO `funcionario` (`idpessoa`, `cargo`, `data_admissao`) VALUES (3,'Esteticista','2023-03-10');
INSERT INTO `funcionario` (`idpessoa`, `cargo`, `data_admissao`) VALUES (4,'Recepcionista','2024-01-08');
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;

--
-- Dumping data for table `endereco`
--

/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (1,1,'49010000','120','Apto 101');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (2,2,'49020010','45','Casa');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (3,3,'49025120','300','Bloco B, Apto 22');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (4,4,'49030230','78','Casa');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (5,5,'49037480','510','Apto 302');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (6,6,'49040320','15','Casa');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (7,7,'49045100','980','Sala 4');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (8,8,'49050660','230','Apto 504');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (9,9,'49055010','67','Casa');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (10,10,'49060220','412','Casa');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (11,11,'49065340','89','Apto 12');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (12,5,'49010550','1500','Escrit├│rio');
INSERT INTO `endereco` (`idendereco`, `idpessoa`, `cep`, `numero`, `complemento`) VALUES (13,12,'49072100','33','Casa');
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;

--
-- Dumping data for table `atendimento`
--

/*!40000 ALTER TABLE `atendimento` DISABLE KEYS */;
INSERT INTO `atendimento` (`idatendimento`, `idpessoa`, `data_atendimento`, `status_atendimento`) VALUES (1,5,'2026-10-02','F');
INSERT INTO `atendimento` (`idatendimento`, `idpessoa`, `data_atendimento`, `status_atendimento`) VALUES (2,6,'2026-10-05','F');
INSERT INTO `atendimento` (`idatendimento`, `idpessoa`, `data_atendimento`, `status_atendimento`) VALUES (3,7,'2026-10-09','F');
INSERT INTO `atendimento` (`idatendimento`, `idpessoa`, `data_atendimento`, `status_atendimento`) VALUES (4,8,'2026-10-14','F');
INSERT INTO `atendimento` (`idatendimento`, `idpessoa`, `data_atendimento`, `status_atendimento`) VALUES (5,9,'2026-10-21','P');
INSERT INTO `atendimento` (`idatendimento`, `idpessoa`, `data_atendimento`, `status_atendimento`) VALUES (6,5,'2026-10-28','C');
INSERT INTO `atendimento` (`idatendimento`, `idpessoa`, `data_atendimento`, `status_atendimento`) VALUES (7,10,'2026-11-03','P');
/*!40000 ALTER TABLE `atendimento` ENABLE KEYS */;

--
-- Dumping data for table `atendimentoitem`
--

/*!40000 ALTER TABLE `atendimentoitem` DISABLE KEYS */;
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (1,1,4,1,89.90);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (1,11,1,1,120.00);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (2,7,4,2,34.90);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (2,13,2,1,130.00);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (3,3,4,1,42.50);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (3,10,4,1,48.00);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (3,15,3,1,140.00);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (4,20,3,1,280.00);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (5,2,4,2,59.90);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (5,12,1,1,150.00);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (6,16,1,1,70.00);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (7,8,4,1,39.90);
INSERT INTO `atendimentoitem` (`idatendimento`, `iditem`, `idfuncionario`, `quantidade_itens`, `valorunitario_entrada`) VALUES (7,9,4,1,54.90);
/*!40000 ALTER TABLE `atendimentoitem` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-06 13:01:17
SET FOREIGN_KEY_CHECKS = 1;
