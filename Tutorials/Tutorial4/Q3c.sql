SELECT DISTINCT R.area , S.pizza , S.price
FROM Restaurants R, Sells S
WHERE R.rname = S.rname
	-- The S.price must be the lowest in the area of that restaurant.
	AND S.price <= ALL ( 
		SELECT S2.price
		FROM Restaurants R2 , Sells S2
		WHERE R2.rname = S2.rname
			AND R2.area = R.area
			AND S2.pizza = S.pizza
);
