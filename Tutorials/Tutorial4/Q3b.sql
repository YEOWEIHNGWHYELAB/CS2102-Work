SELECT DISTINCT pizza
FROM Sells S3
WHERE NOT EXISTS (
	SELECT 1
	FROM Sells S, Restaurants R, Sells S2 , Restaurants R2
	WHERE S.rname = R.rname AND S2.rname = R2.rname
		AND S.pizza = S2.pizza AND R.area = R2.area
		AND R.rname <> R2.rname AND S.pizza = S3.pizza
);
