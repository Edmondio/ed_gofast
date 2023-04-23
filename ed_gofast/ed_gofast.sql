CREATE TABLE IF NOT EXISTS `ed_gofast` (
  `count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `ed_gofast` (`count`) VALUES
	(10);

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('Sac_de_weed', 'Sac de weed', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('Sac_de_coke', 'Sac de coke', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('Sac_de_opium', 'Sac d\'opium', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('Sac_de_meth', 'Sac de meth', 1, 0, 1);



