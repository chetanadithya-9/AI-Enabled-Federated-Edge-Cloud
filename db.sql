/*
SQLyog Community Edition- MySQL GUI v7.15 
MySQL - 5.5.29 : Database - alb
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`alb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `alb`;

/*Table structure for table `cloud` */

DROP TABLE IF EXISTS `cloud`;

CREATE TABLE `cloud` (
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cloud` */

insert  into `cloud`(`username`,`password`) values ('cloud','cloud');

/*Table structure for table `clouddata` */

DROP TABLE IF EXISTS `clouddata`;

CREATE TABLE `clouddata` (
  `filename` varchar(100) DEFAULT NULL,
  `owner` varchar(100) DEFAULT NULL,
  `cipher` varchar(100) DEFAULT NULL,
  `skey` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `status1` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `clouddata` */

insert  into `clouddata`(`filename`,`owner`,`cipher`,`skey`,`status`,`status1`) values ('bbc.txt','munna','eVeiOTrStqokQWYOh3OOj/mZfyhmdS5ejgkv84EoUL4=','hb6H/xaa6lI0V r zX3VnQ==','pending','pending');

ALTER TABLE `clouddata` ADD COLUMN `duration_sec` INT DEFAULT 0;
ALTER TABLE `clouddata` ADD COLUMN `packet_count` INT DEFAULT 0;
ALTER TABLE `clouddata` ADD COLUMN `bytes_transferred` INT DEFAULT 0;
ALTER TABLE `clouddata` ADD COLUMN `flow_rate` INT DEFAULT 0;
ALTER TABLE `clouddata` ADD COLUMN `failed_logins` INT DEFAULT 0;
ALTER TABLE `clouddata` ADD COLUMN `syn_packets` INT DEFAULT 0;
ALTER TABLE `clouddata` ADD COLUMN `udp_packets` INT DEFAULT 0;
ALTER TABLE `clouddata` ADD COLUMN `tcp_retransmissions` INT DEFAULT 0;
ALTER TABLE `clouddata` ADD COLUMN `avg_packet_size` DOUBLE DEFAULT 0;
ALTER TABLE `clouddata` ADD COLUMN `connection_hour` INT DEFAULT 0;
ALTER TABLE `clouddata` ADD COLUMN `prediction` VARCHAR(100) DEFAULT 'Normal';

/*Table structure for table `node` */

DROP TABLE IF EXISTS `node`;

CREATE TABLE `node` (
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `node` varchar(100) DEFAULT NULL,
  `node_value` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `node` */

insert  into `node`(`username`,`password`,`node`,`node_value`) values ('node1','node1','node1',0),('node2','node2','node2',0),('node3','node3','node3',0),('node4','node4','node4',0);

/*Table structure for table `node_data` */

DROP TABLE IF EXISTS `node_data`;

CREATE TABLE `node_data` (
  `filename` varchar(100) DEFAULT NULL,
  `owner` varchar(100) DEFAULT NULL,
  `cipher` text,
  `skey` varchar(100) DEFAULT NULL,
  `node` varbinary(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `node_data` */

insert  into `node_data`(`filename`,`owner`,`cipher`,`skey`,`node`,`status`) values ('bbc.txt','munna','eVeiOTrStqokQWYOh3OOj/mZfyhmdS5ejgkv84EoUL4=','hb6H/xaa6lI0V r zX3VnQ==','node2','sent');

/*Table structure for table `owner` */

DROP TABLE IF EXISTS `owner`;

CREATE TABLE `owner` (
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `owner` */

insert  into `owner`(`username`,`password`,`email`,`mobile`,`address`) values ('munna','munna','munna@gmail.com','08639966858','15-8-424');

/*Table structure for table `rec` */

DROP TABLE IF EXISTS `rec`;

CREATE TABLE `rec` (
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rec` */

insert  into `rec`(`username`,`password`,`email`,`mobile`,`address`) values ('chotu','chotu','moulalicce225@gmail.com','08639966858','15-8-424');

/*Table structure for table `req` */

DROP TABLE IF EXISTS `req`;

CREATE TABLE `req` (
  `filename` varchar(100) DEFAULT NULL,
  `owner` varchar(100) DEFAULT NULL,
  `cipher` varchar(100) DEFAULT NULL,
  `node` varchar(100) DEFAULT NULL,
  `rec` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `req` */

insert  into `req`(`filename`,`owner`,`cipher`,`node`,`rec`,`status`) values ('bbc.txt','munna','eVeiOTrStqokQWYOh3OOj/mZfyhmdS5ejgkv84EoUL4=','node1','chotu','key sent');

/*Table structure for table `upload` */

DROP TABLE IF EXISTS `upload`;

CREATE TABLE `upload` (
  `filename` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `content` text,
  `cipher` text,
  `skey` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `status1` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `upload` */

insert  into `upload`(`filename`,`username`,`content`,`cipher`,`skey`,`status`,`status1`) values ('bbc.txt','munna','hii hello good morning friends\n','eVeiOTrStqokQWYOh3OOj/mZfyhmdS5ejgkv84EoUL4=','hb6H/xaa6lI0V+r+zX3VnQ==','pending','pending');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
