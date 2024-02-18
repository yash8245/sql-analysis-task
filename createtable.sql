CREATE TABLE IF NOT EXISTS student (
    sid SERIAL PRIMARY KEY,
    sname VARCHAR(200) NOT NULL,
    sex VARCHAR(7) NOT NULL,
    age INT NOT NULL,
    year INT NOT NULL,
    gpa DOUBLE PRECISION NOT NULL
);
SELECT * from student;
COPY student from 'D:\SQL Data\student.data'


CREATE TABLE dept (
    dname TEXT PRIMARY KEY,
    numphds INT NOT NULL
);
SELECT * FROM dept
COPY dept FROM 'D:\SQL Data\dept.data'


CREATE TABLE prof (
    pname TEXT PRIMARY KEY,
    dname TEXT,
    CONSTRAINT dept_fk FOREIGN KEY (dname) REFERENCES dept (dname) ON DELETE CASCADE
);
SELECT * FROM prof
COPY prof FROM 'D:\SQL Data\prof.data'


CREATE TABLE course (
    cno SERIAL,
    cname TEXT NOT NULL,
    dname TEXT,
    CONSTRAINT course_fk FOREIGN KEY (dname) REFERENCES dept (dname) ON DELETE CASCADE,
    CONSTRAINT course_pk PRIMARY KEY (cno, dname)
);
SELECT * FROM course 
COPY course FROM 'D:\SQL Data\course.data'


CREATE TABLE major (
    dname TEXT REFERENCES dept (dname),
    sid INT REFERENCES student (sid),
    CONSTRAINT major_pk PRIMARY KEY (dname, sid)
);  
SELECT * FROM major
COPY major FROM 'D:\SQL Data\major.data'


CREATE TABLE section (
    dname TEXT,
    cno INT,
    sectno INT NOT NULL,
    pname TEXT,
    CONSTRAINT section_pk PRIMARY KEY (dname, cno, sectno),
    CONSTRAINT section_course_fk FOREIGN KEY (cno, dname) REFERENCES course (cno, dname) ON DELETE CASCADE
);
SELECT * FROM section
COPY section FROM 'D:\SQL Data\section.data'


CREATE TABLE enroll (
    sid INT REFERENCES student (sid),
    grade DOUBLE PRECISION NOT NULL,
    dname TEXT,
    cno INT,
    sectno INT,
    CONSTRAINT enroll_pk PRIMARY KEY (sid, dname, cno, sectno),
    CONSTRAINT enroll_course_fk FOREIGN KEY (cno, dname) REFERENCES course (cno, dname) ON DELETE CASCADE,
    CONSTRAINT enroll_section_fk FOREIGN KEY (dname, cno, sectno) REFERENCES section (dname, cno, sectno) ON DELETE CASCADE
);
SELECT * FROM enroll
COPY enroll FROM 'D:\SQL Data\enroll.data'
