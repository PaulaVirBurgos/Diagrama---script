-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Playground
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Playground
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Playground` DEFAULT CHARACTER SET utf8 ;
USE `Playground` ;

-- -----------------------------------------------------
-- Table `Playground`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `categoryId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_usuarios_categorias_idx` (`categoryId` ASC) VISIBLE,
  CONSTRAINT `FK_usuarios_categorias`
    FOREIGN KEY (`categoryId`)
    REFERENCES `Playground`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`cursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `img` VARCHAR(45) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_finalizacion` DATE NOT NULL,
  `cupo` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`inscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`inscripciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuarioId` INT NOT NULL,
  `cursoId` INT NULL,
  PRIMARY KEY (`id`, `usuarioId`),
  INDEX `FK_inscripciones_usuarios_idx` (`usuarioId` ASC) VISIBLE,
  INDEX `FK_inscripciones_cursos_idx` (`cursoId` ASC) VISIBLE,
  CONSTRAINT `FK_inscripciones_usuarios`
    FOREIGN KEY (`usuarioId`)
    REFERENCES `Playground`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_inscripciones_cursos`
    FOREIGN KEY (`cursoId`)
    REFERENCES `Playground`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`tipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`tipos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`unidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`unidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `cursosId` INT NULL,
  PRIMARY KEY (`id`, `titulo`),
  INDEX `cursosId_idx` (`cursosId` ASC) VISIBLE,
  CONSTRAINT `FK_unidades_cursos`
    FOREIGN KEY (`cursosId`)
    REFERENCES `Playground`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`clases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`clases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `visibilidad` TINYINT(5) NOT NULL,
  `unidadId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_clases_unidades_idx` (`unidadId` ASC) VISIBLE,
  CONSTRAINT `FK_clases_unidades`
    FOREIGN KEY (`unidadId`)
    REFERENCES `Playground`.`unidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`bloques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`bloques` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NULL,
  `visibilidad` TINYINT NULL,
  `tipoId` INT NOT NULL,
  `claseId` INT NULL,
  PRIMARY KEY (`id`, `tipoId`),
  INDEX `FK_bloques_tipo_idx` (`tipoId` ASC) VISIBLE,
  INDEX `FK_bloques_clases_idx` (`claseId` ASC) VISIBLE,
  CONSTRAINT `FK_bloques_tipo`
    FOREIGN KEY (`tipoId`)
    REFERENCES `Playground`.`tipos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_bloques_clases`
    FOREIGN KEY (`claseId`)
    REFERENCES `Playground`.`clases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`categoria` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`articuloStock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`articuloStock` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `precio` INT NULL,
  `descripcion` TEXT NULL,
  `stock` INT NULL,
  `tipodeuso` TINYINT NULL,
  `categoriaId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_articulo_categoria_idx` (`categoriaId` ASC) VISIBLE,
  CONSTRAINT `FK_articulo_categoria`
    FOREIGN KEY (`categoriaId`)
    REFERENCES `Playground`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`valijas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`valijas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  `descripcion` TEXT NOT NULL,
  `tipodeuso` VARCHAR(45) NOT NULL,
  `stock` INT NOT NULL,
  `categoriaId` INT NULL,
  `articuloId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_valijas_categoria_idx` (`categoriaId` ASC) VISIBLE,
  INDEX `FK_valijas_articulos_idx` (`articuloId` ASC) VISIBLE,
  CONSTRAINT `FK_valijas_categoria`
    FOREIGN KEY (`categoriaId`)
    REFERENCES `Playground`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_valijas_articulos`
    FOREIGN KEY (`articuloId`)
    REFERENCES `Playground`.`articuloStock` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`articulosjardin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`articulosjardin` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `precio` INT NOT NULL,
  `stock` INT NOT NULL,
  `tipodeuso` VARCHAR(45) NOT NULL,
  `categoriaId` INT NULL,
  `articuloId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_artjardin_categoria_idx` (`categoriaId` ASC) VISIBLE,
  INDEX `FK_artjardin_articulo_idx` (`articuloId` ASC) VISIBLE,
  CONSTRAINT `FK_artjardin_categoria`
    FOREIGN KEY (`categoriaId`)
    REFERENCES `Playground`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_artjardin_articulo`
    FOREIGN KEY (`articuloId`)
    REFERENCES `Playground`.`articuloStock` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`juguetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`juguetes` (
  `idjuguetes` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  `descripcion` TEXT NOT NULL,
  `stock` INT NOT NULL,
  `tipodeuso` VARCHAR(45) NOT NULL,
  `categoriaId` INT NULL,
  `articuloId` INT NULL,
  PRIMARY KEY (`idjuguetes`),
  INDEX `FK_juguetes_categoria_idx` (`categoriaId` ASC) VISIBLE,
  INDEX `FK_juguete_articulo_idx` (`articuloId` ASC) VISIBLE,
  CONSTRAINT `FK_juguetes_categoria`
    FOREIGN KEY (`categoriaId`)
    REFERENCES `Playground`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_juguete_articulo`
    FOREIGN KEY (`articuloId`)
    REFERENCES `Playground`.`articuloStock` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`rol` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `rolcol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`empleados` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` INT NOT NULL,
  `sueldo` INT NOT NULL,
  `rolId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_empleado_rol_idx` (`rolId` ASC) VISIBLE,
  CONSTRAINT `FK_empleado_rol`
    FOREIGN KEY (`rolId`)
    REFERENCES `Playground`.`rol` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Playground`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playground`.`ventas` (
  `id` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `mediodepago` INT NOT NULL,
  `total` INT NOT NULL,
  `articuloId` INT NULL,
  `empleadoId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_ventas_articulo_idx` (`articuloId` ASC) VISIBLE,
  INDEX `FK_ventas_empleado_idx` (`empleadoId` ASC) VISIBLE,
  CONSTRAINT `FK_ventas_articulo`
    FOREIGN KEY (`articuloId`)
    REFERENCES `Playground`.`articuloStock` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ventas_empleado`
    FOREIGN KEY (`empleadoId`)
    REFERENCES `Playground`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
