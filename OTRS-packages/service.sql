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
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `criticality` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_name` (`name`),
  KEY `FK_service_create_by_id` (`create_by`),
  KEY `FK_service_change_by_id` (`change_by`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Gold',1,'','2007-06-05 11:56:09',5,'2007-06-05 11:56:09',5,10,'1 very low'),(2,'Gold::Gold CET',1,'','2008-01-08 13:52:48',5,'2008-01-08 13:59:45',5,10,'1 very low'),(3,'Gold::Gold PST',1,'','2008-01-08 13:54:10',5,'2008-01-08 13:59:57',5,10,'1 very low'),(4,'Bronze',1,'','2008-01-08 13:55:02',5,'2008-01-08 13:55:02',5,10,'1 very low'),(5,'Bronze::Bronze PST',1,'','2008-01-08 13:55:29',5,'2008-01-08 13:59:24',5,10,'1 very low'),(6,'Bronze::Bronze CET',1,'','2008-01-08 13:55:41',5,'2008-01-08 13:59:15',5,10,'1 very low'),(7,'Silver',1,'','2008-01-08 13:55:57',5,'2008-01-08 13:55:57',5,10,'1 very low'),(8,'Silver::Silver CET',1,'','2008-01-08 13:56:12',5,'2008-01-08 14:00:30',5,10,'1 very low'),(9,'Silver::Silver PST',1,'','2008-01-08 13:56:24',5,'2008-01-08 14:00:39',5,10,'1 very low'),(10,'Platinum',1,'','2008-01-08 14:01:03',5,'2008-01-08 14:01:03',5,10,'1 very low'),(11,'Platinum::Platinum CET',1,'','2008-01-08 14:01:34',5,'2008-01-08 14:01:34',5,10,'1 very low'),(12,'Platinum::Platinum PST',1,'','2008-01-08 14:02:03',5,'2008-01-08 14:02:03',5,10,'1 very low'),(13,'Centurion',1,'','2008-01-08 14:02:33',5,'2008-01-08 14:02:33',5,10,'1 very low'),(14,'Centurion::Centurion PST',1,'','2008-01-08 14:03:08',5,'2008-01-08 14:03:08',5,10,'1 very low'),(15,'Centurion::Centurion CET',1,'','2008-01-08 14:03:28',5,'2008-01-08 14:03:28',5,10,'1 very low'),(16,'_Entry',1,'','2008-01-08 14:04:13',5,'2008-01-08 14:06:42',5,10,'1 very low'),(17,'_Primary',1,'','2008-01-08 14:05:25',5,'2008-01-08 14:06:55',5,10,'1 very low'),(18,'_Enhanced',1,'','2008-01-08 14:05:41',5,'2008-01-08 14:06:30',5,10,'1 very low'),(19,'_Customized Services',1,'','2008-01-10 13:18:47',5,'2008-01-10 13:20:33',5,10,'1 very low'),(20,'_Customized Services::Customized Service senbjs',1,'','2008-01-10 13:20:16',5,'2008-01-10 13:29:36',5,10,'1 very low'),(21,'ESS-Comfort',1,'','2008-02-07 14:54:53',5,'2009-03-02 11:09:46',5,10,'1 very low'),(22,'ESS-Superior::ESS-Superior CET',1,'','2008-02-07 14:55:51',5,'2009-03-02 11:11:23',5,10,'1 very low'),(23,'ESS-Superior',1,'','2008-02-07 14:56:24',5,'2009-03-02 11:10:58',5,10,'1 very low'),(24,'ESS-Comfort::ESS-Comfort CET',1,'','2008-02-07 14:57:26',5,'2009-03-02 11:10:23',5,10,'1 very low'),(25,'ESS-Superior::ESS-Superior PST',1,'','2008-02-07 14:58:06',5,'2009-03-02 11:11:43',5,10,'1 very low'),(26,'ESS-Comfort::ESS-Comfort PST',1,'','2008-02-07 14:59:47',5,'2009-03-02 11:10:37',5,10,'1 very low'),(27,' Info',1,'','2008-02-08 09:51:17',5,'2008-02-08 10:02:45',5,10,'1 very low'),(28,'_Customized Services:: Customized Service Gold dzbank',1,'Gold+ Vertrag','2008-03-03 11:43:44',5,'2008-03-03 11:43:44',5,10,'1 very low'),(29,'ESS-Premium',1,'','2009-03-02 11:12:09',5,'2009-03-02 11:12:09',5,10,'1 very low'),(30,'ESS-Premium::ESS-Premium CET',1,'','2009-03-02 11:12:26',5,'2009-03-02 11:12:26',5,10,'1 very low'),(31,'ESS-Premium::ESS-Premium PST',1,'','2009-03-02 11:12:37',5,'2009-03-02 11:12:37',5,10,'1 very low'),(32,'_Customized Services::BSI WID Service',1,'','2009-09-01 12:42:25',5,'2009-09-01 12:51:23',5,10,'1 very low'),(33,'_Customized Services::BSI SIRIOS Service',1,'','2009-09-01 12:52:30',5,'2009-09-01 12:52:30',5,10,'1 very low'),(34,'Change Management',1,'Für Change Management Investoren','2010-02-01 17:08:17',70,'2010-02-01 17:08:17',70,10,'1 very low'),(35,'Quick Start Package',1,'active since 01.08.10','2010-08-05 10:13:14',5,'2010-08-05 10:13:14',5,10,'1 very low'),(36,'Quick Start Package::Quick Start Package CET',1,'active since 01.08.10','2010-08-05 10:13:30',5,'2010-08-05 10:13:30',5,10,'1 very low'),(37,'Quick Start Package::Quick Start Package PST',1,'active since 01.08.10','2010-08-05 10:13:47',5,'2010-08-05 10:13:47',5,10,'1 very low'),(38,'Basic Subscription',1,'active since 01.08.10','2010-08-05 13:31:25',5,'2010-08-05 13:31:25',5,10,'1 very low'),(39,'Basic Subscription::Basic Subscription CET',1,'active since 01.08.10','2010-08-05 13:31:41',5,'2010-08-05 13:31:41',5,10,'1 very low'),(40,'Basic Subscription::Basic Subscription PST',1,'active since 01.08.10','2010-08-05 13:31:58',5,'2010-08-05 13:31:58',5,10,'1 very low'),(41,'Professional Subscription',1,'active since 01.08.10','2010-08-05 13:32:32',5,'2010-08-05 13:32:32',5,10,'1 very low'),(42,'Professional Subscription::Professional Subscription CET',1,'active since 01.08.10','2010-08-05 13:32:51',5,'2010-08-05 13:32:51',5,10,'1 very low'),(43,'Professional Subscription::Professional Subscription PST',1,'active since 01.08.10','2010-08-05 13:33:11',5,'2010-08-05 13:33:11',5,10,'1 very low'),(44,'Enterprise Subscription',1,'active since 01.08.10','2010-08-05 13:33:34',5,'2010-08-05 13:33:34',5,10,'1 very low'),(45,'Enterprise Subscription::Enterprise Subscription CET',1,'active since 01.08.10','2010-08-05 13:34:01',5,'2010-08-05 13:34:01',5,10,'1 very low'),(46,'Enterprise Subscription::Enterprise Subscription PST',1,'active since 01.08.10','2010-08-05 13:34:19',5,'2010-08-05 13:34:19',5,10,'1 very low'),(47,'Managed OTRS Professional',1,'active since 01.08.10','2010-08-05 13:37:15',5,'2010-08-05 13:37:15',5,10,'1 very low'),(48,'Managed OTRS Enterprise',1,'','2010-08-05 13:37:46',5,'2010-08-05 13:37:46',5,10,'1 very low'),(49,'Managed OTRS Enterprise::Managed OTRS Enterprise CET',1,'active since 01.08.10','2010-08-05 13:38:27',5,'2010-08-05 13:38:27',5,10,'1 very low'),(50,'Managed OTRS Enterprise::Managed OTRS Enterprise PST',1,'active since 01.08.10','2010-08-05 13:38:44',5,'2010-08-05 13:38:44',5,10,'1 very low'),(51,'Managed OTRS Professional::Managed OTRS Professional CET',1,'active since 01.08.10','2010-08-05 13:39:19',5,'2010-08-05 13:39:19',5,10,'1 very low'),(52,'Managed OTRS Professional::Managed OTRS Professional PST',1,'active since 01.08.10','2010-08-05 13:39:34',5,'2010-08-05 13:39:34',5,10,'1 very low'),(53,'Basic Subscription::Basic Subscription HKT',1,'active since 16.09.11','2011-09-16 07:55:07',70,'2011-09-16 07:55:07',70,10,'1 very low'),(54,'Basic Subscription::Partner Basic Subscription CET',1,'','2012-01-17 09:56:28',70,'2012-01-17 09:56:28',70,10,'1 very low'),(55,'Partner Support',1,'','2012-06-07 13:32:57',70,'2012-06-07 13:32:57',70,10,'1 very low'),(56,'Partner Support::Certified Partner Support',1,'','2012-06-11 06:40:00',70,'2012-06-11 06:40:00',70,10,'1 very low'),(57,'Partner Support::Premium Partner Support',1,'','2012-06-11 06:40:23',70,'2012-06-11 06:40:23',70,10,'1 very low'),(58,'Partner Support::Preferred Partner Support',1,'','2012-06-11 06:40:45',70,'2012-06-11 06:40:45',70,10,'1 very low'),(59,'_Customized Services::custom subscription genpact',1,'','2012-08-08 09:24:02',70,'2012-08-08 09:30:34',70,10,'1 very low'),(60,'Professional Subscription::Professional Subscription HKT',1,'active since 16AUG12','2012-08-16 12:49:35',70,'2012-08-16 12:49:35',70,10,'1 very low'),(61,'Professional Subscription::Partner Professional Subscription CET',1,'','2012-10-18 08:49:13',70,'2012-10-18 08:49:13',70,10,'1 very low'),(62,'Enterprise Subscription::Enterprise Subscription HKT',1,'','2012-12-21 10:01:19',24,'2012-12-21 10:01:19',24,10,'1 very low'),(63,'Managed OTRS Silver',1,'Added by MTR 25-JUN-2013','2013-06-25 08:46:09',65,'2013-06-25 08:46:34',65,10,'1 very low'),(64,'Managed OTRS Silver::Managed OTRS Silver CET',1,'added by MTR 25-JUN-2013','2013-06-25 08:47:31',65,'2013-06-25 08:48:18',65,10,'1 very low'),(65,'Managed OTRS Silver::Managed OTRS Silver PST',1,'added by MTR 25-JUN-2013','2013-06-25 08:48:05',65,'2013-06-25 08:48:05',65,10,'1 very low'),(66,'Managed OTRS Silver::Managed OTRS Silver HKT',1,'added by MTR 25-JUN-2013','2013-06-25 08:48:37',65,'2013-06-25 08:48:37',65,10,'1 very low'),(67,'Managed OTRS Gold',1,'Added by MTR 25-JUL-2013','2013-07-25 07:46:40',65,'2013-07-25 07:47:06',65,10,'1 very low'),(68,'Managed OTRS Gold::Managed OTRS Gold CET',1,'added by MTR 25-JUL-2013','2013-07-25 07:47:34',65,'2013-07-25 19:09:08',65,10,'1 very low'),(69,'Managed OTRS Gold::Managed OTRS Gold HKT',1,'added by MTR 25-JUL-2013','2013-07-25 07:47:56',65,'2013-07-25 07:47:56',65,10,'1 very low'),(70,'Managed OTRS Gold::Managed OTRS Gold PST',1,'added by MTR 25-JUL-2013','2013-07-25 07:48:19',65,'2013-07-25 07:48:19',65,10,'1 very low'),(71,'Managed OTRS Platinum',1,'','2014-04-23 10:53:28',105,'2014-04-23 10:53:28',105,10,'1 very low'),(72,'Managed OTRS Platinum::Managed OTRS Platinum CET',1,'','2014-04-23 10:53:54',105,'2014-04-23 10:53:54',105,10,'1 very low'),(73,'Managed OTRS Platinum::Managed OTRS Platinum PST',1,'','2014-04-23 10:54:27',105,'2014-04-23 10:54:27',105,10,'1 very low'),(74,'Managed OTRS Platinum::Managed OTRS Platinum HKT',1,'','2014-04-23 10:54:46',105,'2014-04-23 10:54:46',105,10,'1 very low');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-14  8:32:14
