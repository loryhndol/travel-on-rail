-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_travel_on_rail
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_travel_on_rail` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db_travel_on_rail` ;

-- -----------------------------------------------------
-- Table `db_travel_on_rail`.`tb_user_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_travel_on_rail`.`tb_user_account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `age` INT NULL,
  `user_name` VARCHAR(20) NOT NULL,
  `passwd` VARCHAR(255) NOT NULL,
  `name` VARCHAR(45) NULL,
  `identity_code` VARCHAR(255) NULL,
  `balance` DECIMAL(8,2) NULL,
  `created_at` TIMESTAMP NULL,
  `created_ip` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_balance` (`balance` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_travel_on_rail`.`tb_office`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_travel_on_rail`.`tb_office` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `station_name` VARCHAR(16) NULL,
  `city_name` VARCHAR(16) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_travel_on_rail`.`tb_train_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_travel_on_rail`.`tb_train_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dept_time` DATETIME NULL,
  `km_mark` INT NULL,
  `arr_time` DATETIME NULL,
  `station_name` VARCHAR(16) NULL,
  `city_id` INT NULL,
  `train_name` VARCHAR(16) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_train_office_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_train_office`
    FOREIGN KEY (`city_id`)
    REFERENCES `db_travel_on_rail`.`tb_office` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_travel_on_rail`.`tb_tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_travel_on_rail`.`tb_tickets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `train_id` INT NULL,
  `train_name` VARCHAR(16) NULL,
  `valid_volume` INT NULL,
  `cabin_type` VARCHAR(16) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ticket_train_idx` (`train_id` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_train`
    FOREIGN KEY (`train_id`)
    REFERENCES `db_travel_on_rail`.`tb_train_log` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_travel_on_rail`.`tb_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_travel_on_rail`.`tb_orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `train_name` VARCHAR(16) NULL,
  `dept_station` VARCHAR(16) NULL,
  `arr_station` VARCHAR(16) NULL,
  `dept_time` DATETIME NULL,
  `arr_time` DATETIME NULL,
  `ticket_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_ticket_idx` (`ticket_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_ticket`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `db_travel_on_rail`.`tb_tickets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_travel_on_rail`.`tb_user_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_travel_on_rail`.`tb_user_orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_code` INT NULL,
  `order_status` INT NULL,
  `created_at` TIMESTAMP NULL,
  `order_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_code_idx` (`user_code` ASC) VISIBLE,
  INDEX `fk_order_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_id`
    FOREIGN KEY (`user_code`)
    REFERENCES `db_travel_on_rail`.`tb_user_account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `db_travel_on_rail`.`tb_orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
ROW_FORMAT = DEFAULT;

USE `db_travel_on_rail` ;

-- -----------------------------------------------------
-- Placeholder table for view `db_travel_on_rail`.`view_city_stations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_travel_on_rail`.`view_city_stations` (`city` INT, `station` INT);

-- -----------------------------------------------------
-- Placeholder table for view `db_travel_on_rail`.`view_user_order_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_travel_on_rail`.`view_user_order_list` (`order_id` INT, `train_name` INT, `dept_station` INT, `arr_station` INT, `dept_time` INT, `arr_time` INT, `user_code` INT, `order_status` INT, `created_at` INT);

-- -----------------------------------------------------
-- Placeholder table for view `db_travel_on_rail`.`view_remaining_tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_travel_on_rail`.`view_remaining_tickets` (`train_name` INT, `cabin_type` INT, `valid_volume` INT, `dept_time` INT, `arr_time` INT, `station_name` INT);

-- -----------------------------------------------------
-- View `db_travel_on_rail`.`view_city_stations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_travel_on_rail`.`view_city_stations`;
USE `db_travel_on_rail`;
CREATE  OR REPLACE VIEW `view_city_stations` AS
select city_name as city, station_name as station from tb_office;

-- -----------------------------------------------------
-- View `db_travel_on_rail`.`view_user_order_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_travel_on_rail`.`view_user_order_list`;
USE `db_travel_on_rail`;
CREATE  OR REPLACE VIEW `view_user_order_list` AS
select 
	order_id, 
    train_name, 
    dept_station, 
    arr_station, 
    dept_time, 
    arr_time,
    user_code,
    order_status,
    created_at
from tb_orders as A, tb_user_orders as B where A.id = B.order_id;

-- -----------------------------------------------------
-- View `db_travel_on_rail`.`view_remaining_tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_travel_on_rail`.`view_remaining_tickets`;
USE `db_travel_on_rail`;
CREATE  OR REPLACE VIEW `view_remaining_tickets` AS
select 
	tb_tickets.train_name,
    cabin_type,
    valid_volume,
    dept_time,
    arr_time,
    station_name
from tb_tickets, tb_train_log
where 
	train_id = tb_train_log.id and
	valid_volume >= 0;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
