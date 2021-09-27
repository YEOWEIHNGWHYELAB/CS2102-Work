--Design A

DROP TABLE IF EXISTS
	Parts , Projects , Suppliers , Supplies CASCADE;

CREATE TABLE Parts (
	pid  INTEGER PRIMARY KEY,
	pname TEXT
);

CREATE TABLE Projects (
	jid  INTEGER PRIMARY KEY,
	jname TEXT
);

CREATE TABLE Suppliers (
	sid  INTEGER PRIMARY KEY,
	sname TEXT
);

CREATE TABLE Supplies (
	sid INTEGER,
	pid INTEGER,
	jid INTEGER,
	price NUMERIC, -- price just user NUMERIC.
	qty INTEGER,
	t_date DATE, -- don't use "date" as a attribute name!
	PRIMARY KEY (sid, pid, jid),
	FOREIGN KEY (sid) REFERENCES Parts(sid),
	FOREIGN KEY (pid) REFERENCES Parts(sid),
	FOREIGN KEY (jid) REFERENCES Parts(sid)
);

--Design B

DROP TABLE IF EXISTS
	Parts , Projects , Suppliers , Uses , Sells , Supplies CASCADE;

CREATE TABLE Parts (
	pid  INTEGER PRIMARY KEY,
	pname TEXT
);

CREATE TABLE Projects (
	jid  INTEGER PRIMARY KEY,
	jname TEXT
);

CREATE TABLE Suppliers (
	sid  INTEGER PRIMARY KEY,
	sname TEXT
);

CREATE TABLE Sells (
	pid INTEGER,
	sid INTEGER,
	price NUMERIC,
	PRIMARY KEY (pid, sid),
	FOREIGN KEY (pid) REFERENCES Parts(pid),
	FOREIGN KEY (sid) REFERENCES Suppliers(sid)
);

CREATE TABLE Uses (
	pid INTEGER,
	jid INTEGER,
	qty INTEGER,
	PRIMARY KEY (pid, jid),
	FOREIGN KEY (pid) REFERENCES Parts(pid),
	FOREIGN KEY (jid) REFERENCES Projects(jid)
);

CREATE TABLE Supplies (
	sid INTEGER,
	jid INTEGER,
	t_date DATE,
	PRIMARY KEY (sid, jid),
	FOREIGN KEY (sid) REFERENCES Suppliers(sid),
	FOREIGN KEY (jid) REFERENCES Projects(jid)
);

--Design C

DROP TABLE IF EXISTS
	Parts , Projects , Suppliers , Uses , Supplies CASCADE;

CREATE TABLE Parts (
	pid  INTEGER PRIMARY KEY,
	pname TEXT
);

CREATE TABLE Projects (
	jid  INTEGER PRIMARY KEY,
	jname TEXT
);

CREATE TABLE Suppliers (
	sid  INTEGER PRIMARY KEY,
	sname TEXT
);

CREATE TABLE Uses (
	pid INTEGER REFERENCES Parts,
	jid INTEGER REFERENCES Projects
);

CREATE TABLE Supplies (
	jid  INTEGER,
	pid  INTEGER,
	sid INTEGER,
	price NUMERIC,
	qty INTEGER,
	t_date DATE,
	PRIMARY KEY (jid, pid, sid),
	FOREIGN KEY (pid, jid) REFERENCES Uses(pid, jid)
	FOREIGN KEY sid REFERENCES Suppliers(sid)
);
	