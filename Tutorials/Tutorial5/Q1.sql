CREATE TABLE R (
	a INTEGER PRIMARY KEY ,
	b INTEGER ,
	c INTEGER
);

CREATE TABLE S (
	x INTEGER PRIMARY KEY ,
	y INTEGER REFERENCES R(a)
);

/* You can see that all attribute retains unless you SELECT a particular attribute...
--
SELECT *
FROM R JOIN S ON R.a = S.y;
--

 a | b | c | x | y
---+---+---+---+---
(0 rows)

*/

/* Invalid! since R.a did not appear!
--
SELECT a, b, x
FROM R JOIN S ON R.a = S.y
GROUP BY x;
--

ERROR:  column "r.a" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: SELECT a, b, x
               ^

*/

/* Valid 
--
SELECT a, b, y, SUM (c)
FROM R JOIN S ON R.a = S.y
GROUP BY a, y;
--

 a | b | y | sum
---+---+---+-----
(0 rows)

*/

/* Valid, see when you have x which is a primary key, you must have it in the GROUP BY clause!
--
SELECT a, b, x, y
FROM R JOIN S ON R.a = S.y
GROUP BY a, x;
--

 a | b | x | y
---+---+---+---
(0 rows)

*/
