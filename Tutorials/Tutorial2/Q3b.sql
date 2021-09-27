CREATE TABLE Purchase (
	pid INTEGER,
	purchase_timestamp TIMESTAMP NOT NULL, -- Changed from purchase_date, "each customer has at most 1 purchase anytime"
	cust_id INTEGER NOT NULL,
	PRIMARY KEY (pid), -- You could also treat purchase_timestamp as primary key as they are unique & NOT NULL.
	FOREIGN KEY (cust_id) REFERENCES Customers,
	UNIQUE (purchase_timestamp, cust_id)
);

/* 
-- Previous Table
CREATE TABLE Purchase (
	pid INTEGER,
	purchase_date DATE NOT NULL,
	cust_id INTEGER NOT NULL,
	PRIMARY KEY (pid),
	FOREIGN KEY (cust_id) REFERENCES Customers
);
*/