-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clientes` (
  `nme_cliente` VARCHAR(45) NOT NULL,
  `tel` INT(11) NOT NULL,
  `end` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nme_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedidos` (
  `num_pedido` INT NOT NULL,
  `dt_cria` DATETIME NOT NULL,
  `status` VARCHAR(10) NOT NULL,
  `pgto` TINYINT NOT NULL,
  `id_cli` INT NOT NULL,
  `clientes_nme_cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`num_pedido`, `clientes_nme_cliente`),
  INDEX `fk_pedidos_clientes_idx` (`clientes_nme_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_clientes`
    FOREIGN KEY (`clientes_nme_cliente`)
    REFERENCES `mydb`.`clientes` (`nme_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`item_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item_pedido` (
  `id_pedido` INT NOT NULL,
  `qtd_prod` INT NOT NULL,
  `preco` FLOAT NOT NULL,
  `pedidos_num_pedido` INT NOT NULL,
  `pedidos_clientes_nme_cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pedido`, `pedidos_num_pedido`, `pedidos_clientes_nme_cliente`),
  INDEX `fk_item_pedido_pedidos1_idx` (`pedidos_num_pedido` ASC, `pedidos_clientes_nme_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_item_pedido_pedidos1`
    FOREIGN KEY (`pedidos_num_pedido` , `pedidos_clientes_nme_cliente`)
    REFERENCES `mydb`.`pedidos` (`num_pedido` , `clientes_nme_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produtos` (
  `idprodutos` INT NOT NULL,
  `desc` VARCHAR(45) NOT NULL,
  `preco` VARCHAR(45) NOT NULL,
  `categ` VARCHAR(5) NOT NULL,
  `estoque` INT NOT NULL,
  `item_pedido_id_pedido` INT NOT NULL,
  `item_pedido_pedidos_num_pedido` INT NOT NULL,
  `item_pedido_pedidos_clientes_nme_cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprodutos`, `item_pedido_id_pedido`, `item_pedido_pedidos_num_pedido`, `item_pedido_pedidos_clientes_nme_cliente`),
  INDEX `fk_produtos_item_pedido1_idx` (`item_pedido_id_pedido` ASC, `item_pedido_pedidos_num_pedido` ASC, `item_pedido_pedidos_clientes_nme_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_produtos_item_pedido1`
    FOREIGN KEY (`item_pedido_id_pedido` , `item_pedido_pedidos_num_pedido` , `item_pedido_pedidos_clientes_nme_cliente`)
    REFERENCES `mydb`.`item_pedido` (`id_pedido` , `pedidos_num_pedido` , `pedidos_clientes_nme_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`fornecedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fornecedores` (
  `id_forn` INT NOT NULL,
  `tel` INT(11) NOT NULL,
  `ing_forn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_forn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`confeiteiros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`confeiteiros` (
  `nme_confeiteiros` VARCHAR(20) NOT NULL,
  `spc` VARCHAR(20) NOT NULL,
  `tn_tra` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`nme_confeiteiros`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ingredientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ingredientes` (
  `id_ing` INT NOT NULL,
  `nme_ing` VARCHAR(20) NOT NULL,
  `qtd_est` INT NOT NULL,
  `fornecedores_id_forn` INT NOT NULL,
  PRIMARY KEY (`id_ing`, `fornecedores_id_forn`),
  INDEX `fk_ingredientes_fornecedores1_idx` (`fornecedores_id_forn` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_fornecedores1`
    FOREIGN KEY (`fornecedores_id_forn`)
    REFERENCES `mydb`.`fornecedores` (`id_forn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`confeiteiros_has_produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`confeiteiros_has_produtos` (
  `confeiteiros_nme_confeiteiros` VARCHAR(20) NOT NULL,
  `produtos_idprodutos` INT NOT NULL,
  PRIMARY KEY (`confeiteiros_nme_confeiteiros`, `produtos_idprodutos`),
  INDEX `fk_confeiteiros_has_produtos_produtos1_idx` (`produtos_idprodutos` ASC) VISIBLE,
  INDEX `fk_confeiteiros_has_produtos_confeiteiros1_idx` (`confeiteiros_nme_confeiteiros` ASC) VISIBLE,
  CONSTRAINT `fk_confeiteiros_has_produtos_confeiteiros1`
    FOREIGN KEY (`confeiteiros_nme_confeiteiros`)
    REFERENCES `mydb`.`confeiteiros` (`nme_confeiteiros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_confeiteiros_has_produtos_produtos1`
    FOREIGN KEY (`produtos_idprodutos`)
    REFERENCES `mydb`.`produtos` (`idprodutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedidos_has_confeiteiros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedidos_has_confeiteiros` (
  `pedidos_num_pedido` INT NOT NULL,
  `pedidos_clientes_nme_cliente` VARCHAR(45) NOT NULL,
  `confeiteiros_nme_confeiteiros` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`pedidos_num_pedido`, `pedidos_clientes_nme_cliente`, `confeiteiros_nme_confeiteiros`),
  INDEX `fk_pedidos_has_confeiteiros_confeiteiros1_idx` (`confeiteiros_nme_confeiteiros` ASC) VISIBLE,
  INDEX `fk_pedidos_has_confeiteiros_pedidos1_idx` (`pedidos_num_pedido` ASC, `pedidos_clientes_nme_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_has_confeiteiros_pedidos1`
    FOREIGN KEY (`pedidos_num_pedido` , `pedidos_clientes_nme_cliente`)
    REFERENCES `mydb`.`pedidos` (`num_pedido` , `clientes_nme_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_has_confeiteiros_confeiteiros1`
    FOREIGN KEY (`confeiteiros_nme_confeiteiros`)
    REFERENCES `mydb`.`confeiteiros` (`nme_confeiteiros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ingredientes_has_produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ingredientes_has_produtos` (
  `ingredientes_id_ing` INT NOT NULL,
  `produtos_idprodutos` INT NOT NULL,
  `produtos_item_pedido_id_pedido` INT NOT NULL,
  `produtos_item_pedido_pedidos_num_pedido` INT NOT NULL,
  `produtos_item_pedido_pedidos_clientes_nme_cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ingredientes_id_ing`, `produtos_idprodutos`, `produtos_item_pedido_id_pedido`, `produtos_item_pedido_pedidos_num_pedido`, `produtos_item_pedido_pedidos_clientes_nme_cliente`),
  INDEX `fk_ingredientes_has_produtos_produtos1_idx` (`produtos_idprodutos` ASC, `produtos_item_pedido_id_pedido` ASC, `produtos_item_pedido_pedidos_num_pedido` ASC, `produtos_item_pedido_pedidos_clientes_nme_cliente` ASC) VISIBLE,
  INDEX `fk_ingredientes_has_produtos_ingredientes1_idx` (`ingredientes_id_ing` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_has_produtos_ingredientes1`
    FOREIGN KEY (`ingredientes_id_ing`)
    REFERENCES `mydb`.`ingredientes` (`id_ing`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_has_produtos_produtos1`
    FOREIGN KEY (`produtos_idprodutos` , `produtos_item_pedido_id_pedido` , `produtos_item_pedido_pedidos_num_pedido` , `produtos_item_pedido_pedidos_clientes_nme_cliente`)
    REFERENCES `mydb`.`produtos` (`idprodutos` , `item_pedido_id_pedido` , `item_pedido_pedidos_num_pedido` , `item_pedido_pedidos_clientes_nme_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
