DROP TABLE IF EXISTS cryptosRank;

CREATE TABLE cryptosRank (
    rank INTEGER NOT NULL,
    symbol CHAR(4) PRIMARY KEY,
    changes INTEGER NOT NULL
);

INSERT INTO cryptosRank (rank, symbol, changes) VALUES (1, 'BTC', -6);
INSERT INTO cryptosRank (rank, symbol, changes) VALUES (2, 'ETH', 3);
INSERT INTO cryptosRank (rank, symbol, changes) VALUES (3, 'DOGE', -6);
INSERT INTO cryptosRank (rank, symbol, changes) VALUES (4, 'ZIL', 10);
INSERT INTO cryptosRank (rank, symbol, changes) VALUES (5, 'XMR', -1);
INSERT INTO cryptosRank (rank, symbol, changes) VALUES (6, 'SHIB', -8);
INSERT INTO cryptosRank (rank, symbol, changes) VALUES (7, 'ADA', 1);
INSERT INTO cryptosRank (rank, symbol, changes) VALUES (8, 'LTC', -7);
INSERT INTO cryptosRank (rank, symbol, changes) VALUES (9, 'XRP', -7);
INSERT INTO cryptosRank (rank, symbol, changes) VALUES (10, 'BNB', -6);

/*
1. Query the cryptos that are down by more than 5% in the past 7
days from the top 10 of the given ranking system.
2. Find the three consecutive coins by traversing (1)
*/
CREATE OR REPLACE FUNCTION cryptosRank 
	(IN num INT)
RETURNS TABLE(rank INT, sym CHAR(4)) AS $$
DECLARE
	curs CURSOR FOR (SELECT * FROM cryptosRank
					WHERE changes < -5); -- Part 1
	-- 2 Variable that will be used in the algorithm. 
	r1 RECORD;
	r2 RECORD;
BEGIN
	OPEN curs; 
	LOOP
		FETCH curs INTO r1; -- Fetch the next tuple. Which r1 will contain the rank 1, "BTC".
		EXIT WHEN NOT FOUND;
		FETCH RELATIVE (num - 1)
			FROM curs INTO r2;
		EXIT WHEN NOT FOUND;
		
		-- Check between r1 and r2 is the difference = 2?
		-- If so, then take all the 3 consecutive points within.
		IF r2.rank - r1.rank = 2 THEN 
			MOVE RELATIVE - (num) FROM curs; -- Here RELATIVE is the "end" pointer.
			FOR c IN 1..num LOOP
				FETCH curs INTO r1;
				-- Assign to out param and then return next...
				rank := r1.rank;
				sym := r1.symbol;
				RETURN NEXT;
			END LOOP;
			CLOSE curs;
			RETURN;
		END IF;
		
		-- If the difference is not 2, means is not consecutive points.
		MOVE RELATIVE - (num - 1) FROM curs; -- Move from 
	END LOOP;
	CLOSE curs; -- Don't forget!
END;
$$ LANGUAGE plpgsql;

SELECT cryptosRank(3); -- Where 3 is the number of coins.
