-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Delivery` (
  `DeliveryID` INT NOT NULL,
  `DeliveryDate` DATE NULL,
  `DeliveryCost` DECIMAL NULL,
  `DeliveryStatus` VARCHAR(45) NULL,
  PRIMARY KEY (`DeliveryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemID` INT NOT NULL,
  `CourseName` VARCHAR(255) NULL,
  `StarterName` VARCHAR(255) NULL,
  `DesertName` VARCHAR(255) NULL,
  `Drinks` VARCHAR(45) NULL,
  `Slides` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `MenuID` INT NOT NULL,
  `MenuName` VARCHAR(45) NULL,
  `Cuisine` VARCHAR(45) NULL,
  `MenuItemID` INT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `fk_MenuItemID_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `fk_MenuItemID`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Countries` (
  `CountryCode` CHAR(2) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CountryCode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Addresses` (
  `AddressID` INT NOT NULL,
  `City` VARCHAR(45) NULL,
  `PostalCode` VARCHAR(45) NULL,
  `CountryCode` CHAR(2) NULL,
  PRIMARY KEY (`AddressID`),
  INDEX `fk_CountryCode_idx` (`CountryCode` ASC) VISIBLE,
  CONSTRAINT `fk_CountryCode`
    FOREIGN KEY (`CountryCode`)
    REFERENCES `LittleLemonDB`.`Countries` (`CountryCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(255) NOT NULL,
  `ContactNumber` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `AddressID` INT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_AddressID_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `fk_AddressID`
    FOREIGN KEY (`AddressID`)
    REFERENCES `LittleLemonDB`.`Addresses` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  `TotalCost` DECIMAL NULL,
  `Quantity` INT NOT NULL,
  `Discount` DECIMAL NULL,
  `DeliveryID` INT NULL,
  `MenuID` INT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  UNIQUE INDEX `OrderID_UNIQUE` (`OrderID` ASC) VISIBLE,
  INDEX `fk_DeliveryID_idx` (`DeliveryID` ASC) VISIBLE,
  INDEX `fk_MenuID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `fk_customerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_DeliveryID`
    FOREIGN KEY (`DeliveryID`)
    REFERENCES `LittleLemonDB`.`Delivery` (`DeliveryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menus` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeID` INT NOT NULL,
  `ExployeeName` VARCHAR(255) NULL,
  `Role` VARCHAR(45) NULL,
  `AnnualSalary` VARCHAR(45) NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`EmployeeID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL,
  `BookingSlot` DATE NOT NULL,
  `CustomerID` INT NOT NULL,
  `TableNumber` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_CustomerIDIdx`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
