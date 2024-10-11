-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema teatropucp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema teatropucp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `teatropucp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `teatropucp` ;

-- -----------------------------------------------------
-- Table `teatropucp`.`obras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teatropucp`.`obras` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `duration` INT NOT NULL,
  `releaseDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `teatropucp`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teatropucp`.`rooms` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
-- Insertar Salas
INSERT INTO `rooms` (`id`, `name`, `capacity`) VALUES
(1, 'Sala Principal', 200),
(2, 'Sala Secundaria', 150),
(3, 'Sala Experimental', 100);


-- -----------------------------------------------------
-- Table `teatropucp`.`funciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teatropucp`.`funciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `obraId` INT NULL DEFAULT NULL,
  `roomId` INT NULL DEFAULT NULL,
  `funcionDate` DATETIME NOT NULL,
  `availableSeats` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `movieId` (`obraId` ASC) VISIBLE,
  INDEX `roomId` (`roomId` ASC) VISIBLE,
  CONSTRAINT `movieprojections_ibfk_1`
    FOREIGN KEY (`obraId`)
    REFERENCES `teatropucp`.`obras` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `movieprojections_ibfk_2`
    FOREIGN KEY (`roomId`)
    REFERENCES `teatropucp`.`rooms` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `teatropucp`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teatropucp`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `teatropucp`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teatropucp`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `roleId` INT NULL DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `roleId` (`roleId` ASC) VISIBLE,
  CONSTRAINT `users_ibfk_1`
    FOREIGN KEY (`roleId`)
    REFERENCES `teatropucp`.`roles` (`id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
INSERT INTO `users` (`id`, `email`, `password`, `enabled`, `role_id`) VALUES
(1, 'admin@teatro.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa.OJ8sI5qZh8FIqFtZNRQIdXwO', 1, 1), -- Contraseña: password
(2, 'gerente@teatro.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa.OJ8sI5qZh8FIqFtZNRQIdXwO', 1, 2), -- Contraseña: password
(3, 'cliente@teatro.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa.OJ8sI5qZh8FIqFtZNRQIdXwO', 1, 3); -- Contraseña: password


-- -----------------------------------------------------
-- Table `teatropucp`.`roomseats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teatropucp`.`roomseats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `roomId` INT NULL DEFAULT NULL,
  `seatNumber` VARCHAR(10) NOT NULL,
  `rowNumber` CHAR(2) NOT NULL,
  `isAvailable` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  INDEX `roomId` (`roomId` ASC) VISIBLE,
  CONSTRAINT `roomseats_ibfk_1`
    FOREIGN KEY (`roomId`)
    REFERENCES `teatropucp`.`rooms` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `teatropucp`.`reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teatropucp`.`reservations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userId` INT NULL DEFAULT NULL,
  `funcionId` INT NULL DEFAULT NULL,
  `roomSeatId` INT NULL DEFAULT NULL,
  `startDatetime` DATETIME NOT NULL,
  `endDatetime` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `userId` (`userId` ASC) VISIBLE,
  INDEX `movieProjectionId` (`funcionId` ASC) VISIBLE,
  INDEX `roomSeatId` (`roomSeatId` ASC) VISIBLE,
  CONSTRAINT `reservations_ibfk_1`
    FOREIGN KEY (`userId`)
    REFERENCES `teatropucp`.`users` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `reservations_ibfk_2`
    FOREIGN KEY (`funcionId`)
    REFERENCES `teatropucp`.`funciones` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `reservations_ibfk_3`
    FOREIGN KEY (`roomSeatId`)
    REFERENCES `teatropucp`.`roomseats` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into teatropucp.roles(name) values("ADMIN"),
("GERENTE"),("CLIENTE");
-- Insertar Obras
INSERT INTO `obras` (`id`, `titulo`, `descripcion`, `room_id`) VALUES
(1, 'Romeo y Julieta', 'Una de las tragedias más famosas de Shakespeare', 1),
(2, 'Hamlet', 'Otra gran obra de Shakespeare sobre venganza y traición', 2),
(3, 'Macbeth', 'La trágica historia de la ambición desmedida', 3);

-- Insertar Funciones
INSERT INTO `funciones` (`id`, `obra_id`, `fechaHora`) VALUES
(1, 1, '2024-10-12 19:00:00'), -- Función para "Romeo y Julieta"
(2, 2, '2024-10-13 19:00:00'), -- Función para "Hamlet"
(3, 3, '2024-10-14 20:00:00'); -- Función para "Macbeth"

-- Insertar Reservas
INSERT INTO `reservations` (`id`, `user_id`, `funcion_id`) VALUES
(1, 3, 1), -- Cliente reservando para "Romeo y Julieta"
(2, 3, 2); -- Cliente reservando para "Hamlet"
