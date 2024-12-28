CREATE DATABASE NOGOMYA1;

USE NOGOMYA1;

CREATE TABLE STUDENT
(
	StudentID VARCHAR(13) PRIMARY KEY NOT NULL,
	SName VARCHAR(25) NOT NULL,
	SAddress VARCHAR(40) NOT NULL,
	Phone VARCHAR(13) NOT NULL,
	CourseID VARCHAR(13) NOT NULL,
	FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
);

CREATE TABLE COURSE
(
	CourseID VARCHAR(13) PRIMARY KEY NOT NULL,
	CName VARCHAR(25) NOT NULL,
	Price FLOAT NOT NULL
)

INSERT INTO STUDENT VALUES
('1XK293','NEGM','Cairo','01089540778','uCPP9M'),
('1XK294','MEGO','Cairo','01164549778','uPY9M')

INSERT INTO COURSE VALUES
('uCPP9M','C++',1999.999),
('uPY9M','Python',999.999)

SELECT
	*
FROM
	STUDENT

SELECT
	*
FROM
	COURSE

SELECT
	*
FROM
	STUDENT S
INNER JOIN
	COURSE C
ON
	C.CourseID = S.CourseID



CREATE PROCEDURE GETNAME(@Name VARCHAR(25))
AS
BEGIN
	SELECT
		*
	FROM
		STUDENT
	WHERE
		SName = @Name;
END;

EXEC GETNAME 'NEGM'

MERGE INTO 
	STUDENT
USING
	COURSE
ON
	COURSE.CourseID = STUDENT.CourseID
WHEN NOT MATCHED BY SOURCE
THEN DELETE;

CREATE VIEW V1
AS
	SELECT
		*
	FROM
		COURSE;

SELECT
	*
FROM
	V1