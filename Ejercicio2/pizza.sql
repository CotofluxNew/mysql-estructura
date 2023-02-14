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
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre_cliente` VARCHAR(45) NOT NULL,
  `apellido_cliente` VARCHAR(45) NOT NULL,
  `direccion_cliente` VARCHAR(45) NULL,
  `cp_cliente` INT NULL,
  `localidad_cliente` VARCHAR(45) NOT NULL,
  `provincia_cliente` VARCHAR(45) NOT NULL,
  `telefono_cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tienda` (
  `id_Tienda` INT NOT NULL AUTO_INCREMENT,
  `direccion_tienda` VARCHAR(45) NOT NULL,
  `Pedidos_id_Pedidos` INT NOT NULL,
  `Pedidos_Cliente_id_cliente` INT NOT NULL,
  `cp_tienda` INT NOT NULL,
  `localidad_tienda` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Tienda`, `Pedidos_id_Pedidos`, `Pedidos_Cliente_id_cliente`),
  INDEX `fk_Tienda_Pedidos1_idx` (`Pedidos_id_Pedidos` ASC, `Pedidos_Cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Tienda_Pedidos1`
    FOREIGN KEY (`Pedidos_id_Pedidos` , `Pedidos_Cliente_id_cliente`)
    REFERENCES `mydb`.`Pedidos` (`id_Pedidos` , `Cliente_id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleados` (
  `id_Empleados` INT NOT NULL AUTO_INCREMENT,
  `Tienda_id_Tienda` INT NOT NULL,
  `Tienda_Pedidos_id_Pedidos` INT NOT NULL,
  `Tienda_Pedidos_Cliente_id_cliente` INT NOT NULL,
  `nombre_empleado` VARCHAR(45) NOT NULL,
  `apellido1_empleado` VARCHAR(45) NOT NULL,
  `apellido2_empleado` VARCHAR(45) NOT NULL,
  `nif_empleado` INT NOT NULL,
  `telefono_empleado` INT NOT NULL,
  `repartidor` TINYINT NULL,
  `cocinero` TINYINT NULL,
  PRIMARY KEY (`id_Empleados`, `Tienda_id_Tienda`, `Tienda_Pedidos_id_Pedidos`, `Tienda_Pedidos_Cliente_id_cliente`),
  INDEX `fk_Empleados_Tienda1_idx` (`Tienda_id_Tienda` ASC, `Tienda_Pedidos_id_Pedidos` ASC, `Tienda_Pedidos_Cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Tienda1`
    FOREIGN KEY (`Tienda_id_Tienda` , `Tienda_Pedidos_id_Pedidos` , `Tienda_Pedidos_Cliente_id_cliente`)
    REFERENCES `mydb`.`Tienda` (`id_Tienda` , `Pedidos_id_Pedidos` , `Pedidos_Cliente_id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedidos` (
  `id_Pedidos` INT NOT NULL AUTO_INCREMENT,
  `fech_hora` VARCHAR(45) NOT NULL,
  `recoger_tienda` TINYINT NOT NULL,
  `recoger_domicilio` TINYINT NOT NULL,
  `precio` FLOAT NULL,
  `Cliente_id_cliente` INT NOT NULL,
  `Empleados_id_Empleados` INT NOT NULL,
  `Empleados_Tienda_id_Tienda` INT NOT NULL,
  `Empleados_Tienda_Pedidos_id_Pedidos` INT NOT NULL,
  `Empleados_Tienda_Pedidos_Cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_Pedidos`, `Cliente_id_cliente`, `Empleados_id_Empleados`, `Empleados_Tienda_id_Tienda`, `Empleados_Tienda_Pedidos_id_Pedidos`, `Empleados_Tienda_Pedidos_Cliente_id_cliente`),
  INDEX `fk_Pedidos_Cliente_idx` (`Cliente_id_cliente` ASC) VISIBLE,
  INDEX `fk_Pedidos_Empleados1_idx` (`Empleados_id_Empleados` ASC, `Empleados_Tienda_id_Tienda` ASC, `Empleados_Tienda_Pedidos_id_Pedidos` ASC, `Empleados_Tienda_Pedidos_Cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Cliente`
    FOREIGN KEY (`Cliente_id_cliente`)
    REFERENCES `mydb`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Empleados1`
    FOREIGN KEY (`Empleados_id_Empleados` , `Empleados_Tienda_id_Tienda` , `Empleados_Tienda_Pedidos_id_Pedidos` , `Empleados_Tienda_Pedidos_Cliente_id_cliente`)
    REFERENCES `mydb`.`Empleados` (`id_Empleados` , `Tienda_id_Tienda` , `Tienda_Pedidos_id_Pedidos` , `Tienda_Pedidos_Cliente_id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Productos` (
  `id_Productos` INT NOT NULL AUTO_INCREMENT,
  `nombre_producto` VARCHAR(45) NOT NULL,
  `imagen_producto` VARCHAR(45) NOT NULL,
  `descripcion_producto` VARCHAR(45) NOT NULL,
  `precio_producto` FLOAT NOT NULL,
  PRIMARY KEY (`id_Productos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pizza` (
  `id_Pizza` INT NOT NULL,
  `categoria_pizza` VARCHAR(45) NOT NULL,
  `Productos_id_Productos` INT NOT NULL,
  PRIMARY KEY (`id_Pizza`, `Productos_id_Productos`),
  INDEX `fk_Pizza_Productos1_idx` (`Productos_id_Productos` ASC) VISIBLE,
  CONSTRAINT `fk_Pizza_Productos1`
    FOREIGN KEY (`Productos_id_Productos`)
    REFERENCES `mydb`.`Productos` (`id_Productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Productos_has_Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Productos_has_Pedidos` (
  `Productos_id_Productos` INT NOT NULL,
  `Pedidos_id_Pedidos` INT NOT NULL,
  `Pedidos_Cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`Productos_id_Productos`, `Pedidos_id_Pedidos`, `Pedidos_Cliente_id_cliente`),
  INDEX `fk_Productos_has_Pedidos_Pedidos1_idx` (`Pedidos_id_Pedidos` ASC, `Pedidos_Cliente_id_cliente` ASC) VISIBLE,
  INDEX `fk_Productos_has_Pedidos_Productos1_idx` (`Productos_id_Productos` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_has_Pedidos_Productos1`
    FOREIGN KEY (`Productos_id_Productos`)
    REFERENCES `mydb`.`Productos` (`id_Productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_has_Pedidos_Pedidos1`
    FOREIGN KEY (`Pedidos_id_Pedidos` , `Pedidos_Cliente_id_cliente`)
    REFERENCES `mydb`.`Pedidos` (`id_Pedidos` , `Cliente_id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
