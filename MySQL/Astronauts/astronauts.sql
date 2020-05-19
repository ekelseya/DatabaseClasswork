-- astronauts database
-- created at: 9/16/19
-- author: Eryn Kelsey-Adkins

CREATE DATABASE astronauts;

USE astronauts;

CREATE TABLE Astronauts (
	id INTEGER PRIMARY KEY AUTO_INCREMENT, 
	lastName VARCHAR (30), 
	firstName VARCHAR (30), 
	suffix VARCHAR (4), 
	gender CHAR (1) DEFAULT '?', 
	birth DATE, 
	city VARCHAR (30), 
	state VARCHAR (2) DEFAULT NULL, 
	country VARCHAR (30), 
	status VARCHAR (7), 
	daysInSpace INTEGER,
	flights INTEGER
	);
	
LOAD DATA INFILE
'absolute_path/astronauts.csv'
INTO TABLE Astronauts
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
IGNORE 1 ROWS;

-- TODO: run queries