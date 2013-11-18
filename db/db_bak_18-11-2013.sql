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
-- Table structure for table `paypal_workerrs`
--

DROP TABLE IF EXISTS `paypal_workerrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypal_workerrs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AddressTypes`
--

DROP TABLE IF EXISTS `AddressTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AddressTypes` (
  `ID` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PeriodType`
--

DROP TABLE IF EXISTS `PeriodType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PeriodType` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(10) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CustomerSearchLogs`
--

DROP TABLE IF EXISTS `CustomerSearchLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerSearchLogs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerSearchID` int(11) NOT NULL,
  `SearchedDateTime` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserRoles`
--

DROP TABLE IF EXISTS `UserRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserRoles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Role` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CustomerPhone`
--

DROP TABLE IF EXISTS `CustomerPhone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerPhone` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerSearchID` int(11) NOT NULL,
  `ContactNumber` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IncorporationTypes`
--

DROP TABLE IF EXISTS `IncorporationTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IncorporationTypes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `UserPaymentDetails`
--

DROP TABLE IF EXISTS `UserPaymentDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserPaymentDetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` varchar(100) NOT NULL,
  `NumberOfItems` int(11) NOT NULL,
  `ItemPrice` float NOT NULL,
  `PayerID` varchar(100) NOT NULL,
  `Token` varchar(100) NOT NULL,
  `TransactionID` varchar(45) NOT NULL,
  `PaymentStatus` bit(1) DEFAULT NULL,
  `ResponseDateTime` datetime DEFAULT NULL,
  `ResponseString` text NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` varchar(500) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CaseTypes`
--

DROP TABLE IF EXISTS `CaseTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CaseTypes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ReviewAnswersHistory`
--

DROP TABLE IF EXISTS `ReviewAnswersHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ReviewAnswersHistory` (
  `ID` int(11) NOT NULL,
  `ReviewID` int(11) NOT NULL,
  `QuestionID` int(11) NOT NULL,
  `Comments` text,
  `IsYes` varchar(50) DEFAULT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Grantors`
--

DROP TABLE IF EXISTS `Grantors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Grantors` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(20) NOT NULL,
  `MiddleName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `StreetAddress` varchar(20) NOT NULL,
  `City` varchar(100) NOT NULL,
  `State` varchar(20) NOT NULL,
  `ZipCode` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_GrantorsCityID` (`City`),
  KEY `fk_GrantorsStateID` (`State`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ModulesOperations`
--

DROP TABLE IF EXISTS `ModulesOperations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ModulesOperations` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ModuleID` int(11) NOT NULL,
  `OperationID` int(11) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_ModuleID` (`ModuleID`),
  KEY `fk_OperationID` (`OperationID`),
  CONSTRAINT `fk_ModuleID` FOREIGN KEY (`ModuleID`) REFERENCES `SiteModules` (`ID`),
  CONSTRAINT `fk_OperationID` FOREIGN KEY (`OperationID`) REFERENCES `Operations` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SearchDetails`
--

DROP TABLE IF EXISTS `SearchDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SearchDetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(20) NOT NULL,
  `MiddleName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `StreetAddress` varchar(20) NOT NULL,
  `City` varchar(100) NOT NULL,
  `State` varchar(20) NOT NULL,
  `ZipCode` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CustomerReviewJoin`
--

DROP TABLE IF EXISTS `CustomerReviewJoin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerReviewJoin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerSearchID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `IsReviewGiven` bit(1) NOT NULL,
  `IsRequestSent` bit(1) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Keys`
--

DROP TABLE IF EXISTS `Keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Keys` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `Key` varchar(45) NOT NULL,
  `DateCreated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `Key_UNIQUE` (`Key`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SiteAccessReports`
--

DROP TABLE IF EXISTS `SiteAccessReports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteAccessReports` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `LoginDateTime` datetime NOT NULL,
  `LogOutDateTime` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ReviewAnswers`
--

DROP TABLE IF EXISTS `ReviewAnswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ReviewAnswers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ReviewID` int(11) NOT NULL,
  `QuestionID` int(11) NOT NULL,
  `Comments` text,
  `IsYes` varchar(50) DEFAULT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `fk_DetailedReviewID` (`ReviewID`),
  KEY `fk_DetailedQuestionID` (`QuestionID`),
  CONSTRAINT `fk_DetailedQuestionID` FOREIGN KEY (`QuestionID`) REFERENCES `ReviewQuestions` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=497 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Cities`
--

DROP TABLE IF EXISTS `Cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cities` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `State` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8180 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Pages`
--

DROP TABLE IF EXISTS `Pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pages` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `DateCreated` varchar(45) NOT NULL,
  `DateUpdated` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RolesModules`
--

DROP TABLE IF EXISTS `RolesModules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RolesModules` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RoleID` int(11) NOT NULL,
  `ModuleOperationID` int(11) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_RoleID` (`RoleID`),
  KEY `fk_ModuleOperationID` (`ModuleOperationID`),
  CONSTRAINT `fk_ModuleOperationID` FOREIGN KEY (`ModuleOperationID`) REFERENCES `ModulesOperations` (`ID`),
  CONSTRAINT `fk_RoleID` FOREIGN KEY (`RoleID`) REFERENCES `UserRoles` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SiteModules`
--

DROP TABLE IF EXISTS `SiteModules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteModules` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Module` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SearchReports`
--

DROP TABLE IF EXISTS `SearchReports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SearchReports` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SearchID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `SearchCount` int(11) NOT NULL,
  `FeedbackRequest` bit(1) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_SearchID` (`SearchID`),
  KEY `fk_SearchUserID` (`UserID`),
  CONSTRAINT `fk_SearchID` FOREIGN KEY (`SearchID`) REFERENCES `SearchDetails` (`ID`),
  CONSTRAINT `fk_SearchUserID` FOREIGN KEY (`UserID`) REFERENCES `SubscribedUsers` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PagesContent`
--

DROP TABLE IF EXISTS `PagesContent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PagesContent` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PageID` int(11) NOT NULL,
  `Title` varchar(30) NOT NULL,
  `Body` text NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_PageID` (`PageID`),
  CONSTRAINT `fk_PageID` FOREIGN KEY (`PageID`) REFERENCES `Pages` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SubscriptionPlans`
--

DROP TABLE IF EXISTS `SubscriptionPlans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SubscriptionPlans` (
  `ID` int(11) NOT NULL,
  `Title` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Period` int(11) NOT NULL,
  `PeriodTypeID` int(11) NOT NULL,
  `isEnabled` bit(1) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_PeriodTypeID` (`PeriodTypeID`),
  CONSTRAINT `fk_PeriodTypeID` FOREIGN KEY (`PeriodTypeID`) REFERENCES `PeriodType` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SubscribedUsers`
--

DROP TABLE IF EXISTS `SubscribedUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SubscribedUsers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Salt` varchar(45) NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `MiddleName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) NOT NULL,
  `EmailID` varchar(50) NOT NULL,
  `CompanyName` varchar(20) NOT NULL,
  `IncorporationType` varchar(20) NOT NULL,
  `ContactNumber` varchar(20) NOT NULL,
  `LicenseNumber` varchar(20) NOT NULL,
  `AuthCodeUsed` varchar(45) DEFAULT NULL,
  `IsEnabled` bit(1) NOT NULL,
  `IsActivated` bit(1) NOT NULL,
  `IsApproved` bit(1) NOT NULL,
  `IsSubscribed` bit(1) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SubscribedUsercol_UNIQUE` (`UserName`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `fk_IncorporationTypeID` (`IncorporationType`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `MiddleName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `ContactNumber` varchar(20) NOT NULL,
  `StreetAddress` varchar(100) NOT NULL,
  `City` varchar(100) NOT NULL,
  `State` varchar(20) NOT NULL,
  `ZIPCode` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Liens`
--

DROP TABLE IF EXISTS `Liens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Liens` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GrantorID` int(11) NOT NULL,
  `DateIssued` datetime NOT NULL,
  `Amount` float NOT NULL,
  `ReleaseDate` datetime NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_LiensGrantorID` (`GrantorID`),
  CONSTRAINT `fk_LiensGrantorID` FOREIGN KEY (`GrantorID`) REFERENCES `Grantors` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserAuthorization`
--

DROP TABLE IF EXISTS `UserAuthorization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserAuthorization` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `RoleID` int(11) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_AuthUserID` (`UserID`),
  KEY `fk_AuthRoleID` (`RoleID`),
  CONSTRAINT `fk_AuthRoleID` FOREIGN KEY (`RoleID`) REFERENCES `UserRoles` (`ID`),
  CONSTRAINT `fk_AuthUserID` FOREIGN KEY (`UserID`) REFERENCES `SubscribedUsers` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Reviews`
--

DROP TABLE IF EXISTS `Reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reviews` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `CustomerSearchID` int(11) NOT NULL,
  `IsVisible` bit(1) NOT NULL,
  `IsApproved` bit(1) NOT NULL,
  `MLAndJudgments` text,
  `OtherPublicThirdPartyInfo` text,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `fk_ReviewsUserID` (`UserID`),
  KEY `fk_ReviewsCustomerID` (`CustomerSearchID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserAddressDetails`
--

DROP TABLE IF EXISTS `UserAddressDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserAddressDetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `AddressType` varchar(20) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `City` varchar(100) NOT NULL,
  `State` varchar(20) NOT NULL,
  `ZIPCode` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `fk_UserAddressTypeID` (`AddressType`),
  KEY `fk_AddressUseriD` (`UserID`),
  KEY `fk_AddressCityID` (`City`),
  KEY `fk_AddressStateID` (`State`),
  CONSTRAINT `fk_AddressUseriD` FOREIGN KEY (`UserID`) REFERENCES `SubscribedUsers` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Plaintiffs`
--

DROP TABLE IF EXISTS `Plaintiffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Plaintiffs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(20) NOT NULL,
  `MiddleName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `StreetAddress` varchar(20) NOT NULL,
  `City` varchar(100) NOT NULL,
  `State` varchar(20) NOT NULL,
  `ZipCode` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_PlaintiffsCityID` (`City`),
  KEY `fk_PlaintiffsStateID` (`State`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paypal_workers`
--

DROP TABLE IF EXISTS `paypal_workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypal_workers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Operations`
--

DROP TABLE IF EXISTS `Operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Operations` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Operation` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SearchContacts`
--

DROP TABLE IF EXISTS `SearchContacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SearchContacts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SearchID` int(11) NOT NULL,
  `ContactNumber` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserSubscriptionPlan`
--

DROP TABLE IF EXISTS `UserSubscriptionPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserSubscriptionPlan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `PlanID` int(11) NOT NULL,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_UserSubscriptionUserID` (`UserID`),
  KEY `fk_UserSubscriptionPlanID` (`PlanID`),
  CONSTRAINT `fk_UserSubscriptionPlanID` FOREIGN KEY (`PlanID`) REFERENCES `SubscriptionPlans` (`ID`),
  CONSTRAINT `fk_UserSubscriptionUserID` FOREIGN KEY (`UserID`) REFERENCES `SubscribedUsers` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserSubscriptionPlanHistory`
--

DROP TABLE IF EXISTS `UserSubscriptionPlanHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserSubscriptionPlanHistory` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `PlanID` int(11) NOT NULL,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_UserSubscriptionHistoryUserID` (`UserID`),
  KEY `fk_UserSubscriptionHistoryPlanID` (`PlanID`),
  CONSTRAINT `fk_UserSubscriptionHistoryPlanID` FOREIGN KEY (`PlanID`) REFERENCES `SubscriptionPlans` (`ID`),
  CONSTRAINT `fk_UserSubscriptionHistoryUserID` FOREIGN KEY (`UserID`) REFERENCES `SubscribedUsers` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CustomerAddress`
--

DROP TABLE IF EXISTS `CustomerAddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerAddress` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `StreetAddress` varchar(100) NOT NULL,
  `City` varchar(50) NOT NULL,
  `State` varchar(20) NOT NULL,
  `ZIPCode` varchar(10) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paypal_interfaces`
--

DROP TABLE IF EXISTS `paypal_interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypal_interfaces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CustomerSearch`
--

DROP TABLE IF EXISTS `CustomerSearch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerSearch` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `AddressID` int(11) NOT NULL,
  `SearchDate` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `States`
--

DROP TABLE IF EXISTS `States`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `States` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `DateCreated` varchar(45) NOT NULL,
  `DateUpdated` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Defendants`
--

DROP TABLE IF EXISTS `Defendants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Defendants` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(20) NOT NULL,
  `MiddleName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `StreetAddress` varchar(20) NOT NULL,
  `City` varchar(100) NOT NULL,
  `State` varchar(20) NOT NULL,
  `ZipCode` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_DefendantsCityID` (`City`),
  KEY `fk_DefendantsStateID` (`State`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CourtProceedings`
--

DROP TABLE IF EXISTS `CourtProceedings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CourtProceedings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PlaintiffID` int(11) NOT NULL,
  `DefendantID` int(11) NOT NULL,
  `DateFiled` datetime NOT NULL,
  `CourtHearingDate` datetime NOT NULL,
  `AmountAwarded` float NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateUpdated` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_PlaintiffID` (`PlaintiffID`),
  KEY `fk_DefendantID` (`DefendantID`),
  CONSTRAINT `fk_DefendantID` FOREIGN KEY (`DefendantID`) REFERENCES `Defendants` (`ID`),
  CONSTRAINT `fk_PlaintiffID` FOREIGN KEY (`PlaintiffID`) REFERENCES `Plaintiffs` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-11-18 12:33:09
