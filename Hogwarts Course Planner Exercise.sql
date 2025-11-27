DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;

CREATE TABLE Student(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL
);

CREATE TABLE Course(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Enrollment(
    StudentId INT,
    CourseId INT,
    PRIMARY KEY (StudentId, CourseId),
    FOREIGN KEY (StudentId) REFERENCES Student(Id),
    FOREIGN KEY (CourseId) REFERENCES Course(Id)
);
-- Studenter
INSERT INTO Student (Name) VALUES 
('Harry Potter'),
('Hermione Granger'),
('Ron Weasley'),
('Draco Malfoy'),
('Luna Lovegood');

-- Kurser
INSERT INTO Course (Name) VALUES 
('Försvar mot svartkonster'),
('Trollformler'),
('Husets historia');

-- Registreringar (Enrollment)
INSERT INTO Enrollment (StudentId, CourseId) VALUES
(1, 1), 
(1, 2), 
(2, 1), 
(2, 2), 
(3, 2), 
(4, 1); 

--tabellen som visar alla studenter med deras kurser
SELECT s.Name AS Student, c.Name AS Course
FROM Student s
LEFT JOIN Enrollment e ON s.Id = e.StudentId
LEFT JOIN Course c ON e.CourseId = c.Id
ORDER BY s.Name;

--tabellen som visar fulla kurser. varje kurs ska ha max 3 studenter
SELECT c.Name AS Course, COUNT(e.StudentId) AS StudentCount
FROM Course c
JOIN Enrollment e ON c.Id = e.CourseId
GROUP BY c.Name
HAVING COUNT(e.StudentId) >= 3;

--studenter utan vald kurs
SELECT s.Name
FROM Student s
LEFT JOIN Enrollment e ON s.Id = e.StudentId
WHERE e.CourseId IS NULL;

--kurser som ingen har valt
SELECT c.Name
FROM Course c
LEFT JOIN Enrollment e ON c.Id = e.CourseId
WHERE e.StudentId IS NULL;

--tabel på tre mest populära kurser AKA alla kurser
SELECT TOP 3 c.Name, COUNT(e.StudentId) AS EnrollmentCount
FROM Course c
LEFT JOIN Enrollment e ON c.Id = e.CourseId
GROUP BY c.Name
ORDER BY COUNT(e.StudentId) DESC;

