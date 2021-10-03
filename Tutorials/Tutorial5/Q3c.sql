WITH averagePriceRestaurant AS (
	SELECT rname, AVG(price) as averagePrice, 
	FROM Sells
	GROUP BY rname
)

SELECT rname, averagePrice
FROM averagePriceRestaurant
WHERE averagePrice > 22;
