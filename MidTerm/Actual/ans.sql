/* Q2.1 */
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW q1 (country_name) AS (
	SELECT name AS country_name
	FROM countries
	Where continent = 'Africa' AND population > 100000000
);
----------------------------------------------------------------------------------------------------

/* Q2.2 */
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW q2 (continent, country_count) AS (
	SELECT c.continent AS continent, COUNT(*) AS country_count
	FROM countries c LEFT JOIN airports a 
		ON c.iso2 = a.country_iso2
	WHERE a.name IS NULL
	GROUP BY c.continent
);
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW q2 (continent, country_count) AS (
	SELECT c.continent AS continent, COUNT(*) AS country_count
	FROM countries c INNER JOIN (
		SELECT co.name AS name
		FROM airports a RIGHT JOIN countries co ON a.country_iso2 = co.iso2
		WHERE a.name IS NULL
		GROUP BY co.name
	) AS inner_query ON inner_query.name = c.name
	GROUP BY c.continent
);
----------------------------------------------------------------------------------------------------
/* Below answer is incorrect! */
/* You don't actually need to use cities here since country_iso2 is stated in airpots */
/* In this case, the number of co.name will be equal to the number of cities without airport */
/* To fix it, remove cities... */
CREATE OR REPLACE VIEW q2 (continent, country_count) AS (
	SELECT c.continent, COUNT(*) 
	/* Do INNER JOIN on countries to get continent attribute and so we can do GROUP BY on continent */
	FROM countries c INNER JOIN (
		/* Will return countries without airport. */
		SELECT co.name AS name 
		/* Dangling tuple will be on cities without any airports */
		FROM ((cities ci LEFT OUTER JOIN airports a ON c1.name = a.city)
			/* So we can do GROUP BY for country name. */
			INNER JOIN countries co ON ci.country_iso2 = co.iso2) 
		WHERE a.name is NULL
		GROUP BY co.name
		) AS inner_query ON inner_query.name = c.name
	GROUP BY c.continent
);
----------------------------------------------------------------------------------------------------

/* Q2.3 */
----------------------------------------------------------------------------------------------------
/* Note that for borders table you should understand that say we have (Malaysia, China) as a tuple but not (China, Malaysia) */
/* Then it is mandatory for you to add the OR condition for the INNER JOIN ON condition otherwise it will under-count */
/* But if both exist in the database, then doing that will result in over-counting */
CREATE OR REPLACE VIEW q3 (country_name , border_count) AS (
	SELECT c.name AS country_name, COUNT(*) AS border_count
	FROM borders b JOIN countries c ON c.iso2 = b.country1_iso2 -- If we add for the ON condition, OR c.iso2 = b.country2_iso2 (will over-count)
	GROUP BY c.name
	ORDER BY border_count DESC -- You can refer to border_count because ORDER BY is run after the SELECT statement.
	LIMIT 10
);
----------------------------------------------------------------------------------------------------

/* Q2.4 */
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW q4 (country_name1 , country_name2) AS (
	SELECT DISTINCT c1.name AS country_name1, c2.name AS country_name2
	FROM countries c1, countries c2, borders b
	WHERE c1.iso2 = b.country1_iso2
		AND c2.iso2 = b.country2_iso2
		/* if you flip 'Asia' and 'Europe' */
		/* The order of the result will be different (<Asia>, <Europe>) which is not what the question wants. */
		AND c1.continent = 'Europe' 
		AND c2.continent = 'Asia'
);
----------------------------------------------------------------------------------------------------

/* Q2.5 */
----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW q5 (country_name) AS (
	/* Coutries in Asia - Countries in Asia where SQ flies to */
);
----------------------------------------------------------------------------------------------------
