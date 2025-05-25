-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hosteldb
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `fee`
--

DROP TABLE IF EXISTS `fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fee` (
  `FeeID` int NOT NULL AUTO_INCREMENT,
  `StudentID` int DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Status` enum('Paid','Unpaid','Pending') DEFAULT NULL,
  PRIMARY KEY (`FeeID`),
  KEY `fee_ibfk_1` (`StudentID`),
  CONSTRAINT `fee_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fee`
--

LOCK TABLES `fee` WRITE;
/*!40000 ALTER TABLE `fee` DISABLE KEYS */;
INSERT INTO `fee` VALUES (1,1,20000.00,'Unpaid'),(2,2,20000.00,'Unpaid'),(3,3,20000.00,'Unpaid'),(4,4,20000.00,'Unpaid'),(5,5,20000.00,'Unpaid'),(6,6,20000.00,'Unpaid'),(7,7,20000.00,'Unpaid'),(8,8,20000.00,'Unpaid'),(9,9,20000.00,'Unpaid'),(10,10,20000.00,'Unpaid'),(11,11,20000.00,'Unpaid'),(12,12,20000.00,'Unpaid'),(13,13,20000.00,'Unpaid'),(14,14,20000.00,'Unpaid'),(15,15,20000.00,'Unpaid'),(16,16,20000.00,'Unpaid'),(17,17,20000.00,'Unpaid'),(18,18,20000.00,'Unpaid'),(19,19,20000.00,'Unpaid'),(20,20,20000.00,'Unpaid'),(21,21,20000.00,'Unpaid'),(22,22,20000.00,'Unpaid'),(23,23,20000.00,'Unpaid'),(24,24,20000.00,'Unpaid'),(25,25,20000.00,'Unpaid'),(26,26,20000.00,'Unpaid'),(27,27,20000.00,'Unpaid'),(28,28,20000.00,'Unpaid'),(29,29,20000.00,'Unpaid'),(30,30,18000.00,'Unpaid'),(31,31,18000.00,'Unpaid'),(32,32,18000.00,'Unpaid'),(33,33,18000.00,'Unpaid'),(34,34,18000.00,'Unpaid'),(35,35,18000.00,'Unpaid'),(36,36,18000.00,'Unpaid'),(37,37,18000.00,'Unpaid'),(38,38,18000.00,'Unpaid'),(39,39,18000.00,'Unpaid'),(40,40,18000.00,'Unpaid'),(41,41,18000.00,'Unpaid'),(42,42,18000.00,'Unpaid'),(43,43,18000.00,'Unpaid'),(44,44,18000.00,'Unpaid'),(45,45,18000.00,'Unpaid'),(46,46,18000.00,'Unpaid'),(47,47,18000.00,'Unpaid'),(48,48,18000.00,'Unpaid');
/*!40000 ALTER TABLE `fee` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-27 15:57:34
