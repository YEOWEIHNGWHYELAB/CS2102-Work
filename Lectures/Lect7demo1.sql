DROP TABLE IF EXISTS Scores;

CREATE TABLE Scores (
	name VARCHAR(50) PRIMARY KEY,
    mark INTEGER NOT NULL
);

INSERT INTO Scores (name, mark) VALUES ('Alice', 92);
INSERT INTO Scores (name, mark) VALUES ('Bob', 63);
INSERT INTO Scores (name, mark) VALUES ('Cathy', 58);
INSERT INTO Scores (name, mark) VALUES ('David', 47);

CREATE OR REPLACE FUNCTION convert (Mark INT)
RETURNS CHAR(1) AS $$
	SELECT CASE
		WHEN Mark >= 75 THEN 'A'
		WHEN Mark >= 65 THEN 'B'
		WHEN Mark >= 50 THEN 'C'
		ELSE 'F'
	END;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION CountGradeStudents() 
RETURNS TABLE(MARK CHAR(1), COUNT INT) AS $$

	SELECT convert(Mark), COUNT(*) 
	FROM Scores
	GROUP BY convert(Mark);
	
$$ LANGUAGE sql;
