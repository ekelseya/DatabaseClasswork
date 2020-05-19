-- flowers.sql
-- Database Assignment 01
-- Author Eryn Kelsey-Adkins
-- Date 9/29/19

-- create database flowers
CREATE DATABASE flowers;

USE flowers;

-- create table Zones
CREATE TABLE Zones (
	id INTEGER PRIMARY KEY,
	lowerTemp INTEGER NOT NULL,
	higherTemp INTEGER NOT NULL
	);
	
-- populate Zones
INSERT INTO Zones VALUES (2, -50, -40);
INSERT INTO Zones VALUES (3, -40, -30);
INSERT INTO Zones VALUES (4, -30, -20);
INSERT INTO Zones VALUES (5, -20, -10);
INSERT INTO Zones VALUES (6, -10, 0);
INSERT INTO Zones VALUES (7, 0, 10);
INSERT INTO Zones VALUES (8, 10, 20);
INSERT INTO Zones VALUES (9, 20, 30);
INSERT INTO Zones VALUES (10, 30, 40);

-- create table Deliveries
CREATE TABLE Deliveries (
	id INTEGER PRIMARY KEY,
	categ VARCHAR(5) NOT NULL,
	delSize DECIMAL (5, 3)
	);

-- populate Deliveries
INSERT INTO Deliveries VALUES (1, 'pot', 1.500);
INSERT INTO Deliveries VALUES (2, 'pot', 2.250);
INSERT INTO Deliveries VALUES (3, 'pot', 2.625);
INSERT INTO Deliveries VALUES (4, 'pot', 4.250);
INSERT INTO Deliveries VALUES (5, 'plant', NULL);
INSERT INTO Deliveries VALUES (6, 'bulb', NULL);
INSERT INTO Deliveries VALUES (7, 'hedge', 18.000);
INSERT INTO Deliveries VALUES (8, 'shrub', 24.000);
INSERT INTO Deliveries VALUES (9, 'tree', 36.000);

-- create table FlowersInfo
CREATE TABLE FlowersInfo (
	id INTEGER PRIMARY KEY,
	comName VARCHAR (30),
	latName VARCHAR (35),
	cZone INTEGER,
	hZone INTEGER,
	deliver INTEGER,
	sunNeeds VARCHAR (5),
	FOREIGN KEY (cZone) REFERENCES Zones (id),
	FOREIGN KEY (hZone) REFERENCES Zones (id),
	FOREIGN KEY (deliver) REFERENCES Deliveries (id)
	);
	
-- populate FlowersInfo
INSERT INTO FlowersInfo VALUES 
	(101, 'Lady Fern', 'Atbyrium filix-femina', 2, 9, 5, 'SH');
INSERT INTO FlowersInfo VALUES 
	(102, 'Pink Caladiums', 'C.x bortulanum', 10, 10, 6, 'PtoSH');
INSERT INTO FlowersInfo VALUES 
	(103, 'Lily-of-the-Valley', 'Convallaria majalis', 2, 8, 5, 'PtoSH');
INSERT INTO FlowersInfo VALUES 
	(105, 'Purple Liatris', 'Liatris spicata', 3, 9, 6, 'StoP');
INSERT INTO FlowersInfo VALUES 
	(106, 'Black Eyed Susan', 'Rudbeckia fulgida var. specios', 4, 10, 2, 'StoP');
INSERT INTO FlowersInfo VALUES 
	(107, 'Nikko Blue Hydrangea', 'Hydrangea macrophylla', 5, 9, 4, 'StoSH');
INSERT INTO FlowersInfo VALUES 
	(108, 'Variegated Weigela', 'W. florida Variegata', 4, 9, 8, 'StoP');
INSERT INTO FlowersInfo VALUES 
	(110, 'Lombardy Poplar', 'Populus nigra Italica', 3, 9, 9, 'S');
INSERT INTO FlowersInfo VALUES 
	(111, 'Purple Leaf Plum Hedge', 'Prunus x cistena', 2, 8, 7, 'S');
INSERT INTO FlowersInfo VALUES 
	(114, 'Thorndale Ivy', 'Hedera belix Thorndale', 3, 9, 1, 'StoSH');

-- queries

-- a) the total number of zones
SELECT COUNT(*) FROM Zones;

-- b) the number of flowers per cool zone.
SELECT cZone, COUNT(*) as count FROM FlowersInfo 
	GROUP BY cZone ORDER BY count DESC;

-- c) common names of the plants that have delivery sizes less than 5
SELECT f.comName, d.delSize 
	FROM FlowersInfo f 
	INNER JOIN Deliveries d 
	ON f.deliver = d.id AND d.delSize < 5;

-- d) common names of the plants that require full sun (i.e., sun needs contains ‘S’)
SELECT a.comName, b.sunNeeds 
	FROM FlowersInfo a 
	NATURAL JOIN FlowersInfo b 
	WHERE b.sunNeeds LIKE 'S';

-- e) all delivery category names order alphabetically (without repetition)
SELECT DISTINCT categ 
	FROM Deliveries ORDER BY categ;

-- f) the exact output (note that it is order by Name)
SELECT f.comName AS 'Name',
	   z.lowerTemp AS 'Cool Zone (low)', 
	   z.higherTemp AS 'Cool Zone (high)',
	   d.categ AS 'Delivery'
	FROM FlowersInfo f 
	INNER JOIN Zones z
	ON f.cZone = z.id 
	INNER JOIN Deliveries d 
	ON f.deliver = d.id 
	ORDER BY f.comName;

-- g) plant names that have the same hot zone as “Pink Caladiums” 
--    (your solution MUST get the hot zone of “Pink Caladiums” in a variable)
SET @pcHot := (SELECT hZone FROM FlowersInfo 
			   WHERE comName LIKE 'Pink Caladiums');
SELECT comName FROM FlowersInfo 
	WHERE hZone LIKE @pcHot 
	AND comName NOT LIKE 'Pink Caladiums';

-- h) the total number of plants, the minimum delivery size, the maximum delivery size, 
--    and the average size based on the plants that have delivery sizes (note that the 
--    average value should be rounded using two decimals)
SET @pCount := (SELECT COUNT(*) FROM FlowersInfo);
SET @minSize := (SELECT MIN(delSize) FROM Deliveries);
SET @maxSize := (SELECT MAX(delSize) FROM Deliveries);
SET @avgSize := (SELECT AVG(a.delSize) 
						FROM (SELECT d.delSize 
						FROM FlowersInfo f 
						INNER JOIN Deliveries d 
						ON f.deliver = d.id) a);
SELECT @pCount AS 'Total', 
		@minSize AS 'Min', 
		@maxSize AS 'Max', 
		@avgSize AS 'Average';

-- i) the Latin name of the plant that has the word ‘Eyed’ in its name 
--    (you must use LIKE in this query to get full credit)
SELECT latName FROM FlowersInfo WHERE comName LIKE '%Eyed%';

-- j) the exact output (ordered by Category and then by Name)
SELECT d.categ AS 'Category',
	   f.comName AS 'Name' 
	FROM Deliveries d 
	INNER JOIN FlowersInfo f
	ON d.id = f.deliver   
	ORDER BY d.categ;