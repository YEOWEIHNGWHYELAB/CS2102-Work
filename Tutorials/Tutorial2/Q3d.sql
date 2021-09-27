DROP TABLE IF EXISTS
	Books, Customers, Carts, Purchase, Purchased_items CASCADE;

CREATE TABLE Books (
	isbn TEXT,
	title TEXT NOT NULL,
	authors TEXT NOT NULL,
	year INTEGER,
	edition TEXT NOT NULL
		CHECK (edition in ('hardcopy', 'paperback', 'ebook')),
	publisher TEXT,
	number_pages INTEGER CHECK (number_pages > 0),
	price NUMERIC NOT NULL CHECK (price > 0),
	PRIMARY KEY (isbn)
);

CREATE TABLE Customers (
	cust_id INTEGER,
	name TEXT NOT NULL,
	email TEXT NOT NULL,
	PRIMARY KEY (cust_id)
);

CREATE TABLE Carts (
	cust_id INTEGER,
	isbn TEXT,
	PRIMARY KEY (cust_id, isbn),
	FOREIGN KEY (cust_id) REFERENCES Customers
		ON DELETE CASCADE ON UPDATE CASCADE, -- (i)
	FOREIGN KEY (isbn) REFERENCES Books
		ON DELETE CASCADE ON UPDATE CASCADE -- (ii)
);

CREATE TABLE Purchase (
	pid INTEGER,
	purchase_date DATE NOT NULL,
	cust_id INTEGER NOT NULL,
	PRIMARY KEY (pid),
	FOREIGN KEY (cust_id) REFERENCES Customers
		ON DELETE CASCADE ON UPDATE CASCADE -- (i)
);

CREATE TABLE Purchased_Items (
	pid INTEGER,
	isbn TEXT DEFAULT '0', -- (ii)
	PRIMARY KEY (pid, isbn),
	FOREIGN KEY (pid) REFERENCES Purchase
		ON DELETE CASCADE ON UPDATE CASCADE, -- (iii)
	FOREIGN KEY (isbn) REFERENCES Books
		ON DELETE SET DEFAULT ON UPDATE CASCADE 
);


/*
	For "ON DELETE SET DEFAULT" at Purchased_Items to work...
	Books must have a isbn entry of '0' (since without '0', 
	it violates FK contraint of being 
	NOT NULL or a PK of referencing relation), 
	otherwise deletion will be rejected.
*/
