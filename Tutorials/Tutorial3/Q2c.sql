DROP TABLE IF EXISTS A, B, C CASCADE ;

-- Simple...
CREATE TABLE A (
	a1 INTEGER PRIMARY KEY,
	a2 INTEGER
);

-- B is a weak entity with identifying owner A.
CREATE TABLE B (
	a1 INTEGER REFERENCES A
		ON DELETE CASCADE,
	b1 INTEGER,
	b2 INTEGER,
	PRIMARY KEY (a1 , b1)
);

-- C is a weak entity with identifying owner B.
CREATE TABLE C (
	a1 INTEGER, -- This is also needed as you need to take all PRIMARY KEY OF B. 
	b1 INTEGER,
	c1 INTEGER,
	c2 INTEGER,
	PRIMARY KEY (a1 , b1 , c1),
	FOREIGN KEY (a1 , b1) REFERENCES B 
		ON DELETE CASCADE
);