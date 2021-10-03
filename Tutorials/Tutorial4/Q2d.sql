-- Select all rname, pizza, price of S1...
SELECT rname, pizza, price
FROM Sells S1
WHERE price IS NOT NULL
EXCEPT
-- This gives a table of pizza, price of that restaurant of S1 that is not most expensive.
SELECT S1.rname, S1.pizza, S1.price
FROM Sells S1, Sells S2
WHERE 
	AND S1.price > S2.price
	AND S1.rname = S2.rname;
	