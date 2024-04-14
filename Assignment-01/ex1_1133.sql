SET ECHO ON;
SET PAUSE ON;
SET LINESIZE 150;

REM: Dropping Existing Tables

	drop table sungby;
	drop table artist;
	drop table song;
	drop table album;
	drop table musician;
	drop table studio;

REM: --------------------------------------------------------------------

REM: Creating Musician Table

	CREATE TABLE Musician(
	M_ID varchar2(4),
	Name varchar2(40) CONSTRAINT musc_name_not_null NOT NULL,
	BirthPlace varchar2(25),
	CONSTRAINT musc_pk PRIMARY KEY(M_ID)
	);

	DESC Musician

REM: --------------------------------------------------------------------

REM: Inserting into Musician Table:
	
	INSERT INTO Musician VALUES('M01','Niel','Chennai');

REM: Error due to NULL name:
	INSERT INTO Musician Values('MO2','','Dehradun');

REM: Error due to same primary key:
	INSERT INTO Musician VALUES('M01','Test','Bangalore');

REM: Inserting valid records: 
	INSERT INTO Musician VALUES('M02','Tom','Banglaore');
	INSERT INTO Musician VALUES('M03','Anotny','Delhi');
	INSERT INTO Musician VALUES('M04','Kumar','Madurai');
	INSERT INTO Musician VALUES('M05','Raj','Hyderabad');

REM: Contents of Musician Table
	
	SELECT * FROM Musician;

REM: --------------------------------------------------------------------

REM: Creating Studio Table

	CREATE TABLE Studio(
	Studio_Name varchar2(20),
	Address varchar2(50),
	Phone Number(10),
	CONSTRAINT studio_pk PRIMARY KEY(Studio_Name)
	);

	DESC Studio

REM: Inserting into Studio Table;
	INSERT INTO Studio VALUES('U2 Studios','#1, 7th Main Road,Chennai',9988776655);
	

REM: Error due to same PRIMARY KEY
	INSERT INTO Studio VALUES('U2 Studios','#2 Anna Nagar',9940043090);

REM: Inserting Valid Records
	INSERT INTO Studio VALUES('ARM Studios','#1, 7th Main Road,Chennai',9980776655);
	INSERT INTO Studio VALUES('Matthew Records','#13, 8th Cross Road,Chennai',8899776655);
	INSERT INTO Studio VALUES('Precision Studios','#21, 10th Main Road,Chennai',7799886655);
	INSERT INTO Studio VALUES('Sound Lab','#15, 12th Cross Road,Chennai',6699887755);

REM: Contents of Studio Table
	SELECT * FROM Studio;

REM: --------------------------------------------------------------------

REM: Creating Album Table

	CREATE TABLE Album(
	Album_Name varchar2(25),
	Album_ID varchar2(4),
	Year Number(4),
	No_Tracks Number(3),
	Studio_Name varchar2(20),
	Genre varchar2(10),
	M_ID varchar2(4),
	CONSTRAINT album_chk_genre CHECK(Genre IN ('CAR', 'DIV', 'MOV', 'POP')),
	CONSTRAINT album_chk_year CHECK(Year > 1954),
	CONSTRAINT album_pk PRIMARY KEY(Album_ID),
	CONSTRAINT album_fk FOREIGN KEY(Studio_Name) REFERENCES Studio(Studio_Name),
	CONSTRAINT album_fk_mus FOREIGN KEY(M_ID) REFERENCES Musician(M_ID)
	);

	DESC Album

REM:  Inserting into Album Table

	INSERT INTO Album VALUES('Darbar','ALB1',2019,5,'ARM Studios','CAR','M01');

REM: Foreign Key Constraint Error(No such studio)
	INSERT INTO Album VALUES('Test','ALB2',2019,4,'XYZ Studios','CAR','M01');

REM: Foreign Key Constraint Error(No such Musician)
	INSERT INTO Album VALUES('Test','ALB2',2018,5,'ARM Studios','MOV','M100');

REM: Checking Year of Release
	INSERT INTO Album VALUES('Test','ALB3',1940,5,'ARM Studios','DIV','M01');

REM: Checking Genre 
	INSERT INTO Album VALUES('Test','ALB4',2019,5,'ARM Studios','ELE','M01');

REM: Inserting Valid Values
	INSERT INTO Album VALUES('Psycho','ALB2',2019,5,'ARM Studios','CAR','M01');
	INSERT INTO Album VALUES('1986','ALB3',2018,3,'Matthew Records','DIV','M02');
	INSERT INTO Album VALUES('Advent','ALB4',2020,8,'Sound Lab','MOV','M02');

REM: Contents of Album Table
	SELECT * FROM Album;


REM: --------------------------------------------------------------------

REM: Creating Song Table

	CREATE TABLE Song(
	Album_ID varchar2(4),
	Track_No Number(3),
	Song_Name varchar2(30) CONSTRAINT song_name_not_null NOT NULL,
	Length varchar2(10),
	Genre varchar2(10),
	CONSTRAINT song_chk_genre CHECK(Genre IN ('PHI', 'REL', 'LOV', 'PAT')),
	CONSTRAINT song_chk_len CHECK((Genre = 'PAT' and Length > 7) or Genre != 'PAT'),
	CONSTRAINT song_pk PRIMARY KEY(Album_ID,Track_No),
	CONSTRAINT song_fk FOREIGN KEY(Album_ID) REFERENCES Album(Album_ID)
	);

	DESC Song

REM: Inserting into Song Table
	INSERT INTO Song VALUES('ALB1',1,'First Track',8,'PHI');

REM: Checking genre
	INSERT INTO Song VALUES('ALB2',2,'First Track - Reprise',8,'ROCK');

REM: Checking Len for PAT songs
	INSERT INTO Song VALUES('ALB2',1,'Nation First',6,'PAT');

REM: Inserting Valid Values
	INSERT INTO Song VALUES('ALB2',1,'Nirvana',8,'PHI');
	INSERT INTO Song VALUES('ALB2',2,'Hello',3,'REL');
	INSERT INTO Song VALUES('ALB4',1,'Roses',5,'LOV');

REM: Contents of Song Table
	SELECT * FROM song;

REM: --------------------------------------------------------------------

REM: Creating Artist Table

	CREATE TABLE Artist(
	Artist_ID varchar2(4),
	Artist_Name varchar2(25),
	CONSTRAINT artist_pk PRIMARY KEY(Artist_ID),
	CONSTRAINT artist_name_uniq UNIQUE(Artist_Name)
	);

	DESC ARTIST


REM: Inserting into Artist Table

	INSERT INTO Artist VALUES('A01','Sid Sriram');

REM: Checking unique artist name
	INSERT INTO Artist VALUES('A02','Sid Sriram');

REM: Inserting valid records:
	INSERT INTO Artist VALUES('A02','Joseph');
	INSERT INTO Artist VALUES('A03','Ani');
	INSERT INTO Artist VALUES('A04','Stephen');

REM: Contents of Artist

	SELECT * FROM Artist;



REM: --------------------------------------------------------------------

REM: Creating SungBy Table

	CREATE TABLE SungBy(
	Album_ID varchar2(4),
	Track_No Number(3),
	Artist_ID varchar2(4),
	R_Date Date,
	CONSTRAINT sungby_pk PRIMARY KEY(Album_ID,Track_No,Artist_ID),
	CONSTRAINT sungby_fk FOREIGN KEY(Album_ID,Track_No) REFERENCES Song(Album_ID,Track_No),
 	CONSTRAINT sungby_fk2 FOREIGN KEY(Artist_ID) REFERENCES Artist(Artist_ID)
	);

	DESC SungBy

REM: Inserting into SungBy table
	INSERT INTO SungBy VALUES('ALB1',1,'A01','05Jan2019');

REM: Checking Foreign Key Constraint
	INSERT INTO SungBy VALUES('ALB1',2,'A01','05Mar2018');

REM: Inserting valid records
	INSERT INTO SungBy VALUES('ALB2',1,'A01','05Jan2019');
	INSERT INTO SungBy VALUES('ALB2',2,'A02','17Jul2018');
	INSERT INTO SungBy VALUES('ALB4',1,'A04','23Aug2017');

REM: Contents of SungBy Table
	SELECT * FROM SungBy;

REM: --------------------------------------------------------------------
		
REM: Adding Attribute Gender to Artist Table

	ALTER TABLE Artist ADD gender varchar2(1);

REM: Checking the schema
	
	DESC Artist;

REM: Adding New Record Into Artist Table

	INSERT INTO Artist VALUES('A05','Ashwin','M');

REM: Contents of Artist

	SELECT * FROM Artist;

REM: --------------------------------------------------------------------

REM: Adding Phone Number Constraint to Studio table

	ALTER TABLE Studio ADD CONSTRAINT chk_ph_uniq UNIQUE(Phone);

REM: Checking Phone number Constraint

	INSERT INTO Studio VALUES('Sound Eng Lab','#42, 14th Main Road,Chennai',6699887755);

REM: Adding Valid Record
	
	INSERT INTO Studio VALUES('Sound Eng Lab','#42, 14th Main Road,Chennai',6898887755);

REM: Contents of Studio

	SELECT * FROM Studio;

REM: --------------------------------------------------------------------

REM: Adding R_Date[Recording Date] NOT NULL constraint to SungBy Table

	ALTER TABLE SungBy MODIFY R_Date CONSTRAINT r_date_not_null NOT NULL;

REM: Checking  R_Date NOT NULL Constraint
	
	INSERT INTO SungBy VALUES('ALB2',1,'A01','');		

REM: Adding Valid Record into SungBy

	INSERT INTO SungBy VALUES('ALB2',1,'A02','05Jan2019');

REM: Contents of SungBy
	
	SELECT * FROM SungBy;

REM: --------------------------------------------------------------------

REM: Adding NAT Genre to song table
REM: Dropping Existing Constraint

	ALTER TABLE Song DROP CONSTRAINT song_chk_genre;

REM: Adding Modified CONSTRAINT

	ALTER TABLE Song ADD CONSTRAINT song_chk_genre CHECK(Genre IN('PHI', 'REL', 'LOV', 'PAT','NAT'));

REM: Checking Genre Constraint

	INSERT INTO Song VALUES('ALB4',2,'Memories',5,'SAD');

REM: Adding Valid Record

	INSERT INTO Song VALUES('ALB4',2,'Memories',5,'NAT');

REM: Contents of Song 

	SELECT * FROM Song;

REM: --------------------------------------------------------------------

REM: Adding Constraint to delete all corresponding records when Song record is deleted
REM: Before Adding the constraint..

	DELETE FROM Song WHERE Album_ID = 'ALB1';

REM: Adding Cascade Constraint

	ALTER TABLE SungBy DROP CONSTRAINT sungby_fk;
	ALTER TABLE SungBy ADD CONSTRAINT sungby_fk FOREIGN KEY(Album_ID,Track_No) REFERENCES Song(Album_ID,Track_No) ON DELETE CASCADE;
 	
REM: Song Table Before Deletion
	
	SELECT * FROM Song;

REM: Deleting A Record
	
	DELETE FROM Song WHERE Album_ID='ALB1';

REM: Song Table After Deleting

	SELECT * FROM Song;


REM: --------------------------------------------------------------------;