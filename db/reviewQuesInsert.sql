CREATE DATABASE  IF NOT EXISTS `nickslist_dev` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `nickslist_dev`;
-- MySQL dump 10.13  Distrib 5.5.31, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: nickslist_dev
-- ------------------------------------------------------
-- Server version	5.5.31-0ubuntu0.13.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ReviewQuestions`
--

DROP TABLE IF EXISTS `ReviewQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ReviewQuestions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ParentID` int(11) DEFAULT NULL,
  `Description` text NOT NULL,
  `Type` varchar(45) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ReviewQuestions`
--

LOCK TABLES `ReviewQuestions` WRITE;
/*!40000 ALTER TABLE `ReviewQuestions` DISABLE KEYS */;
INSERT INTO `ReviewQuestions` (`ID`, `ParentID`, `Description`, `Type`, `DateCreated`, `DateUpdated`) VALUES (1,NULL,'Did you work for this person','General','2013-10-11 15:58:54','2013-10-11 15:58:54'),(2,NULL,'Did this person take any actions against you','General','2013-10-11 15:58:54','2013-10-11 15:58:54'),(3,2,'Are you currently in legal proceedings','General','2013-10-11 15:58:54','2013-10-11 15:58:54'),(4,2,'Did this person sue you','General','2013-10-11 15:58:54','2013-10-11 15:58:54'),(5,2,'Has the problem(s) been resolved','General','2013-10-11 15:58:54','2013-10-11 15:58:54'),(6,2,'Has the person reported you to any reviewing sites','General','2013-10-11 15:58:54','2013-10-11 15:58:54'),(7,2,'At what point(s) did the problems occur','General','2013-10-11 15:58:54','2013-10-11 15:58:54'),(8,NULL,'Would you work for them again','Detailed','2013-10-11 15:58:54','2013-10-11 15:58:54'),(9,NULL,'Was this person a price shopper','Detailed','2013-10-11 15:58:54','2013-10-11 15:58:54'),(10,NULL,'Was this person abusive to you or your employees','Detailed','2013-10-11 15:58:54','2013-10-11 15:58:54'),(11,NULL,'Did this person micro manage the project','Detailed','2013-10-11 15:58:54','2013-10-11 15:58:54'),(12,NULL,'Was this person indecisive','Detailed','2013-10-11 15:58:54','2013-10-11 15:58:54'),(13,NULL,'Was this person distrustful due to past experiences','Detailed','2013-10-11 15:58:54','2013-10-11 15:58:54'),(14,NULL,'Was this person overly picky','Detailed','2013-10-11 15:58:54','2013-10-11 15:58:54'),(15,NULL,'Was this person overly emotional','Detailed','2013-10-11 15:58:54','2013-10-11 15:58:54'),(16,NULL,'Was this person difficult to communicate with','Detailed','2013-10-11 15:58:54','2013-10-11 15:58:54'),(17,NULL,'Please list any suggestions for other contractors who may deal with this person','Detailed','2013-10-11 15:58:54','2013-10-11 15:58:54');
/*!40000 ALTER TABLE `ReviewQuestions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-11-12 15:33:37
