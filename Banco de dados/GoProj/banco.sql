-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_uber_entrega
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_uber_entrega
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_uber_entrega` DEFAULT CHARACTER SET utf8 ;
USE `db_uber_entrega` ;

-- -----------------------------------------------------
-- Table `db_uber_entrega`.`tb_categoria_cnh`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_uber_entrega`.`tb_categoria_cnh` (
  `id_categoria_cnh` INT(11) NOT NULL,
  `sg_categoria_cnh` CHAR(1) NOT NULL,
  `nm_veiculo` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_categoria_cnh`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_uber_entrega`.`tb_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_uber_entrega`.`tb_cliente` (
  `id_cliente` INT(11) NOT NULL,
  `nm_cliente` VARCHAR(30) NOT NULL,
  `nm_sobrenome` VARCHAR(60) NOT NULL,
  `nm_email` VARCHAR(80) NOT NULL,
  `nm_senha` VARCHAR(100) NOT NULL,
  `cd_ddd_celular` VARCHAR(2) NULL,
  `cd_celular` VARCHAR(9) NULL,
  `img_cliente` VARCHAR(200) NULL DEFAULT NULL,
  `cd_cpf` CHAR(11) NULL,
  `dt_nascimento` DATE NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_uber_entrega`.`tb_motorista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_uber_entrega`.`tb_motorista` (
  `id_motorista` INT(11) NOT NULL,
  `nm_motorista` VARCHAR(30) NOT NULL,
  `nm_sobrenome` VARCHAR(60) NOT NULL,
  `nm_email` VARCHAR(80) NOT NULL,
  `nm_senha` VARCHAR(100) NOT NULL,
  `cd_ddd_celular` VARCHAR(2) NULL DEFAULT NULL,
  `cd_cpf` CHAR(11) NOT NULL,
  `img_motorista` VARCHAR(200) NULL DEFAULT NULL,
  `cd_cnh` CHAR(10) NOT NULL,
  `id_categoria_cnh` INT(11) NOT NULL,
  `dt_validade_cnh` DATE NOT NULL,
  `img_veiculo` BLOB NULL DEFAULT NULL,
  `ds_veiculo` VARCHAR(200) NULL DEFAULT NULL,
  `cd_avaliacao` DECIMAL(2,1) NULL DEFAULT NULL,
  `dt_nascimento` DATE NULL,
  PRIMARY KEY (`id_motorista`),
  INDEX `fk_motorista_categoria_cnh` (`id_categoria_cnh` ASC),
  CONSTRAINT `fk_motorista_categoria_cnh`
    FOREIGN KEY (`id_categoria_cnh`)
    REFERENCES `db_uber_entrega`.`tb_categoria_cnh` (`id_categoria_cnh`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_uber_entrega`.`tb_catergoria_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_uber_entrega`.`tb_catergoria_servico` (
  `id_categoria_servico` INT NOT NULL,
  `nm_categoria_servico` VARCHAR(60) NOT NULL,
  `ds_categoria_servico` VARCHAR(120) NULL,
  `vl_minimo_servico` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`id_categoria_servico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_uber_entrega`.`tb_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_uber_entrega`.`tb_servico` (
  `id_servico` INT(11) NOT NULL,
  `nm_servico` VARCHAR(60) NOT NULL,
  `ds_servico` VARCHAR(200) NOT NULL,
  `cd_cep_destinatario` INT(8) NOT NULL,
  `cd_cep_remetente` INT(8) NOT NULL,
  `cd_avaliacao` DECIMAL(2,1) NULL DEFAULT NULL,
  `is_realizado` TINYINT(4) NULL DEFAULT NULL,
  `id_categoria_servico` INT NOT NULL,
  `id_cliente` INT(11) NOT NULL,
  `vl_sugerido` DECIMAL(8,2) NULL,
  PRIMARY KEY (`id_servico`),
  INDEX `fk_servico_cliente` (`id_cliente` ASC),
  INDEX `fk_servico_categoria_servico_idx` (`id_categoria_servico` ASC),
  CONSTRAINT `fk_servico_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `db_uber_entrega`.`tb_cliente` (`id_cliente`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_servico_categoria_servico`
    FOREIGN KEY (`id_categoria_servico`)
    REFERENCES `db_uber_entrega`.`tb_catergoria_servico` (`id_categoria_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_uber_entrega`.`tb_proposta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_uber_entrega`.`tb_proposta` (
  `id_proposta` INT(11) NOT NULL,
  `vl_proposta` DECIMAL(10,2) NOT NULL,
  `cd_servico` INT(11) NOT NULL,
  `cd_motorista` INT(11) NOT NULL,
  PRIMARY KEY (`id_proposta`),
  INDEX `fk_proposta_servico` (`cd_servico` ASC),
  INDEX `fk_proposta_motorista` (`cd_motorista` ASC),
  CONSTRAINT `fk_proposta_motorista`
    FOREIGN KEY (`cd_motorista`)
    REFERENCES `db_uber_entrega`.`tb_motorista` (`id_motorista`),
  CONSTRAINT `fk_proposta_servico`
    FOREIGN KEY (`cd_servico`)
    REFERENCES `db_uber_entrega`.`tb_servico` (`id_servico`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_uber_entrega`.`tb_veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_uber_entrega`.`tb_veiculo` (
  `id_veiculo` INT NOT NULL,
  `nm_placa` CHAR(7) NOT NULL,
  `nm_chassi` VARCHAR(18) NOT NULL,
  `nm_cor` VARCHAR(50) NOT NULL,
  `cd_ano` CHAR(4) NULL,
  `nm_modelo` VARCHAR(50) NULL,
  PRIMARY KEY (`id_veiculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_uber_entrega`.`tb_veiculo_motorista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_uber_entrega`.`tb_veiculo_motorista` (
  `id_veiculo` INT NOT NULL,
  `id_motorista` INT NOT NULL,
  INDEX `fk_veiculo_motorista_motorista_idx` (`id_motorista` ASC),
  INDEX `fk_tb_veiculo_motorista_veiculo_idx` (`id_veiculo` ASC),
  CONSTRAINT `fk_veiculo_motorista_motorista`
    FOREIGN KEY (`id_motorista`)
    REFERENCES `db_uber_entrega`.`tb_motorista` (`id_motorista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_veiculo_motorista_veiculo`
    FOREIGN KEY (`id_veiculo`)
    REFERENCES `db_uber_entrega`.`tb_veiculo` (`id_veiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

