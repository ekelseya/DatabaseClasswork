-- empoyees.sql
-- Employees database
-- Author Eryn Kelsey-Adkins
-- Date 9/24/19

-- create database empoyees

CREATE DATABASE employees;

USE employees;

-- create table departments

CREATE TABLE Departments (
	code CHAR(2) PRIMARY KEY,
	`desc` VARCHAR (30) NOT NULL
	);

	
-- populate departments
INSERT INTO Departments VALUES ('HR', 'Human Resources');
INSERT INTO Departments VALUES ('IT', 'Information Technology');
INSERT INTO Departments VALUES ('SL', 'Sales');
	
-- create table employees

CREATE TABLE Employees (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR (45) NOT NULL,
	sal INTEGER NOT NULL,
	deptCode CHAR(2),
	FOREIGN KEY (deptCode) REFERENCES Departments (code)
	);

-- populate employees
INSERT INTO Employees (name, sal, deptCode) VALUES ('Sam Mai Tai', 50000, 'HR');
INSERT INTO Employees (name, sal, deptCode) VALUES ('James Brandy', 55000, 'HR');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Whiskey Strauss', 60000, 'HR');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Romeo Curacau', 65000, 'IT');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Jose Caipirinha', 65000, 'IT');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Tony Gin and Tonic', 80000, 'SL');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Debby Derby', 85000, 'SL');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Morbid Mojito', 150000, 'SL');

SELECT name, sal FROM Employees

SELECT * FROM Employees NATURAL JOIN Departments;

SET @high_salary := (SELECT sal FROM Employees WHERE sal > 100000);






