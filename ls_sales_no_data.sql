-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: lk_sales
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

--
-- Table structure for table `bots`
--

DROP TABLE IF EXISTS `bots`;
CREATE TABLE `bots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','stop','pause','moderation','refuse') NOT NULL DEFAULT 'moderation',
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_date` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `direction` tinyint(2) DEFAULT 0,
  `app_name` varchar(64) DEFAULT '',
  `ats_prefix` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Table structure for table `events_00000110`
--

DROP TABLE IF EXISTS `events_00000110`;
CREATE TABLE `events_00000110` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `source` varchar(20) NOT NULL,
  `importance` int(11) NOT NULL,
  `quality` int(11) DEFAULT NULL,
  `stage` varchar(30) DEFAULT NULL,
  `forgot` tinyint(2) DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`source`) USING BTREE,
  KEY `project_id_index` (`project_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `events_00000173`
--

DROP TABLE IF EXISTS `events_00000173`;
CREATE TABLE `events_00000173` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `source` varchar(20) NOT NULL,
  `importance` int(11) NOT NULL,
  `quality` int(11) DEFAULT NULL,
  `stage` varchar(30) DEFAULT NULL,
  `forgot` tinyint(2) DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`source`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `events_00000178`
--

DROP TABLE IF EXISTS `events_00000178`;
CREATE TABLE `events_00000178` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `source` varchar(20) NOT NULL,
  `importance` int(11) NOT NULL,
  `quality` int(11) DEFAULT NULL,
  `stage` varchar(30) DEFAULT NULL,
  `forgot` tinyint(2) DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`source`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `events_call_00000110`
--

DROP TABLE IF EXISTS `events_call_00000110`;
CREATE TABLE `events_call_00000110` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime_event` int(11) NOT NULL,
  `type_event` varchar(20) NOT NULL,
  `title` longtext NOT NULL,
  `clid` varchar(40) NOT NULL,
  `did` varchar(30) NOT NULL,
  `src` varchar(30) NOT NULL,
  `dst` varchar(30) NOT NULL,
  `duration` int(11) NOT NULL,
  `billsec` int(11) NOT NULL,
  `voice_duration` decimal(11,3) NOT NULL,
  `disposition` varchar(30) NOT NULL,
  `uniqueid` int(11) NOT NULL,
  `link` text NOT NULL,
  `manager` varchar(30) DEFAULT NULL,
  `text_yandex` text DEFAULT NULL,
  `short_pause` int(11) DEFAULT NULL,
  `medium_pause` int(11) DEFAULT NULL,
  `long_pause` int(11) DEFAULT NULL,
  `client_collisions` int(11) DEFAULT NULL,
  `manager_collisions` int(11) DEFAULT NULL,
  `manager_words` decimal(10,2) DEFAULT NULL,
  `client_words` decimal(10,2) DEFAULT NULL,
  `client_symbols` int(11) DEFAULT NULL,
  `manager_symbols` int(11) DEFAULT NULL,
  `calculatestats` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `datetime_event_index` (`datetime_event`)
) ENGINE=MyISAM AUTO_INCREMENT=19256 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `events_call_00000173`
--

DROP TABLE IF EXISTS `events_call_00000173`;
CREATE TABLE `events_call_00000173` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime_event` int(11) NOT NULL,
  `type_event` varchar(20) NOT NULL,
  `title` longtext NOT NULL,
  `clid` varchar(40) NOT NULL,
  `did` varchar(30) NOT NULL,
  `src` varchar(30) NOT NULL,
  `dst` varchar(30) NOT NULL,
  `duration` int(11) NOT NULL,
  `billsec` int(11) NOT NULL,
  `voice_duration` decimal(11,3) NOT NULL,
  `disposition` varchar(30) NOT NULL,
  `uniqueid` int(11) NOT NULL,
  `link` text NOT NULL,
  `manager` varchar(30) DEFAULT NULL,
  `text_yandex` text DEFAULT NULL,
  `short_pause` int(11) DEFAULT NULL,
  `medium_pause` int(11) DEFAULT NULL,
  `long_pause` int(11) DEFAULT NULL,
  `client_collisions` int(11) DEFAULT NULL,
  `manager_collisions` int(11) DEFAULT NULL,
  `manager_words` decimal(10,2) DEFAULT NULL,
  `client_words` decimal(10,2) DEFAULT NULL,
  `client_symbols` int(11) DEFAULT NULL,
  `manager_symbols` int(11) DEFAULT NULL,
  `calculatestats` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `datetime_event_index` (`datetime_event`)
) ENGINE=MyISAM AUTO_INCREMENT=194 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `events_call_00000178`
--

DROP TABLE IF EXISTS `events_call_00000178`;
CREATE TABLE `events_call_00000178` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime_event` int(11) NOT NULL,
  `type_event` varchar(20) NOT NULL,
  `title` longtext NOT NULL,
  `clid` varchar(40) NOT NULL,
  `did` varchar(30) NOT NULL,
  `src` varchar(30) NOT NULL,
  `dst` varchar(30) NOT NULL,
  `duration` int(11) NOT NULL,
  `billsec` int(11) NOT NULL,
  `voice_duration` decimal(11,3) NOT NULL,
  `disposition` varchar(30) NOT NULL,
  `uniqueid` int(11) NOT NULL,
  `link` text NOT NULL,
  `manager` varchar(30) DEFAULT NULL,
  `text_yandex` text DEFAULT NULL,
  `short_pause` int(11) DEFAULT NULL,
  `medium_pause` int(11) DEFAULT NULL,
  `long_pause` int(11) DEFAULT NULL,
  `client_collisions` int(11) DEFAULT NULL,
  `manager_collisions` int(11) DEFAULT NULL,
  `manager_words` decimal(10,2) DEFAULT NULL,
  `client_words` decimal(10,2) DEFAULT NULL,
  `client_symbols` int(11) DEFAULT NULL,
  `manager_symbols` int(11) DEFAULT NULL,
  `calculatestats` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `datetime_event_index` (`datetime_event`)
) ENGINE=MyISAM AUTO_INCREMENT=210 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `events_conversations_00000110`
--

DROP TABLE IF EXISTS `events_conversations_00000110`;
CREATE TABLE `events_conversations_00000110` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime_event` int(11) NOT NULL,
  `src` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `dst` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `direction` enum('input','output') DEFAULT NULL,
  `billsec` int(11) DEFAULT NULL,
  `app_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `app_name_full` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `app_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `job_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `report_data` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `conversation` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sent_report` tinyint(1) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datetime_event` (`datetime_event`),
  KEY `src_dst_sent_report` (`src`,`dst`,`sent_report`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Table structure for table `events_conversations_00000173`
--

DROP TABLE IF EXISTS `events_conversations_00000173`;
CREATE TABLE `events_conversations_00000173` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime_event` int(11) NOT NULL,
  `src` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `dst` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `direction` enum('input','output') DEFAULT NULL,
  `billsec` int(11) DEFAULT NULL,
  `app_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `app_name_full` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `app_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `job_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `report_data` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `conversation` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sent_report` tinyint(1) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datetime_event` (`datetime_event`),
  KEY `src_dst_sent_report` (`src`,`dst`,`sent_report`)
) ENGINE=MyISAM AUTO_INCREMENT=234 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Table structure for table `events_conversations_00000178`
--

DROP TABLE IF EXISTS `events_conversations_00000178`;
CREATE TABLE `events_conversations_00000178` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime_event` int(11) NOT NULL,
  `src` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `dst` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `direction` enum('input','output') DEFAULT NULL,
  `billsec` int(11) DEFAULT NULL,
  `app_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `app_name_full` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `app_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `job_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `report_data` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `conversation` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sent_report` tinyint(1) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datetime_event` (`datetime_event`),
  KEY `src_dst_sent_report` (`src`,`dst`,`sent_report`)
) ENGINE=MyISAM AUTO_INCREMENT=160 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `amount` float NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=183 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'Unknown',
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` smallint(6) DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `archive` tinyint(1) NOT NULL DEFAULT 0,
  `auth_key` varchar(255) NOT NULL,
  `ats_login` varchar(255) DEFAULT NULL,
  `ats_pass` varchar(255) DEFAULT NULL,
  `owner` int(255) DEFAULT NULL,
  `report_link` varchar(500) DEFAULT NULL,
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `calltouch_id` varchar(255) DEFAULT NULL,
  `calltouch_key` varchar(255) DEFAULT NULL,
  `controller_id` int(11) DEFAULT NULL,
  `bots_discount` int(11) DEFAULT NULL,
  `analytics_discount` int(11) DEFAULT NULL,
  `dashboard` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role` (`role`)
) ENGINE=MyISAM AUTO_INCREMENT=452 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;