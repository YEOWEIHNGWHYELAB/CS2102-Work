SELECT DISTINCT R.area , S.pizza , S.price AS minPrice , (
	-- This part obtains the highest price of a pizza in a area as maxPrice
	SELECT DISTINCT S2.price
	FROM Restaurants R2 , Sells S2
	WHERE R2.rname = S2.rname
		AND R2.price <= ALL (
			SELECT S2.price
			FROM Restaurants R3 , Sells S3
			WHERE R3.rname = S3. rname
				AND R3.area = R2.area
				AND S3.pizza = S2.pizza
) AS maxPrice
-- This part is the same as part c
FROM Restaurants R, Sells S
WHERE R.rname = S.rname
	AND S.price <= ALL (
		SELECT S2.price
		FROM Restaurants R2 , Sells S2
		WHERE R2.rname = S2. rname
			AND R2.area = R. area
			AND S2.pizza = S. pizza
);
