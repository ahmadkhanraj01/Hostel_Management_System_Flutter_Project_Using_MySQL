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
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `StudentID` int NOT NULL AUTO_INCREMENT,
  `RoomID` varchar(10) DEFAULT NULL,
  `StudentName` varchar(100) DEFAULT NULL,
  `SContactNo` varchar(15) DEFAULT NULL,
  `Gender` enum('Male','Female') DEFAULT NULL,
  PRIMARY KEY (`StudentID`),
  KEY `student_ibfk_1` (`RoomID`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`RoomID`) REFERENCES `room` (`RoomID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'Ah01','Aslam','03001234567','Male'),(2,'Ah01','Akram','03011234567','Male'),(3,'Ah02','Faheem','03021234567','Male'),(4,'Ah02','Kamran','03031234567','Male'),(5,'Ah05','Shishu','03041234567','Male'),(6,'Ah05','Younis','03051234567','Male'),(7,'Ah08','Faraz','03061234567','Male'),(8,'Ah10','Nakeeb','03071234567','Male'),(9,'Ah03','Waqas','03081234567','Male'),(10,'Ah04','Irfan','03091234567','Male'),(11,'Ah06','Noman','03101234567','Male'),(12,'Ah07','Adeel','03111234567','Male'),(13,'Ah09','Tariq','03121234567','Male'),(14,'Al01','Shibu','03131234567','Male'),(15,'Al01','Shah Zaman','03141234567','Male'),(16,'Al02','Usman','03151234567','Male'),(17,'Al02','Bilal','03161234567','Male'),(18,'Al03','Danish','03171234567','Male'),(19,'Al03','Arsalan','03181234567','Male'),(20,'Al04','Zohaib','03191234567','Male'),(21,'Al04','Kashif','03201234567','Male'),(22,'Al05','Rizwan','03211234567','Male'),(23,'Al05','Saad','03221234567','Male'),(24,'Al06','Hasnain','03231234567','Male'),(25,'Al06','Sufiyan','03241234567','Male'),(26,'Al07','Imran','03251234567','Male'),(27,'Al07','Shahbaz','03261234567','Male'),(28,'Al08','Ahsan','03271234567','Male'),(29,'Al08','Owais','03281234567','Male'),(30,'Ay01','Aleena','03291234567','Female'),(31,'Ay01','Rabia','03301234567','Female'),(32,'Ay02','Lakshmi','03311234567','Female'),(33,'Ay02','Fatima','03321234567','Female'),(34,'Ay03','Jahan Ara','03331234567','Female'),(35,'Ay03','Perveen','03341234567','Female'),(36,'Ay04','Saba','03351234567','Female'),(37,'Ay04','Nimra','03361234567','Female'),(38,'Ay05','Amna','03371234567','Female'),(39,'Ay05','Hina','03381234567','Female'),(40,'Ay06','Sundas','03391234567','Female'),(41,'Ay06','Sara','03401234567','Female'),(42,'Ay07','Kinza','03411234567','Female'),(43,'Ay07','Nazia','03421234567','Female'),(44,'Ay09','Elizabeth','03431234567','Female'),(45,'Ay09','Diana','03441234567','Female'),(46,'Ay15','Nasreen','03451234567','Female'),(47,'Ay16','Mehek','03461234567','Female'),(48,'Ay16','Iman','03471234567','Female');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-27 15:57:35
