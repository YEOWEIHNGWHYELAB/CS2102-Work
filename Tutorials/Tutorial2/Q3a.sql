-- Let C be the numbered constraint given in qn.

DROP TABLE IF EXISTS
	Books , Customers , Carts , Purchase , Purchased_items CASCADE ;
	
CREATE TABLE Books (
	isbn TEXT,
	title TEXT NOT NULL, -- Given in C1
	authors TEXT NOT NULL, -- Given in C1
	year INTEGER,
	edition TEXT NOT NULL -- Given in C1 
		CHECK (edition in ('hardcopy', 'paperback', 'ebook')), -- C1 as these are the only value edition can take
	publisher TEXT,
	number_pages INTEGER CHECK (number_pages > 0), -- C1
	price NUMERIC NOT NULL CHECK (price > 0), -- C1 
	PRIMARY KEY (isbn)
);

CREATE TABLE Customers (
	cust_id INTEGER,
	name TEXT NOT NULL, -- C2
	email TEXT NOT NULL, -- C2
	PRIMARY KEY (cust_id) -- C2 "Unique Identifier"
);

CREATE TABLE Carts (
	cust_id INTEGER,
	isbn TEXT,
	PRIMARY KEY (cust_id, isbn),
	FOREIGN KEY (cust_id) REFERENCES Customers,
	FOREIGN KEY (isbn) REFERENCES Books
);

CREATE TABLE Purchase (
	pid INTEGER,
	purchase_date DATE NOT NULL,
	cust_id INTEGER NOT NULL,
	PRIMARY KEY (pid),
	FOREIGN KEY (cust_id) REFERENCES Customers
);

CREATE TABLE Purchased_Items (
	pid INTEGER,
	isbn TEXT,
	PRIMARY KEY (pid, isbn),
	FOREIGN KEY (pid) REFERENCES Purchase,
	FOREIGN KEY (isbn) REFERENCES Books
);