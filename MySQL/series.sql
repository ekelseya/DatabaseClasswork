--
-- CS 3810 - Principles of Database Systems - Fall 2019
-- SQL Competition: The "series" database
-- Date:
-- Team:
--

-- database creation
-- DROP DATABASE series;
CREATE DATABASE series;
USE series;

-- table Actors
CREATE TABLE Actors (
    actorId   INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    actorName VARCHAR(30) NOT NULL,
    sex       CHAR(1)     NOT NULL
);

INSERT INTO Actors (actorName, sex) VALUES ('Keri Russell',        'F');
INSERT INTO Actors (actorName, sex) VALUES ('Matthew Rhys',        'M');
INSERT INTO Actors (actorName, sex) VALUES ('Andrew Lincoln',      'M');
INSERT INTO Actors (actorName, sex) VALUES ('Jon Bernthal',        'M');
INSERT INTO Actors (actorName, sex) VALUES ('Sarah Wayne Callies', 'F');
INSERT INTO Actors (actorName, sex) VALUES ('Scott Speedman',      'M');
INSERT INTO Actors (actorName, sex) VALUES ('Amy Jo Johnson',      'F');
INSERT INTO Actors (actorName, sex) VALUES ('Tangi Miller',        'F');
INSERT INTO Actors (actorName, sex) VALUES ('Jennifer Aniston',    'F');

-- table Series
CREATE TABLE Series (
    seriesId INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title    VARCHAR(30) NOT NULL
);

INSERT INTO Series (title) VALUES ('The Americans');
INSERT INTO Series (title) VALUES ('The Walking Dead');
INSERT INTO Series (title) VALUES ('Felicity');
INSERT INTO Series (title) VALUES ('Breaking Bad');

-- table Acts
CREATE TABLE Acts (
    seriesId INT NOT NULL,
    actorId  INT NOT NULL,
    PRIMARY KEY (seriesId, actorId),
    FOREIGN KEY (seriesId) REFERENCES Series (seriesId),
    FOREIGN KEY (actorId)  REFERENCES Actors (actorId)
);

-- "The Americans" cast
INSERT INTO Acts VALUES (1, 1);
INSERT INTO Acts VALUES (1, 2);
-- "The Walking Dead" cast
INSERT INTO Acts VALUES (2, 3);
INSERT INTO Acts VALUES (2, 4);
INSERT INTO Acts VALUES (2, 5);
-- "Felicity" cast
INSERT INTO Acts VALUES (3, 1);
INSERT INTO Acts VALUES (3, 6);
INSERT INTO Acts VALUES (3, 7);
INSERT INTO Acts VALUES (3, 8);

-- table Seasons
CREATE TABLE Seasons (
    seriesId INT         NOT NULL,
    number   INT         NOT NULL,
    season   VARCHAR(10) NOT NULL,
    year     INT         NOT NULL,
    episodes INT         NOT NULL,
    FOREIGN KEY (seriesId) REFERENCES Series (seriesId),
    PRIMARY KEY (seriesId, number, season, year)
);

-- "The Americans" seasons
INSERT INTO Seasons VALUES (1, 1, 'spring', 2013, 13);
INSERT INTO Seasons VALUES (1, 2, 'spring', 2014, 13);
INSERT INTO Seasons VALUES (1, 3, 'spring', 2015, 13);
INSERT INTO Seasons VALUES (1, 4, 'spring', 2016, 13);
INSERT INTO Seasons VALUES (1, 5, 'spring', 2017, 13);
INSERT INTO Seasons VALUES (1, 6, 'spring', 2018, 10);
-- "The Walking Dead" seasons
INSERT INTO Seasons VALUES (2, 1, 'fall',   2010, 6);
INSERT INTO Seasons VALUES (2, 2, 'fall',   2011, 13);
INSERT INTO Seasons VALUES (2, 3, 'fall',   2012, 16);
INSERT INTO Seasons VALUES (2, 4, 'fall',   2013, 16);
INSERT INTO Seasons VALUES (2, 5, 'fall',   2014, 16);
INSERT INTO Seasons VALUES (2, 6, 'fall',   2015, 16);
INSERT INTO Seasons VALUES (2, 7, 'fall',   2016, 16);
INSERT INTO Seasons VALUES (2, 8, 'fall',   2017, 16);
INSERT INTO Seasons VALUES (2, 9, 'fall',   2018, 16);
-- "Felicity" seasons
INSERT INTO Seasons VALUES (3, 1, 'fall',   1998, 22);
INSERT INTO Seasons VALUES (3, 2, 'fall',   1999, 23);
INSERT INTO Seasons VALUES (3, 3, 'fall',   2000, 17);
INSERT INTO Seasons VALUES (3, 4, 'fall',   2011, 22);
-- "Breaking Bad" seasons
INSERT INTO Seasons VALUES (4, 1, 'spring', 2008, 7);
INSERT INTO Seasons VALUES (4, 2, 'spring', 2009, 13);
INSERT INTO Seasons VALUES (4, 3, 'spring', 2010, 13);
INSERT INTO Seasons VALUES (4, 4, 'fall',   2011, 13);
INSERT INTO Seasons VALUES (4, 5, 'fall',   2012, 8);
INSERT INTO Seasons VALUES (4, 5, 'fall',   2013, 8);

-- table Users
CREATE TABLE Users (
    userId   INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userName VARCHAR(30) NOT NULL
);

INSERT INTO Users (userName) VALUES ('Joe');
INSERT INTO Users (userName) VALUES ('Mary');

-- table Watches
CREATE TABLE Watches (
    userId   INT         NOT NULL,
    seriesId INT         NOT NULL,
    number   INT         NOT NULL,
    season   VARCHAR(10) NOT NULL,
    year     INT         NOT NULL,
    rnk      INT         NOT NULL,
    FOREIGN KEY (userId) REFERENCES Users (userId),
    FOREIGN KEY (seriesId, number, season, year) REFERENCES Seasons (seriesId, number, season, year),
    PRIMARY KEY (userId, seriesId, number, season, year)
);

-- Joe gave a 5 to "The Americans" season 1 spring 2013
INSERT INTO Watches VALUES (1, 1, 1, 'spring', 2013, 5);
-- Joe gave a 4 to "The Americans" season 2 spring 2014
INSERT INTO Watches VALUES (1, 1, 2, 'spring', 2014, 4);
-- Joe gave a 3 to "The Americans" season 3 spring 2015
INSERT INTO Watches VALUES (1, 1, 3, 'spring', 2015, 3);
-- Joe gave a 1 to "The Walking Dead" season 1 fall 2010
INSERT INTO Watches VALUES (1, 2, 1, 'fall', 2010, 1);
-- Joe gave a 3 to "Breaking Bad" to both seasons 5 fall 2012 and 2013
INSERT INTO Watches VALUES (1, 4, 5, 'fall', 2012, 3);
INSERT INTO Watches VALUES (1, 4, 5, 'fall', 2013, 3);
-- Mary gave a 1 to "The Americans" season 1 spring 2013
INSERT INTO Watches VALUES (2, 1, 1, 'spring', 2013, 1);
-- Mary gave a 2 to "The Americans" season 2 spring 2014
INSERT INTO Watches VALUES (2, 1, 2, 'spring', 2014, 2);
-- Mary gave a 5 to "The Walking Dead" season 1 fall 2010
INSERT INTO Watches VALUES (2, 2, 1, 'fall', 2010, 5);

-- query 01) return all actors/actresses sorted by actorId

-- query 02) return all actresses sorted by actorName
SELECT actorName FROM actors WHERE sex = 'F';

-- query 03) return the counts of actors and actress using two columns: 'sex' and 'total', sorted by sex

-- query 04) return the names of the actors/actresses that were in 'The Americans' sorted by actorName

-- query 05) return the names of actors/actresses that didn't 
-- appear in any series sorted by actorName
SELECT a.actorName FROM actors a WHERE a.actorId NOT IN 
	(SELECT b.actorId FROM acts b) ORDER BY a.actorName;

-- query 06) return the titles of series that didn't have any actors/actresses in their cast sorted by title

-- query 07) the titles of all series followed by the 'total number of seasons that they had (referred to as 'seasons') sorted by title

-- query 08) return the title of the series that had at least 
-- one season with less than 10 episodes sorted by title
SELECT a.title FROM series a INNER JOIN seasons b 
	ON a. seriesId = b.seriesId WHERE b.episodes < 10 
	ORDER BY a.title;

-- query 09) return the title of all series watched by user 'Joe' sorted by title

-- query 10) return the title of all series that had 'Keri Russell' sorted by title

-- query 11) return the title of the series, their season number, 
-- season, and year followed by the 'average rank number' 
-- (referred to as 'rnk') of all series based on the users ranks 
-- sorted by title, season number, season, and year)
SELECT a.title, b.number, b.season, b.year, b.rnk FROM series a 
	INNER JOIN watches b ON a.seriesId = b.seriesId;  

-- query 12) return the title of the series, their season number, season, and year of all series that didn't get watched by a user sorted by title, season number, season, and year

-- query 13) return the names of the actors/actress whose names begin with the letter 'S' sorted by actorName

-- query 14) return the seasons that were watched by more than one user, showing its series title, season number, season, year, and 'number of users' (referred to as 'users') sorted by title, season number, season, year, and users

-- query 15) return the name of the series that had seasons in the fall sorted by title

-- query 16) return the name of the series that had the most number of episodes in a season

-- query 17) return the name of the series that had seasons before 2010 sorted by title

-- query 18) return the title of the series that had seasons in the fall and in the spring sorted by title

-- query 19) return the year and the corresponding number of episodes 
-- (referred to as 'episodes') of seasons in that year regardless of 
-- their series sorted by year

-- query 20) return the title of the series that user 'Mary' didn't watch a single season sorted by title