ALTER TABLE `players`
ADD `mdt_image` varchar(1024) DEFAULT NULL,
ADD `mdt_height` int(11) DEFAULT NULL,
ADD `mdt_description` varchar(255) DEFAULT NULL;

ALTER TABLE `player_vehicles`
ADD `mdt_image` varchar(1024) DEFAULT NULL,
ADD `mdt_description` varchar(255) DEFAULT NULL;

CREATE TABLE `mdt_evidences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `images` varchar(1024) DEFAULT NULL,
  `players` varchar(1024) DEFAULT NULL,
  `description` varchar(1024) NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `players` (`players`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `mdt_incidents` (
  `id` int(11) DEFAULT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `players` varchar(1024) DEFAULT NULL,
  `cops` varchar(1024) DEFAULT NULL,
  `vehicles` varchar(1024) DEFAULT NULL,
  `evidences` varchar(1024) DEFAULT NULL,
  `fines` varchar(1024) DEFAULT NULL,
  `jail` varchar(1024) DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `mdt_fines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `amount` int(11) DEFAULT 0,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `mdt_jail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `mdt_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `mdt_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wtype` varchar(255) NOT NULL,
  `players` varchar(1024) NOT NULL DEFAULT '[]',
  `house` varchar(255) DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `description` varchar(1024) NOT NULL,
  `done` tinyint(1) NOT NULL DEFAULT 0,
  `start_time` varchar(255) DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `players` (`players`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;
