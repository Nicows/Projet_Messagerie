-- MySQL Script generated by MySQL Workbench
-- Thu Dec 17 16:49:21 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema messagerie_instantanee
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema messagerie_instantanee
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `messagerie_instantanee` DEFAULT CHARACTER SET utf8 ;
USE `messagerie_instantanee` ;

-- -----------------------------------------------------
-- Table `messagerie_instantanee`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `messagerie_instantanee`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(20) NULL,
  `prenom` VARCHAR(20) NULL,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(80) NOT NULL,
  `status` SMALLINT(10) NULL,
  `login` VARCHAR(20) NULL,
  `username` VARCHAR(20) NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messagerie_instantanee`.`groupe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `messagerie_instantanee`.`groupe` (
  `id_groupe` INT NOT NULL AUTO_INCREMENT,
  `nom_groupe` VARCHAR(45) NOT NULL,
  `id_administrateur` INT NOT NULL,
  `date_creation` TIMESTAMP NOT NULL,
  `user_iduser` INT NOT NULL,
  PRIMARY KEY (`id_groupe`),
  INDEX `fk_groupe_user1_idx` (`user_iduser` ASC) ,
  CONSTRAINT `fk_groupe_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `messagerie_instantanee`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messagerie_instantanee`.`asset`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `messagerie_instantanee`.`asset` (
  `id_asset` INT NOT NULL AUTO_INCREMENT,
  `nom_document` VARCHAR(45) NOT NULL,
  `date_creation` TIMESTAMP NULL,
  `descriptif` VARCHAR(45) NULL,
  `url` VARCHAR(200) NULL,
  `groupe_idgroupe` INT NOT NULL,
  PRIMARY KEY (`id_asset`),
  INDEX `fk_asset_groupe1_idx` (`groupe_idgroupe` ASC) ,
  CONSTRAINT `fk_asset_groupe1`
    FOREIGN KEY (`groupe_idgroupe`)
    REFERENCES `messagerie_instantanee`.`groupe` (`id_groupe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messagerie_instantanee`.`image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `messagerie_instantanee`.`image` (
  `asset_idasset` INT NOT NULL,
  PRIMARY KEY (`asset_idasset`),
  INDEX `fk_image_asset1_idx` (`asset_idasset` ASC) ,
  CONSTRAINT `fk_image_asset1`
    FOREIGN KEY (`asset_idasset`)
    REFERENCES `messagerie_instantanee`.`asset` (`id_asset`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messagerie_instantanee`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `messagerie_instantanee`.`video` (
  `asset_idasset` INT NOT NULL,
  PRIMARY KEY (`asset_idasset`),
  INDEX `fk_video_asset1_idx` (`asset_idasset` ASC) ,
  CONSTRAINT `fk_video_asset1`
    FOREIGN KEY (`asset_idasset`)
    REFERENCES `messagerie_instantanee`.`asset` (`id_asset`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messagerie_instantanee`.`conversation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `messagerie_instantanee`.`conversation` (
  `id_conversation` INT NOT NULL AUTO_INCREMENT,
  `user_id_emetteur` INT NOT NULL,
  `user_id_recepteur` INT NOT NULL,
  PRIMARY KEY (`id_conversation`),
  INDEX `fk_conversation_user1_idx` (`user_id_emetteur` ASC) ,
  INDEX `fk_conversation_user2_idx` (`user_id_recepteur` ASC) ,
  CONSTRAINT `fk_conversation_user1`
    FOREIGN KEY (`user_id_emetteur`)
    REFERENCES `messagerie_instantanee`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conversation_user2`
    FOREIGN KEY (`user_id_recepteur`)
    REFERENCES `messagerie_instantanee`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messagerie_instantanee`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `messagerie_instantanee`.`message` (
  `id_message` INT NOT NULL AUTO_INCREMENT,
  `conversation_idconversation` INT NOT NULL,
  `user_iduser` INT NOT NULL,
  `contenu_message` VARCHAR(45) NULL,
  `date_heure` TIMESTAMP NULL,
  PRIMARY KEY (`id_message`),
  INDEX `fk_message_conversation1_idx` (`conversation_idconversation` ASC) ,
  INDEX `fk_message_user1_idx` (`user_iduser` ASC) ,
  CONSTRAINT `fk_message_conversation1`
    FOREIGN KEY (`conversation_idconversation`)
    REFERENCES `messagerie_instantanee`.`conversation` (`id_conversation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `messagerie_instantanee`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messagerie_instantanee`.`membre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `messagerie_instantanee`.`membre` (
  `user_iduser` INT NOT NULL,
  `groupe_idgroupe` INT NOT NULL,
  PRIMARY KEY (`user_iduser`, `groupe_idgroupe`),
  INDEX `fk_user_has_groupe_groupe1_idx` (`groupe_idgroupe` ASC) ,
  INDEX `fk_user_has_groupe_user1_idx` (`user_iduser` ASC) ,
  CONSTRAINT `fk_user_has_groupe_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `messagerie_instantanee`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_groupe_groupe1`
    FOREIGN KEY (`groupe_idgroupe`)
    REFERENCES `messagerie_instantanee`.`groupe` (`id_groupe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
