-- University Course Management System

CREATE DATABASE IF NOT EXISTS UniversityDB;
USE UniversityDB;

-- Remove old tables so the file can be run again
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Instructors;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Create tables
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    BirthDate DATE,
    EnrollmentDate DATE
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(80) NOT NULL,
    DepartmentID INT,
    Credits INT,
    InstructorID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 2. Add sample data
INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

INSERT INTO Students VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-04-12', '2021-06-10'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-08-20', '2022-07-15'),
(3, 'Aarav', 'Patel', 'aarav.patel@email.com', '2003-01-11', '2023-06-12'),
(4, 'Diya', 'Shah', 'diya.shah@email.com', '2002-05-25', '2023-06-15'),
(5, 'Rohan', 'Mehta', 'rohan.mehta@email.com', '2001-11-02', '2024-06-10'),
(6, 'Sara', 'Desai', 'sara.desai@email.com', '2003-09-19', '2024-06-18'),
(7, 'Karan', 'Joshi', 'karan.joshi@email.com', '2002-02-08', '2025-06-10'),
(8, 'Mira', 'Trivedi', 'mira.trivedi@email.com', '2004-03-14', '2025-06-12'),
(9, 'Dev', 'Parikh', 'dev.parikh@email.com', '2001-12-30', '2021-06-12'),
(10, 'Isha', 'Rao', 'isha.rao@email.com', '2003-07-07', '2022-06-11'),
(11, 'Neil', 'Kapoor', 'neil.kapoor@email.com', '2002-10-16', '2023-06-20'),
(12, 'Tara', 'Verma', 'tara.verma@email.com', '2004-06-05', '2024-06-22');

INSERT INTO Instructors VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 65000.00),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 58000.00),
(3, 'Nina', 'Shah', 'nina.shah@univ.com', 1, 72000.00);

INSERT INTO Courses VALUES
(101, 'Introduction to SQL', 1, 3, 1),
(102, 'Data Structures', 2, 4, 2),
(103, 'Python Basics', 1, 3, 3);

-- 12 students take Introduction to SQL.
INSERT INTO Enrollments VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 101, '2022-08-05'),
(3, 3, 101, '2023-08-01'),
(4, 4, 101, '2023-08-03'),
(5, 5, 101, '2024-08-01'),
(6, 6, 101, '2024-08-04'),
(7, 7, 101, '2025-08-01'),
(8, 8, 101, '2025-08-02'),
(9, 9, 101, '2021-08-01'),
(10, 10, 101, '2022-08-02'),
(11, 11, 101, '2023-08-02'),
(12, 12, 101, '2024-08-03'),
(13, 1, 102, '2022-08-10'),
(14, 2, 102, '2022-08-11'),
(15, 3, 102, '2023-08-10'),
(16, 4, 102, '2023-08-12'),
(17, 5, 102, '2024-08-10'),
(18, 6, 102, '2024-08-12'),
(19, 1, 103, '2023-01-10'),
(20, 7, 103, '2025-01-10');

-- 3. CRUD practice on all tables

START TRANSACTION;

INSERT INTO Departments VALUES (99, 'Test Department');
INSERT INTO Students VALUES
(99, 'Test', 'Student', 'test.student@email.com', '2004-01-01', '2025-06-01');
INSERT INTO Instructors VALUES
(99, 'Test', 'Teacher', 'test.teacher@univ.com', 99, 40000.00);
INSERT INTO Courses VALUES (199, 'Test Course', 99, 2, 99);
INSERT INTO Enrollments VALUES (999, 99, 199, '2025-08-01');

-- READ: view records from all tables
SELECT * FROM Departments;
SELECT * FROM Students;
SELECT * FROM Instructors;
SELECT * FROM Courses;
SELECT * FROM Enrollments;

-- UPDATE: change a test record in each table
UPDATE Departments SET DepartmentName = 'Updated Department' WHERE DepartmentID = 99;
UPDATE Students SET LastName = 'Updated' WHERE StudentID = 99;
UPDATE Instructors SET Salary = 42000 WHERE InstructorID = 99;
UPDATE Courses SET Credits = 3 WHERE CourseID = 199;
UPDATE Enrollments SET EnrollmentDate = '2025-09-01' WHERE EnrollmentID = 999;

-- DELETE: remove the test records in child-to-parent order
DELETE FROM Enrollments WHERE EnrollmentID = 999;
DELETE FROM Courses WHERE CourseID = 199;
DELETE FROM Instructors WHERE InstructorID = 99;
DELETE FROM Students WHERE StudentID = 99;
DELETE FROM Departments WHERE DepartmentID = 99;

ROLLBACK;

-- 4. Queries from the project

--1. Students who enrolled after 2022
SELECT *
FROM Students
WHERE EnrollmentDate >= '2023-01-01';

-- 2. Courses in the Mathematics department (maximum 5)
SELECT c.CourseID, c.CourseName, c.Credits
FROM Courses c
JOIN Departments d ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;

-- 3. Number of students in each course; show courses with more than 5
SELECT c.CourseName, COUNT(DISTINCT e.StudentID) AS TotalStudents
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(DISTINCT e.StudentID) > 5;

-- 4. Students enrolled in both SQL and Data Structures
SELECT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(DISTINCT c.CourseName) = 2;

-- 5. Students enrolled in either SQL or Data Structures
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures');

-- 6. Average course credits
SELECT AVG(Credits) AS AverageCredits
FROM Courses;

-- 7. Highest instructor salary in Computer Science
SELECT MAX(i.Salary) AS HighestSalary
FROM Instructors i
JOIN Departments d ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';

-- 8. Number of students enrolled in courses in each department
SELECT d.DepartmentName, COUNT(DISTINCT e.StudentID) AS TotalStudents
FROM Departments d
LEFT JOIN Courses c ON d.DepartmentID = c.DepartmentID
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY d.DepartmentID, d.DepartmentName;

-- 9. INNER JOIN: students and their courses
SELECT s.FirstName, s.LastName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

-- 10. LEFT JOIN: all students, including students without a course
SELECT s.FirstName, s.LastName, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;

-- 11. Subquery: students in courses with more than 10 students
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(DISTINCT StudentID) > 10
);

-- 12. Get the year of each student's enrollment
SELECT FirstName, LastName, YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;

-- 13. Join instructor first and last name together
SELECT CONCAT(FirstName, ' ', LastName) AS InstructorName
FROM Instructors;

-- 14. Running total of course enrollments by date
SELECT EnrollmentID, CourseID, EnrollmentDate,
       COUNT(*) OVER (
           ORDER BY EnrollmentDate, EnrollmentID
       ) AS RunningTotal
FROM Enrollments;

-- 15. Label students Senior or Junior based on years since enrollment
SELECT FirstName, LastName, EnrollmentDate,
       CASE
           WHEN TIMESTAMPDIFF(YEAR, EnrollmentDate, CURDATE()) > 4 THEN 'Senior'
           ELSE 'Junior'
       END AS StudentLevel
FROM Students;
