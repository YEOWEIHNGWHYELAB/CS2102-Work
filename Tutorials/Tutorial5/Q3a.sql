SELECT rname, pizza
FROM Sells
WHERE price >= ALL (
	SELECT price 
	FROM Sells
);
	