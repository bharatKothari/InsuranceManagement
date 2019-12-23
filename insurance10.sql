-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: insurance
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `agent`
--

DROP TABLE IF EXISTS `agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agent` (
  `agentID` int(11) NOT NULL AUTO_INCREMENT,
  `agentName` varchar(21) DEFAULT NULL,
  `contact` varchar(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `password` varchar(21) DEFAULT NULL,
  PRIMARY KEY (`agentID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent`
--

LOCK TABLES `agent` WRITE;
/*!40000 ALTER TABLE `agent` DISABLE KEYS */;
INSERT INTO `agent` VALUES (1,'amol',NULL,NULL,'admin'),(2,'rajat',NULL,NULL,'admin');
/*!40000 ALTER TABLE `agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `agent_commission`
--

DROP TABLE IF EXISTS `agent_commission`;
/*!50001 DROP VIEW IF EXISTS `agent_commission`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `agent_commission` AS SELECT 
 1 AS `agentID`,
 1 AS `agentName`,
 1 AS `commission`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `claim`
--

DROP TABLE IF EXISTS `claim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `claim` (
  `claimID` int(11) NOT NULL AUTO_INCREMENT,
  `policyNumber` int(11) DEFAULT NULL,
  `claimDate` date DEFAULT NULL,
  `status` varchar(21) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`claimID`),
  KEY `policyNumber` (`policyNumber`),
  CONSTRAINT `claim_ibfk_1` FOREIGN KEY (`policyNumber`) REFERENCES `policy` (`policyNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `claim`
--

LOCK TABLES `claim` WRITE;
/*!40000 ALTER TABLE `claim` DISABLE KEYS */;
INSERT INTO `claim` VALUES (1,10,NULL,'Claim Approved',NULL),(2,11,NULL,'Claim Rejected',NULL);
/*!40000 ALTER TABLE `claim` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `new_claim` AFTER INSERT ON `claim` FOR EACH ROW BEGIN
update policy set status = 'Claim Filed' where policy.policyNumber = new.policyNumber;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_claim` AFTER UPDATE ON `claim` FOR EACH ROW BEGIN
IF new.status = 'Under Process' THEN
update policy set status = 'Claim Filed' where policy.policyNumber = new.policyNumber;
ELSEIF new.status = 'Claim Approved' THEN
update policy set status = 'Claimed' where policy.policyNumber = new.policyNumber;
ELSE
update policy set status = 'Closed' where policy.policyNumber = new.policyNumber;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `clientID` int(11) NOT NULL AUTO_INCREMENT,
  `clientName` varchar(21) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `contact` varchar(11) DEFAULT NULL,
  `aadhaar` varchar(21) DEFAULT NULL,
  `houseNo` varchar(51) DEFAULT NULL,
  `zip` int(6) DEFAULT NULL,
  `password` varchar(21) DEFAULT NULL,
  PRIMARY KEY (`clientID`),
  KEY `zip` (`zip`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`zip`) REFERENCES `location` (`zip`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'anshul',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'bharat',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `area` varchar(21) DEFAULT NULL,
  `city` varchar(21) DEFAULT NULL,
  `state` varchar(21) DEFAULT NULL,
  `zip` int(6) NOT NULL,
  PRIMARY KEY (`zip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nominee`
--

DROP TABLE IF EXISTS `nominee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nominee` (
  `nomineeName` varchar(21) DEFAULT NULL,
  `aadhaar` varchar(21) NOT NULL,
  `contact` varchar(11) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  PRIMARY KEY (`aadhaar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nominee`
--

LOCK TABLES `nominee` WRITE;
/*!40000 ALTER TABLE `nominee` DISABLE KEYS */;
/*!40000 ALTER TABLE `nominee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `transID` int(11) NOT NULL AUTO_INCREMENT,
  `policyNumber` int(11) DEFAULT NULL,
  `payDate` datetime DEFAULT NULL,
  `premium_amt` int(11) DEFAULT NULL,
  `lateFee` int(11) DEFAULT NULL,
  PRIMARY KEY (`transID`),
  KEY `policyNumber` (`policyNumber`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`policyNumber`) REFERENCES `policy` (`policyNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,11,NULL,NULL,NULL),(5,12,NULL,NULL,NULL),(6,12,NULL,NULL,NULL),(7,11,NULL,NULL,NULL),(8,10,NULL,NULL,NULL),(10,10,NULL,NULL,NULL),(11,10,NULL,NULL,NULL),(12,11,NULL,NULL,NULL),(13,12,NULL,NULL,NULL),(14,11,NULL,NULL,NULL),(15,11,NULL,NULL,NULL),(16,11,NULL,NULL,NULL),(17,10,NULL,NULL,NULL),(18,11,NULL,NULL,NULL),(19,11,NULL,NULL,NULL),(20,12,NULL,NULL,NULL),(21,12,NULL,NULL,NULL),(22,12,NULL,NULL,NULL),(23,10,NULL,NULL,NULL),(24,10,NULL,NULL,NULL),(25,11,NULL,NULL,NULL),(26,12,NULL,NULL,NULL),(28,14,NULL,NULL,600),(29,10,'2019-10-10 18:57:45',NULL,0),(30,14,'2019-10-10 18:59:18',NULL,300),(31,14,'2019-10-10 19:00:21',NULL,100),(32,14,'2019-10-10 19:01:01',NULL,0),(43,10,NULL,NULL,NULL),(44,10,NULL,NULL,NULL),(47,10,NULL,NULL,NULL),(52,10,NULL,NULL,NULL),(53,10,NULL,NULL,NULL),(54,10,NULL,NULL,NULL),(55,10,NULL,NULL,NULL),(56,10,NULL,NULL,NULL),(57,10,NULL,NULL,NULL),(58,14,NULL,NULL,NULL),(59,14,NULL,NULL,NULL),(60,14,NULL,NULL,NULL),(61,10,NULL,NULL,NULL),(62,10,NULL,NULL,NULL),(63,12,NULL,NULL,NULL),(64,12,NULL,NULL,NULL),(65,12,NULL,NULL,NULL),(66,12,NULL,NULL,NULL),(67,12,NULL,NULL,NULL),(68,12,NULL,NULL,NULL);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pay_commission` AFTER INSERT ON `payment` FOR EACH ROW BEGIN
update policy set commission = (commission + calculate_commission(new.policyNumber)) where policyNumber = new.policyNumber;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_payment` AFTER INSERT ON `payment` FOR EACH ROW BEGIN                                                                                                                                                 call update_due_date(new.policynumber);
update policy set status = 'Active' where DATEDIFF(dueDate, CURDATE()-1) >= 1 and policyNumber = new.policyNumber;                                                                                                                                                       
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `planID` int(11) NOT NULL AUTO_INCREMENT,
  `planName` varchar(21) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `policyType` varchar(21) DEFAULT NULL,
  `comRate` int(11) DEFAULT NULL,
  `adminCharge` int(11) DEFAULT NULL,
  PRIMARY KEY (`planID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (1,'a',1,'aa','aa',2,2),(2,'b',1,NULL,NULL,5,5),(3,'c',1,NULL,NULL,10,10);
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy`
--

DROP TABLE IF EXISTS `policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy` (
  `policyNumber` int(11) NOT NULL AUTO_INCREMENT,
  `clientID` int(11) DEFAULT NULL,
  `planID` int(11) DEFAULT NULL,
  `cover` int(11) DEFAULT NULL,
  `nomineeID` varchar(21) DEFAULT NULL,
  `premium` int(11) DEFAULT NULL,
  `dueDate` date DEFAULT NULL,
  `payment_interval` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `agentID` int(11) DEFAULT NULL,
  `commission` int(11) DEFAULT NULL,
  `status` varchar(21) DEFAULT NULL,
  PRIMARY KEY (`policyNumber`),
  KEY `custID` (`clientID`),
  KEY `planID` (`planID`),
  KEY `agentID` (`agentID`),
  KEY `clientID` (`nomineeID`),
  CONSTRAINT `policy_ibfk_1` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`),
  CONSTRAINT `policy_ibfk_2` FOREIGN KEY (`planID`) REFERENCES `plans` (`planID`),
  CONSTRAINT `policy_ibfk_3` FOREIGN KEY (`agentID`) REFERENCES `agent` (`agentID`),
  CONSTRAINT `policy_ibfk_4` FOREIGN KEY (`nomineeID`) REFERENCES `nominee` (`aadhaar`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy`
--

LOCK TABLES `policy` WRITE;
/*!40000 ALTER TABLE `policy` DISABLE KEYS */;
INSERT INTO `policy` VALUES (10,1,1,NULL,NULL,100000,'2020-04-11',3,NULL,1,28834,'lapsed'),(11,1,2,NULL,NULL,100,'2024-10-15',6,NULL,2,13,'Active'),(12,2,3,NULL,NULL,1000,NULL,1,'2018-10-11',2,1108,'Expired'),(14,2,1,NULL,NULL,12000,'2020-01-05',1,NULL,1,NULL,'Claim filed');
/*!40000 ALTER TABLE `policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `reminders`
--

DROP TABLE IF EXISTS `reminders`;
/*!50001 DROP VIEW IF EXISTS `reminders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reminders` AS SELECT 
 1 AS `policyNumber`,
 1 AS `clientID`,
 1 AS `planID`,
 1 AS `cover`,
 1 AS `nomineeID`,
 1 AS `premium`,
 1 AS `dueDate`,
 1 AS `payment_interval`,
 1 AS `startDate`,
 1 AS `agentID`,
 1 AS `commission`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'insurance'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_commission` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_commission`(policynum int(11)) RETURNS int(11)
    DETERMINISTIC
BEGIN                                                                                                                                                       declare com int(11);                                                                                                                                        
declare t int(11);
select TIMESTAMPDIFF(MONTH, dueDate, CURDATE()-1) into t from policy where policyNumber = policynum;                                                          
IF t < 0 THEN
set t = 0;
END IF;
select ((1 +FLOOR( t/policy.payment_interval))* policy.premium*plans.comRate*0.01) into com from policy, plans where policy.planID = plans.planID and policy.policyNumber = policynum;
return (com);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calculate_due_premium` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_due_premium`(policynum int(11)) RETURNS int(11)
    DETERMINISTIC
BEGIN                                                                                                                                                       declare due int(11);                                                                                                                                        
declare t int(11);
select TIMESTAMPDIFF(MONTH, dueDate, CURDATE()-1) into t from policy where policyNumber = policynum;                                                          
IF t < 0 THEN
set t = 0;
END IF;
select ((1 + floor(t/policy.payment_interval))*policy.premium) into due from policy where policy.policyNumber = policynum;
return (due);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calculate_late_fee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_late_fee`(policynum int(11)) RETURNS int(11)
    DETERMINISTIC
BEGIN                                                                                                                                                       declare fee int(11);                                                                                                                                        
declare t int(11);
select TIMESTAMPDIFF(MONTH, dueDate, CURDATE()-1) into t from policy where policyNumber = policynum;                                                          
if t > 0 THEN                                                                                                                                               select ((1 + FLOOR(t/policy.payment_interval))*policy.premium* t/240) into fee from policy where policy.policyNumber=policynum;                                  
else                                                                                                                                                    
set fee = 0;                                                                                                                                                end if;                                                                                                                                                     return (fee);                                                                                                                                               END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_due_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_due_date`(policynum int)
BEGIN                                                                                                                                                       
select (TIMESTAMPDIFF(MONTH, dueDate, CURDATE()
-1)) into @t from policy where policyNumber = policynum;                                                          
IF @t < 0 THEN
set @t = 0;
END IF;
update policy set dueDate = DATE_ADD(dueDate, INTERVAL (1+FLOOR(@t/payment_interval))*payment_interval MONTH) where policyNumber = policynum;
update policy set dueDate = NULL where dueDate = (select DATE_ADD(startDate, INTERVAL duration YEAR) from plans  where policy.planID = plans.planID) and policyNumber = policynum;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_status`()
BEGIN
update policy set status = 'Lapsed' where TIMESTAMPDIFF(MONTH, dueDate, CURDATE()-1) >= 1;
update policy set status = 'Expired', dueDate = NULL where policyNumber = (select policyNumber from plans where CURDATE()-1 =DATE_ADD(startDate, INTERVAL duration YEAR) and policy.planID = plans.planID and (status='Active' or status='Expired'));                                              
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `agent_commission`
--

/*!50001 DROP VIEW IF EXISTS `agent_commission`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `agent_commission` AS select `agent`.`agentID` AS `agentID`,`agent`.`agentName` AS `agentName`,sum(`policy`.`commission`) AS `commission` from (`policy` join `agent`) where (`policy`.`agentID` = `agent`.`agentID`) group by `agent`.`agentID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `reminders`
--

/*!50001 DROP VIEW IF EXISTS `reminders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reminders` AS select `policy`.`policyNumber` AS `policyNumber`,`policy`.`clientID` AS `clientID`,`policy`.`planID` AS `planID`,`policy`.`cover` AS `cover`,`policy`.`nomineeID` AS `nomineeID`,`policy`.`premium` AS `premium`,`policy`.`dueDate` AS `dueDate`,`policy`.`payment_interval` AS `payment_interval`,`policy`.`startDate` AS `startDate`,`policy`.`agentID` AS `agentID`,`policy`.`commission` AS `commission`,`policy`.`status` AS `status` from `policy` where (((to_days(`policy`.`dueDate`) - to_days(curdate())) <= 10) and ((to_days(`policy`.`dueDate`) - to_days(curdate())) >= -(10))) */;
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

-- Dump completed on 2019-10-12 16:44:58
