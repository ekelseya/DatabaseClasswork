-- ipps.sql
-- Database Assignment 02
-- Author Eryn Kelsey-Adkins
-- Date 10/27/19

-- create database ipps
CREATE DATABASE ipps;

USE ipps;

-- create table DiagnosisGroups
CREATE TABLE DiagnosisGroups (
	code INTEGER PRIMARY KEY,
	description VARCHAR(70)
	);
	
-- create table ReferralRegions
CREATE TABLE ReferralRegions (
	id INTEGER PRIMARY KEY,
	state VARCHAR(2),
	city VARCHAR(30)
	);
	
-- create table Providers
CREATE TABLE Providers (
	id INTEGER PRIMARY KEY,
	name VARCHAR(70),
	address VARCHAR(70),
	city VARCHAR(30),
	state VARCHAR(2),
	zip VARCHAR(5),
	regionId INTEGER,
	FOREIGN KEY (regionId) REFERENCES ReferralRegions (id)
	);
	
-- create table Charges
CREATE TABLE Charges (
	id INTEGER PRIMARY KEY,
	totalDischarges INTEGER,
	averageCoveredCharges DECIMAL(9, 2),
	averageTotalPayments DECIMAL(9, 2), 
	averageMedicarePayments DECIMAL(9, 2),
	diagnosisCode INTEGER,
	FOREIGN KEY (diagnosisCode) REFERENCES DiagnosisGroups (code),
	providerId INTEGER,
	FOREIGN KEY (providerId) REFERENCES Providers (id)
);

-- create user ipps
CREATE USER 'ipps' IDENTIFIED BY '024680';

-- grant admin access to user ipps 
GRANT ALL PRIVILEGES ON ipps TO 'ipps';
