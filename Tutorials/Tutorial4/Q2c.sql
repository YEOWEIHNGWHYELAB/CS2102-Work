SELECT DISTINCT S1.rname
FROM Sells S1, Sells S2
WHERE S1.rname <> 'Corleone Corner'
	AND S2.rname = 'Corleone Corner' -- S2 takes only pizza sold by 'Corleone Corner'
	AND S1.price > S2.price;
	