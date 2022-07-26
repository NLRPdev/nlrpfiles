ALTER TABLE `player_vehicles`
ADD COLUMN `traveldistance` INT(50) NULL DEFAULT 0 AFTER `financetime`,
ADD COLUMN `noslevel` INT(10) NULL DEFAULT 0 AFTER `traveldistance`,
ADD COLUMN `hasnitro` TINYINT(0) NULL DEFAULT 0 AFTER `noslevel`;