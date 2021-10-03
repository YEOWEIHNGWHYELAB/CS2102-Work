SELECT *
FROM bar b
WHERE EXISTS (
	SELECT 1
	FROM foo f
	WHERE f.f > 100
		AND f.a = b.a
);