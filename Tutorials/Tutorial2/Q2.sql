-- Let C be the numbered constraint given in qn.

DROP TABLE IF EXISTS Offices, Employees CASCADE;

CREATE TABLE Offices (
	office_id INTEGER,
	building TEXT NOT NULL, -- C2 "Candidate Key" must be NOT NULL & Unique
	level INTEGER NOT NULL, -- C2 "Candidate Key" must be NOT NULL & Unique
	room_number INTEGER NOT NULL, -- C2 "Candidate Key" must be NOT NULL & Unique
	area INTEGER,
	PRIMARY KEY (office_id), -- C1 "Unique Identifier"
	UNIQUE (building, level, room_number) -- C2 "Candidate Key" must be NOT NULL & Unique
);

CREATE TABLE Employees (
	emp_id INTEGER,
	name TEXT NOT NULL, -- C5
	office_id INTEGER NOT NULL, -- C6 Ensures participation. 
	manager_id INTEGER, -- C7 No need NOT NULL because "maybe" and again at most one is enforced by primary key: emp_id
	PRIMARY KEY (emp_id), -- C4 & C6 as Primary Key enforce that there is exactly one office for this employee
	FOREIGN KEY (office_id) REFERENCES Offices (office_id)
		ON DELETE NO ACTION ON UPDATE CASCADE, -- C9 & C11
	FOREIGN KEY (manager_id) REFERENCES Employees (emp_id) -- C8 Self-Referencing
		ON DELETE NO ACTION ON UPDATE CASCADE -- C10 & C12
);