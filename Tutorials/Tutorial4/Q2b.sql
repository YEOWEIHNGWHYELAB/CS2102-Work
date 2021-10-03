-- Use Set Operations.
SELECT C.cname
FROM Customers C
EXCEPT 
SELECT C.cname
FROM Likes L, Sells S
WHERE S. rname = 'Corleone Corner '
	AND S. pizza = L. pizza
	AND C. cname = L. cname
	