DROP TABLE IF EXISTS
	Doctors, Patients, Pharmacies, Drugs, Sells, PharmaceuticalCompanies, Prescribes, Contracts CASCADE;

CREATE TABLE Doctors (
	ssn TEXT PRIMARY KEY,
	name TEXT,
	specialty TEXT,
	years INTEGER
);

CREATE TABLE Patients (
	ssn TEXT PRIMARY KEY,
	physician TEXT NOT NULL REFERENCES Doctors,
	name TEXT,
	address TEXT,
	age INTEGER
);

CREATE TABLE Pharmacies (
	name TEXT PRIMARY KEY,
	phone TEXT,
	address TEXT,
);

CREATE TABLE PharmaceuticalCompanies (
	name TEXT PRIMARY KEY,
	phone TEXT
);

CREATE TABLE Drugs (
	pcname TEXT REFERENCES PharmaceuticalCompanies
		ON DELETE CASCADE,
	tradename TEXT,
	formula TEXT,
	PRIMARY KEY (pcname, tradename)
);

CREATE TABLE Prescribes (
	dssn TEXT REFERENCES Doctors,
	pssn TEXT REFERENCES Patients,
	pcname TEXT REFERENCES PharmaceuticalCompanies
		ON DELETE CASCADE,
	tradename TEXT,
	pdate DATE,
	qty INTEGER,
	PRIMARY KEY (dssn, pssn, pcname, tradename),
	FOREIGN KEY (pcname, tradename) REFERENCES Drugs
);

CREATE TABLE Contracts (
	pname TEXT REFERENCES Pharmacies,
	pcname TEXT REFERENCES PharmaceuticalCompanies
		ON DELETE CASCADE,
	start_date DATE,
	end_date DATE,
	comments TEXT,
	PRIMARY KEY (pname, pcname)
);

CREATE TABLE Sells (
	pname TEXT REFERENCES Pharmacies,
	pcname TEXT REFERENCES PharmaceuticalCompanies
		ON DELETE CASCADE,
	tradename TEXT,
	price NUMERIC,
	PRIMARY KEY (pname, pcname, tradename),
	FOREIGN KEY (pname, pcname) REFERENCES Contracts,
	FOREIGN KEY (pcname, tradename) REFERENCES Drugs
);

CREATE TABLE Supervisors (
	ssn TEXT PRIMARY KEY
);

CREATE TABLE Supervises (
	pcname TEXT,
	pname TEXT,
	ssn TEXT NOT NULL REFERENCES Supervisors, -- There must always be a supervisor for each contract. 
	start_date DATE,
	PRIMARY KEY (pname, pcname, start_date),
	FOREIGN KEY (pname, pcname) REFERENCES Contracts
);