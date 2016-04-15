-- MySQL dump 10.15  Distrib 10.0.23-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: otrs
-- ------------------------------------------------------
-- Server version	10.0.23-MariaDB-log

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
-- Table structure for table `ticket_type`
--

DROP TABLE IF EXISTS `ticket_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_type_name` (`name`),
  KEY `FK_ticket_type_create_by_id` (`create_by`),
  KEY `FK_ticket_type_change_by_id` (`change_by`),
  KEY `FK_ticket_type_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_ticket_type_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_type_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_type_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_type`
--

LOCK TABLES `ticket_type` WRITE;
/*!40000 ALTER TABLE `ticket_type` DISABLE KEYS */;
INSERT INTO `ticket_type` VALUES (1,'default',1,'2007-05-21 20:33:12',1,'2007-05-21 20:33:12',1);
/*!40000 ALTER TABLE `ticket_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-14  8:32:00
