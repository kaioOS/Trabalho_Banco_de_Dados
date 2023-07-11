-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: trabalho_bd
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `agencia`
--

DROP TABLE IF EXISTS `agencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agencia` (
  `id_agencia` int NOT NULL AUTO_INCREMENT,
  `nome_agencia` varchar(100) NOT NULL,
  `endereco` varchar(200) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `id_banco` int NOT NULL,
  PRIMARY KEY (`id_agencia`),
  KEY `idx_agencia_id_agencia` (`id_agencia`),
  KEY `idx_agencia_id_banco` (`id_banco`),
  CONSTRAINT `agencia_ibfk_1` FOREIGN KEY (`id_banco`) REFERENCES `banco` (`id_banco`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agencia`
--

LOCK TABLES `agencia` WRITE;
/*!40000 ALTER TABLE `agencia` DISABLE KEYS */;
INSERT INTO `agencia` VALUES (1,'Agencia Atualizada','Rua X, 123','1111111111',1),(2,'Agência A2','Rua Y, 456','2222222222',1),(3,'Agência B1','Avenida Z, 789','3333333333',2),(4,'Agência B2','Avenida W, 987','4444444444',2),(5,'Agência C1','Rua K, 321','5555555555',3),(6,'Agência 1','Endereço 1','1111111111',1),(7,'Agência 2','Endereço 2','2222222222',2),(8,'Agência 3','Endereço 3','3333333333',3),(9,'Agência 4','Endereço 4','4444444444',4),(10,'Agência 5','Endereço 5','5555555555',5),(11,'Agencia 1','Rua X, 456','(00) 9876-5432',1);
/*!40000 ALTER TABLE `agencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banco`
--

DROP TABLE IF EXISTS `banco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banco` (
  `id_banco` int NOT NULL AUTO_INCREMENT,
  `nome_banco` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `cnpj` varchar(14) NOT NULL,
  PRIMARY KEY (`id_banco`),
  UNIQUE KEY `cnpj` (`cnpj`),
  KEY `idx_banco_id_banco` (`id_banco`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banco`
--

LOCK TABLES `banco` WRITE;
/*!40000 ALTER TABLE `banco` DISABLE KEYS */;
INSERT INTO `banco` VALUES (1,'Banco A','1111111111','12345678901234'),(2,'Banco B','2222222222','98765432109876'),(3,'Banco C','3333333333','34567890123456'),(4,'Banco D','4444444444','76543210987654'),(5,'Banco E','5555555555','56789012345678'),(6,'Banco A','(00) 1234-5678','12345677901234');
/*!40000 ALTER TABLE `banco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartao`
--

DROP TABLE IF EXISTS `cartao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartao` (
  `id_cartao` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(16) NOT NULL,
  `validade` varchar(5) NOT NULL,
  `cvv` varchar(3) NOT NULL,
  `bandeira` varchar(50) NOT NULL,
  `limite` decimal(10,2) NOT NULL,
  `id_conta` int NOT NULL,
  PRIMARY KEY (`id_cartao`),
  UNIQUE KEY `numero` (`numero`),
  KEY `idx_cartao_id_cartao` (`id_cartao`),
  KEY `idx_cartao_id_conta` (`id_conta`),
  CONSTRAINT `cartao_ibfk_1` FOREIGN KEY (`id_conta`) REFERENCES `conta` (`id_conta`),
  CONSTRAINT `CHK_Validade` CHECK (regexp_like(`validade`,_utf8mb4'^(0[1-9]|1[0-2])/[0-9]{2}$'))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartao`
--

LOCK TABLES `cartao` WRITE;
/*!40000 ALTER TABLE `cartao` DISABLE KEYS */;
INSERT INTO `cartao` VALUES (1,'1111111111111115','12/25','123','MasterCard',2000.00,1),(2,'2222222222222222','12/26','456','Mastercard',3000.00,2),(3,'3333333333333333','09/24','789','American Express',4000.00,3),(4,'4444444444444444','03/27','012','Elo',5000.00,4),(5,'5555555555555555','11/23','345','Diners Club',2500.00,5),(6,'1234567890123456','12/25','123','Visa',2000.00,1);
/*!40000 ALTER TABLE `cartao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `id_pessoa` int NOT NULL,
  `id_agencia` int NOT NULL,
  `senha` varchar(50) NOT NULL DEFAULT '12345',
  PRIMARY KEY (`id_cliente`),
  KEY `idx_cliente_id_cliente` (`id_cliente`),
  KEY `idx_cliente_id_pessoa` (`id_pessoa`),
  KEY `idx_cliente_id_agencia` (`id_agencia`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`),
  CONSTRAINT `cliente_ibfk_2` FOREIGN KEY (`id_agencia`) REFERENCES `agencia` (`id_agencia`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,1,1,'12345'),(2,2,1,'12345'),(3,3,2,'12345'),(4,4,3,'12345'),(5,5,3,'12345'),(6,6,1,'12345'),(7,7,2,'12345'),(8,8,3,'12345'),(9,9,1,'12345'),(10,10,2,'12345'),(11,11,1,'12345'),(12,12,2,'12345'),(13,13,3,'12345'),(14,14,1,'12345'),(15,15,2,'12345'),(16,16,3,'12345'),(17,17,1,'12345'),(18,18,2,'12345'),(19,19,3,'12345'),(20,20,1,'12345'),(21,21,2,'12345'),(22,22,1,'12345'),(23,23,2,'12345'),(24,24,3,'12345'),(25,25,1,'12345'),(26,26,2,'12345'),(27,1,1,'senha123');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `id_compra` int NOT NULL AUTO_INCREMENT,
  `valor` decimal(10,2) NOT NULL,
  `divisao` int NOT NULL,
  `data_hora` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estabelecimento` varchar(100) NOT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `idx_compra_id_compra` (`id_compra`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (1,50.00,1,'2023-07-10 23:45:33','Loja A'),(2,100.00,1,'2023-07-10 23:45:33','Loja B'),(3,75.50,1,'2023-07-10 23:45:33','Loja C'),(4,200.00,3,'2023-07-10 23:45:33','Loja D'),(5,120.00,1,'2023-07-10 23:45:33','Loja E'),(6,100.00,1,'2023-07-10 10:00:00','Loja A');
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conta`
--

DROP TABLE IF EXISTS `conta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conta` (
  `id_conta` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT 'Ativo',
  `saldo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `limite` decimal(10,2) NOT NULL,
  `id_cliente` int NOT NULL,
  PRIMARY KEY (`id_conta`),
  UNIQUE KEY `numero` (`numero`),
  KEY `FKc_Status` (`status`),
  KEY `idx_conta_id_conta` (`id_conta`),
  KEY `idx_conta_id_cliente` (`id_cliente`),
  CONSTRAINT `conta_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `FKc_Status` FOREIGN KEY (`status`) REFERENCES `statusconta` (`valor`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conta`
--

LOCK TABLES `conta` WRITE;
/*!40000 ALTER TABLE `conta` DISABLE KEYS */;
INSERT INTO `conta` VALUES (1,'12345677','Ativa',2299.00,500.00,1),(2,'23456700','Ativa',3500.00,1000.00,2),(3,'34567897','Ativa',1750.00,1500.00,3),(4,'45678903','Ativa',500.00,200.00,4),(5,'56789014','Ativa',800.00,300.00,5),(6,'67890127','Ativa',1200.00,600.00,6),(7,'78901238','Ativa',2500.00,2000.00,7),(8,'89012340','Ativa',600.00,300.00,8),(9,'90123451','Ativa',1800.00,1500.00,9),(10,'01234562','Ativa',3000.00,1000.00,10),(11,'12345673','Ativa',900.00,400.00,11),(12,'23456740','Ativa',1700.00,1200.00,12),(13,'34567467','Ativa',2200.00,1800.00,13),(14,'45678801','Ativa',400.00,150.00,14),(15,'56789512','Ativa',700.00,250.00,15),(16,'67890323','Ativa',1100.00,500.00,16),(17,'78901034','Ativa',2400.00,2000.00,17),(18,'89012375','Ativa',550.00,250.00,18),(19,'90123256','Ativa',1700.00,1300.00,19),(20,'01234267','Ativa',2800.00,900.00,20),(21,'12345178','Ativa',800.00,350.00,21),(22,'23456189','Ativa',1600.00,1100.00,22),(23,'34567292','Ativa',2100.00,1700.00,23),(24,'45678090','Ativa',350.00,120.00,24),(25,'56789519','Ativa',650.00,200.00,25),(26,'67890128','Ativa',1000.00,450.00,26),(27,'12345679','Ativa',1000.00,500.00,1),(28,'23456789','Ativa',1500.00,1000.00,2),(29,'34567890','Ativa',2000.00,1500.00,3),(30,'45678901','Ativa',500.00,200.00,4),(31,'56789012','Ativa',800.00,300.00,5),(32,'123459789','Ativa',1000.00,500.00,1);
/*!40000 ALTER TABLE `conta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposito`
--

DROP TABLE IF EXISTS `deposito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deposito` (
  `id_operacao` int NOT NULL,
  `status` varchar(20) DEFAULT 'Em processamento',
  PRIMARY KEY (`id_operacao`),
  KEY `FKd_status` (`status`),
  KEY `idx_deposito_id_operacao` (`id_operacao`),
  CONSTRAINT `deposito_ibfk_1` FOREIGN KEY (`id_operacao`) REFERENCES `operacao` (`id_operacao`),
  CONSTRAINT `FKd_status` FOREIGN KEY (`status`) REFERENCES `statusmovimentacao` (`valor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposito`
--

LOCK TABLES `deposito` WRITE;
/*!40000 ALTER TABLE `deposito` DISABLE KEYS */;
INSERT INTO `deposito` VALUES (1,'Concluído'),(2,'Concluído'),(4,'Concluído'),(5,'Concluído'),(6,'Concluído');
/*!40000 ALTER TABLE `deposito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emprestimo`
--

DROP TABLE IF EXISTS `emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emprestimo` (
  `id_operacao` int NOT NULL,
  `taxa_juros` decimal(5,2) NOT NULL,
  `parcelas` int NOT NULL,
  PRIMARY KEY (`id_operacao`),
  KEY `idx_emprestimo_id_operacao` (`id_operacao`),
  CONSTRAINT `emprestimo_ibfk_1` FOREIGN KEY (`id_operacao`) REFERENCES `operacao` (`id_operacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprestimo`
--

LOCK TABLES `emprestimo` WRITE;
/*!40000 ALTER TABLE `emprestimo` DISABLE KEYS */;
INSERT INTO `emprestimo` VALUES (1,8.50,6),(2,10.20,12),(3,12.80,24),(4,9.90,18),(5,11.50,24),(6,0.10,12);
/*!40000 ALTER TABLE `emprestimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `extrato`
--

DROP TABLE IF EXISTS `extrato`;
/*!50001 DROP VIEW IF EXISTS `extrato`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `extrato` AS SELECT 
 1 AS `id_cliente`,
 1 AS `id_operacao`,
 1 AS `valor`,
 1 AS `data_hora`,
 1 AS `tipo`,
 1 AS `status_saque`,
 1 AS `tipo_investimento`,
 1 AS `taxa_rendimento`,
 1 AS `prazo`,
 1 AS `taxa_juros`,
 1 AS `parcelas`,
 1 AS `id_destino`,
 1 AS `status_transferencia`,
 1 AS `status_deposito`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `fatura`
--

DROP TABLE IF EXISTS `fatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fatura` (
  `id_fatura` int NOT NULL AUTO_INCREMENT,
  `vencimento` date NOT NULL,
  `pagamento` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Aguardando pagamento',
  `id_cartao` int NOT NULL,
  PRIMARY KEY (`id_fatura`),
  KEY `FKf_status` (`status`),
  KEY `idx_fatura_id_fatura` (`id_fatura`),
  KEY `idx_fatura_id_cartao` (`id_cartao`),
  CONSTRAINT `fatura_ibfk_1` FOREIGN KEY (`id_cartao`) REFERENCES `cartao` (`id_cartao`),
  CONSTRAINT `FKf_status` FOREIGN KEY (`status`) REFERENCES `statusfatura` (`valor`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fatura`
--

LOCK TABLES `fatura` WRITE;
/*!40000 ALTER TABLE `fatura` DISABLE KEYS */;
INSERT INTO `fatura` VALUES (1,'2023-06-15','2023-06-20','Paga',1),(2,'2023-06-10','2023-06-25','Aguardando pagamento',2),(3,'2023-06-05','2023-06-15','Paga',3),(4,'2023-06-12','2023-06-18','Vencida',4),(5,'2023-06-08','2023-06-22','Aguardando pagamento',5),(6,'2023-07-10','2023-07-11','Paga',1);
/*!40000 ALTER TABLE `fatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faturacompra`
--

DROP TABLE IF EXISTS `faturacompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faturacompra` (
  `id_fatura` int NOT NULL,
  `id_compra` int NOT NULL,
  `valor_parcela` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_fatura`,`id_compra`),
  KEY `idx_faturacompra_id_fatura` (`id_fatura`),
  KEY `idx_faturacompra_id_compra` (`id_compra`),
  CONSTRAINT `faturacompra_ibfk_1` FOREIGN KEY (`id_fatura`) REFERENCES `fatura` (`id_fatura`),
  CONSTRAINT `faturacompra_ibfk_2` FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id_compra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faturacompra`
--

LOCK TABLES `faturacompra` WRITE;
/*!40000 ALTER TABLE `faturacompra` DISABLE KEYS */;
INSERT INTO `faturacompra` VALUES (1,1,50.00),(1,2,50.00),(2,1,100.00),(2,3,100.00),(3,4,75.00),(4,5,40.00);
/*!40000 ALTER TABLE `faturacompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `id_funcionario` int NOT NULL AUTO_INCREMENT,
  `id_pessoa` int NOT NULL,
  `cargo` varchar(100) NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `data_admissao` date NOT NULL,
  `id_gerente` int DEFAULT NULL,
  `id_agencia` int NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  KEY `idx_funcionario_id_funcionario` (`id_funcionario`),
  KEY `idx_funcionario_id_pessoa` (`id_pessoa`),
  KEY `idx_funcionario_id_gerente` (`id_gerente`),
  KEY `idx_funcionario_id_agencia` (`id_agencia`),
  CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`),
  CONSTRAINT `funcionario_ibfk_2` FOREIGN KEY (`id_gerente`) REFERENCES `funcionario` (`id_funcionario`),
  CONSTRAINT `funcionario_ibfk_3` FOREIGN KEY (`id_agencia`) REFERENCES `agencia` (`id_agencia`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,1,'Gerente',5000.00,'2010-01-01',NULL,1),(2,2,'Atendente',2000.00,'2015-05-01',1,1),(3,3,'Gerente',5500.00,'2008-03-01',1,2),(4,4,'Atendente',1800.00,'2013-07-01',3,2),(5,5,'Gerente',5200.00,'2009-02-01',1,3);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `informacoes_cliente`
--

DROP TABLE IF EXISTS `informacoes_cliente`;
/*!50001 DROP VIEW IF EXISTS `informacoes_cliente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `informacoes_cliente` AS SELECT 
 1 AS `nome`,
 1 AS `cpf`,
 1 AS `cnpj`,
 1 AS `endereco`,
 1 AS `email`,
 1 AS `data_nasc`,
 1 AS `telefone`,
 1 AS `sexo`,
 1 AS `numero_conta`,
 1 AS `saldo`,
 1 AS `limite_conta`,
 1 AS `status`,
 1 AS `numero_cartao`,
 1 AS `validade`,
 1 AS `cvv`,
 1 AS `bandeira`,
 1 AS `limite_cartao`,
 1 AS `nome_banco`,
 1 AS `nome_agencia`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `investimento`
--

DROP TABLE IF EXISTS `investimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `investimento` (
  `id_operacao` int NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `taxa_rendimento` decimal(5,2) NOT NULL,
  `prazo` int NOT NULL,
  PRIMARY KEY (`id_operacao`),
  KEY `idx_investimento_id_operacao` (`id_operacao`),
  CONSTRAINT `investimento_ibfk_1` FOREIGN KEY (`id_operacao`) REFERENCES `operacao` (`id_operacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investimento`
--

LOCK TABLES `investimento` WRITE;
/*!40000 ALTER TABLE `investimento` DISABLE KEYS */;
INSERT INTO `investimento` VALUES (1,'Poupança',2.50,12),(2,'Tesouro Direto',4.20,24),(3,'Ações',6.80,36),(4,'CDB',3.90,18),(5,'Fundos Imobiliários',5.50,24),(6,'Poupança',0.05,365);
/*!40000 ALTER TABLE `investimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operacao`
--

DROP TABLE IF EXISTS `operacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operacao` (
  `id_operacao` int NOT NULL AUTO_INCREMENT,
  `valor` decimal(10,2) NOT NULL,
  `data_hora` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_conta` int NOT NULL,
  `tipo_op` char(1) NOT NULL,
  PRIMARY KEY (`id_operacao`),
  KEY `FK_TipoOperacao` (`tipo_op`),
  KEY `idx_operacao_id_operacao` (`id_operacao`),
  KEY `idx_operacao_id_conta` (`id_conta`),
  CONSTRAINT `FK_TipoOperacao` FOREIGN KEY (`tipo_op`) REFERENCES `tiposoperacao` (`valor`),
  CONSTRAINT `operacao_ibfk_1` FOREIGN KEY (`id_conta`) REFERENCES `conta` (`id_conta`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operacao`
--

LOCK TABLES `operacao` WRITE;
/*!40000 ALTER TABLE `operacao` DISABLE KEYS */;
INSERT INTO `operacao` VALUES (1,501.00,'2023-07-10 23:45:33',1,'S'),(2,1000.00,'2023-07-10 23:45:33',2,'D'),(3,250.00,'2023-07-10 23:45:33',3,'S'),(4,800.00,'2023-07-10 23:45:33',4,'D'),(5,1500.00,'2023-07-10 23:45:33',5,'D'),(6,500.00,'2023-07-10 12:00:00',1,'D');
/*!40000 ALTER TABLE `operacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa` (
  `id_pessoa` int NOT NULL AUTO_INCREMENT,
  `cnpj` varchar(14) DEFAULT NULL,
  `cpf` varchar(11) DEFAULT NULL,
  `nome` varchar(100) NOT NULL,
  `endereco` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `data_nasc` date NOT NULL,
  `sexo` char(1) NOT NULL,
  PRIMARY KEY (`id_pessoa`),
  UNIQUE KEY `cnpj` (`cnpj`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `FK_Sexo` (`sexo`),
  KEY `idx_pessoa_id_pessoa` (`id_pessoa`),
  KEY `idx_pessoa_cpf` (`cpf`),
  CONSTRAINT `FK_Sexo` FOREIGN KEY (`sexo`) REFERENCES `sexopermitido` (`valor`)
) ENGINE=InnoDB AUTO_INCREMENT=528 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (1,'12345678901205',NULL,'João Silva','Rua A, 123','joao@example.com','1234567890','1990-01-01','M'),(2,NULL,'12345678901','Maria Souza','Avenida B, 456','maria@example.com','9876543210','1995-05-10','F'),(3,'98765432109876',NULL,'Pedro Santos','Rua C, 789','pedro@example.com','4567890123','1985-07-15','M'),(4,NULL,'98765432109','Ana Oliveira','Avenida D, 789','ana@example.com','3210987654','1998-09-20','F'),(5,NULL,'56789012345','José Pereira','Rua E, 456','jose@example.com','0123456789','1992-03-25','M'),(6,NULL,'56789012346','Monica Lima','Rua P, 305','monica@example.com','0123456789','1970-01-20','F'),(7,NULL,'12345678911','Carolina Santos','Rua P, 123','carolina@example.com','1234567890','1993-11-05','F'),(8,'98765432101245',NULL,'Gustavo Oliveira','Avenida Q, 456','gustavo@example.com','9876543210','1988-08-20','M'),(9,NULL,'98765432112','Larissa Lima','Rua R, 789','larissa@example.com','4567890123','1991-03-15','F'),(10,NULL,'56789012356','Thiago Pereira','Rua S, 456','thiago@example.com','0123456789','1995-12-10','M'),(11,'12345678901323',NULL,'Isabela Silva','Avenida T, 789','isabela@example.com','3210987654','1999-09-25','F'),(12,NULL,'12345678914','Mateus Souza','Rua U, 123','mateus@example.com','1234567890','1986-06-07','M'),(13,'98765432101456',NULL,'Fernanda Santos','Avenida V, 456','fernanda@example.com','9876543210','1992-01-30','F'),(14,NULL,'98765432115','Rafael Lima','Rua W, 789','rafael@example.com','4567890123','1994-07-14','M'),(15,NULL,'56789012367','Bianca Pereira','Rua X, 456','bianca@example.com','0123456789','1998-04-18','F'),(16,'12345678901589',NULL,'Vinicius Silva','Avenida Y, 789','vinicius@example.com','3210987654','1987-03-22','M'),(17,NULL,'12345678923','Aline Santos','Rua Z, 123','aline@example.com','1234567890','1996-09-12','F'),(18,'98765432101678',NULL,'Raul Oliveira','Avenida AA, 456','raul@example.com','9876543210','1990-12-28','M'),(19,NULL,'98765432134','Leticia Lima','Rua BB, 789','leticia@example.com','4567890123','1993-08-05','F'),(20,NULL,'56789012378','Roberto Pereira','Rua CC, 456','roberto@example.com','0123456789','1997-05-25','M'),(21,'12345678901765',NULL,'Mariana Silva','Avenida DD, 789','mariana@example.com','3210987654','1992-04-15','F'),(22,NULL,'12345678945','Renato Souza','Rua EE, 123','renato@example.com','1234567890','1988-11-20','M'),(23,'98765432101987',NULL,'Patricia Santos','Avenida FF, 456','patricia@example.com','9876543210','1994-10-10','F'),(24,NULL,'98765432156','Eduardo Lima','Rua GG, 789','eduardo@example.com','4567890123','1985-07-08','M'),(25,NULL,'56789012389','Carla Pereira','Rua HH, 456','carla@example.com','0123456789','1999-02-03','F'),(26,'12345678902100',NULL,'Fernando Silva','Avenida II, 789','fernando@example.com','3210987654','1989-01-14','M'),(27,'57449164574452',NULL,'Pessoa1','Endereço1','pessoa1@example.com','9999999901','2020-12-02','F'),(28,'14199449163116',NULL,'Pessoa2','Endereço2','pessoa2@example.com','9999999902','2003-11-27','M'),(29,'54828633372512',NULL,'Pessoa3','Endereço3','pessoa3@example.com','9999999903','2023-05-12','F'),(30,'62905686230310',NULL,'Pessoa4','Endereço4','pessoa4@example.com','9999999904','2000-08-21','M'),(31,'62081941200496',NULL,'Pessoa5','Endereço5','pessoa5@example.com','9999999905','1995-12-27','F'),(32,'48101911654790',NULL,'Pessoa6','Endereço6','pessoa6@example.com','9999999906','1997-05-17','F'),(33,'31940663803313',NULL,'Pessoa7','Endereço7','pessoa7@example.com','9999999907','1994-04-13','F'),(34,'16501633419191',NULL,'Pessoa8','Endereço8','pessoa8@example.com','9999999908','2009-02-17','F'),(35,'27732894679282',NULL,'Pessoa9','Endereço9','pessoa9@example.com','9999999909','2021-06-06','F'),(36,'83087615857913',NULL,'Pessoa10','Endereço10','pessoa10@example.com','9999999910','2004-11-29','M'),(37,'68221256125924',NULL,'Pessoa11','Endereço11','pessoa11@example.com','9999999911','1970-04-19','M'),(38,'84335005743741',NULL,'Pessoa12','Endereço12','pessoa12@example.com','9999999912','1985-05-16','F'),(39,'64826687932784',NULL,'Pessoa13','Endereço13','pessoa13@example.com','9999999913','1967-06-16','F'),(40,'49090023375200',NULL,'Pessoa14','Endereço14','pessoa14@example.com','9999999914','1985-11-16','F'),(41,'36881439664290',NULL,'Pessoa15','Endereço15','pessoa15@example.com','9999999915','1964-07-10','M'),(42,'25084685846310',NULL,'Pessoa16','Endereço16','pessoa16@example.com','9999999916','1977-07-30','M'),(43,'40976140602469',NULL,'Pessoa17','Endereço17','pessoa17@example.com','9999999917','1979-06-13','F'),(44,'10804874180634',NULL,'Pessoa18','Endereço18','pessoa18@example.com','9999999918','2016-07-21','F'),(45,'48034282017531',NULL,'Pessoa19','Endereço19','pessoa19@example.com','9999999919','1996-07-11','F'),(46,'61011102358820',NULL,'Pessoa20','Endereço20','pessoa20@example.com','9999999920','1970-07-22','F'),(47,'93962718065793',NULL,'Pessoa21','Endereço21','pessoa21@example.com','9999999921','1992-08-29','F'),(48,'39717825408762',NULL,'Pessoa22','Endereço22','pessoa22@example.com','9999999922','2003-12-15','F'),(49,'30432788758010',NULL,'Pessoa23','Endereço23','pessoa23@example.com','9999999923','2010-11-04','M'),(50,'32241958437712',NULL,'Pessoa24','Endereço24','pessoa24@example.com','9999999924','2017-02-14','F'),(51,'67671522384203',NULL,'Pessoa25','Endereço25','pessoa25@example.com','9999999925','1973-11-29','M'),(52,'63189056751494',NULL,'Pessoa26','Endereço26','pessoa26@example.com','9999999926','2004-11-15','F'),(53,'97993579579511',NULL,'Pessoa27','Endereço27','pessoa27@example.com','9999999927','1991-01-08','F'),(54,'33381977904012',NULL,'Pessoa28','Endereço28','pessoa28@example.com','9999999928','1965-07-08','M'),(55,'44731727507646',NULL,'Pessoa29','Endereço29','pessoa29@example.com','9999999929','1978-02-25','F'),(56,'87224941036873',NULL,'Pessoa30','Endereço30','pessoa30@example.com','9999999930','1998-09-25','M'),(57,'30238784076868',NULL,'Pessoa31','Endereço31','pessoa31@example.com','9999999931','1984-10-31','F'),(58,'84029461987344',NULL,'Pessoa32','Endereço32','pessoa32@example.com','9999999932','1996-01-29','F'),(59,'75909932745536',NULL,'Pessoa33','Endereço33','pessoa33@example.com','9999999933','2011-08-20','F'),(60,'43999289818107',NULL,'Pessoa34','Endereço34','pessoa34@example.com','9999999934','1993-03-25','M'),(61,'50375145152560',NULL,'Pessoa35','Endereço35','pessoa35@example.com','9999999935','2019-08-29','F'),(62,'72030930949403',NULL,'Pessoa36','Endereço36','pessoa36@example.com','9999999936','1992-07-20','F'),(63,'12345700666630',NULL,'Pessoa37','Endereço37','pessoa37@example.com','9999999937','1988-06-15','F'),(64,'52821061529983',NULL,'Pessoa38','Endereço38','pessoa38@example.com','9999999938','1973-02-10','F'),(65,'42351148233144',NULL,'Pessoa39','Endereço39','pessoa39@example.com','9999999939','1995-06-12','M'),(66,'91923341175469',NULL,'Pessoa40','Endereço40','pessoa40@example.com','9999999940','1977-10-26','M'),(67,'20386435576143',NULL,'Pessoa41','Endereço41','pessoa41@example.com','9999999941','2003-05-24','M'),(68,'68984778187223',NULL,'Pessoa42','Endereço42','pessoa42@example.com','9999999942','2006-10-10','M'),(69,'38348638255473',NULL,'Pessoa43','Endereço43','pessoa43@example.com','9999999943','2006-07-20','M'),(70,'55302193216329',NULL,'Pessoa44','Endereço44','pessoa44@example.com','9999999944','2017-03-20','M'),(71,'78762368242035',NULL,'Pessoa45','Endereço45','pessoa45@example.com','9999999945','1977-03-19','F'),(72,'57830386355361',NULL,'Pessoa46','Endereço46','pessoa46@example.com','9999999946','1966-09-03','M'),(73,'89847109727419',NULL,'Pessoa47','Endereço47','pessoa47@example.com','9999999947','1963-09-29','M'),(74,'66348490432229',NULL,'Pessoa48','Endereço48','pessoa48@example.com','9999999948','2013-12-01','F'),(75,'22007415771491',NULL,'Pessoa49','Endereço49','pessoa49@example.com','9999999949','1969-08-22','M'),(76,'79184163882568',NULL,'Pessoa50','Endereço50','pessoa50@example.com','9999999950','1989-08-28','F'),(77,'90533028608684',NULL,'Pessoa51','Endereço51','pessoa51@example.com','9999999951','1968-04-30','F'),(78,'84670007698861',NULL,'Pessoa52','Endereço52','pessoa52@example.com','9999999952','1999-12-04','M'),(79,'29208987307929',NULL,'Pessoa53','Endereço53','pessoa53@example.com','9999999953','1985-09-15','F'),(80,'70628920598541',NULL,'Pessoa54','Endereço54','pessoa54@example.com','9999999954','1973-10-29','M'),(81,'21671134402669',NULL,'Pessoa55','Endereço55','pessoa55@example.com','9999999955','2006-10-25','M'),(82,'26710039886375',NULL,'Pessoa56','Endereço56','pessoa56@example.com','9999999956','1968-08-22','M'),(83,'41682705871465',NULL,'Pessoa57','Endereço57','pessoa57@example.com','9999999957','1981-06-21','M'),(84,'23445536618535',NULL,'Pessoa58','Endereço58','pessoa58@example.com','9999999958','1999-11-05','F'),(85,'50210014786766',NULL,'Pessoa59','Endereço59','pessoa59@example.com','9999999959','1984-04-01','F'),(86,'73771838074337',NULL,'Pessoa60','Endereço60','pessoa60@example.com','9999999960','1979-03-26','F'),(87,'66076790537756',NULL,'Pessoa61','Endereço61','pessoa61@example.com','9999999961','1998-10-30','M'),(88,'74303758846878',NULL,'Pessoa62','Endereço62','pessoa62@example.com','9999999962','2023-05-19','F'),(89,'40227507064330',NULL,'Pessoa63','Endereço63','pessoa63@example.com','9999999963','2019-02-13','M'),(90,'61999220114200',NULL,'Pessoa64','Endereço64','pessoa64@example.com','9999999964','1974-12-16','M'),(91,'23795062232571',NULL,'Pessoa65','Endereço65','pessoa65@example.com','9999999965','1974-07-27','F'),(92,'69626179355779',NULL,'Pessoa66','Endereço66','pessoa66@example.com','9999999966','1996-10-24','M'),(93,'87627812016408',NULL,'Pessoa67','Endereço67','pessoa67@example.com','9999999967','1987-12-13','M'),(94,'20318262540100',NULL,'Pessoa68','Endereço68','pessoa68@example.com','9999999968','1997-05-08','F'),(95,'89510222598454',NULL,'Pessoa69','Endereço69','pessoa69@example.com','9999999969','1969-06-22','F'),(96,'62224863127083',NULL,'Pessoa70','Endereço70','pessoa70@example.com','9999999970','2003-09-13','F'),(97,'61213183841866',NULL,'Pessoa71','Endereço71','pessoa71@example.com','9999999971','2017-01-02','F'),(98,'86983546751536',NULL,'Pessoa72','Endereço72','pessoa72@example.com','9999999972','1977-06-22','M'),(99,'15927920225940',NULL,'Pessoa73','Endereço73','pessoa73@example.com','9999999973','1993-02-06','M'),(100,'25677999617232',NULL,'Pessoa74','Endereço74','pessoa74@example.com','9999999974','1972-05-13','F'),(101,'24186267111623',NULL,'Pessoa75','Endereço75','pessoa75@example.com','9999999975','1990-01-29','M'),(102,'91595523098106',NULL,'Pessoa76','Endereço76','pessoa76@example.com','9999999976','1988-06-09','M'),(103,'34612779668171',NULL,'Pessoa77','Endereço77','pessoa77@example.com','9999999977','1978-07-20','F'),(104,'45943393638304',NULL,'Pessoa78','Endereço78','pessoa78@example.com','9999999978','2011-02-08','F'),(105,'60926583857207',NULL,'Pessoa79','Endereço79','pessoa79@example.com','9999999979','2004-07-08','F'),(106,'53655224175802',NULL,'Pessoa80','Endereço80','pessoa80@example.com','9999999980','1977-09-23','M'),(107,'57400313753076',NULL,'Pessoa81','Endereço81','pessoa81@example.com','9999999981','1990-12-28','M'),(108,'13334191332882',NULL,'Pessoa82','Endereço82','pessoa82@example.com','9999999982','1976-05-17','F'),(109,'76926979130997',NULL,'Pessoa83','Endereço83','pessoa83@example.com','9999999983','2008-02-20','M'),(110,'54135308325416',NULL,'Pessoa84','Endereço84','pessoa84@example.com','9999999984','2005-10-13','M'),(111,'23796373329867',NULL,'Pessoa85','Endereço85','pessoa85@example.com','9999999985','1979-01-14','M'),(112,'12056685436569',NULL,'Pessoa86','Endereço86','pessoa86@example.com','9999999986','2001-08-19','F'),(113,'72032898852632',NULL,'Pessoa87','Endereço87','pessoa87@example.com','9999999987','2012-12-30','F'),(114,'57101545256657',NULL,'Pessoa88','Endereço88','pessoa88@example.com','9999999988','2012-04-29','M'),(115,'33235495344955',NULL,'Pessoa89','Endereço89','pessoa89@example.com','9999999989','2011-07-18','M'),(116,'57098049500117',NULL,'Pessoa90','Endereço90','pessoa90@example.com','9999999990','1966-12-27','M'),(117,'90485729529043',NULL,'Pessoa91','Endereço91','pessoa91@example.com','9999999991','2021-04-08','F'),(118,'47211169653768',NULL,'Pessoa92','Endereço92','pessoa92@example.com','9999999992','1990-06-16','F'),(119,'93779018850791',NULL,'Pessoa93','Endereço93','pessoa93@example.com','9999999993','2017-05-03','F'),(120,'37620071245003',NULL,'Pessoa94','Endereço94','pessoa94@example.com','9999999994','2001-08-30','F'),(121,'47572334462378',NULL,'Pessoa95','Endereço95','pessoa95@example.com','9999999995','2000-09-13','F'),(122,'20044977208641',NULL,'Pessoa96','Endereço96','pessoa96@example.com','9999999996','1987-03-11','F'),(123,'69145290040546',NULL,'Pessoa97','Endereço97','pessoa97@example.com','9999999997','2011-06-26','M'),(124,'60408962443851',NULL,'Pessoa98','Endereço98','pessoa98@example.com','9999999998','1981-05-16','F'),(125,'15794308246853',NULL,'Pessoa99','Endereço99','pessoa99@example.com','9999999999','1974-06-26','F'),(126,'12502817597708',NULL,'Pessoa100','Endereço100','pessoa100@example.com','9999999910','1996-07-13','M'),(127,'53779228985103',NULL,'Pessoa101','Endereço101','pessoa101@example.com','9999999910','1967-10-05','M'),(128,'24762387503648',NULL,'Pessoa102','Endereço102','pessoa102@example.com','9999999910','2008-09-03','F'),(129,'98951961527533',NULL,'Pessoa103','Endereço103','pessoa103@example.com','9999999910','1981-05-17','F'),(130,'67572603437651',NULL,'Pessoa104','Endereço104','pessoa104@example.com','9999999910','1990-08-02','F'),(131,'54105457602166',NULL,'Pessoa105','Endereço105','pessoa105@example.com','9999999910','1965-07-07','M'),(132,'93976459190227',NULL,'Pessoa106','Endereço106','pessoa106@example.com','9999999910','1989-09-13','M'),(133,'47269523793151',NULL,'Pessoa107','Endereço107','pessoa107@example.com','9999999910','2023-02-14','F'),(134,'94197649149408',NULL,'Pessoa108','Endereço108','pessoa108@example.com','9999999910','2005-04-11','F'),(135,'69534933371036',NULL,'Pessoa109','Endereço109','pessoa109@example.com','9999999910','2013-10-04','F'),(136,'69458286482336',NULL,'Pessoa110','Endereço110','pessoa110@example.com','9999999911','1974-09-26','M'),(137,'99219861402381',NULL,'Pessoa111','Endereço111','pessoa111@example.com','9999999911','1981-09-19','F'),(138,'52215321000865',NULL,'Pessoa112','Endereço112','pessoa112@example.com','9999999911','1975-01-10','F'),(139,'78289566038446',NULL,'Pessoa113','Endereço113','pessoa113@example.com','9999999911','1970-08-07','M'),(140,'13351759885765',NULL,'Pessoa114','Endereço114','pessoa114@example.com','9999999911','1977-01-19','F'),(141,'54322651656645',NULL,'Pessoa115','Endereço115','pessoa115@example.com','9999999911','2013-03-22','M'),(142,'45314759449395',NULL,'Pessoa116','Endereço116','pessoa116@example.com','9999999911','1974-07-09','F'),(143,'18469305055653',NULL,'Pessoa117','Endereço117','pessoa117@example.com','9999999911','1978-12-22','M'),(144,'94046043152032',NULL,'Pessoa118','Endereço118','pessoa118@example.com','9999999911','2001-03-30','M'),(145,'25012359493423',NULL,'Pessoa119','Endereço119','pessoa119@example.com','9999999911','1983-08-23','F'),(146,'21745738202469',NULL,'Pessoa120','Endereço120','pessoa120@example.com','9999999912','2012-11-28','M'),(147,'94325493708556',NULL,'Pessoa121','Endereço121','pessoa121@example.com','9999999912','2011-04-18','M'),(148,'48904709051274',NULL,'Pessoa122','Endereço122','pessoa122@example.com','9999999912','1991-06-14','M'),(149,'35588537804399',NULL,'Pessoa123','Endereço123','pessoa123@example.com','9999999912','2006-04-01','F'),(150,'16656023800984',NULL,'Pessoa124','Endereço124','pessoa124@example.com','9999999912','1987-02-21','F'),(151,'31591527193404',NULL,'Pessoa125','Endereço125','pessoa125@example.com','9999999912','1977-10-02','M'),(152,'27609676679232',NULL,'Pessoa126','Endereço126','pessoa126@example.com','9999999912','1982-05-05','F'),(153,'25803043950165',NULL,'Pessoa127','Endereço127','pessoa127@example.com','9999999912','2003-05-12','M'),(154,'78782389507426',NULL,'Pessoa128','Endereço128','pessoa128@example.com','9999999912','2002-02-04','M'),(155,'45909117773090',NULL,'Pessoa129','Endereço129','pessoa129@example.com','9999999912','1992-10-22','M'),(156,'35605048980196',NULL,'Pessoa130','Endereço130','pessoa130@example.com','9999999913','2003-10-02','F'),(157,'98857882375696',NULL,'Pessoa131','Endereço131','pessoa131@example.com','9999999913','1990-07-06','F'),(158,'37294411423890',NULL,'Pessoa132','Endereço132','pessoa132@example.com','9999999913','2014-12-05','F'),(159,'64390233600875',NULL,'Pessoa133','Endereço133','pessoa133@example.com','9999999913','1987-06-26','M'),(160,'24269723458466',NULL,'Pessoa134','Endereço134','pessoa134@example.com','9999999913','2010-08-04','F'),(161,'43041713287161',NULL,'Pessoa135','Endereço135','pessoa135@example.com','9999999913','2021-11-24','M'),(162,'18054673427766',NULL,'Pessoa136','Endereço136','pessoa136@example.com','9999999913','2002-11-02','M'),(163,'32247759301446',NULL,'Pessoa137','Endereço137','pessoa137@example.com','9999999913','1971-07-23','F'),(164,'42344705399446',NULL,'Pessoa138','Endereço138','pessoa138@example.com','9999999913','2022-04-01','M'),(165,'16887074650160',NULL,'Pessoa139','Endereço139','pessoa139@example.com','9999999913','2005-08-17','M'),(166,'47659070061202',NULL,'Pessoa140','Endereço140','pessoa140@example.com','9999999914','2005-04-21','M'),(167,'46774733175313',NULL,'Pessoa141','Endereço141','pessoa141@example.com','9999999914','2008-06-24','M'),(168,'45183906206101',NULL,'Pessoa142','Endereço142','pessoa142@example.com','9999999914','1971-06-14','M'),(169,'31794844588073',NULL,'Pessoa143','Endereço143','pessoa143@example.com','9999999914','1981-05-31','F'),(170,'83622243314629',NULL,'Pessoa144','Endereço144','pessoa144@example.com','9999999914','1979-06-11','M'),(171,'91318805125838',NULL,'Pessoa145','Endereço145','pessoa145@example.com','9999999914','1972-06-03','F'),(172,'27703984405569',NULL,'Pessoa146','Endereço146','pessoa146@example.com','9999999914','2003-08-26','M'),(173,'40711157881385',NULL,'Pessoa147','Endereço147','pessoa147@example.com','9999999914','1993-04-03','F'),(174,'98885195393939',NULL,'Pessoa148','Endereço148','pessoa148@example.com','9999999914','1997-05-01','M'),(175,'81614512551216',NULL,'Pessoa149','Endereço149','pessoa149@example.com','9999999914','2004-08-22','M'),(176,'99260872294437',NULL,'Pessoa150','Endereço150','pessoa150@example.com','9999999915','1999-09-19','M'),(177,'87278088505638',NULL,'Pessoa151','Endereço151','pessoa151@example.com','9999999915','2007-09-26','F'),(178,'92203672334741',NULL,'Pessoa152','Endereço152','pessoa152@example.com','9999999915','2002-11-05','F'),(179,'89785540960529',NULL,'Pessoa153','Endereço153','pessoa153@example.com','9999999915','1994-10-02','F'),(180,'33344267637789',NULL,'Pessoa154','Endereço154','pessoa154@example.com','9999999915','2018-11-16','F'),(181,'83331948922324',NULL,'Pessoa155','Endereço155','pessoa155@example.com','9999999915','2008-10-18','F'),(182,'26260831399132',NULL,'Pessoa156','Endereço156','pessoa156@example.com','9999999915','1990-05-15','M'),(183,'50904034861274',NULL,'Pessoa157','Endereço157','pessoa157@example.com','9999999915','1987-04-13','F'),(184,'53280484958813',NULL,'Pessoa158','Endereço158','pessoa158@example.com','9999999915','1997-11-13','F'),(185,'28029999284101',NULL,'Pessoa159','Endereço159','pessoa159@example.com','9999999915','1968-11-19','F'),(186,'13826992673638',NULL,'Pessoa160','Endereço160','pessoa160@example.com','9999999916','2002-09-23','F'),(187,'99349577053775',NULL,'Pessoa161','Endereço161','pessoa161@example.com','9999999916','2014-11-24','F'),(188,'34637505947274',NULL,'Pessoa162','Endereço162','pessoa162@example.com','9999999916','2014-10-19','F'),(189,'18562039163487',NULL,'Pessoa163','Endereço163','pessoa163@example.com','9999999916','1978-02-26','M'),(190,'29750616336009',NULL,'Pessoa164','Endereço164','pessoa164@example.com','9999999916','1987-05-02','M'),(191,'98874393300036',NULL,'Pessoa165','Endereço165','pessoa165@example.com','9999999916','1972-01-19','M'),(192,'16684966764119',NULL,'Pessoa166','Endereço166','pessoa166@example.com','9999999916','2000-08-24','F'),(193,'35188865862031',NULL,'Pessoa167','Endereço167','pessoa167@example.com','9999999916','2002-11-09','F'),(194,'44615310164741',NULL,'Pessoa168','Endereço168','pessoa168@example.com','9999999916','2007-03-22','M'),(195,'29125578737934',NULL,'Pessoa169','Endereço169','pessoa169@example.com','9999999916','1996-10-21','F'),(196,'65433068420209',NULL,'Pessoa170','Endereço170','pessoa170@example.com','9999999917','2005-01-21','F'),(197,'58254991526021',NULL,'Pessoa171','Endereço171','pessoa171@example.com','9999999917','1987-04-05','M'),(198,'33706618569518',NULL,'Pessoa172','Endereço172','pessoa172@example.com','9999999917','2019-04-22','F'),(199,'63644858192321',NULL,'Pessoa173','Endereço173','pessoa173@example.com','9999999917','2005-10-09','F'),(200,'61510097842207',NULL,'Pessoa174','Endereço174','pessoa174@example.com','9999999917','1976-06-07','M'),(201,'72396800017353',NULL,'Pessoa175','Endereço175','pessoa175@example.com','9999999917','1973-05-07','M'),(202,'10971503482173',NULL,'Pessoa176','Endereço176','pessoa176@example.com','9999999917','1979-01-30','F'),(203,'23006821938796',NULL,'Pessoa177','Endereço177','pessoa177@example.com','9999999917','1981-06-13','M'),(204,'34315304918508',NULL,'Pessoa178','Endereço178','pessoa178@example.com','9999999917','2015-12-28','F'),(205,'74040344966613',NULL,'Pessoa179','Endereço179','pessoa179@example.com','9999999917','2017-03-30','M'),(206,'66714508362779',NULL,'Pessoa180','Endereço180','pessoa180@example.com','9999999918','1964-07-05','M'),(207,'28071498757294',NULL,'Pessoa181','Endereço181','pessoa181@example.com','9999999918','1968-11-06','F'),(208,'14428318621989',NULL,'Pessoa182','Endereço182','pessoa182@example.com','9999999918','2001-01-11','F'),(209,'56335167145668',NULL,'Pessoa183','Endereço183','pessoa183@example.com','9999999918','2000-02-20','M'),(210,'87248912693233',NULL,'Pessoa184','Endereço184','pessoa184@example.com','9999999918','2019-01-20','F'),(211,'78863646359055',NULL,'Pessoa185','Endereço185','pessoa185@example.com','9999999918','1997-08-04','F'),(212,'13371209840635',NULL,'Pessoa186','Endereço186','pessoa186@example.com','9999999918','1988-05-14','F'),(213,'40378479389826',NULL,'Pessoa187','Endereço187','pessoa187@example.com','9999999918','2009-09-30','M'),(214,'99255829322390',NULL,'Pessoa188','Endereço188','pessoa188@example.com','9999999918','1990-07-18','F'),(215,'30247546099356',NULL,'Pessoa189','Endereço189','pessoa189@example.com','9999999918','1975-07-27','M'),(216,'29896440077476',NULL,'Pessoa190','Endereço190','pessoa190@example.com','9999999919','2015-07-18','M'),(217,'65031605348951',NULL,'Pessoa191','Endereço191','pessoa191@example.com','9999999919','2020-06-21','M'),(218,'95324689657729',NULL,'Pessoa192','Endereço192','pessoa192@example.com','9999999919','1994-10-03','F'),(219,'40121972030142',NULL,'Pessoa193','Endereço193','pessoa193@example.com','9999999919','2022-12-25','M'),(220,'25991285486138',NULL,'Pessoa194','Endereço194','pessoa194@example.com','9999999919','1977-08-14','M'),(221,'26009737910711',NULL,'Pessoa195','Endereço195','pessoa195@example.com','9999999919','2023-03-31','M'),(222,'49014468564665',NULL,'Pessoa196','Endereço196','pessoa196@example.com','9999999919','1981-08-10','M'),(223,'88894705417467',NULL,'Pessoa197','Endereço197','pessoa197@example.com','9999999919','1975-08-18','M'),(224,'48185925984928',NULL,'Pessoa198','Endereço198','pessoa198@example.com','9999999919','2021-10-12','F'),(225,'34717176356089',NULL,'Pessoa199','Endereço199','pessoa199@example.com','9999999919','1978-03-10','F'),(226,'56354250727551',NULL,'Pessoa200','Endereço200','pessoa200@example.com','9999999920','1981-03-29','F'),(227,'80976440423146',NULL,'Pessoa201','Endereço201','pessoa201@example.com','9999999920','2023-06-27','F'),(228,'26550608041277',NULL,'Pessoa202','Endereço202','pessoa202@example.com','9999999920','2023-01-15','M'),(229,'47684895710726',NULL,'Pessoa203','Endereço203','pessoa203@example.com','9999999920','1985-11-16','F'),(230,'57925383577053',NULL,'Pessoa204','Endereço204','pessoa204@example.com','9999999920','2022-10-02','M'),(231,'36538645808155',NULL,'Pessoa205','Endereço205','pessoa205@example.com','9999999920','2019-01-25','M'),(232,'29106451905431',NULL,'Pessoa206','Endereço206','pessoa206@example.com','9999999920','1987-07-13','M'),(233,'11972859447796',NULL,'Pessoa207','Endereço207','pessoa207@example.com','9999999920','2022-07-27','M'),(234,'11954698210539',NULL,'Pessoa208','Endereço208','pessoa208@example.com','9999999920','2019-07-07','M'),(235,'23108795586143',NULL,'Pessoa209','Endereço209','pessoa209@example.com','9999999920','1968-05-01','M'),(236,'15926939040354',NULL,'Pessoa210','Endereço210','pessoa210@example.com','9999999921','1973-08-01','F'),(237,'40217786235937',NULL,'Pessoa211','Endereço211','pessoa211@example.com','9999999921','1976-11-13','F'),(238,'17395688618901',NULL,'Pessoa212','Endereço212','pessoa212@example.com','9999999921','1977-11-23','F'),(239,'55775004975288',NULL,'Pessoa213','Endereço213','pessoa213@example.com','9999999921','1971-06-21','F'),(240,'52316949146163',NULL,'Pessoa214','Endereço214','pessoa214@example.com','9999999921','1969-03-11','M'),(241,'89430941193765',NULL,'Pessoa215','Endereço215','pessoa215@example.com','9999999921','2020-05-23','F'),(242,'91917812388313',NULL,'Pessoa216','Endereço216','pessoa216@example.com','9999999921','1980-11-24','F'),(243,'98789722666879',NULL,'Pessoa217','Endereço217','pessoa217@example.com','9999999921','1995-11-13','M'),(244,'41397022699375',NULL,'Pessoa218','Endereço218','pessoa218@example.com','9999999921','1981-04-08','M'),(245,'34439447777755',NULL,'Pessoa219','Endereço219','pessoa219@example.com','9999999921','1967-12-26','F'),(246,'37436353170719',NULL,'Pessoa220','Endereço220','pessoa220@example.com','9999999922','2019-01-31','M'),(247,'15043307491618',NULL,'Pessoa221','Endereço221','pessoa221@example.com','9999999922','1968-10-05','M'),(248,'32683207553516',NULL,'Pessoa222','Endereço222','pessoa222@example.com','9999999922','2019-08-17','F'),(249,'68487445841066',NULL,'Pessoa223','Endereço223','pessoa223@example.com','9999999922','1991-01-02','F'),(250,'26549207173799',NULL,'Pessoa224','Endereço224','pessoa224@example.com','9999999922','1985-07-30','F'),(251,'24775680028624',NULL,'Pessoa225','Endereço225','pessoa225@example.com','9999999922','1964-07-26','M'),(252,'25225952430838',NULL,'Pessoa226','Endereço226','pessoa226@example.com','9999999922','1989-01-28','M'),(253,'19132977527690',NULL,'Pessoa227','Endereço227','pessoa227@example.com','9999999922','1998-10-18','F'),(254,'59537630416022',NULL,'Pessoa228','Endereço228','pessoa228@example.com','9999999922','1994-10-09','F'),(255,'36420183867607',NULL,'Pessoa229','Endereço229','pessoa229@example.com','9999999922','2009-10-28','M'),(256,'66098832009452',NULL,'Pessoa230','Endereço230','pessoa230@example.com','9999999923','2003-08-28','F'),(257,'94561740164236',NULL,'Pessoa231','Endereço231','pessoa231@example.com','9999999923','2003-04-10','F'),(258,'40270892717196',NULL,'Pessoa232','Endereço232','pessoa232@example.com','9999999923','2019-03-17','M'),(259,'58504576774783',NULL,'Pessoa233','Endereço233','pessoa233@example.com','9999999923','1985-01-17','F'),(260,'13052182451870',NULL,'Pessoa234','Endereço234','pessoa234@example.com','9999999923','1999-11-23','F'),(261,'24551167063928',NULL,'Pessoa235','Endereço235','pessoa235@example.com','9999999923','2011-05-31','F'),(262,'11684582747225',NULL,'Pessoa236','Endereço236','pessoa236@example.com','9999999923','1992-06-02','F'),(263,'21885252885413',NULL,'Pessoa237','Endereço237','pessoa237@example.com','9999999923','2020-09-08','F'),(264,'15336640491463',NULL,'Pessoa238','Endereço238','pessoa238@example.com','9999999923','1977-01-03','F'),(265,'26029555244398',NULL,'Pessoa239','Endereço239','pessoa239@example.com','9999999923','1976-04-27','M'),(266,'68275270115840',NULL,'Pessoa240','Endereço240','pessoa240@example.com','9999999924','2021-08-09','M'),(267,'99223761501930',NULL,'Pessoa241','Endereço241','pessoa241@example.com','9999999924','2005-04-08','F'),(268,'84468770860199',NULL,'Pessoa242','Endereço242','pessoa242@example.com','9999999924','1993-12-25','F'),(269,'48460252097305',NULL,'Pessoa243','Endereço243','pessoa243@example.com','9999999924','2011-12-04','F'),(270,'86163498392480',NULL,'Pessoa244','Endereço244','pessoa244@example.com','9999999924','2013-01-04','M'),(271,'24653208604690',NULL,'Pessoa245','Endereço245','pessoa245@example.com','9999999924','1975-07-04','F'),(272,'25842375611739',NULL,'Pessoa246','Endereço246','pessoa246@example.com','9999999924','2003-07-22','M'),(273,'71753560445973',NULL,'Pessoa247','Endereço247','pessoa247@example.com','9999999924','2022-05-07','M'),(274,'22540837994349',NULL,'Pessoa248','Endereço248','pessoa248@example.com','9999999924','1988-11-17','M'),(275,'65921051340104',NULL,'Pessoa249','Endereço249','pessoa249@example.com','9999999924','1981-12-01','F'),(276,'95081625194364',NULL,'Pessoa250','Endereço250','pessoa250@example.com','9999999925','1968-12-04','F'),(277,'86661773199831',NULL,'Pessoa251','Endereço251','pessoa251@example.com','9999999925','2016-12-28','F'),(278,'65738119572157',NULL,'Pessoa252','Endereço252','pessoa252@example.com','9999999925','2015-10-17','F'),(279,'59181833210570',NULL,'Pessoa253','Endereço253','pessoa253@example.com','9999999925','2001-03-12','M'),(280,'99617572230862',NULL,'Pessoa254','Endereço254','pessoa254@example.com','9999999925','2004-11-16','F'),(281,'91496425617017',NULL,'Pessoa255','Endereço255','pessoa255@example.com','9999999925','1974-02-01','M'),(282,'60039742961562',NULL,'Pessoa256','Endereço256','pessoa256@example.com','9999999925','1989-10-22','M'),(283,'12776089099027',NULL,'Pessoa257','Endereço257','pessoa257@example.com','9999999925','1980-02-20','F'),(284,'51014211793443',NULL,'Pessoa258','Endereço258','pessoa258@example.com','9999999925','1981-05-22','M'),(285,'66182681635192',NULL,'Pessoa259','Endereço259','pessoa259@example.com','9999999925','1982-08-23','F'),(286,'67230956225871',NULL,'Pessoa260','Endereço260','pessoa260@example.com','9999999926','1989-04-21','F'),(287,'11544237752951',NULL,'Pessoa261','Endereço261','pessoa261@example.com','9999999926','2008-08-22','M'),(288,'28303345971091',NULL,'Pessoa262','Endereço262','pessoa262@example.com','9999999926','1996-08-28','F'),(289,'82573402191114',NULL,'Pessoa263','Endereço263','pessoa263@example.com','9999999926','2015-01-13','M'),(290,'11681977903174',NULL,'Pessoa264','Endereço264','pessoa264@example.com','9999999926','2009-11-20','M'),(291,'75076516927291',NULL,'Pessoa265','Endereço265','pessoa265@example.com','9999999926','2001-03-17','F'),(292,'40708094631049',NULL,'Pessoa266','Endereço266','pessoa266@example.com','9999999926','1985-08-30','M'),(293,'79581757280586',NULL,'Pessoa267','Endereço267','pessoa267@example.com','9999999926','1995-08-18','M'),(294,'67422171241996',NULL,'Pessoa268','Endereço268','pessoa268@example.com','9999999926','2013-05-03','F'),(295,'25066396617392',NULL,'Pessoa269','Endereço269','pessoa269@example.com','9999999926','2021-09-05','F'),(296,'24913249690936',NULL,'Pessoa270','Endereço270','pessoa270@example.com','9999999927','1971-02-19','F'),(297,'76267410438756',NULL,'Pessoa271','Endereço271','pessoa271@example.com','9999999927','2019-07-03','M'),(298,'48735237278728',NULL,'Pessoa272','Endereço272','pessoa272@example.com','9999999927','1977-03-04','F'),(299,'59599044285341',NULL,'Pessoa273','Endereço273','pessoa273@example.com','9999999927','2021-07-10','F'),(300,'52072280135073',NULL,'Pessoa274','Endereço274','pessoa274@example.com','9999999927','1975-09-30','F'),(301,'56608358935088',NULL,'Pessoa275','Endereço275','pessoa275@example.com','9999999927','1972-11-23','F'),(302,'82717294993547',NULL,'Pessoa276','Endereço276','pessoa276@example.com','9999999927','2021-05-30','F'),(303,'68958052069841',NULL,'Pessoa277','Endereço277','pessoa277@example.com','9999999927','2022-05-20','M'),(304,'63277344594967',NULL,'Pessoa278','Endereço278','pessoa278@example.com','9999999927','1989-04-27','M'),(305,'70320305545181',NULL,'Pessoa279','Endereço279','pessoa279@example.com','9999999927','2016-03-12','F'),(306,'67136283383831',NULL,'Pessoa280','Endereço280','pessoa280@example.com','9999999928','2001-02-18','F'),(307,'72254564820094',NULL,'Pessoa281','Endereço281','pessoa281@example.com','9999999928','1989-04-04','F'),(308,'27685678077568',NULL,'Pessoa282','Endereço282','pessoa282@example.com','9999999928','1985-05-22','F'),(309,'13981139896419',NULL,'Pessoa283','Endereço283','pessoa283@example.com','9999999928','1996-07-20','M'),(310,'30978027452694',NULL,'Pessoa284','Endereço284','pessoa284@example.com','9999999928','1974-08-09','M'),(311,'50751562845661',NULL,'Pessoa285','Endereço285','pessoa285@example.com','9999999928','2016-02-08','M'),(312,'93718430263659',NULL,'Pessoa286','Endereço286','pessoa286@example.com','9999999928','1971-05-08','F'),(313,'27182368093340',NULL,'Pessoa287','Endereço287','pessoa287@example.com','9999999928','2007-02-10','F'),(314,'24191974181860',NULL,'Pessoa288','Endereço288','pessoa288@example.com','9999999928','1999-06-21','F'),(315,'51434139862129',NULL,'Pessoa289','Endereço289','pessoa289@example.com','9999999928','1981-05-03','M'),(316,'61548029893588',NULL,'Pessoa290','Endereço290','pessoa290@example.com','9999999929','1996-04-26','F'),(317,'45120759043023',NULL,'Pessoa291','Endereço291','pessoa291@example.com','9999999929','2005-07-07','M'),(318,'77864060148470',NULL,'Pessoa292','Endereço292','pessoa292@example.com','9999999929','1976-12-03','F'),(319,'80864461549431',NULL,'Pessoa293','Endereço293','pessoa293@example.com','9999999929','2019-08-05','F'),(320,'66827443779285',NULL,'Pessoa294','Endereço294','pessoa294@example.com','9999999929','2007-12-02','M'),(321,'32855184341645',NULL,'Pessoa295','Endereço295','pessoa295@example.com','9999999929','2020-08-03','M'),(322,'34073909124428',NULL,'Pessoa296','Endereço296','pessoa296@example.com','9999999929','1970-03-25','F'),(323,'58822896563283',NULL,'Pessoa297','Endereço297','pessoa297@example.com','9999999929','1976-05-03','M'),(324,'25836322536539',NULL,'Pessoa298','Endereço298','pessoa298@example.com','9999999929','1966-02-06','M'),(325,'48687739547982',NULL,'Pessoa299','Endereço299','pessoa299@example.com','9999999929','2001-06-26','F'),(326,'67438599185495',NULL,'Pessoa300','Endereço300','pessoa300@example.com','9999999930','1990-10-03','F'),(327,'50519110877550',NULL,'Pessoa301','Endereço301','pessoa301@example.com','9999999930','1975-09-22','F'),(328,'80686836029111',NULL,'Pessoa302','Endereço302','pessoa302@example.com','9999999930','2022-04-10','F'),(329,'70931032468500',NULL,'Pessoa303','Endereço303','pessoa303@example.com','9999999930','2015-01-18','F'),(330,'95938168527500',NULL,'Pessoa304','Endereço304','pessoa304@example.com','9999999930','1978-09-26','F'),(331,'19915749384011',NULL,'Pessoa305','Endereço305','pessoa305@example.com','9999999930','1967-02-23','M'),(332,'12929544311882',NULL,'Pessoa306','Endereço306','pessoa306@example.com','9999999930','2020-06-23','M'),(333,'66638455415739',NULL,'Pessoa307','Endereço307','pessoa307@example.com','9999999930','1982-11-24','M'),(334,'51978880671764',NULL,'Pessoa308','Endereço308','pessoa308@example.com','9999999930','1973-08-05','F'),(335,'39072301349669',NULL,'Pessoa309','Endereço309','pessoa309@example.com','9999999930','2004-03-10','F'),(336,'32354473669412',NULL,'Pessoa310','Endereço310','pessoa310@example.com','9999999931','2004-10-14','F'),(337,'23405900945333',NULL,'Pessoa311','Endereço311','pessoa311@example.com','9999999931','2005-12-16','M'),(338,'28901430386026',NULL,'Pessoa312','Endereço312','pessoa312@example.com','9999999931','1963-10-03','M'),(339,'80155249191592',NULL,'Pessoa313','Endereço313','pessoa313@example.com','9999999931','1973-06-04','F'),(340,'72081458738149',NULL,'Pessoa314','Endereço314','pessoa314@example.com','9999999931','1967-09-12','F'),(341,'22325114712421',NULL,'Pessoa315','Endereço315','pessoa315@example.com','9999999931','1967-12-19','M'),(342,'39809934897171',NULL,'Pessoa316','Endereço316','pessoa316@example.com','9999999931','1964-03-12','F'),(343,'82016838371769',NULL,'Pessoa317','Endereço317','pessoa317@example.com','9999999931','2015-02-22','M'),(344,'16478971351384',NULL,'Pessoa318','Endereço318','pessoa318@example.com','9999999931','1995-08-19','M'),(345,'23863215906418',NULL,'Pessoa319','Endereço319','pessoa319@example.com','9999999931','1997-02-11','F'),(346,'44125189859536',NULL,'Pessoa320','Endereço320','pessoa320@example.com','9999999932','1983-01-07','M'),(347,'25708503123101',NULL,'Pessoa321','Endereço321','pessoa321@example.com','9999999932','2014-05-30','M'),(348,'75300267474074',NULL,'Pessoa322','Endereço322','pessoa322@example.com','9999999932','1968-06-05','M'),(349,'39891957435656',NULL,'Pessoa323','Endereço323','pessoa323@example.com','9999999932','1999-02-05','M'),(350,'98249516885960',NULL,'Pessoa324','Endereço324','pessoa324@example.com','9999999932','1976-09-08','F'),(351,'52878643947540',NULL,'Pessoa325','Endereço325','pessoa325@example.com','9999999932','1994-02-16','M'),(352,'67554703715773',NULL,'Pessoa326','Endereço326','pessoa326@example.com','9999999932','2015-08-26','F'),(353,'36653054511782',NULL,'Pessoa327','Endereço327','pessoa327@example.com','9999999932','2007-07-14','M'),(354,'48267504450182',NULL,'Pessoa328','Endereço328','pessoa328@example.com','9999999932','1976-02-09','F'),(355,'11768028029955',NULL,'Pessoa329','Endereço329','pessoa329@example.com','9999999932','2019-09-30','M'),(356,'18219766074996',NULL,'Pessoa330','Endereço330','pessoa330@example.com','9999999933','1982-03-30','M'),(357,'79844673024345',NULL,'Pessoa331','Endereço331','pessoa331@example.com','9999999933','2001-01-05','F'),(358,'65640301756225',NULL,'Pessoa332','Endereço332','pessoa332@example.com','9999999933','1996-11-15','M'),(359,'55418112674186',NULL,'Pessoa333','Endereço333','pessoa333@example.com','9999999933','1998-04-25','F'),(360,'71161010350250',NULL,'Pessoa334','Endereço334','pessoa334@example.com','9999999933','1985-07-19','M'),(361,'76591929650485',NULL,'Pessoa335','Endereço335','pessoa335@example.com','9999999933','2004-08-07','M'),(362,'86007236415527',NULL,'Pessoa336','Endereço336','pessoa336@example.com','9999999933','2014-08-29','M'),(363,'62596956512515',NULL,'Pessoa337','Endereço337','pessoa337@example.com','9999999933','2005-03-20','F'),(364,'95561281615459',NULL,'Pessoa338','Endereço338','pessoa338@example.com','9999999933','1997-07-14','M'),(365,'34784847232312',NULL,'Pessoa339','Endereço339','pessoa339@example.com','9999999933','1997-08-25','M'),(366,'42633318801069',NULL,'Pessoa340','Endereço340','pessoa340@example.com','9999999934','1974-06-09','M'),(367,'61474772646534',NULL,'Pessoa341','Endereço341','pessoa341@example.com','9999999934','1972-12-24','M'),(368,'96882347927319',NULL,'Pessoa342','Endereço342','pessoa342@example.com','9999999934','2003-09-20','F'),(369,'80769116562576',NULL,'Pessoa343','Endereço343','pessoa343@example.com','9999999934','1983-08-20','F'),(370,'85706074801931',NULL,'Pessoa344','Endereço344','pessoa344@example.com','9999999934','2005-04-25','F'),(371,'15719980798400',NULL,'Pessoa345','Endereço345','pessoa345@example.com','9999999934','2003-07-23','M'),(372,'43534588053389',NULL,'Pessoa346','Endereço346','pessoa346@example.com','9999999934','1997-02-19','M'),(373,'18327706547759',NULL,'Pessoa347','Endereço347','pessoa347@example.com','9999999934','2010-08-19','F'),(374,'40782790212689',NULL,'Pessoa348','Endereço348','pessoa348@example.com','9999999934','2004-06-17','F'),(375,'87775284059136',NULL,'Pessoa349','Endereço349','pessoa349@example.com','9999999934','1985-09-29','F'),(376,'90887532821751',NULL,'Pessoa350','Endereço350','pessoa350@example.com','9999999935','1974-05-02','M'),(377,'61070099976910',NULL,'Pessoa351','Endereço351','pessoa351@example.com','9999999935','1986-05-06','M'),(378,'21644755798992',NULL,'Pessoa352','Endereço352','pessoa352@example.com','9999999935','1996-05-07','F'),(379,'12687908376276',NULL,'Pessoa353','Endereço353','pessoa353@example.com','9999999935','1992-08-09','M'),(380,'90624407362774',NULL,'Pessoa354','Endereço354','pessoa354@example.com','9999999935','2022-09-18','M'),(381,'87379206695947',NULL,'Pessoa355','Endereço355','pessoa355@example.com','9999999935','2014-01-04','M'),(382,'63477680714314',NULL,'Pessoa356','Endereço356','pessoa356@example.com','9999999935','2003-10-21','F'),(383,'38976020188048',NULL,'Pessoa357','Endereço357','pessoa357@example.com','9999999935','2022-01-16','M'),(384,'74184379590846',NULL,'Pessoa358','Endereço358','pessoa358@example.com','9999999935','2017-11-30','M'),(385,'42397966023905',NULL,'Pessoa359','Endereço359','pessoa359@example.com','9999999935','1974-08-16','F'),(386,'58859176793004',NULL,'Pessoa360','Endereço360','pessoa360@example.com','9999999936','1980-04-24','F'),(387,'73989204628383',NULL,'Pessoa361','Endereço361','pessoa361@example.com','9999999936','1985-09-04','M'),(388,'29938740692975',NULL,'Pessoa362','Endereço362','pessoa362@example.com','9999999936','2021-03-17','F'),(389,'57390874305172',NULL,'Pessoa363','Endereço363','pessoa363@example.com','9999999936','2020-09-06','F'),(390,'22924089536931',NULL,'Pessoa364','Endereço364','pessoa364@example.com','9999999936','1978-10-04','M'),(391,'34373700548311',NULL,'Pessoa365','Endereço365','pessoa365@example.com','9999999936','1996-09-04','M'),(392,'80945770201222',NULL,'Pessoa366','Endereço366','pessoa366@example.com','9999999936','1983-10-20','F'),(393,'77571845126870',NULL,'Pessoa367','Endereço367','pessoa367@example.com','9999999936','1968-11-24','M'),(394,'80211958550114',NULL,'Pessoa368','Endereço368','pessoa368@example.com','9999999936','1963-12-31','F'),(395,'22517009417076',NULL,'Pessoa369','Endereço369','pessoa369@example.com','9999999936','1974-01-22','F'),(396,'15638016346504',NULL,'Pessoa370','Endereço370','pessoa370@example.com','9999999937','2012-02-01','F'),(397,'33082197292784',NULL,'Pessoa371','Endereço371','pessoa371@example.com','9999999937','1964-06-15','M'),(398,'84349485900578',NULL,'Pessoa372','Endereço372','pessoa372@example.com','9999999937','1983-11-08','F'),(399,'24739688974562',NULL,'Pessoa373','Endereço373','pessoa373@example.com','9999999937','2003-10-03','M'),(400,'81739142482857',NULL,'Pessoa374','Endereço374','pessoa374@example.com','9999999937','1992-09-19','M'),(401,'41159940148852',NULL,'Pessoa375','Endereço375','pessoa375@example.com','9999999937','2011-08-13','F'),(402,'25838508704526',NULL,'Pessoa376','Endereço376','pessoa376@example.com','9999999937','2022-07-07','F'),(403,'75762456176581',NULL,'Pessoa377','Endereço377','pessoa377@example.com','9999999937','1964-06-24','F'),(404,'73356902937737',NULL,'Pessoa378','Endereço378','pessoa378@example.com','9999999937','2004-01-16','F'),(405,'62966062084740',NULL,'Pessoa379','Endereço379','pessoa379@example.com','9999999937','1999-04-06','M'),(406,'16648731293760',NULL,'Pessoa380','Endereço380','pessoa380@example.com','9999999938','1987-09-29','F'),(407,'11814971046349',NULL,'Pessoa381','Endereço381','pessoa381@example.com','9999999938','1974-09-06','M'),(408,'65682082609908',NULL,'Pessoa382','Endereço382','pessoa382@example.com','9999999938','2020-03-02','M'),(409,'95562534374708',NULL,'Pessoa383','Endereço383','pessoa383@example.com','9999999938','1994-08-08','F'),(410,'41586663342627',NULL,'Pessoa384','Endereço384','pessoa384@example.com','9999999938','2018-12-18','M'),(411,'46744783126511',NULL,'Pessoa385','Endereço385','pessoa385@example.com','9999999938','2019-12-14','M'),(412,'26742883703431',NULL,'Pessoa386','Endereço386','pessoa386@example.com','9999999938','1980-11-14','F'),(413,'87321695692205',NULL,'Pessoa387','Endereço387','pessoa387@example.com','9999999938','2005-07-20','F'),(414,'73677939217237',NULL,'Pessoa388','Endereço388','pessoa388@example.com','9999999938','1977-02-20','F'),(415,'46549497522925',NULL,'Pessoa389','Endereço389','pessoa389@example.com','9999999938','1975-11-22','F'),(416,'44655586802079',NULL,'Pessoa390','Endereço390','pessoa390@example.com','9999999939','1983-09-09','M'),(417,'85610654880861',NULL,'Pessoa391','Endereço391','pessoa391@example.com','9999999939','1981-07-06','F'),(418,'83151690646215',NULL,'Pessoa392','Endereço392','pessoa392@example.com','9999999939','2016-08-15','M'),(419,'40647713747478',NULL,'Pessoa393','Endereço393','pessoa393@example.com','9999999939','2006-01-25','M'),(420,'36721596183927',NULL,'Pessoa394','Endereço394','pessoa394@example.com','9999999939','2012-08-03','M'),(421,'60239567365720',NULL,'Pessoa395','Endereço395','pessoa395@example.com','9999999939','1979-11-17','F'),(422,'67682436125057',NULL,'Pessoa396','Endereço396','pessoa396@example.com','9999999939','2004-12-12','F'),(423,'28126714963583',NULL,'Pessoa397','Endereço397','pessoa397@example.com','9999999939','2015-10-24','M'),(424,'82711565543628',NULL,'Pessoa398','Endereço398','pessoa398@example.com','9999999939','1968-02-29','M'),(425,'27504083306998',NULL,'Pessoa399','Endereço399','pessoa399@example.com','9999999939','1999-11-30','M'),(426,'77114538715327',NULL,'Pessoa400','Endereço400','pessoa400@example.com','9999999940','1989-03-16','F'),(427,'46552991770722',NULL,'Pessoa401','Endereço401','pessoa401@example.com','9999999940','2014-02-14','F'),(428,'42146940177443',NULL,'Pessoa402','Endereço402','pessoa402@example.com','9999999940','2018-02-28','M'),(429,'64824580219410',NULL,'Pessoa403','Endereço403','pessoa403@example.com','9999999940','1968-05-25','F'),(430,'17999176595359',NULL,'Pessoa404','Endereço404','pessoa404@example.com','9999999940','2015-05-11','M'),(431,'69670605538106',NULL,'Pessoa405','Endereço405','pessoa405@example.com','9999999940','2019-03-15','M'),(432,'67670818807250',NULL,'Pessoa406','Endereço406','pessoa406@example.com','9999999940','2018-02-22','F'),(433,'42559298884644',NULL,'Pessoa407','Endereço407','pessoa407@example.com','9999999940','2009-09-18','M'),(434,'67631946809247',NULL,'Pessoa408','Endereço408','pessoa408@example.com','9999999940','2023-05-06','M'),(435,'51454818687825',NULL,'Pessoa409','Endereço409','pessoa409@example.com','9999999940','2022-03-31','F'),(436,'60323075009810',NULL,'Pessoa410','Endereço410','pessoa410@example.com','9999999941','1986-03-26','M'),(437,'36566040047040',NULL,'Pessoa411','Endereço411','pessoa411@example.com','9999999941','2012-10-08','M'),(438,'56560322331786',NULL,'Pessoa412','Endereço412','pessoa412@example.com','9999999941','1990-05-03','M'),(439,'47542849106288',NULL,'Pessoa413','Endereço413','pessoa413@example.com','9999999941','1997-03-12','F'),(440,'46299369378294',NULL,'Pessoa414','Endereço414','pessoa414@example.com','9999999941','2012-06-23','F'),(441,'10292768227209',NULL,'Pessoa415','Endereço415','pessoa415@example.com','9999999941','1970-08-07','M'),(442,'43338628796244',NULL,'Pessoa416','Endereço416','pessoa416@example.com','9999999941','1985-02-01','M'),(443,'59185705398382',NULL,'Pessoa417','Endereço417','pessoa417@example.com','9999999941','1996-06-30','F'),(444,'74713598205441',NULL,'Pessoa418','Endereço418','pessoa418@example.com','9999999941','1978-05-30','F'),(445,'79073954512434',NULL,'Pessoa419','Endereço419','pessoa419@example.com','9999999941','2022-03-02','F'),(446,'98649353281268',NULL,'Pessoa420','Endereço420','pessoa420@example.com','9999999942','1993-12-12','F'),(447,'16951634499199',NULL,'Pessoa421','Endereço421','pessoa421@example.com','9999999942','1972-06-10','M'),(448,'62598365175163',NULL,'Pessoa422','Endereço422','pessoa422@example.com','9999999942','1973-04-12','M'),(449,'70175226368173',NULL,'Pessoa423','Endereço423','pessoa423@example.com','9999999942','2021-07-05','M'),(450,'73862393557897',NULL,'Pessoa424','Endereço424','pessoa424@example.com','9999999942','2019-10-28','M'),(451,'74260516524557',NULL,'Pessoa425','Endereço425','pessoa425@example.com','9999999942','2021-09-10','M'),(452,'96556839734834',NULL,'Pessoa426','Endereço426','pessoa426@example.com','9999999942','1976-12-14','F'),(453,'69513376457163',NULL,'Pessoa427','Endereço427','pessoa427@example.com','9999999942','2004-11-05','F'),(454,'94035587566006',NULL,'Pessoa428','Endereço428','pessoa428@example.com','9999999942','1966-09-12','F'),(455,'85985984770568',NULL,'Pessoa429','Endereço429','pessoa429@example.com','9999999942','1999-01-02','F'),(456,'39918061196727',NULL,'Pessoa430','Endereço430','pessoa430@example.com','9999999943','2015-12-08','F'),(457,'81823450766339',NULL,'Pessoa431','Endereço431','pessoa431@example.com','9999999943','2018-07-07','M'),(458,'88088552828960',NULL,'Pessoa432','Endereço432','pessoa432@example.com','9999999943','2007-07-01','F'),(459,'87851199459145',NULL,'Pessoa433','Endereço433','pessoa433@example.com','9999999943','2016-01-11','M'),(460,'79705174183198',NULL,'Pessoa434','Endereço434','pessoa434@example.com','9999999943','1976-08-01','F'),(461,'64431693092390',NULL,'Pessoa435','Endereço435','pessoa435@example.com','9999999943','2008-05-31','M'),(462,'52495888278350',NULL,'Pessoa436','Endereço436','pessoa436@example.com','9999999943','2022-02-01','F'),(463,'50015492606922',NULL,'Pessoa437','Endereço437','pessoa437@example.com','9999999943','2016-09-26','M'),(464,'83850568871805',NULL,'Pessoa438','Endereço438','pessoa438@example.com','9999999943','1999-02-18','F'),(465,'67627353191028',NULL,'Pessoa439','Endereço439','pessoa439@example.com','9999999943','1994-06-07','F'),(466,'16223039576991',NULL,'Pessoa440','Endereço440','pessoa440@example.com','9999999944','1973-09-13','F'),(467,'31904773835004',NULL,'Pessoa441','Endereço441','pessoa441@example.com','9999999944','2001-01-09','M'),(468,'64359982055015',NULL,'Pessoa442','Endereço442','pessoa442@example.com','9999999944','1988-08-12','M'),(469,'77369814689615',NULL,'Pessoa443','Endereço443','pessoa443@example.com','9999999944','1996-10-19','F'),(470,'61865803517276',NULL,'Pessoa444','Endereço444','pessoa444@example.com','9999999944','1967-07-22','F'),(471,'90279428595937',NULL,'Pessoa445','Endereço445','pessoa445@example.com','9999999944','1984-11-16','F'),(472,'81977736541980',NULL,'Pessoa446','Endereço446','pessoa446@example.com','9999999944','2002-01-05','M'),(473,'90674495101603',NULL,'Pessoa447','Endereço447','pessoa447@example.com','9999999944','2005-08-20','F'),(474,'20560865328238',NULL,'Pessoa448','Endereço448','pessoa448@example.com','9999999944','2012-10-08','F'),(475,'26658002349229',NULL,'Pessoa449','Endereço449','pessoa449@example.com','9999999944','2006-01-14','F'),(476,'67496967909389',NULL,'Pessoa450','Endereço450','pessoa450@example.com','9999999945','1994-05-18','F'),(477,'19991513155392',NULL,'Pessoa451','Endereço451','pessoa451@example.com','9999999945','2022-09-17','F'),(478,'66903062711379',NULL,'Pessoa452','Endereço452','pessoa452@example.com','9999999945','1966-02-08','F'),(479,'62474305548215',NULL,'Pessoa453','Endereço453','pessoa453@example.com','9999999945','2009-01-10','M'),(480,'61561894483456',NULL,'Pessoa454','Endereço454','pessoa454@example.com','9999999945','1994-05-28','F'),(481,'18145452708141',NULL,'Pessoa455','Endereço455','pessoa455@example.com','9999999945','2004-02-03','M'),(482,'79465209431448',NULL,'Pessoa456','Endereço456','pessoa456@example.com','9999999945','1974-10-16','F'),(483,'37289675229498',NULL,'Pessoa457','Endereço457','pessoa457@example.com','9999999945','2007-04-06','M'),(484,'47613507544261',NULL,'Pessoa458','Endereço458','pessoa458@example.com','9999999945','1978-07-05','M'),(485,'32259516177940',NULL,'Pessoa459','Endereço459','pessoa459@example.com','9999999945','1979-05-04','F'),(486,'55196734373640',NULL,'Pessoa460','Endereço460','pessoa460@example.com','9999999946','1982-07-24','F'),(487,'54731956920336',NULL,'Pessoa461','Endereço461','pessoa461@example.com','9999999946','1978-02-14','M'),(488,'28244869372104',NULL,'Pessoa462','Endereço462','pessoa462@example.com','9999999946','2015-10-15','M'),(489,'81826856752696',NULL,'Pessoa463','Endereço463','pessoa463@example.com','9999999946','1970-10-21','M'),(490,'43537211002350',NULL,'Pessoa464','Endereço464','pessoa464@example.com','9999999946','1972-02-22','M'),(491,'33651891698736',NULL,'Pessoa465','Endereço465','pessoa465@example.com','9999999946','1974-09-22','M'),(492,'96646782668909',NULL,'Pessoa466','Endereço466','pessoa466@example.com','9999999946','1965-04-18','F'),(493,'93141681480353',NULL,'Pessoa467','Endereço467','pessoa467@example.com','9999999946','1980-07-21','F'),(494,'91871530201166',NULL,'Pessoa468','Endereço468','pessoa468@example.com','9999999946','2016-10-08','F'),(495,'84897159957231',NULL,'Pessoa469','Endereço469','pessoa469@example.com','9999999946','1984-01-06','F'),(496,'11241624980458',NULL,'Pessoa470','Endereço470','pessoa470@example.com','9999999947','1983-01-28','M'),(497,'67106823424908',NULL,'Pessoa471','Endereço471','pessoa471@example.com','9999999947','2012-11-15','F'),(498,'45022143353728',NULL,'Pessoa472','Endereço472','pessoa472@example.com','9999999947','1964-01-05','F'),(499,'99887379659234',NULL,'Pessoa473','Endereço473','pessoa473@example.com','9999999947','1987-01-27','M'),(500,'45392646021575',NULL,'Pessoa474','Endereço474','pessoa474@example.com','9999999947','1973-05-24','M'),(501,'54452574760143',NULL,'Pessoa475','Endereço475','pessoa475@example.com','9999999947','1995-06-10','F'),(502,'90604682062384',NULL,'Pessoa476','Endereço476','pessoa476@example.com','9999999947','1969-09-14','F'),(503,'38155190300340',NULL,'Pessoa477','Endereço477','pessoa477@example.com','9999999947','2013-11-18','F'),(504,'86088952176355',NULL,'Pessoa478','Endereço478','pessoa478@example.com','9999999947','1985-09-21','F'),(505,'26926179832710',NULL,'Pessoa479','Endereço479','pessoa479@example.com','9999999947','2017-12-18','F'),(506,'29692821688663',NULL,'Pessoa480','Endereço480','pessoa480@example.com','9999999948','1999-10-15','M'),(507,'48419023443403',NULL,'Pessoa481','Endereço481','pessoa481@example.com','9999999948','2013-08-03','F'),(508,'31815833711825',NULL,'Pessoa482','Endereço482','pessoa482@example.com','9999999948','1989-06-13','M'),(509,'87953207807571',NULL,'Pessoa483','Endereço483','pessoa483@example.com','9999999948','1964-04-10','M'),(510,'77229258219925',NULL,'Pessoa484','Endereço484','pessoa484@example.com','9999999948','1981-01-24','M'),(511,'43604190623019',NULL,'Pessoa485','Endereço485','pessoa485@example.com','9999999948','1965-06-19','F'),(512,'73145421737009',NULL,'Pessoa486','Endereço486','pessoa486@example.com','9999999948','2002-11-20','F'),(513,'14320735972673',NULL,'Pessoa487','Endereço487','pessoa487@example.com','9999999948','2000-01-15','F'),(514,'90732634748083',NULL,'Pessoa488','Endereço488','pessoa488@example.com','9999999948','2021-01-04','F'),(515,'51951052417933',NULL,'Pessoa489','Endereço489','pessoa489@example.com','9999999948','1977-01-08','M'),(516,'16303199069856',NULL,'Pessoa490','Endereço490','pessoa490@example.com','9999999949','1968-10-30','M'),(517,'11577654137814',NULL,'Pessoa491','Endereço491','pessoa491@example.com','9999999949','2021-05-31','M'),(518,'56026099972451',NULL,'Pessoa492','Endereço492','pessoa492@example.com','9999999949','2012-04-27','M'),(519,'49491479908573',NULL,'Pessoa493','Endereço493','pessoa493@example.com','9999999949','1963-11-24','F'),(520,'36613837263187',NULL,'Pessoa494','Endereço494','pessoa494@example.com','9999999949','1992-11-16','F'),(521,'82837167356942',NULL,'Pessoa495','Endereço495','pessoa495@example.com','9999999949','2021-01-26','F'),(522,'78399926282837',NULL,'Pessoa496','Endereço496','pessoa496@example.com','9999999949','1995-04-27','M'),(523,'95390727823032',NULL,'Pessoa497','Endereço497','pessoa497@example.com','9999999949','1991-11-14','F'),(524,'44460360039454',NULL,'Pessoa498','Endereço498','pessoa498@example.com','9999999949','1991-06-24','F'),(525,'11279295767917',NULL,'Pessoa499','Endereço499','pessoa499@example.com','9999999949','1993-07-05','M'),(526,'81914084201598',NULL,'Pessoa500','Endereço500','pessoa500@example.com','9999999950','1986-08-29','F'),(527,NULL,'12345678921','João da Silva','Rua A, 123','joao@example.com','(00) 1234-5678','1990-01-01','M');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saque`
--

DROP TABLE IF EXISTS `saque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saque` (
  `id_operacao` int NOT NULL,
  `status` varchar(20) DEFAULT 'Em processamento',
  PRIMARY KEY (`id_operacao`),
  KEY `FKs_status` (`status`),
  KEY `idx_saque_id_operacao` (`id_operacao`),
  CONSTRAINT `FKs_status` FOREIGN KEY (`status`) REFERENCES `statusmovimentacao` (`valor`),
  CONSTRAINT `saque_ibfk_1` FOREIGN KEY (`id_operacao`) REFERENCES `operacao` (`id_operacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saque`
--

LOCK TABLES `saque` WRITE;
/*!40000 ALTER TABLE `saque` DISABLE KEYS */;
INSERT INTO `saque` VALUES (1,'Concluído'),(3,'Concluído');
/*!40000 ALTER TABLE `saque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sexopermitido`
--

DROP TABLE IF EXISTS `sexopermitido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sexopermitido` (
  `valor` char(1) NOT NULL,
  PRIMARY KEY (`valor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sexopermitido`
--

LOCK TABLES `sexopermitido` WRITE;
/*!40000 ALTER TABLE `sexopermitido` DISABLE KEYS */;
INSERT INTO `sexopermitido` VALUES ('-'),('F'),('M');
/*!40000 ALTER TABLE `sexopermitido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statusconta`
--

DROP TABLE IF EXISTS `statusconta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statusconta` (
  `valor` varchar(20) NOT NULL,
  PRIMARY KEY (`valor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statusconta`
--

LOCK TABLES `statusconta` WRITE;
/*!40000 ALTER TABLE `statusconta` DISABLE KEYS */;
INSERT INTO `statusconta` VALUES ('Ativa'),('Bloqueada'),('Inativa');
/*!40000 ALTER TABLE `statusconta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statusfatura`
--

DROP TABLE IF EXISTS `statusfatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statusfatura` (
  `valor` varchar(20) NOT NULL,
  PRIMARY KEY (`valor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statusfatura`
--

LOCK TABLES `statusfatura` WRITE;
/*!40000 ALTER TABLE `statusfatura` DISABLE KEYS */;
INSERT INTO `statusfatura` VALUES ('Aguardando pagamento'),('Paga'),('Vencida');
/*!40000 ALTER TABLE `statusfatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statusmovimentacao`
--

DROP TABLE IF EXISTS `statusmovimentacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statusmovimentacao` (
  `valor` varchar(20) NOT NULL,
  PRIMARY KEY (`valor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statusmovimentacao`
--

LOCK TABLES `statusmovimentacao` WRITE;
/*!40000 ALTER TABLE `statusmovimentacao` DISABLE KEYS */;
INSERT INTO `statusmovimentacao` VALUES ('Concluído'),('Em processamento'),('Negado');
/*!40000 ALTER TABLE `statusmovimentacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiposoperacao`
--

DROP TABLE IF EXISTS `tiposoperacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiposoperacao` (
  `valor` char(1) NOT NULL,
  PRIMARY KEY (`valor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposoperacao`
--

LOCK TABLES `tiposoperacao` WRITE;
/*!40000 ALTER TABLE `tiposoperacao` DISABLE KEYS */;
INSERT INTO `tiposoperacao` VALUES ('D'),('E'),('I'),('S'),('T');
/*!40000 ALTER TABLE `tiposoperacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferencia`
--

DROP TABLE IF EXISTS `transferencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transferencia` (
  `id_operacao` int NOT NULL,
  `id_destino` int NOT NULL,
  `status` varchar(20) DEFAULT 'Em processamento',
  PRIMARY KEY (`id_operacao`),
  KEY `FKt_status` (`status`),
  KEY `idx_transferencia_id_operacao` (`id_operacao`),
  KEY `idx_transferencia_id_destino` (`id_destino`),
  CONSTRAINT `FKt_status` FOREIGN KEY (`status`) REFERENCES `statusmovimentacao` (`valor`),
  CONSTRAINT `transferencia_ibfk_1` FOREIGN KEY (`id_operacao`) REFERENCES `operacao` (`id_operacao`),
  CONSTRAINT `transferencia_ibfk_2` FOREIGN KEY (`id_destino`) REFERENCES `conta` (`id_conta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferencia`
--

LOCK TABLES `transferencia` WRITE;
/*!40000 ALTER TABLE `transferencia` DISABLE KEYS */;
INSERT INTO `transferencia` VALUES (1,2,'Concluído'),(2,1,'Concluído'),(3,3,'Concluído'),(4,1,'Concluído'),(5,2,'Concluído'),(6,2,'Concluído');
/*!40000 ALTER TABLE `transferencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `extrato`
--

/*!50001 DROP VIEW IF EXISTS `extrato`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `extrato` AS select `c`.`id_cliente` AS `id_cliente`,`o`.`id_operacao` AS `id_operacao`,`o`.`valor` AS `valor`,`o`.`data_hora` AS `data_hora`,`t`.`tipo` AS `tipo`,`s`.`status` AS `status_saque`,(case when (`t`.`tipo` = 'Investimento') then `i`.`tipo` else NULL end) AS `tipo_investimento`,(case when (`t`.`tipo` = 'Investimento') then `i`.`taxa_rendimento` else NULL end) AS `taxa_rendimento`,(case when (`t`.`tipo` = 'Investimento') then `i`.`prazo` else NULL end) AS `prazo`,(case when (`t`.`tipo` = 'Empréstimo') then `e`.`taxa_juros` else NULL end) AS `taxa_juros`,(case when (`t`.`tipo` = 'Empréstimo') then `e`.`parcelas` else NULL end) AS `parcelas`,(case when (`t`.`tipo` = 'Transferência') then `tr`.`id_destino` else NULL end) AS `id_destino`,(case when (`t`.`tipo` = 'Transferência') then `tr`.`status` else NULL end) AS `status_transferencia`,(case when (`t`.`tipo` = 'Deposito') then `d`.`status` else NULL end) AS `status_deposito` from (((((((((`cliente` `c` join `pessoa` `p` on((`c`.`id_pessoa` = `p`.`id_pessoa`))) join `conta` `co` on((`c`.`id_cliente` = `co`.`id_cliente`))) join `operacao` `o` on((`co`.`id_conta` = `o`.`id_conta`))) join (select `deposito`.`id_operacao` AS `id_operacao`,'Depósito' AS `tipo` from `deposito` union all select `saque`.`id_operacao` AS `id_operacao`,'Saque' AS `tipo` from `saque` union all select `investimento`.`id_operacao` AS `id_operacao`,'Investimento' AS `tipo` from `investimento` union all select `emprestimo`.`id_operacao` AS `id_operacao`,'Empréstimo' AS `tipo` from `emprestimo` union all select `transferencia`.`id_operacao` AS `id_operacao`,'Transferência' AS `tipo` from `transferencia`) `t` on((`o`.`id_operacao` = `t`.`id_operacao`))) left join `deposito` `d` on((`o`.`id_operacao` = `d`.`id_operacao`))) left join `saque` `s` on((`o`.`id_operacao` = `s`.`id_operacao`))) left join `investimento` `i` on((`o`.`id_operacao` = `i`.`id_operacao`))) left join `emprestimo` `e` on((`o`.`id_operacao` = `e`.`id_operacao`))) left join `transferencia` `tr` on((`o`.`id_operacao` = `tr`.`id_operacao`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `informacoes_cliente`
--

/*!50001 DROP VIEW IF EXISTS `informacoes_cliente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `informacoes_cliente` AS select `p`.`nome` AS `nome`,`p`.`cpf` AS `cpf`,`p`.`cnpj` AS `cnpj`,`p`.`endereco` AS `endereco`,`p`.`email` AS `email`,`p`.`data_nasc` AS `data_nasc`,`p`.`telefone` AS `telefone`,`p`.`sexo` AS `sexo`,`ct`.`numero` AS `numero_conta`,`ct`.`saldo` AS `saldo`,`ct`.`limite` AS `limite_conta`,`ct`.`status` AS `status`,`ca`.`numero` AS `numero_cartao`,`ca`.`validade` AS `validade`,`ca`.`cvv` AS `cvv`,`ca`.`bandeira` AS `bandeira`,`ca`.`limite` AS `limite_cartao`,`b`.`nome_banco` AS `nome_banco`,`a`.`nome_agencia` AS `nome_agencia` from (((((`pessoa` `p` join `cliente` `c` on((`p`.`id_pessoa` = `c`.`id_pessoa`))) join `conta` `ct` on((`c`.`id_cliente` = `ct`.`id_cliente`))) join `cartao` `ca` on((`ct`.`id_conta` = `ca`.`id_conta`))) join `agencia` `a` on((`c`.`id_agencia` = `a`.`id_agencia`))) join `banco` `b` on((`a`.`id_banco` = `b`.`id_banco`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-11  0:01:40
