SELECT DISTINCT cname
FROM Likes L, Sells S 
WHERE S.rname = 'Corleone Corner'
	AND S.pizza = L.pizza;
	