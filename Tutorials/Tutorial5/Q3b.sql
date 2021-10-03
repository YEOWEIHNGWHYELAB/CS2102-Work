-- Gives a table of Restaurant and their corresponding max price.
WITH MaxPriceOfEachRestaurant AS (
	SELECT rname, (SELECT MAX(price) 
		FROM Sells 
		WHERE rname = R.rname) AS maxPrice
	FROM Restaurants R
)

SELECT M1.rname, M2.rname
FROM MaxPriceOfEachRestaurant M1, MaxPriceOfEachRestaurant M2
WHERE M1.maxPrice > M2.maxPrice
