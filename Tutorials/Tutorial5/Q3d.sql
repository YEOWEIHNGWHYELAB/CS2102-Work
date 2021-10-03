WITH RestaurantTotalPrice AS (
	SELECT rname, SUM(price) as totalPrice
	FROM Sells
	GROUP BY rname
)

SELECT rname, totalPrice
FROM RestaurantTotalPrice
WHERE totalPrice > (SELECT AVG(totalPrice) 
	FROM RestaurantTotalPrice);
