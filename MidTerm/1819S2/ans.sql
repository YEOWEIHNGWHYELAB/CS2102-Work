/*	Q1	*/
CREATE VIEW v1 (eid) AS (
	SELECT DISTINCT eid 
	FROM Works
	WHERE hours > 10;
);

/*	Q2	*/
CREATE VIEW v2 (eid) AS (
	SELECT DISTINCT eid 
	FROM Specializes
	WHERE aid = 'A';
	INTERSECT
	SELECT DISTINCT eid
	FROM Specializes
	WHERE aid = 'B' OR aid = 'C'
);

/*	Q3	*/
CREATE VIEW v3 (eid) AS (
	SELECT E.eid -- We only want the eid from Employee table.
	FROM ((Employees E INNER JOIN Departments D on E.did = D.did) -- This get a combi of Department and Employee joining on did.
		INNER JOIN Offices O on D.oid = O.oid) -- Only Department has the oid. 
	WHERE address = 'A'
);

/*	Q4	*/
CREATE VIEW v4 (eid) AS (
	SELECT eid
	FROM Managers M
	WHERE M.eid NOT IN 
		(SELECT P.eid
		FROM Projects P)
);



/*	Q5	*/
CREATE VIEW v5 (eid) AS (
	SELECT E.eid
	FROM Engineers E 
	WHERE (NOT EXISTS ( -- Ensure that that engineer work on at most 1 hour on some project.
		SELECT 1
		FROM Works W1
		WHERE W1.eid = E.eid 
			AND W1.hours > 1))
		AND 
		(E.eid IN -- Ensure that that engineer work on some project.
		(SELECT W2.eid
		FROM Works W2))
);

/*	Q6	*/
CREATE VIEW v6 (eid, num) AS (
	SELECT eid, CASE 
		-- Check if it is managers.
		WHEN E.eid IN (SELECT eid FROM Managers) THEN
			-- Count the number of department.
			(SELECT COUNT(*) 
			FROM Departments D 
			WHERE D.eid = E.eid)
		-- Check if is engineers. 
		WHEN E.eid IN (SELECT eid FROM Engineers) THEN
			-- Count the number of project. 
			(SELECT COUNT(*) 
			FROM Works W 
			WHERE W.eid = E.eid)
		ELSE 0 END AS num
	FROM Employees E
);

/*	Q7	*/
CREATE VIEW v7 (pid, eid, eid2) AS (
	SELECT DISTINCT W1.pid, W1.eid, W2.eid
	FROM Works W1 JOIN Works W2 ON W1.pid = W2.pid 
		AND W1.eid < W2.eid 
	WHERE (SELECT COUNT(*) 
		FROM Works 
		WHERE pid = W1.pid) = 2 -- Check there is exactly 2 engineer working in this project.
);

/*	Q8	*/
CREATE VIEW v8 (aid, num) AS (
	SELECT A.aid, COUNT(DISTINCT E.did) -- The key thing is that COUNT only count NON-NULL Values!
	FROM Areas A LEFT OUTER JOIN -- Will have null for eid, did if that area does not have any specialization!
		(Specializes S JOIN Employees E ON S.eid = E.eid) -- This provides the aid and did for the employee eid.
		ON A.aid = S.aid
	GROUP BY A.aid -- Ensure the distinct aid...
);

/*	Q9	*/
CREATE VIEW v9 (pid) AS (
	SELECT pid
	FROM Works W
	GROUP BY pid
	HAVING COUNT(eid) > (
		/* number of employees who belong to department managing project W.pid */
		SELECT COUNT(eid)
		FROM Employees E
		WHERE E.did = (
			/* identifier of department managing project W.pid */
			SELECT E2.did
			FROM Employees E2 JOIN Projects P ON E2.eid = P.eid
				AND P.pid = W.pid
		)
	)
);

/*	Q10	*/
CREATE VIEW v10 (eid) AS (
	SELECT M.eid
	FROM Managers M
	WHERE NOT EXISTS (
		/* departments that are managed by M */
		SELECT 1
		FROM Departments D
		WHERE D.eid = M.eid
		AND EXISTS (
			/* employees who belong to department D (i.e., employees who are managed by M) */
			SELECT 1
			FROM Employees E
			WHERE E.did = D.did
				AND E.eid IN (
					/* engineers who work on some project */
					/* not supervised by M */
					SELECT W.eid
					FROM Works W JOIN Projects P ON W.pid = P.pid 
						AND P.eid <> M.eid)
		)
	)
);
