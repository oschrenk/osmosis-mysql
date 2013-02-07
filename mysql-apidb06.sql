-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.77


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema api06_test
--

CREATE DATABASE IF NOT EXISTS api06_test
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_bin;
USE api06_test;

--
-- Definition of table `api06_test`.`acls`
--

DROP TABLE IF EXISTS `api06_test`.`acls`;
CREATE TABLE  `api06_test`.`acls` (
  `id` int(11) NOT NULL auto_increment,
  `address` int(10) unsigned NOT NULL,
  `netmask` int(10) unsigned NOT NULL,
  `k` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `v` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `acls_k_idx` (`k`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`acls`
--

/*!40000 ALTER TABLE `acls` DISABLE KEYS */;
LOCK TABLES `acls` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `acls` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`changeset_tags`
--

DROP TABLE IF EXISTS `api06_test`.`changeset_tags`;
CREATE TABLE  `api06_test`.`changeset_tags` (
  `changeset_id` bigint(64) NOT NULL,
  `k` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '',
  `v` varchar(255) NOT NULL default '',
  KEY `changeset_tags_id_idx` (`changeset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`changeset_tags`
--

/*!40000 ALTER TABLE `changeset_tags` DISABLE KEYS */;
LOCK TABLES `changeset_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `changeset_tags` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`changesets`
--

DROP TABLE IF EXISTS `api06_test`.`changesets`;
CREATE TABLE  `api06_test`.`changesets` (
  `id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `min_lat` int(11) default NULL,
  `max_lat` int(11) default NULL,
  `min_lon` int(11) default NULL,
  `max_lon` int(11) default NULL,
  `closed_at` datetime NOT NULL,
  `num_changes` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`changesets`
--

/*!40000 ALTER TABLE `changesets` DISABLE KEYS */;
LOCK TABLES `changesets` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `changesets` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`current_node_tags`
--

DROP TABLE IF EXISTS `api06_test`.`current_node_tags`;
CREATE TABLE  `api06_test`.`current_node_tags` (
  `node_id` bigint(64) NOT NULL,
  `k` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '',
  `v` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`node_id`,`k`),
  CONSTRAINT `current_node_tags_ibfk_1` FOREIGN KEY (`node_id`) REFERENCES `current_nodes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`current_node_tags`
--

/*!40000 ALTER TABLE `current_node_tags` DISABLE KEYS */;
LOCK TABLES `current_node_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_node_tags` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`current_nodes`
--

DROP TABLE IF EXISTS `api06_test`.`current_nodes`;
CREATE TABLE  `api06_test`.`current_nodes` (
  `id` bigint(64) NOT NULL auto_increment,
  `latitude` int(11) NOT NULL,
  `longitude` int(11) NOT NULL,
  `changeset_id` bigint(20) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `timestamp` datetime NOT NULL,
  `tile` int(10) unsigned default NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `current_nodes_timestamp_idx` (`timestamp`),
  KEY `current_nodes_tile_idx` (`tile`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `current_nodes_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`current_nodes`
--

/*!40000 ALTER TABLE `current_nodes` DISABLE KEYS */;
LOCK TABLES `current_nodes` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_nodes` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`current_relation_members`
--

DROP TABLE IF EXISTS `api06_test`.`current_relation_members`;
CREATE TABLE  `api06_test`.`current_relation_members` (
  `id` bigint(64) NOT NULL,
  `member_type` enum('Node','Way','Relation') NOT NULL default 'Node',
  `member_id` bigint(11) NOT NULL,
  `member_role` varchar(255) NOT NULL default '',
  `sequence_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`,`member_type`,`member_id`,`member_role`,`sequence_id`),
  KEY `current_relation_members_member_idx` (`member_type`,`member_id`),
  CONSTRAINT `current_relation_members_ibfk_1` FOREIGN KEY (`id`) REFERENCES `current_relations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`current_relation_members`
--

/*!40000 ALTER TABLE `current_relation_members` DISABLE KEYS */;
LOCK TABLES `current_relation_members` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_relation_members` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`current_relation_tags`
--

DROP TABLE IF EXISTS `api06_test`.`current_relation_tags`;
CREATE TABLE  `api06_test`.`current_relation_tags` (
  `id` bigint(64) NOT NULL,
  `k` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '',
  `v` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`,`k`),
  CONSTRAINT `current_relation_tags_ibfk_1` FOREIGN KEY (`id`) REFERENCES `current_relations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`current_relation_tags`
--

/*!40000 ALTER TABLE `current_relation_tags` DISABLE KEYS */;
LOCK TABLES `current_relation_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_relation_tags` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`current_relations`
--

DROP TABLE IF EXISTS `api06_test`.`current_relations`;
CREATE TABLE  `api06_test`.`current_relations` (
  `id` bigint(64) NOT NULL auto_increment,
  `changeset_id` bigint(20) NOT NULL,
  `timestamp` datetime NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `current_relations_timestamp_idx` (`timestamp`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `current_relations_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`current_relations`
--

/*!40000 ALTER TABLE `current_relations` DISABLE KEYS */;
LOCK TABLES `current_relations` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_relations` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`current_way_nodes`
--

DROP TABLE IF EXISTS `api06_test`.`current_way_nodes`;
CREATE TABLE  `api06_test`.`current_way_nodes` (
  `id` bigint(64) NOT NULL,
  `node_id` bigint(64) NOT NULL,
  `sequence_id` bigint(11) NOT NULL,
  PRIMARY KEY  (`id`,`sequence_id`),
  KEY `current_way_nodes_node_idx` (`node_id`),
  CONSTRAINT `current_way_nodes_ibfk_2` FOREIGN KEY (`node_id`) REFERENCES `current_nodes` (`id`),
  CONSTRAINT `current_way_nodes_ibfk_1` FOREIGN KEY (`id`) REFERENCES `current_ways` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`current_way_nodes`
--

/*!40000 ALTER TABLE `current_way_nodes` DISABLE KEYS */;
LOCK TABLES `current_way_nodes` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_way_nodes` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`current_way_tags`
--

DROP TABLE IF EXISTS `api06_test`.`current_way_tags`;
CREATE TABLE  `api06_test`.`current_way_tags` (
  `way_id` bigint(64) NOT NULL,
  `k` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '',
  `v` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`way_id`,`k`),
  CONSTRAINT `current_way_tags_ibfk_1` FOREIGN KEY (`way_id`) REFERENCES `current_ways` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`current_way_tags`
--

/*!40000 ALTER TABLE `current_way_tags` DISABLE KEYS */;
LOCK TABLES `current_way_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_way_tags` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`current_ways`
--

DROP TABLE IF EXISTS `api06_test`.`current_ways`;
CREATE TABLE  `api06_test`.`current_ways` (
  `id` bigint(64) NOT NULL auto_increment,
  `changeset_id` bigint(20) NOT NULL,
  `timestamp` datetime NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `current_ways_timestamp_idx` (`timestamp`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `current_ways_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`current_ways`
--

/*!40000 ALTER TABLE `current_ways` DISABLE KEYS */;
LOCK TABLES `current_ways` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `current_ways` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`diary_comments`
--

DROP TABLE IF EXISTS `api06_test`.`diary_comments`;
CREATE TABLE  `api06_test`.`diary_comments` (
  `id` bigint(20) NOT NULL auto_increment,
  `diary_entry_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `body` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `diary_comments_entry_id_idx` (`diary_entry_id`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`diary_comments`
--

/*!40000 ALTER TABLE `diary_comments` DISABLE KEYS */;
LOCK TABLES `diary_comments` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `diary_comments` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`diary_entries`
--

DROP TABLE IF EXISTS `api06_test`.`diary_entries`;
CREATE TABLE  `api06_test`.`diary_entries` (
  `id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `latitude` double default NULL,
  `longitude` double default NULL,
  `language` varchar(3) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`diary_entries`
--

/*!40000 ALTER TABLE `diary_entries` DISABLE KEYS */;
LOCK TABLES `diary_entries` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `diary_entries` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`friends`
--

DROP TABLE IF EXISTS `api06_test`.`friends`;
CREATE TABLE  `api06_test`.`friends` (
  `id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL,
  `friend_user_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id_idx` (`friend_user_id`),
  KEY `friends_user_id_idx` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`friends`
--

/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
LOCK TABLES `friends` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`gps_points`
--

DROP TABLE IF EXISTS `api06_test`.`gps_points`;
CREATE TABLE  `api06_test`.`gps_points` (
  `altitude` float default NULL,
  `trackid` int(11) NOT NULL,
  `latitude` int(11) NOT NULL,
  `longitude` int(11) NOT NULL,
  `gpx_id` bigint(64) NOT NULL,
  `timestamp` datetime default NULL,
  `tile` int(10) unsigned default NULL,
  KEY `points_gpxid_idx` (`gpx_id`),
  KEY `points_tile_idx` (`tile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`gps_points`
--

/*!40000 ALTER TABLE `gps_points` DISABLE KEYS */;
LOCK TABLES `gps_points` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `gps_points` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`gpx_file_tags`
--

DROP TABLE IF EXISTS `api06_test`.`gpx_file_tags`;
CREATE TABLE  `api06_test`.`gpx_file_tags` (
  `gpx_id` bigint(64) NOT NULL default '0',
  `tag` varchar(255) NOT NULL,
  `id` bigint(20) NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `gpx_file_tags_gpxid_idx` (`gpx_id`),
  KEY `gpx_file_tags_tag_idx` (`tag`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`gpx_file_tags`
--

/*!40000 ALTER TABLE `gpx_file_tags` DISABLE KEYS */;
LOCK TABLES `gpx_file_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `gpx_file_tags` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`gpx_files`
--

DROP TABLE IF EXISTS `api06_test`.`gpx_files`;
CREATE TABLE  `api06_test`.`gpx_files` (
  `id` bigint(64) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL,
  `visible` tinyint(1) NOT NULL default '1',
  `name` varchar(255) NOT NULL default '',
  `size` bigint(20) default NULL,
  `latitude` double default NULL,
  `longitude` double default NULL,
  `timestamp` datetime NOT NULL,
  `public` tinyint(1) NOT NULL default '1',
  `description` varchar(255) NOT NULL default '',
  `inserted` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `gpx_files_timestamp_idx` (`timestamp`),
  KEY `gpx_files_visible_public_idx` (`visible`,`public`),
  KEY `gpx_files_user_id_idx` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`gpx_files`
--

/*!40000 ALTER TABLE `gpx_files` DISABLE KEYS */;
LOCK TABLES `gpx_files` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `gpx_files` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`messages`
--

DROP TABLE IF EXISTS `api06_test`.`messages`;
CREATE TABLE  `api06_test`.`messages` (
  `id` bigint(20) NOT NULL auto_increment,
  `from_user_id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `sent_on` datetime NOT NULL,
  `message_read` tinyint(1) NOT NULL default '0',
  `to_user_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `messages_to_user_id_idx` (`to_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`messages`
--

/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
LOCK TABLES `messages` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`node_tags`
--

DROP TABLE IF EXISTS `api06_test`.`node_tags`;
CREATE TABLE  `api06_test`.`node_tags` (
  `node_id` bigint(64) NOT NULL,
  `version` bigint(20) NOT NULL,
  `k` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '',
  `v` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`node_id`,`version`,`k`),
  CONSTRAINT `node_tags_ibfk_1` FOREIGN KEY (`node_id`, `version`) REFERENCES `nodes` (`node_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`node_tags`
--

/*!40000 ALTER TABLE `node_tags` DISABLE KEYS */;
LOCK TABLES `node_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `node_tags` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`nodes`
--

DROP TABLE IF EXISTS `api06_test`.`nodes`;
CREATE TABLE  `api06_test`.`nodes` (
  `node_id` bigint(64) NOT NULL,
  `latitude` int(11) NOT NULL,
  `longitude` int(11) NOT NULL,
  `changeset_id` bigint(20) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `timestamp` datetime NOT NULL,
  `tile` int(10) unsigned default NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`node_id`,`version`),
  KEY `nodes_timestamp_idx` (`timestamp`),
  KEY `nodes_tile_idx` (`tile`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `nodes_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`nodes`
--

/*!40000 ALTER TABLE `nodes` DISABLE KEYS */;
LOCK TABLES `nodes` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `nodes` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`relation_members`
--

DROP TABLE IF EXISTS `api06_test`.`relation_members`;
CREATE TABLE  `api06_test`.`relation_members` (
  `relation_id` bigint(64) NOT NULL default '0',
  `member_type` enum('Node','Way','Relation') NOT NULL default 'Node',
  `member_id` bigint(11) NOT NULL,
  `member_role` varchar(255) NOT NULL default '',
  `version` bigint(20) NOT NULL default '0',
  `sequence_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`relation_id`,`version`,`member_type`,`member_id`,`member_role`,`sequence_id`),
  KEY `relation_members_member_idx` (`member_type`,`member_id`),
  CONSTRAINT `relation_members_ibfk_1` FOREIGN KEY (`relation_id`, `version`) REFERENCES `relations` (`relation_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`relation_members`
--

/*!40000 ALTER TABLE `relation_members` DISABLE KEYS */;
LOCK TABLES `relation_members` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `relation_members` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`relation_tags`
--

DROP TABLE IF EXISTS `api06_test`.`relation_tags`;
CREATE TABLE  `api06_test`.`relation_tags` (
  `relation_id` bigint(64) NOT NULL default '0',
  `k` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '',
  `v` varchar(255) NOT NULL default '',
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`relation_id`,`version`,`k`),
  CONSTRAINT `relation_tags_ibfk_1` FOREIGN KEY (`relation_id`, `version`) REFERENCES `relations` (`relation_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`relation_tags`
--

/*!40000 ALTER TABLE `relation_tags` DISABLE KEYS */;
LOCK TABLES `relation_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `relation_tags` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`relations`
--

DROP TABLE IF EXISTS `api06_test`.`relations`;
CREATE TABLE  `api06_test`.`relations` (
  `relation_id` bigint(64) NOT NULL default '0',
  `changeset_id` bigint(20) NOT NULL,
  `timestamp` datetime NOT NULL,
  `version` bigint(20) NOT NULL,
  `visible` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`relation_id`,`version`),
  KEY `relations_timestamp_idx` (`timestamp`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `relations_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`relations`
--

/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
LOCK TABLES `relations` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`schema_migrations`
--

DROP TABLE IF EXISTS `api06_test`.`schema_migrations`;
CREATE TABLE  `api06_test`.`schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`schema_migrations`
--

/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
LOCK TABLES `schema_migrations` WRITE;
INSERT INTO `api06_test`.`schema_migrations` VALUES  ('1'),
 ('10'),
 ('11'),
 ('12'),
 ('13'),
 ('14'),
 ('15'),
 ('16'),
 ('17'),
 ('18'),
 ('19'),
 ('2'),
 ('20'),
 ('21'),
 ('22'),
 ('23'),
 ('24'),
 ('25'),
 ('3'),
 ('4'),
 ('5'),
 ('6'),
 ('7'),
 ('8'),
 ('9');
UNLOCK TABLES;
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`sessions`
--

DROP TABLE IF EXISTS `api06_test`.`sessions`;
CREATE TABLE  `api06_test`.`sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) default NULL,
  `data` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sessions_session_id_idx` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`sessions`
--

/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
LOCK TABLES `sessions` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`user_preferences`
--

DROP TABLE IF EXISTS `api06_test`.`user_preferences`;
CREATE TABLE  `api06_test`.`user_preferences` (
  `user_id` bigint(20) NOT NULL,
  `k` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `v` varchar(255) NOT NULL,
  PRIMARY KEY  (`user_id`,`k`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`user_preferences`
--

/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
LOCK TABLES `user_preferences` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`user_tokens`
--

DROP TABLE IF EXISTS `api06_test`.`user_tokens`;
CREATE TABLE  `api06_test`.`user_tokens` (
  `id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expiry` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_tokens_token_idx` (`token`),
  KEY `user_tokens_user_id_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`user_tokens`
--

/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
LOCK TABLES `user_tokens` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `user_tokens` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`users`
--

DROP TABLE IF EXISTS `api06_test`.`users`;
CREATE TABLE  `api06_test`.`users` (
  `email` varchar(255) NOT NULL,
  `id` bigint(20) NOT NULL auto_increment,
  `active` int(11) NOT NULL default '0',
  `pass_crypt` varchar(255) NOT NULL,
  `creation_time` datetime NOT NULL,
  `display_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '',
  `data_public` tinyint(1) NOT NULL default '0',
  `description` text NOT NULL,
  `home_lat` double default NULL,
  `home_lon` double default NULL,
  `home_zoom` smallint(6) default '3',
  `nearby` int(11) default '50',
  `pass_salt` varchar(255) default NULL,
  `image` text,
  `administrator` tinyint(1) NOT NULL default '0',
  `email_valid` tinyint(1) NOT NULL default '0',
  `new_email` varchar(255) default NULL,
  `visible` tinyint(1) NOT NULL default '1',
  `creation_ip` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `users_email_idx` (`email`),
  UNIQUE KEY `users_display_name_idx` (`display_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
LOCK TABLES `users` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`way_nodes`
--

DROP TABLE IF EXISTS `api06_test`.`way_nodes`;
CREATE TABLE  `api06_test`.`way_nodes` (
  `way_id` bigint(64) NOT NULL,
  `node_id` bigint(64) NOT NULL,
  `version` bigint(20) NOT NULL,
  `sequence_id` bigint(11) NOT NULL,
  PRIMARY KEY  (`way_id`,`version`,`sequence_id`),
  KEY `way_nodes_node_idx` (`node_id`),
  CONSTRAINT `way_nodes_ibfk_1` FOREIGN KEY (`way_id`, `version`) REFERENCES `ways` (`way_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`way_nodes`
--

/*!40000 ALTER TABLE `way_nodes` DISABLE KEYS */;
LOCK TABLES `way_nodes` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `way_nodes` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`way_tags`
--

DROP TABLE IF EXISTS `api06_test`.`way_tags`;
CREATE TABLE  `api06_test`.`way_tags` (
  `way_id` bigint(64) NOT NULL default '0',
  `k` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `v` varchar(255) NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY  (`way_id`,`version`,`k`),
  CONSTRAINT `way_tags_ibfk_1` FOREIGN KEY (`way_id`, `version`) REFERENCES `ways` (`way_id`, `version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`way_tags`
--

/*!40000 ALTER TABLE `way_tags` DISABLE KEYS */;
LOCK TABLES `way_tags` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `way_tags` ENABLE KEYS */;


--
-- Definition of table `api06_test`.`ways`
--

DROP TABLE IF EXISTS `api06_test`.`ways`;
CREATE TABLE  `api06_test`.`ways` (
  `way_id` bigint(64) NOT NULL default '0',
  `changeset_id` bigint(20) NOT NULL,
  `timestamp` datetime NOT NULL,
  `version` bigint(20) NOT NULL,
  `visible` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`way_id`,`version`),
  KEY `ways_timestamp_idx` (`timestamp`),
  KEY `changeset_id` (`changeset_id`),
  CONSTRAINT `ways_ibfk_1` FOREIGN KEY (`changeset_id`) REFERENCES `changesets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api06_test`.`ways`
--

/*!40000 ALTER TABLE `ways` DISABLE KEYS */;
LOCK TABLES `ways` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `ways` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
