/*	Q1	*/
CREATE VIEW qn1 (uname) AS (
	SELECT DISTINCT uname
	FROM Customers
	WHERE uname LIKE 'A____%' -- Use Pattern Matching
);

/*	Q2	*/
CREATE VIEW qn2 (uname, name) AS (
	SELECT DISTINCT uname, name
	FROM Pet
	WHERE (atype = 'A' OR atype = 'B')
		AND diet = 'D1'
);

/*	Q3	*/
CREATE VIEW qn3 (uname) AS (
	(SELECT DISTINCT uname FROM Customers)
	EXCEPT
	(SELECT DISTINCT uname
	FROM CareTaker c INNER JOIN PetOwner p 
		ON c.uname = p.uname)
);

/*	Q4	*/
/* No need to check for ctuname IS NOT NULL since
that is a value of Primary Key attribute... */
CREATE VIEW qn4 (uname) AS (
	SELECT DISTINCT pouname AS uname
	FROM Bid b
	WHERE b.rating IS NULL 
		AND is_win = TRUE
);

/*	Q5	*/
CREATE VIEW qn5 (p1uname, p2uname) AS (
	SELECT DISTINCT AS p1.uname AS p1uname, p2.uname AS p2uname
	FROM Pet p1 INNER JOIN Pet p2 
		ON p1.atype = p2.atype
	WHERE p1.uname <> p2.uname 
		AND p1.uname < p2.uname
);

/*	Q6	*/
CREATE VIEW qn6 (uname, num) AS (
	SELECT w1.uname, COUNT(DISTINCT(w1.uname, w2.uname)) - 1 -- W1.uname can be removed since the group is done by w1.uname already.
	FROM Work w1, Work w2
	WHERE w1.area = w2.area
	GROUP BY w1.uname -- Since GROUP BY is partitioning, it automatically GROUP uname that are same...
);

/*	Q7	*/
CREATE VIEW qn7 (pouname, ctuname) AS (
	SELECT DISTINCT b1.pouname, b1.ctuname
	FROM Bid b1 
	WHERE NOT EXISTS (
		SELECT 1 
		FROM Availability a 
		WHERE b1.ctuname = a.uname
			AND NOT EXIST ( 
				SELECT 1
				FROM Bid b2
				WHERE a.uname = b2.ctuname
					AND a.s_date = b2.s_date
					AND a.s_time = b2.s_time
					AND a.e_time = b2.e_time
					AND b1.pouname = b2.pouname
	)
);

/*	Q8	*/
CREATE VIEW qn8 (uname, area) AS (
	WITH HasNoManager AS (
		SELECT O.uname
		FROM Offices O
		EXCEPT
		SELECT W.uname
		FROM Work W
		WHERE EXISTS (
			SELECT 1
			FROM Offices O
			WHERE O.uname <> W.uname
				AND W.area = O.area
		)
	)

	SELECT M.uname, O1.area
	FROM HasNoManager M NATURAL JOIN Offices O1
	WHERE (
		SELECT COUNT(*)
		FROM Offices O2, Work W
		WHERE O2.uname = W.uname
			AND O2.uname <> M.uname
			AND W.area = O1.area
	) >= 3
);
