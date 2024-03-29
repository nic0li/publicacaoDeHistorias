CREATE SCHEMA IF NOT EXISTS `db_projeto` DEFAULT CHARACTER SET utf8 ;
USE `db_projeto` ;

-- -----------------------------------------------------
-- Table `usuarios`
-- -----------------------------------------------------
CREATE TABLE `usuarios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nomeUsuario` VARCHAR(50) UNIQUE NOT NULL,
  `email` VARCHAR(200) UNIQUE NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  `nome` VARCHAR(200),
  `avatar` VARCHAR(200),
  `descricao` TEXT,
  `dataNascimento` DATE,
  `genero` VARCHAR(1),
  `localizacao` VARCHAR(100),
  `emailSecundario` VARCHAR(200) UNIQUE,
  `celular` BIGINT UNIQUE,
  `createdAt` DATETIME,
  `updatedAt` DATETIME
);

-- -----------------------------------------------------
-- Table `classificacoes`
-- -----------------------------------------------------
CREATE TABLE `classificacoes` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nome` VARCHAR(100) UNIQUE NOT NULL,
  `createdAt` DATETIME,
  `updatedAt` DATETIME
);

-- -----------------------------------------------------
-- Table `historias`
-- -----------------------------------------------------
CREATE TABLE `historias` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fkClassificacao` INT NOT NULL,
  `diretorio` VARCHAR(200),
  `titulo` VARCHAR(200),
  `capa` VARCHAR(200),
  `sinopse` TEXT,
  `finalizada` TINYINT,
  `interativa` TINYINT,
  `visivel` TINYINT,
  `createdAt` DATETIME,
  `updatedAt` DATETIME,
    FOREIGN KEY (`fkClassificacao`)
    REFERENCES `classificacoes` (`id`)
);

-- -----------------------------------------------------
-- Table `capitulos`
-- -----------------------------------------------------
CREATE TABLE `capitulos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fkHistoria` INT NOT NULL,
  `titulo` VARCHAR(200),
  `texto` VARCHAR(200),
  `notasIniciais` TEXT,
  `notasFinais` TEXT,
  `visivel` TINYINT,
  `createdAt` DATETIME,
  `updatedAt` DATETIME,
    FOREIGN KEY (`fkHistoria`)
    REFERENCES `historias` (`id`)
);

-- -----------------------------------------------------
-- Table `generos`
-- -----------------------------------------------------
CREATE TABLE `generos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nome` VARCHAR(100) UNIQUE NOT NULL,
  `descricao` VARCHAR(250),
  `createdAt` DATETIME,
  `updatedAt` DATETIME
);

-- -----------------------------------------------------
-- Table `categorias`
-- -----------------------------------------------------
CREATE TABLE `categorias` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nome` VARCHAR(100) UNIQUE NOT NULL,
  `descricao` VARCHAR(250),
  `createdAt` DATETIME,
  `updatedAt` DATETIME
);

-- -----------------------------------------------------
-- Table `generosHistorias`
-- -----------------------------------------------------
CREATE TABLE `generosHistorias` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fkHistoria` INT NOT NULL,
  `fkGenero` INT NOT NULL,
  `principal` TINYINT,
  `createdAt` DATETIME,
  `updatedAt` DATETIME,
    FOREIGN KEY (`fkHistoria`)
    REFERENCES `historias` (`id`),
    FOREIGN KEY (`fkGenero`)
    REFERENCES `generos` (`id`)
);

-- -----------------------------------------------------
-- Table `categoriasHistorias`
-- -----------------------------------------------------
CREATE TABLE `categoriasHistorias` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fkHistoria` INT NOT NULL,
  `fkCategoria` INT NOT NULL,
  `principal` TINYINT,
  `createdAt` DATETIME,
  `updatedAt` DATETIME,
    FOREIGN KEY (`fkHistoria`)
    REFERENCES `historias` (`id`),
    FOREIGN KEY (`fkCategoria`)
    REFERENCES `categorias` (`id`)
);

-- -----------------------------------------------------
-- Table `autores`
-- -----------------------------------------------------
CREATE TABLE `autores` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fkHistoria` INT NOT NULL,
  `fkUsuario` INT NOT NULL,
  `principal` TINYINT,
  `createdAt` DATETIME,
  `updatedAt` DATETIME,
    FOREIGN KEY (`fkHistoria`)
    REFERENCES `historias` (`id`),
    FOREIGN KEY (`fkUsuario`)
    REFERENCES `usuarios` (`id`)
);

-- -----------------------------------------------------
-- Table `permissoes`
-- -----------------------------------------------------
CREATE TABLE `permissoes` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nome` VARCHAR(100) UNIQUE NOT NULL,
  `createdAt` DATETIME,
  `updatedAt` DATETIME
);

-- -----------------------------------------------------
-- Table `permissoesUsuarios`
-- -----------------------------------------------------
CREATE TABLE `permissoesUsuarios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fkUsuario` INT NOT NULL,
  `fkPermissao` INT NOT NULL,
  `createdAt` DATETIME,
  `updatedAt` DATETIME,
    FOREIGN KEY (`fkUsuario`)
    REFERENCES `usuarios` (`id`),
    FOREIGN KEY (`fkPermissao`)
    REFERENCES `permissoes` (`id`)
);
-- -----------------------------------------------------
-- Table `newsletters`
-- -----------------------------------------------------
CREATE TABLE `newsletters` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `email` VARCHAR(200) NOT NULL,
  `nome` VARCHAR(200),
  `createdAt` DATETIME,
  `updatedAt` DATETIME
);
