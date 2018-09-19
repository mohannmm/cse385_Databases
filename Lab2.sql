USE master
GO

/****** Object:  Database UniversitySystem     ******/
IF DB_ID('UniversitySystem') IS NOT NULL
	DROP DATABASE UniversitySystem
GO

CREATE DATABASE UniversitySystem
GO 

USE UniversitySystem
GO
--------------------------------------------------------

CREATE TABLE Universities (
	UniversityID	INT				NOT NULL	PRIMARY KEY		IDENTITY,
	UniversityName	VARCHAR(50)		NOT NULL	DEFAULT(''),	
)
GO

CREATE TABLE Schools (
	SchoolID		INT				NOT NULL	PRIMARY KEY		IDENTITY,
	UniversityID	INT				NOT NULL	FOREIGN KEY REFERENCES Universities(universityId),
	SchoolName		VARCHAR(50)		NOT NULL	DEFAULT('')		
)
GO

CREATE TABLE Courses (
	CourseID		INT				NOT NULL	PRIMARY KEY		IDENTITY,
	SchoolID		INT				NOT NULL	FOREIGN KEY REFERENCES Schools(SchoolID),
	CourseName		VARCHAR(50)		NOT NULL	DEFAULT('')
)
GO

CREATE TABLE CourseSections (
	CourseSectionID INT				NOT NULL	PRIMARY KEY		IDENTITY,
	CourseID		INT				NOT NULL	FOREIGN KEY REFERENCES Courses(CourseID),
	SectionName		CHAR(1)			NOT NULL	DEFAULT(''),
	Description		VARCHAR(100)	NOT NULL	DEFAULT('')
)
GO

CREATE TABLE Assignments (
	AssignmentID	INT				NOT NULL	PRIMARY KEY		IDENTITY,
	CourseSectionID	INT				NOT NULL	FOREIGN KEY REFERENCES CourseSections(CourseSectionID),
	AssignmentName	VARCHAR(50)		NOT NULL	DEFAULT('')	
)
GO

--------------------------------------------------------
CREATE TABLE Instructors (
	InstructorID	INT				NOT NULL	PRIMARY KEY		IDENTITY,
	UniveristyID	INT				NOT NULL	FOREIGN KEY REFERENCES Universities(UniversityID),
	InstructorName	VARCHAR(50)		NOT NULL	DEFAULT('')
)
GO


CREATE TABLE Students (
	StudentID		INT				NOT NULL	PRIMARY KEY		IDENTITY,
	UniversityID	INT				NOT NULL	FOREIGN KEY REFERENCES Universities(UniversityID),
	StudentName		VARCHAR(50)		NOT NULL	DEFAULT('')
)
GO

--------------------------------------------------------
CREATE Table InstructorCourseSections (
	InstructorID	INT		FOREIGN KEY REFERENCES Instructors(InstructorID),
	CourseSectionID	INT		FOREIGN KEY REFERENCES CourseSections(CourseSectionID),
	PRIMARY KEY (InstructorID, CourseSectionID),
	isPrimaryInstructor		BIT		NOT NULL	DEFAULT(0)
)
GO

CREATE Table StudentCourseSections (
	StudentID		INT		FOREIGN KEY REFERENCES Students(StudentID),
	CourseSectionID	INT		FOREIGN KEY REFERENCES CourseSections(CourseSectionID),
	PRIMARY KEY (StudentID, CourseSectionID),
)
GO

CREATE TABLE StudentAssignmentGrades(
	StudentID		INT		FOREIGN KEY REFERENCES Students(StudentID),
	AssignmentID	INT		FOREIGN KEY REFERENCES Assignments(AssignmentID),
	CourseSectionID	INT		FOREIGN KEY REFERENCES CourseSections(CourseSectionID),
	AssignmentGrade FLOAT		NOT NULL	DEFAULT(0),
	PRIMARY KEY (StudentID, AssignmentID, CourseSectionID)
)
GO

--------------------------------------------------------
SET IDENTITY_INSERT Universities ON 
INSERT INTO Universities (UniversityID, UniversityName) VALUES (1, 'Hiroshima University');
INSERT INTO Universities (UniversityID, UniversityName) VALUES (2, 'Misan University');
SET IDENTITY_INSERT Universities OFF
GO

SET IDENTITY_INSERT Schools ON 
insert into Schools (SchoolID, UniversityID, SchoolName) values (1, 1, 'Business Development');
insert into Schools (SchoolID, UniversityID, SchoolName) values (2, 2, 'Business Development');
insert into Schools (SchoolID, UniversityID, SchoolName) values (3, 1, 'Engineering');
insert into Schools (SchoolID, UniversityID, SchoolName) values (4, 2, 'Engineering');
SET IDENTITY_INSERT Schools OFF
GO

SET IDENTITY_INSERT Courses ON 
insert into Courses (CourseID, SchoolID, CourseName) values (1, 1, 'Managemnet strategies');
insert into Courses (CourseID, SchoolID, CourseName) values (2, 1, 'Owning a Business');
insert into Courses (CourseID, SchoolID, CourseName) values (3, 2, 'Managemnet strategies');
insert into Courses (CourseID, SchoolID, CourseName) values (4, 2, 'Owning a Business');
insert into Courses (CourseID, SchoolID, CourseName) values (5, 3, 'Programming in Java');
insert into Courses (CourseID, SchoolID, CourseName) values (6, 3, 'Calculus');
insert into Courses (CourseID, SchoolID, CourseName) values (7, 4, 'Programming in Java');
insert into Courses (CourseID, SchoolID, CourseName) values (8, 4, 'Calculus');
SET IDENTITY_INSERT Courses OFF
GO


SET IDENTITY_INSERT CourseSections ON 
insert into CourseSections (CourseSectionID, CourseID, SectionName, Description) values (1, 1, 'A', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.');
insert into CourseSections (CourseSectionID, CourseID, SectionName, Description) values (2, 1, 'B', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.');
insert into CourseSections (CourseSectionID, CourseID, SectionName, Description) values (3, 2, 'A', 'Aenean lectus. Pellentesque eget nunc.');
insert into CourseSections (CourseSectionID, CourseID, SectionName, Description) values (4, 2, 'B', 'Aenean lectus. Pellentesque eget nunc.');
insert into CourseSections (CourseSectionID, CourseID, SectionName, Description) values (5, 3, 'A', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into CourseSections (CourseSectionID, CourseID, SectionName, Description) values (6, 3, 'B', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into CourseSections (CourseSectionID, CourseID, SectionName, Description) values (7, 4, 'A', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into CourseSections (CourseSectionID, CourseID, SectionName, Description) values (8, 4, 'B', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
SET IDENTITY_INSERT CourseSections OFF
GO

SET IDENTITY_INSERT Assignments ON 
insert into Assignments (AssignmentID, CourseSectionID, AssignmentName) values (1, 1, 'Assign1');
insert into Assignments (AssignmentID, CourseSectionID, AssignmentName) values (2, 2, 'Assign1');
insert into Assignments (AssignmentID, CourseSectionID, AssignmentName) values (3, 3, 'Assign1');
insert into Assignments (AssignmentID, CourseSectionID, AssignmentName) values (4, 4, 'Assign1');
insert into Assignments (AssignmentID, CourseSectionID, AssignmentName) values (5, 5, 'Assign1');
insert into Assignments (AssignmentID, CourseSectionID, AssignmentName) values (6, 6, 'Assign1');
insert into Assignments (AssignmentID, CourseSectionID, AssignmentName) values (7, 7, 'Assign1');
insert into Assignments (AssignmentID, CourseSectionID, AssignmentName) values (8, 8, 'Assign1');
SET IDENTITY_INSERT Assignments OFF
GO

SET IDENTITY_INSERT Students ON 
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (1, 'Brandice Simeone', 2);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (2, 'Zilvia Shilston', 2);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (3, 'Yetta Jovanovic', 1);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (4, 'Chad Cremen', 1);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (5, 'Lucien Giacopini', 2);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (6, 'Zita Grimwade', 2);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (7, 'Fredi Mulligan', 2);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (8, 'Thomas Brando', 2);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (9, 'Anson Gilbeart', 2);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (10, 'Aldwin Dugall', 1);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (11, 'Shana Devey', 2);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (12, 'Gerti Treverton', 2);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (13, 'Billye Frankiewicz', 1);
insert into StudentAssignmentGrades (StudentID, StudentName, UniversityID) values (14, 'Alfons Dakhno', 1);
SET IDENTITY_INSERT Students OFF
GO

SET IDENTITY_INSERT StudentCourseSections ON 
insert into StudentCourseSections (StudentID, CourseSectionID) values (9, 3);
insert into StudentCourseSections (StudentID, CourseSectionID) values (10, 5);
insert into StudentCourseSections (StudentID, CourseSectionID) values (2, 8);
insert into StudentCourseSections (StudentID, CourseSectionID) values (11, 3);
insert into StudentCourseSections (StudentID, CourseSectionID) values (13, 7);
insert into StudentCourseSections (StudentID, CourseSectionID) values (8, 2);
insert into StudentCourseSections (StudentID, CourseSectionID) values (3, 2);
insert into StudentCourseSections (StudentID, CourseSectionID) values (8, 8);
insert into StudentCourseSections (StudentID, CourseSectionID) values (1, 6);
insert into StudentCourseSections (StudentID, CourseSectionID) values (2, 2);
insert into StudentCourseSections (StudentID, CourseSectionID) values (14, 2);
insert into StudentCourseSections (StudentID, CourseSectionID) values (13, 3);
insert into StudentCourseSections (StudentID, CourseSectionID) values (14, 7);
insert into StudentCourseSections (StudentID, CourseSectionID) values (6, 1);
SET IDENTITY_INSERT StudentCourseSections OFF
GO

SET IDENTITY_INSERT StudentAssignmentGrades ON 
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (9, 3, 91);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (10, 5, 69);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (2, 8, 88.5);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (11, 3, 55,7);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (13, 7, 100);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (8, 2, 88.9);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (3, 2, 88.9);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (8, 8, 78);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (1, 6, 99.3);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (2, 2, 56.8);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (14, 2, 70.8);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (13, 3,69);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (14, 7,88.1);
insert into StudentAssignmentGrades (StudentID, CourseSectionID, Grade) values (6, 1, 81.2);
SET IDENTITY_INSERT StudentAssignmentGrades OFF
GO

SET IDENTITY_INSERT Instructors ON 
insert into Instructors (InstructorID, UniversityID, InstructorName) values (1, 1, 'Theadora Renahan');
insert into Instructors (InstructorID, UniversityID, InstructorName) values (2, 2, 'Ruperta Llewhellin');
insert into Instructors (InstructorID, UniversityID, InstructorName) values (3, 2, 'Shell Martensen');
insert into Instructors (InstructorID, UniversityID, InstructorName) values (4, 1, 'Ara Lorence');
insert into Instructors (InstructorID, UniversityID, InstructorName) values (5, 1, 'Tierney Orange');
insert into Instructors (InstructorID, UniversityID, InstructorName) values (6, 2, 'Druci Deetlefs');
SET IDENTITY_INSERT Instructors OFF
GO

SET IDENTITY_INSERT InstructorCourseSections ON 
insert into InstructorCourseSections (InstructorID, CourseSectionID, isPrimaryInstructor) values (1, 1, 1);
insert into InstructorCourseSections (InstructorID, CourseSectionID, isPrimaryInstructor) values (2, 2, 1);
insert into InstructorCourseSections (InstructorID, CourseSectionID, isPrimaryInstructor) values (3, 3, 1);
insert into InstructorCourseSections (InstructorID, CourseSectionID, isPrimaryInstructor) values (4, 4, 1);
insert into InstructorCourseSections (InstructorID, CourseSectionID, isPrimaryInstructor) values (5, 5, 1);
insert into InstructorCourseSections (InstructorID, CourseSectionID, isPrimaryInstructor) values (5, 6, 1);
insert into InstructorCourseSections (InstructorID, CourseSectionID, isPrimaryInstructor) values (6, 7, 1);
insert into InstructorCourseSections (InstructorID, CourseSectionID, isPrimaryInstructor) values (6, 8, 1);
insert into InstructorCourseSections (InstructorID, CourseSectionID, isPrimaryInstructor) values (1, 8, 0);
insert into InstructorCourseSections (InstructorID, CourseSectionID, isPrimaryInstructor) values (2, 8, 0);
SET IDENTITY_INSERT InstructorCourseSections OFF
GO

--------------------------------------------------------

--All the students from University 1 (Hiroshima)
SELECT StudentName
FROM Students
WHERE (UniversityID = 1)

SELECT *
From Schools
Where SchoolName = 'Engineering'