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
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `RoomID` varchar(10) NOT NULL,
  `HostelID` int DEFAULT NULL,
  `Capacity` int DEFAULT NULL,
  `OccupiedCount` int DEFAULT NULL,
  PRIMARY KEY (`RoomID`),
  KEY `HostelID` (`HostelID`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`HostelID`) REFERENCES `hostel` (`HostelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES ('Ah01',1,2,2),('Ah02',1,2,2),('Ah03',1,2,1),('Ah04',1,2,1),('Ah05',1,2,2),('Ah06',1,2,1),('Ah07',1,2,1),('Ah08',1,2,1),('Ah09',1,2,1),('Ah10',1,2,1),('Ah11',1,2,0),('Ah12',1,2,0),('Ah13',1,2,0),('Ah14',1,2,0),('Ah15',1,2,0),('Ah16',1,2,0),('Ah17',1,2,0),('Ah18',1,2,0),('Ah19',1,2,0),('Ah20',1,2,0),('Al01',2,2,2),('Al02',2,2,2),('Al03',2,2,2),('Al04',2,2,2),('Al05',2,2,2),('Al06',2,2,2),('Al07',2,2,2),('Al08',2,2,2),('Al09',2,2,0),('Al10',2,2,0),('Al11',2,2,0),('Al12',2,2,0),('Al13',2,2,0),('Al14',2,2,0),('Al15',2,2,0),('Al16',2,2,0),('Al17',2,2,0),('Al18',2,2,0),('Al19',2,2,0),('Al20',2,2,0),('Ay01',3,2,2),('Ay02',3,2,2),('Ay03',3,2,2),('Ay04',3,2,2),('Ay05',3,2,2),('Ay06',3,2,2),('Ay07',3,2,2),('Ay08',3,2,0),('Ay09',3,2,2),('Ay10',3,2,0),('Ay11',3,2,0),('Ay12',3,2,0),('Ay13',3,2,0),('Ay14',3,2,0),('Ay15',3,2,1),('Ay16',3,2,2),('Ay17',3,2,0),('Ay18',3,2,0),('Ay19',3,2,0),('Ay20',3,2,0);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
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
