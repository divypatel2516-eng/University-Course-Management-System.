University Course Management System
About
This is a small MySQL project for managing university students, courses, instructors, departments and enrollments. It is made for SQL practice and includes the queries given in the project task.
Files
- university_course_management.sql — creates the database, adds sample data and runs the required SQL examples.
How to run
1. Open MySQL Workbench.
2. Open university_course_management.sql.
3. Run the file from the top.
4. Check the result grid after each SELECT query.
The script uses MySQL 8.0 or later because it includes a window function.
Tables
- Students — student details and university enrollment date.
- Departments — department names.
- Instructors — instructor details and salary.
- Courses — course name, department, credits and instructor.
- Enrollments — connects students with courses.
What is covered
- CRUD: INSERT, SELECT, UPDATE and DELETE
- Filtering, sorting and LIMIT
- Aggregate functions: COUNT, AVG and MAX
- GROUP BY and HAVING
- INNER JOIN and LEFT JOIN
- Subqueries
- Date functions: YEAR and TIMESTAMPDIFF
- String function: CONCAT
- Window function: COUNT() OVER
- CASE expression
Assumptions
1. The task asks for instructor salary, so a Salary column is included in the Instructors table.
2. An InstructorID column is included in Courses to connect each course to an instructor.
3. The sample data has enough enrollments to test the queries for courses with more than 5 and more than 10 students.
4. The CRUD examples use temporary test records inside a transaction and finish with ROLLBACK, so the sample data stays unchanged.
5. The Senior/Junior label uses the student's EnrollmentDate. A student is labelled Senior when more than 4 full years have passed; otherwise the label is Junior.
