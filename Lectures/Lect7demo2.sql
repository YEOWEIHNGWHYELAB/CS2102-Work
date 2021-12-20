DROP TABLE IF EXISTS Scores;

CREATE TABLE Scores (
	name VARCHAR(50) PRIMARY KEY,
    mark INTEGER NOT NULL
);

INSERT INTO Scores (name, mark) VALUES ('Alice', 92);
INSERT INTO Scores (name, mark) VALUES ('Bob', 63);
INSERT INTO Scores (name, mark) VALUES ('Cathy', 58);
INSERT INTO Scores (name, mark) VALUES ('David', 47);

CREATE OR REPLACE FUNCTION splitMarks
	(IN name1 VARCHAR(20), IN name2 VARCHAR(20))
RETURNS TABLE(Mark1 INT, Mark2 INT) AS $$
DECLARE
	temp INT := 0;
BEGIN
	SELECT mark INTO mark1 FROM Scores WHERE name = name1;
	SELECT mark INTO mark2 FROM Scores WHERE name = name2;
	
	temp := (mark1 + mark2) / 2;
	
	UPDATE Scores SET mark = temp WHERE name = name1 OR name = name2;
	RETURN QUERY SELECT mark1, mark2;
	RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

SELECT splitMarks('Alice', 'Bob');


/*
-----------------------------------
-- Here the "RETURN NEXT;" is being commented.

SELECT splitMarks('Alice', 'Bob');

 splitmarks
------------
 (92,63)
(1 row)

SELECT *
FROM Scores;

 name  | mark
-------+------
 Cathy |   58
 David |   47
 Alice |   77
 Bob   |   77
(4 rows)
-----------------------------------
-- Here the "RETURN QUERY SELECT mark1, mark2;" is being commented.

SELECT splitMarks('Alice', 'Bob');

 splitmarks
------------
 (92,63)
(1 row)


SELECT *
FROM Scores;

 name  | mark
-------+------
 Cathy |   58
 David |   47
 Alice |   77
 Bob   |   77
(4 rows)
-----------------------------------
SELECT splitMarks('Alice', 'Bob');

 splitmarks
------------
 (92,63)
 (92,63)
(2 rows)

SELECT *
FROM Scores;

 name  | mark
-------+------
 Cathy |   58
 David |   47
 Alice |   77
 Bob   |   77
(4 rows)
-----------------------------------
*/

DROP TABLE IF EXISTS Scores;

CREATE TABLE Scores (
	name VARCHAR(50), -- If this is not primary key...
    mark INTEGER NOT NULL
);

INSERT INTO Scores (name, mark) VALUES ('Alice', 32);
INSERT INTO Scores (name, mark) VALUES ('Alice', 92);
INSERT INTO Scores (name, mark) VALUES ('Bob', 67);
INSERT INTO Scores (name, mark) VALUES ('Bob', 63);
INSERT INTO Scores (name, mark) VALUES ('Cathy', 58);
INSERT INTO Scores (name, mark) VALUES ('David', 47);

SELECT splitMarks('Alice', 'Bob');

/*
-- Depending on which one of the duplicated name you put first is the 
marks that will be returned. 
-----------------------------------
SELECT splitMarks('Alice', 'Bob');

 splitmarks
------------
 (92,63)
(1 row)
-----------------------------------
SELECT splitMarks('Alice', 'Bob');

 splitmarks
------------
 (32,67)
-----------------------------------
SELECT * FROM Scores;

 name  | mark
-------+------
 Cathy |   58
 David |   47
 Alice |   77
 Alice |   77
 Bob   |   77
 Bob   |   77
(6 rows)
-----------------------------------
*/
