SELECT pizza FROM Likes L1
WHERE cname = 'Alice '
	AND NOT EXISTS (
		SELECT 1 FROM Likes L2
		WHERE L2.cname = 'Bob ' AND L2.pizza = L1.pizza
);
