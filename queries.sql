-- QUERIES 
-- 1 Print the names of professors who work in departments that have fewer than 50 PhD students.
SELECT prof.pname
FROM prof
JOIN dept ON prof.dname = dept.dname
WHERE dept.numphds < 50;


-- 2 Print the names of the students with the lowest GPA.
SELECT sname 
FROM student 
ORDER BY gpa ASC
LIMIT 10;

SELECT sname
FROM student
WHERE gpa = (SELECT MIN(gpa) FROM student);


-- 3 For each Computer Sciences class, print the class number, section number, and the average gpa of the students enrolled in the class section.
SELECT e.cno, e.sectno, AVG(s.gpa) AS avg_gpa
FROM enroll e
JOIN student s ON e.sid = s.sid
WHERE e.dname = 'Computer Sciences'
GROUP BY e.cno, e.sectno;


-- 4 Print the names and section numbers of all sections with more than six students enrolled in them.


-- 5 Print the name(s) and sid(s) of the student(s) enrolled in the most sections.
SELECT s.sid, s.sname, COUNT(e.sid) AS num_sections
FROM enroll e
JOIN student s ON e.sid = s.sid
GROUP BY s.sid, s.sname
ORDER BY num_sections DESC
LIMIT 10;


-- 6 Print the names of departments that have one or more majors who are under 18 years old.
SELECT DISTINCT d.dname
FROM dept d
JOIN major m ON d.dname = m.dname
JOIN student s ON m.sid = s.sid
WHERE s.age < 18;


-- 7 Print the names and majors of students who are taking one of the College Geometry courses.


-- 8 For those departments that have no major taking a College Geometry course print the department name and the number of PhD students in the department. 
SELECT d.dname, d.numphds
FROM dept d
JOIN major m ON d.dname = m.dname
JOIN student s ON m.sid = s.sid
JOIN enroll e ON s.sid = e.sid
JOIN course c ON e.cno = c.cno AND e.dname = c.dname
WHERE c.cname IS NULL OR c.cname != 'College Geometry'
GROUP BY d.dname, d.numphds;


-- 9 Print the names of students who are taking both a Computer Sciences course and a Mathematics course.
SELECT DISTINCT s.sname
FROM student s
JOIN enroll e1 ON s.sid = e1.sid
JOIN course c1 ON e1.cno = c1.cno AND e1.dname = c1.dname
JOIN enroll e2 ON s.sid = e2.sid
JOIN course c2 ON e2.cno = c2.cno AND e2.dname = c2.dname
WHERE (c1.dname = 'Computer Sciences' AND c2.dname = 'Mathematics') OR (c1.dname = 'Mathematics' AND c2.dname = 'Computer Sciences');


-- 10 .Print the age difference between the oldest and the youngest Computer Sciences major.
SELECT MAX(s.age) - MIN(s.age) AS age_difference
FROM student s
JOIN major m ON s.sid = m.sid
JOIN dept d ON m.dname = d.dname
WHERE d.dname = 'Computer Sciences';


-- 11 For each department that has one or more majors with a GPA under 1.0, print the name of the department and the average GPA of its majors.
SELECT d.dname, AVG(s.gpa) AS avg_gpa
FROM dept d
JOIN major m ON d.dname = m.dname
JOIN student s ON m.sid = s.sid
WHERE s.gpa < 1.0
GROUP BY d.dname;


-- 12 Print the ids, names and GPAs of the students who are currently taking all the Civil Engineering courses.
SELECT s.sid, s.sname, s.gpa
FROM student s
WHERE NOT EXISTS (
    SELECT c.cno
    FROM course c
    WHERE c.dname = 'Civil Engineering'
    EXCEPT
    SELECT e.cno
    FROM enroll e
    WHERE e.sid = s.sid AND e.dname = 'Civil Engineering'
);
