CREATE SEQUENCE scoala_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE elev_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE profesor_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE coordonator_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE recenzie_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE bursa_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE departament_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE locatie_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE atestat_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE diploma_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE programe_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE curs_seq START WITH 1 INCREMENT BY 1;

--DROP SEQUENCE scoala_seq;
--DROP SEQUENCE elev_seq;
--DROP SEQUENCE profesor_seq;
--DROP SEQUENCE coordonator_seq;
--DROP SEQUENCE recenzie_seq;
--DROP SEQUENCE bursa_seq;
--DROP SEQUENCE departament_seq;
--DROP SEQUENCE locatie_seq;
--DROP SEQUENCE atestat_seq;
--DROP SEQUENCE diploma_seq;
--DROP SEQUENCE programe_seq;
--DROP SEQUENCE curs_seq;


--DROP TABLE Scoala;
--DROP TABLE Atestat;
--DROP TABLE Bursa;
--DROP TABLE Coordonator;
--DROP TABLE Curs;
--DROP TABLE Fizic;
--DROP TABLE CursOnline;
--DROP TABLE Diploma;
--DROP TABLE Elev;
--DROP TABLE Locatie;
--DROP TABLE Departament;
--DROP TABLE Profesor;
--DROP TABLE Recenzie;
--DROP TABLE Programe;
--DROP TABLE Formular;
--DROP TABLE Certificare;
--DROP TABLE Instruire;
--DROP TABLE Tabara;

SELECT * FROM Scoala;
SELECT * FROM Elev;
SELECT * FROM Coordonator;
SELECT * FROM Profesor;
SELECT * FROM Curs;
SELECT * FROM FIZIC;
SELECT * FROM CursOnline;
SELECT * FROM Atestat;
SELECT * FROM Diploma;
SELECT * FROM Recenzie;
SELECT * FROM Bursa;
SELECT * FROM Departament;
SELECT * FROM Locatie;
SELECT * FROM Programe;
SELECT * FROM Certificare;
SELECT * FROM Instruire;
SELECT * FROM Formular;
SELECT * FROM Specializare;
SELECT * FROM Acreditare;
SELECT * FROM Tabara;

UPDATE Scoala
SET denumire_scoala = 'Logiscool ROMA'
WHERE denumire_scoala = 'Logiscool UNIRII';


CREATE TABLE Scoala (
 id_scoala INT DEFAULT scoala_seq.NEXTVAL PRIMARY KEY,
 denumire_scoala VARCHAR(50)
);

CREATE TABLE Elev(
id_elev INT DEFAULT elev_seq.NEXTVAL PRIMARY KEY,
nume_elev VARCHAR(50),
prenume_elev VARCHAR(50),
data_nasterii DATE,
id_scoala INT ,
FOREIGN KEY(id_scoala) REFERENCES Scoala(id_scoala)
);

CREATE TABLE Coordonator(
id_coordonator INT DEFAULT coordonator_seq.NEXTVAL PRIMARY KEY,
nume_coordonator VARCHAR(50),
prenume_coordonator VARCHAR(50),
data_angajare_coo DATE,
salariu INT,
fost_profesor NUMBER(1,0) DEFAULT 0,
CONSTRAINT ck_fost_profesor CHECK (fost_profesor IN (0, 1)),
id_scoala INT ,
FOREIGN KEY(id_scoala) REFERENCES Scoala(id_scoala)
);


CREATE TABLE Profesor(
id_profesor INT DEFAULT profesor_seq.NEXTVAL PRIMARY KEY,
nume_profesor VARCHAR(50),
prenume_profesor VARCHAR(50),
data_angajare_prof DATE,
salariu INT,
id_coordonator INT ,
FOREIGN KEY(id_coordonator) REFERENCES Coordonator(id_coordonator)
);

CREATE TABLE Curs(
id_curs INT DEFAULT curs_seq.NEXTVAL PRIMARY KEY,
denumire_curs VARCHAR(50),
inceput_curs DATE,
final_curs DATE,
loc_curs INT,
CONSTRAINT ck_loc_curs CHECK (loc_curs>=1 AND loc_curs<=15),
id_profesor INT,
FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
);

CREATE TABLE FIZIC(
id_fizic INT PRIMARY KEY REFERENCES Curs(id_curs),
sala INT
);

CREATE TABLE CursOnline(
id_online INT PRIMARY KEY REFERENCES Curs(id_curs),
platforma VARCHAR(50)
);

CREATE TABLE Atestat(
id_atestat INT DEFAULT atestat_seq.NEXTVAL PRIMARY KEY,
denumire_atestat VARCHAR(50)
);

CREATE TABLE Diploma(
id_diploma INT DEFAULT diploma_seq.NEXTVAL PRIMARY KEY,
denumire_diploma VARCHAR(50),
grad_diploma INT,
CONSTRAINT ck_grad_diploma CHECK (grad_diploma>=0 AND grad_diploma<=10)
);

CREATE TABLE Recenzie(
id_recenzie INT DEFAULT recenzie_seq.NEXTVAL PRIMARY KEY,
data_recenzie DATE,
evaluare INT,
CONSTRAINT ck_evaluare CHECK (evaluare >=0 AND evaluare<=10),
id_elev INT,
FOREIGN KEY (id_elev) REFERENCES Elev(id_elev)
);

CREATE TABLE Bursa(
id_bursa INT DEFAULT bursa_seq.NEXTVAL PRIMARY KEY,
tip VARCHAR(50),
suma INT,
medie_minima INT,
CONSTRAINT ck_medie_minima CHECK (medie_minima >=8 AND medie_minima<=10),
situatieSpeciala NUMBER(1,0) DEFAULT 0,
CONSTRAINT ck_situatieSpeciala CHECK (situatieSpeciala IN (0, 1))
);

CREATE TABLE Departament(
id_departament INT DEFAULT departament_seq.NEXTVAL PRIMARY KEY,
denumire_departament VARCHAR(50),
capacitate INT,
CONSTRAINT ck_capacitate CHECK (capacitate>=1 AND capacitate<=15),
id_scoala INT,
FOREIGN KEY (id_scoala) REFERENCES Scoala(id_scoala)
);

CREATE TABLE Locatie(
id_locatie INT DEFAULT locatie_seq.NEXTVAL PRIMARY KEY,
oras_locatie VARCHAR(50),
tara_locatie VARCHAR(50),
id_scoala INT,
FOREIGN KEY (id_scoala) REFERENCES Scoala(id_scoala)
);

CREATE TABLE Programe(
id_program INT DEFAULT programe_seq.NEXTVAL PRIMARY KEY,
denumire_program VARCHAR(50),
data_inceput DATE,
data_final DATE
);

CREATE TABLE Certificare(
id_elev INT,
id_atestat INT,
FOREIGN KEY(id_elev) REFERENCES Elev(id_elev),
FOREIGN KEY(id_atestat) REFERENCES Atestat(id_atestat),
PRIMARY KEY(id_elev, id_atestat)
);

CREATE TABLE Instruire(
nota_elev INT,
CONSTRAINT ck_nota_elev CHECK (nota_elev >=1 AND nota_elev<=10),
id_elev INT,
id_curs INT,
FOREIGN KEY (id_elev) REFERENCES Elev(id_elev),
FOREIGN KEY(id_curs) REFERENCES Curs(id_curs),
PRIMARY KEY(id_elev, id_curs)
);

CREATE TABLE Formular(
media_elev INT,
id_elev INT,
id_bursa INT,
FOREIGN KEY (id_elev) REFERENCES Elev(id_elev),
FOREIGN KEY(id_bursa) REFERENCES Bursa(id_bursa),
PRIMARY KEY(id_elev, id_bursa)
);

CREATE TABLE Specializare(
id_profesor INT,
id_departament INT,
FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor),
FOREIGN KEY (id_departament) REFERENCES Departament(id_departament),
PRIMARY KEY (id_profesor, id_departament)
);

CREATE TABLE Acreditare(
id_profesor INT,
id_diploma INT,
FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor),
FOREIGN KEY (id_diploma) REFERENCES Diploma(id_diploma),
PRIMARY KEY (id_profesor, id_diploma)
);

CREATE TABLE Tabara(
id_elev INT,
id_program INT,
id_coordonator INT ,
FOREIGN KEY (id_elev) REFERENCES Elev(id_elev),
FOREIGN KEY (id_program) REFERENCES Programe(id_program),
FOREIGN KEY(id_coordonator) REFERENCES Coordonator(id_coordonator),
PRIMARY KEY(id_elev,id_program,id_coordonator),
m_m NUMBER(1,0) DEFAULT 0,
CONSTRAINT ck_m_m CHECK (m_m IN (0, 1))
);

--Inserari pentru tabelul Scoala
INSERT INTO Scoala (denumire_scoala) VALUES ( 'Logiscool Online');
INSERT INTO Scoala (denumire_scoala) VALUES ( 'Logiscool MILITARI');
INSERT INTO Scoala (denumire_scoala) VALUES ( 'Logiscool DRUMUL TABEREI');
INSERT INTO Scoala (denumire_scoala) VALUES ( 'Logiscool PANTELIMON');
INSERT INTO Scoala (denumire_scoala) VALUES ( 'Logiscool ROMA');

select * from scoala;


-- Elevi pentru Scoala 1
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Popescu', 'Ion', TO_DATE('2006-03-15', 'YYYY-MM-DD'), 1);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Ionescu', 'Maria', TO_DATE('2007-08-22', 'YYYY-MM-DD'), 1);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Dumitrescu', 'Andrei', TO_DATE('2010-05-10', 'YYYY-MM-DD'), 1);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Georgescu', 'Elena', TO_DATE('2012-11-30', 'YYYY-MM-DD'), 1);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Constantinescu', 'Ana', TO_DATE('2015-02-18', 'YYYY-MM-DD'), 1);

SELECT * FROM Elev
WHERE id_scoala=1;

-- Elevi pentru Scoala 2
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Radu', 'Mircea', TO_DATE('2005-07-20', 'YYYY-MM-DD'), 2);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Stoica', 'Ana-Maria', TO_DATE('2006-09-12', 'YYYY-MM-DD'), 2);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Gheorghiu', 'Alexandru', TO_DATE('2009-04-03', 'YYYY-MM-DD'), 2);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Marinescu', 'Andreea', TO_DATE('2011-10-25', 'YYYY-MM-DD'), 2);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Popa', 'Ioana', TO_DATE('2013-12-07', 'YYYY-MM-DD'), 2);

SELECT * FROM Elev
WHERE id_scoala=2;

-- Elevi pentru Scoala 3
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Dragomir', 'Cristian', TO_DATE('2007-01-10', 'YYYY-MM-DD'), 3);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Mihai', 'Ioana', TO_DATE('2008-11-05', 'YYYY-MM-DD'), 3);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Ilie', 'Andrei', TO_DATE('2010-06-18', 'YYYY-MM-DD'), 3);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Stanciu', 'Elena', TO_DATE('2012-09-29', 'YYYY-MM-DD'), 3);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Iordache', 'Mihai', TO_DATE('2014-03-14', 'YYYY-MM-DD'), 3);

SELECT * FROM Elev
WHERE id_scoala=3;

-- Elevi pentru Scoala 4
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Popovici', 'Alina', TO_DATE('2006-02-28', 'YYYY-MM-DD'), 4);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Dobre', 'C?t?lin', TO_DATE('2008-07-15', 'YYYY-MM-DD'), 4);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Florescu', 'Ana-Maria', TO_DATE('2010-10-07', 'YYYY-MM-DD'), 4);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Munteanu', 'Radu', TO_DATE('2013-04-19', 'YYYY-MM-DD'), 4);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Diaconu', 'Andreea', TO_DATE('2016-08-02', 'YYYY-MM-DD'), 4);

SELECT * FROM Elev
WHERE id_scoala=4;

-- Elevi pentru Scoala 5
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Balan', 'Mihai', TO_DATE('2007-05-03', 'YYYY-MM-DD'), 5);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Iacob', 'Andreea', TO_DATE('2009-08-11', 'YYYY-MM-DD'), 5);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Stefan', 'R?zvan', TO_DATE('2011-12-28', 'YYYY-MM-DD'), 5);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Cristea', 'Elena', TO_DATE('2014-02-09', 'YYYY-MM-DD'), 5);
INSERT INTO Elev (nume_elev, prenume_elev, data_nasterii, id_scoala) VALUES 
('Pop', 'Maria', TO_DATE('2017-06-14', 'YYYY-MM-DD'), 5);

SELECT * FROM Elev;
WHERE id_scoala=5;

-- Locatie pentru Scoala 1 (Logiscool Online)
INSERT INTO Locatie (oras_locatie, tara_locatie, id_scoala) VALUES (NULL, NULL, 1);

-- Locatie pentru Scoala 2 (Logiscool MILITARI)
INSERT INTO Locatie (oras_locatie, tara_locatie, id_scoala) VALUES ('Bucuresti', 'Romania', 2);

-- Locatie pentru Scoala 3 (Logiscool DRUMUL TABEREI)
INSERT INTO Locatie (oras_locatie, tara_locatie, id_scoala) VALUES ('Bucuresti', 'Romania', 3);

-- Locatie pentru Scoala 4 (Logiscool PANTELIMON)
INSERT INTO Locatie (oras_locatie, tara_locatie, id_scoala) VALUES ('Bucuresti', 'Romania', 4);

-- Locatie pentru Scoala 5 (Logiscool ROMA)
INSERT INTO Locatie (oras_locatie, tara_locatie, id_scoala) VALUES ('Roma', 'Italia', 5);

-- Departamente pentru Scoala 1 (Logiscool Online)
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('Java', 10, 1);
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('C', 12, 1);

SELECT * FROM Departament
WHERE id_scoala=1;

-- Departamente pentru Scoala 2 (Logiscool MILITARI)
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('Python', 15, 2);
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('C++', 10, 2);
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('Ruby', 9, 2);

SELECT * FROM Departament
WHERE id_scoala=2;

-- Departamente pentru Scoala 3 (Logiscool DRUMUL TABEREI)
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('Java', 15, 3);
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('C#', 12, 3);

SELECT * FROM Departament
WHERE id_scoala=3;

-- Departamente pentru Scoala 4 (Logiscool PANTELIMON)
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('C++', 8, 4);
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('JavaScript', 10, 4);
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('Python', 12, 4);

SELECT * FROM Departament
WHERE id_scoala=4;

-- Departamente pentru Scoala 5 (Logiscool ROMA)
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('Python', 10, 5);
INSERT INTO Departament (denumire_departament, capacitate, id_scoala) VALUES ('C#', 15, 5);

SELECT * FROM Departament
WHERE id_scoala=5;

SELECT * FROM Departament;
-- Coordonator pentru Scoala 1
INSERT INTO Coordonator (nume_coordonator, prenume_coordonator, data_angajare_coo, salariu, fost_profesor, id_scoala) VALUES 
('Ionescu', 'George', TO_DATE('2015-06-15', 'YYYY-MM-DD'), 3000, 1, 1);

-- Coordonator pentru Scoala 2
INSERT INTO Coordonator (nume_coordonator, prenume_coordonator, data_angajare_coo, salariu, fost_profesor, id_scoala) VALUES 
('Popescu', 'Marian', TO_DATE('2018-09-23', 'YYYY-MM-DD'), 3500, 0, 2);

-- Coordonator pentru Scoala 3
INSERT INTO Coordonator (nume_coordonator, prenume_coordonator, data_angajare_coo, salariu, fost_profesor, id_scoala) VALUES 
('Georgescu', 'Elena', TO_DATE('2016-11-05', 'YYYY-MM-DD'), 4000, 1, 3);

-- Coordonator pentru Scoala 4
INSERT INTO Coordonator (nume_coordonator, prenume_coordonator, data_angajare_coo, salariu, fost_profesor, id_scoala) VALUES 
('Constantinescu', 'Ion', TO_DATE('2017-03-10', 'YYYY-MM-DD'), 2800, 0, 4);

-- Coordonator pentru Scoala 5
INSERT INTO Coordonator (nume_coordonator, prenume_coordonator, data_angajare_coo, salariu, fost_profesor, id_scoala) VALUES 
('Dumitrescu', 'Ana', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 3700, 1, 5);

SELECT * FROM Coordonator;

-- Program 1: Kodu
INSERT INTO Programe (denumire_program, data_inceput, data_final) 
VALUES ('Kodu', TO_DATE('15-06-2025', 'DD-MM-YYYY '), TO_DATE('20-06-2025', 'DD-MM-YYYY'));

-- Program 2: Roblox
INSERT INTO Programe (denumire_program, data_inceput, data_final) 
VALUES ('Roblox', TO_DATE('16-05-2025 ', 'DD-MM-YYYY'), TO_DATE('21-05-2025', 'DD-MM-YYYY'));

-- Program 3: Minecraft
INSERT INTO Programe (denumire_program, data_inceput, data_final) 
VALUES ('Minecraft', TO_DATE('17-07-2025 ', 'DD-MM-YYYY'), TO_DATE('22-07-2025 ', 'DD-MM-YYYY'));

-- Program 4: LegoSpike
INSERT INTO Programe (denumire_program, data_inceput, data_final) 
VALUES ('LegoSpike', TO_DATE('18-05-2025', 'DD-MM-YYYY'), TO_DATE('23-05-2025', 'DD-MM-YYYY'));

-- Program 5: Robotica
INSERT INTO Programe (denumire_program, data_inceput, data_final) 
VALUES ('Robotica', TO_DATE('19-05-2025', 'DD-MM-YYYY'), TO_DATE('24-05-2025', 'DD-MM-YYYY'));

-- Program 6: ImagiCharm
INSERT INTO Programe (denumire_program, data_inceput, data_final) 
VALUES ('ImagiCharm', TO_DATE('20-05-2025', 'DD-MM-YYYY'), TO_DATE('25-05-2025', 'DD-MM-YYYY'));

-- Program 7: AI
INSERT INTO Programe (denumire_program, data_inceput, data_final) 
VALUES (' AI', TO_DATE('01-05-2025', 'DD-MM-YYYY'), TO_DATE('04-05-2025', 'DD-MM-YYYY'));

--Program 8: Digital Discovery
INSERT INTO Programe (denumire_program, data_inceput, data_final) 
VALUES ('Digital Discovery', TO_DATE('01-08-2025 ', 'DD-MM-YYYY'), TO_DATE('06-08-2025 ', 'DD-MM-YYYY'));

select * from programe;
--Tabera la care participa elevii scolii 1
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (2, 1, 1, 1);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (4, 1, 1, 1);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (3, 1, 1, 1);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (2, 2, 1, 0);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (5, 2, 1, 0);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (1, 2, 1, 0);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (3, 3, 1, 1);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (2, 3, 1, 1);

SELECT * FROM Tabara
WHERE id_coordonator=1;

--Tabera la care participa elevii  scolii 2
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (6, 4, 2, 1);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (8, 4, 2, 1);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (9, 4, 2, 1);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (7, 5, 2, 1);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (10, 5, 2, 1);

SELECT * FROM Tabara
WHERE id_coordonator=2;

--Tabera la care participa elevii  scolii 3
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (11, 4, 3, 1);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (12, 4, 3, 1);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (13, 5, 3, 0);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (12, 5, 3, 0);

SELECT * FROM Tabara
WHERE id_coordonator=3;

--Tabera la care participa elevii scolii 4
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (16, 6, 4, 0);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (17, 6, 4, 0);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (19, 6, 4, 0);

SELECT * FROM Tabara
WHERE id_coordonator=4;

--Taberele la care participa elevii elvii scolii 5
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (20, 7, 5, 0);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (21, 7, 5, 0);
INSERT INTO Tabara (id_elev, id_program, id_coordonator, m_m)
VALUES (25, 7, 5, 0);

SELECT * FROM Tabara
WHERE id_coordonator=5;

--Atestate
INSERT INTO Atestat (denumire_atestat) VALUES ('Securitate cibernetic?');
INSERT INTO Atestat (denumire_atestat) VALUES ('Baze de Date SQL');
INSERT INTO Atestat (denumire_atestat) VALUES ('Design Grafic');
INSERT INTO Atestat (denumire_atestat) VALUES ('Administrarea Sistemelor de Operare');
INSERT INTO Atestat (denumire_atestat) VALUES ('Dezvoltare Web');
INSERT INTO Atestat (denumire_atestat) VALUES ('Dezvoltare de Aplica?ii Mobile');

--Certificare
INSERT INTO Certificare(id_elev, id_atestat) VALUES (1,1);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (1,2);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (1,3);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (2,4);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (3,4);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (3,5);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (4,1);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (4,6);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (5,1);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (6,1);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (7,1);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (7,2);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (15,1);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (10,3);
INSERT INTO Certificare(id_elev, id_atestat) VALUES (14,4);

SELECT * FROM Certificare;

--RECENZII

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 9, 1);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 8, 2);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 7, 3);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 6, 4);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 4, 5);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 8, 6);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 9, 9);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 5, 11);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 9, 15);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 8, 16);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 3, 17);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 7, 18);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 8, 20);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 4, 23);

INSERT INTO Recenzie (data_recenzie, evaluare, id_elev) 
VALUES (TO_DATE('2024-05-20', 'YYYY-MM-DD'), 6, 21);

SELECT * FROM Recenzie;

--Burse

INSERT INTO Bursa( tip, suma, medie_minima) VALUES
('Bursa de studiu', 900, 8);

INSERT INTO Bursa( tip, suma, medie_minima) VALUES
('Bursa de merit', 1200, 9);

INSERT INTO Bursa( tip, suma, medie_minima) VALUES
('Bursa de performanta', 1700, 10);

INSERT INTO Bursa( tip, suma, situatieSpeciala) VALUES
('Bursa sociala', 1300, 1);

INSERT INTO Bursa( tip, suma, situatieSpeciala) VALUES
('Bursa de handicap', 1500,1);

select* from bursa;
delete from bursa;
--Profesori

-- Profesori suplimentari pentru Coordonatorul 1
INSERT INTO Profesor ( nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ( 'Ionescu', 'Mihai', TO_DATE('15-06-2023', 'DD-MM-YYYY'), 1600, 1);
INSERT INTO Profesor ( nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ( 'Popa', 'Alexandra', TO_DATE('20-07-2023', 'DD-MM-YYYY'), 1900, 1);
INSERT INTO Profesor ( nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ( 'Popescu', 'Alexandru', TO_DATE('20-08-2022', 'DD-MM-YYYY'), 1500, 1);

-- Profesori suplimentari pentru Coordonatorul 2
INSERT INTO Profesor (nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ('Dumitrescu', 'Andrei', TO_DATE('25-08-2023', 'DD-MM-YYYY'), 1800, 2);
INSERT INTO Profesor ( nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ( 'Gheorghiu', 'Elena', TO_DATE('30-09-2023', 'DD-MM-YYYY'), 1950, 2);

-- Profesori suplimentari pentru Coordonatorul 3
INSERT INTO Profesor ( nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ( 'Mihaila', 'Adrian', TO_DATE('05-10-2023', 'DD-MM-YYYY'), 1700, 3);
INSERT INTO Profesor ( nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ( 'Florescu', 'Ioana', TO_DATE('10-11-2023', 'DD-MM-YYYY'), 1850, 3);

-- Profesori suplimentari pentru Coordonatorul 4
INSERT INTO Profesor ( nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ( 'Stanescu', 'Gabriel', TO_DATE('15-12-2023', 'DD-MM-YYYY'), 1900, 4);
INSERT INTO Profesor ( nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ('Dinu', 'Cristina', TO_DATE('20-01-2024', 'DD-MM-YYYY'), 1750, 4);

-- Profesori suplimentari pentru Coordonatorul 5
INSERT INTO Profesor ( nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ( 'Vasilescu', 'Mariana', TO_DATE('25-02-2024', 'DD-MM-YYYY'), 1650, 5);
INSERT INTO Profesor ( nume_profesor, prenume_profesor, data_angajare_prof, salariu, id_coordonator) 
VALUES ( 'Iacob', 'Mihai', TO_DATE('01-03-2024', 'DD-MM-YYYY'), 1950, 5);

SELECT * FROM Profesor;

--Specializare

--Departamentul 1
INSERT INTO Specializare (id_profesor, id_departament) VALUES (1,1);
INSERT INTO Specializare (id_profesor, id_departament) VALUES (2,1);
INSERT INTO Specializare (id_profesor, id_departament) VALUES (3,2);

--Departamentul 2
INSERT INTO Specializare (id_profesor, id_departament) VALUES (4,3);
INSERT INTO Specializare (id_profesor, id_departament) VALUES (4,4);
INSERT INTO Specializare (id_profesor, id_departament) VALUES (5,5);

--Departamentul 3
INSERT INTO Specializare (id_profesor, id_departament) VALUES (6,6);
INSERT INTO Specializare (id_profesor, id_departament) VALUES (7,7);

--Departamentul 4
INSERT INTO Specializare (id_profesor, id_departament) VALUES (8,8);
INSERT INTO Specializare (id_profesor, id_departament) VALUES (9,9);
INSERT INTO Specializare (id_profesor, id_departament) VALUES (9,10);

--Departamentul 5
INSERT INTO Specializare (id_profesor, id_departament) VALUES (10,11);
INSERT INTO Specializare (id_profesor, id_departament) VALUES (11,12);

SELECT * FROM Specializare;
DELETE FROM Specializare;

--SELECT id_profesor 
--FROM profesor p
--JOIN departament d ON d.id_departament=p.id_departament
--WHERE p.id_scoala=1;


--DIPLOMA
--1 Insert Diploma: JAVA
INSERT INTO Diploma (denumire_diploma, grad_diploma) 
VALUES ('JAVA', 8);

--2 Insert Diploma: C
INSERT INTO Diploma (denumire_diploma, grad_diploma) 
VALUES ('C', 7);

--3 Insert Diploma: Python
INSERT INTO Diploma (denumire_diploma, grad_diploma) 
VALUES ('Python', 9);

--4 Insert Diploma: C++
INSERT INTO Diploma (denumire_diploma, grad_diploma) 
VALUES ('C++', 6);

--5 Insert Diploma: Ruby
INSERT INTO Diploma (denumire_diploma, grad_diploma) 
VALUES ('Ruby', 5);

--6 Insert Diploma: C#
INSERT INTO Diploma (denumire_diploma, grad_diploma) 
VALUES ('C#', 7);

--7 Insert Diploma: JAVASCRIPT
INSERT INTO Diploma (denumire_diploma, grad_diploma) 
VALUES ('JAVASCRIPT', 8);

SELECT * FROM Diploma;


SELECT d.denumire_departament, p.id_profesor
FROM departament d
JOIN specializare s ON s.id_departament = d.id_departament
JOIN profesor p ON p.id_profesor = s.id_profesor
WHERE d.id_departament = 11;

--Acreditare
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (1,1);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (2,1);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (3,2);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (4,3);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (4,4);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (5,5);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (6,1);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (7,6);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (8,4);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (9,7);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (9,3);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (10,3);
INSERT INTO Acreditare(id_profesor, id_diploma) VALUES (11,6);

SELECT * FROM Acreditare;


-- Curs predat de profesorul 1 (Java)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('POO in Java', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 5, 1);
-- Curs online
INSERT INTO CursOnline (id_online, platforma) VALUES (1, 'Zoom');

-- Cursuri predate de profesorul 2 (Java)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Java Avansat', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 6, 2);
-- Curs online
INSERT INTO CursOnline (id_online, platforma) VALUES (2, 'Zoom');

-- Cursuri predate de profesorul 3 (C)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Introducere in C', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 7, 3);
-- Curs fizic
INSERT INTO FIZIC (id_fizic, sala) VALUES (3, 102);

-- Cursuri predate de profesorul 4 (Python)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Python pentru incepatori', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 8, 4);
-- Curs fizic
INSERT INTO FIZIC (id_fizic, sala) VALUES (4, 103);

-- Curs suplimentar pentru profesorul 4 (C++)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Programare avansata in C++', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 5, 4);
-- Curs fizic
INSERT INTO FIZIC (id_fizic, sala) VALUES (5, 107);

-- Cursuri predate de profesorul 5 (C++)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Programare in C++', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 9, 5);
-- Curs online
INSERT INTO CursOnline (id_online, platforma) VALUES (6, 'Teams');

-- Cursuri predate de profesorul 6 (Ruby)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Ruby pentru incepatori', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 10, 6);
-- Curs fizic
INSERT INTO FIZIC (id_fizic, sala) VALUES (7, 104);

-- Cursuri predate de profesorul 7 (C#)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Programare in C#', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 11, 7);
-- Curs online
INSERT INTO CursOnline (id_online, platforma) VALUES (8, 'Google Meet');

-- Cursuri predate de profesorul 8 (C++)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Algoritmi in C++', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 12, 8);
-- Curs fizic
INSERT INTO FIZIC (id_fizic, sala) VALUES (9, 105);

-- Cursuri predate de profesorul 9 (JavaScript)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('JavaScript pentru web', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 13, 9);
-- Curs online
INSERT INTO CursOnline (id_online, platforma) VALUES (10, 'Webex');

-- Curs suplimentar pentru profesorul 9 (Python)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Python pentru Data Science', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 6, 9);
-- Curs online
INSERT INTO CursOnline (id_online, platforma) VALUES (11, 'Google Classroom');

-- Curs predat de profesorul 10 (Python)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Python intermediar', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 14, 10);
-- Curs online
INSERT INTO CursOnline (id_online, platforma) VALUES (12, 'Zoom');

-- Cursuri predate de profesorul 11 (C#)
INSERT INTO Curs (denumire_curs, inceput_curs, final_curs, loc_curs, id_profesor) 
VALUES ('Dezvoltare aplicatii in C#', TO_DATE('01-09-2024', 'DD-MM-YYYY'), TO_DATE('01-03-2025', 'DD-MM-YYYY'), 15, 11);
-- Curs online
INSERT INTO CursOnline (id_online, platforma) VALUES (13, 'Microsoft Teams');


select * from curs;
select * from fizic;
select * from cursonline;
DELETE FROM Curs;
DELETE FROM fizic;
DELETE FROM cursonline;


--INSTRUIRE
-- Scoala 1
-- Profesori: 1 (Java), 2 (Java), 3 (C), 4 (Python, C++)
-- Cursuri: 1 (Java), 2 (Java), 3 (C), 4 (Python), 5 (C++)

-- Elevii din Scoala 1: 1, 2, 3, 4, 5
-- Elevul 1
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (8, 1, 1);  -- POO in Java
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 1, 2);  -- Java Avansat

-- Elevul 2
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 2, 4);  -- Python pentru incepatori
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (8, 2, 5);  -- Programare avansata in C++

-- Elevul 3
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 3, 5);  -- Programare avansata in C++

-- Elevul 4
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (8, 4, 3);  -- Introducere in C
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 4, 4);  -- Python pentru incepatori

-- Elevul 5
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 5, 3);  -- Introducere in C
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (8, 5, 4);  -- Python pentru incepatori
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 5, 5);  -- Programare avansata in C++

-- Scoala 2
-- Profesori: 5 (C++), 6 (Ruby)
-- Cursuri: 6 (C++), 7 (Ruby)

-- Elevii din Scoala 2: 6, 7, 8, 9, 10
-- Elevul 6
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 6, 7);  -- Ruby pentru incepatori

-- Elevul 7
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 7, 6);  -- Programare in C++

-- Elevul 8
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 8, 6);  -- Programare in C++
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 8, 7);  -- Ruby pentru incepatori

-- Elevul 9
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 9, 7);  -- Ruby pentru incepatori

-- Elevul 10
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 10, 6); -- Programare in C++

-- Scoala 3
-- Profesori: 7 (C#), 8 (C++)
-- Cursuri: 8 (C#), 9 (C++)

-- Elevii din Scoala 3: 11, 12, 13, 14, 15
-- Elevul 11
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (8, 11, 9);  -- Algoritmi in C++

-- Elevul 12
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 12, 8);  -- Programare in C#

-- Elevul 13
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (8, 13, 8);  -- Programare in C#
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 13, 9);  -- Algoritmi in C++

-- Elevul 14
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 14, 8);  -- Programare in C#
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (8, 14, 9);  -- Algoritmi in C++

-- Elevul 15
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 15, 9);  -- Algoritmi in C++

-- Scoala 4
-- Profesori: 9 (JavaScript, Python)
-- Cursuri: 10 (JavaScript), 11 (Python)

-- Elevii din Scoala 4: 16, 17, 18, 19, 20
-- Elevul 16
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 16, 11);  -- Python pentru Data Science

-- Elevul 17
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 17, 10);  -- JavaScript pentru web
-- Elevul 18
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 18, 11);  -- Python pentru Data Science

-- Elevul 19
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 19, 11);  -- Python pentru Data Science

-- Elevul 20
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 20, 10);  -- JavaScript pentru web

-- Scoala 5
-- Profesori: 10 (Python), 11 (C#)
-- Cursuri: 12 (Python), 13 (C#)

-- Elevii din Scoala 5: 21, 22, 23, 24, 25
-- Elevul 21
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 21, 12);  -- Python intermediar
-- Elevul 22
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 22, 12);  -- Python intermediar
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 22, 13);  -- Dezvoltare aplicatii in C#

-- Elevul 23
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (7, 23, 13);  -- Dezvoltare aplicatii in C#

-- Elevul 24
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 24, 12);  -- Python intermediar
-- Elevul 25
INSERT INTO Instruire (nota_elev, id_elev, id_curs) VALUES (9, 25, 13);  -- Dezvoltare aplicatii in C#

select * from instruire;

--FORMULAR

-- Inserare pentru bursa de studiu
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 5, 1);  -- Elevul 5
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 8, 1);  -- Elevul 8
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 11, 1); -- Elevul 11
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 22, 1); -- Elevul 22
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 2, 1);  -- Elevul 2
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 4, 1);  -- Elevul 4
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 13, 1); -- Elevul 13

-- Inserare pentru bursa de merit
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 6, 2); -- Elevul 6
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 9, 2); -- Elevul 9
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 1, 2); -- Elevul 1
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 14, 2); -- Elevul 14
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 15, 2); -- Elevul 15
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 16, 2); -- Elevul 16
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 19, 2); -- Elevul 19
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 21, 2); -- Elevul 21
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 24, 2); -- Elevul 24
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 25, 2); -- Elevul 25

-- Elevii selecta?i pentru burse sociale sau de handicap
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 1, 4);  -- Bursa sociala
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 2, 4);  -- Bursa sociala
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (7, 3, 5);    -- Bursa de handicap
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 4, 4);  -- Bursa sociala
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 5, 5);    -- Bursa de handicap
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 6, 4);    -- Bursa sociala
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (7, 7, 5);    -- Bursa de handicap
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (8, 8, 4);    -- Bursa sociala
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (9, 9, 5);    -- Bursa de handicap
INSERT INTO Formular (media_elev, id_elev, id_bursa) VALUES (7, 10, 4);   -- Bursa sociala



delete from formular;
select * from formular;
select * from bursa;

SELECT p.nume_profesor, p.prenume_profesor, p.salariu, d.denumire_departament, sc.denumire_scoala
FROM Profesor p
JOIN Specializare s ON s.id_profesor=p.id_profesor
JOIN Departament d ON d.id_departament=s.id_departament
JOIN Scoala sc ON d.id_scoala=sc.id_scoala
WHERE p.salariu=(
SELECT MAX(p1.salariu)
FROM Profesor p1
JOIN Specializare s1 ON p1.id_profesor=s1.id_profesor
WHERE s1.id_departament=d.id_departament
);


WITH Bursa_elev AS(
SELECT f.id_elev, COUNT(f.id_bursa) AS nr_burse
FROM Formular f
GROUP BY f.id_elev
),
MinBursa AS(
SELECT MIN(nr_burse) AS min_burse
FROM Bursa_elev
)
SELECT e.nume_elev,e.prenume_elev, b.nr_burse,f.media_elev, sc.denumire_scoala
FROM Bursa_elev b
JOIN Elev e ON e.id_elev=b.id_elev
JOIN MinBursa minb ON b.nr_burse=minb.min_burse
JOIN Formular f ON f.id_elev=b.id_elev
JOIN Scoala sc ON e.id_scoala=sc.id_scoala;

WITH Curs_de_Java AS (
    SELECT c.id_curs
    FROM Curs c
    WHERE c.denumire_curs = 'POO in Java'
),
Elevi_Java AS (
    SELECT e.id_scoala, COUNT(DISTINCT e.id_elev) AS nr_elevi_java
    FROM Instruire i
    JOIN Curs_de_Java cj ON i.id_curs = cj.id_curs
    JOIN Elev e ON i.id_elev = e.id_elev
    GROUP BY e.id_scoala
)
SELECT sc.denumire_scoala, ej.nr_elevi_java
FROM Elevi_Java ej
JOIN Scoala sc ON ej.id_scoala = sc.id_scoala
GROUP BY sc.denumire_scoala, ej.nr_elevi_java
HAVING ej.nr_elevi_java = (
    SELECT MIN(nr_elevi_java)
    FROM Elevi_Java
)
ORDER BY sc.denumire_scoala;


SELECT id_bursa,
tip,
suma,
NVL(medie_minima, 0) AS medie_minima,
DECODE(situatieSpeciala,0,'Nu',1,'Da','Necunoscut') AS siatuatieSpeciala
FROM Bursa
ORDER BY suma;



SELECT id_profesor, 
nume_profesor, 
UPPER(SUBSTR(prenume_profesor,1 ,5)) AS porecla,
data_angajare_prof,
ROUND(MONTHS_BETWEEN(SYSDATE,data_angajare_prof),0) AS experienta,
ADD_MONTHS(data_angajare_prof,12) AS aniversare,
salariu,
CASE 
   WHEN ROUND(MONTHS_BETWEEN(SYSDATE, data_angajare_prof), 0) < 6 THEN 'Incepator'
    WHEN ROUND(MONTHS_BETWEEN(SYSDATE, data_angajare_prof), 0) >= 15 THEN 'Profesionist'
        ELSE 'Mediocru'
END AS clasificare_experienta
FROM  Profesor
ORDER BY experienta;


UPDATE Coordonator
SET salariu=salariu*1.05
WHERE ROUND( MONTHS_BETWEEN(SYSDATE, data_angajare_coo),0)>=72;


DELETE FROM Certificare
WHERE  id_atestat=(
 SELECT  id_atestat FROM (
   SELECT  id_atestat FROM Certificare
GROUP BY  id_atestat
ORDER BY COUNT (id_elev) ASC
FETCH FIRST 1 ROW ONLY
 )
);

UPDATE Curs
SET inceput_curs=inceput_curs +INTERVAL '10' DAY,
final_curs=final_curs +INTERVAL '10' DAY
WHERE id_curs IN (3,4,5,7,9);


CREATE VIEW Curs_Prof_Elev AS
SELECT c.id_curs, c.denumire_curs, p.nume_profesor, p.prenume_profesor, COUNT(i.id_elev) AS numar_elevi
FROM Curs c
JOIN Profesor p ON c.id_profesor = p.id_profesor
JOIN Instruire i ON c.id_curs = i.id_curs
GROUP BY c.id_curs, c.denumire_curs, p.nume_profesor, p.prenume_profesor;


select * from Curs_Prof_Elev
WHERE numar_elevi=3;

DELETE FROM Curs_Prof_Elev
WHERE id_curs = 1;


SELECT s.id_scoala,s.denumire_scoala, c.id_coordonator,c.prenume_coordonator,p.id_profesor,p.prenume_profesor,l.id_locatie,l.tara_locatie,l.oras_locatie
FROM Scoala s
FULL OUTER JOIN Coordonator c ON s.id_scoala=c.id_scoala
FULL OUTER JOIN Profesor p ON c.id_coordonator=p.id_coordonator
FULL OUTER JOIN Locatie l ON l.id_scoala=s.id_scoala;



SELECT e.id_elev, e.nume_elev, e.prenume_elev
FROM Elev e
WHERE NOT EXISTS (
    SELECT c.id_curs
    FROM Curs c
    WHERE NOT EXISTS (
        SELECT i.id_curs
        FROM Instruire i
        WHERE i.id_elev = e.id_elev
        AND i.id_curs = c.id_curs
    )
);

WITH TopCoo AS(
SELECT c.id_coordonator, c.nume_coordonator, c.prenume_coordonator, c.salariu, c.id_scoala,
ROW_NUMBER() OVER (ORDER BY c.salariu DESC) AS top
FROM Coordonator c
)
SELECT  id_coordonator,nume_coordonator,prenume_coordonator, salariu, id_scoala
FROM TopCoo WHERE top<=3 ORDER BY top;
