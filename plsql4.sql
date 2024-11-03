CREATE TABLE students(
    rollno INT PRIMARY KEY NOT NULL,
    name VARCHAR2(20),
    sem1 INT,
    sem2 INT
);

INSERT INTO students VALUES (52, 'Bob', 8, 8); 
INSERT INTO students VALUES (53, 'Charlie', 9, 4); 
INSERT INTO students VALUES (51, 'Alice', 5, 2); 
INSERT INTO students VALUES (54, 'David', 65, 70); 
INSERT INTO students VALUES (55, 'Eve', 80, 85); 
INSERT INTO students VALUES (56, 'Frank', 55, 60);

DECLARE
    CURSOR student_detail IS
        SELECT rollno, name, sem1, sem2 FROM students WHERE (sem1 + sem2) > 12 ORDER BY rollno;
    
    roll students.rollno%TYPE;
    name students.name%TYPE;
    s1 students.sem1%TYPE;
    s2 students.sem2%TYPE;
    maxs NUMBER := 0;

BEGIN
    OPEN student_detail;
    LOOP
        FETCH student_detail INTO roll, name, s1, s2;
        EXIT WHEN student_detail%NOT_FOUND;
        
        DBMS_OUTPUT.put_line('Roll NO: ' || roll || ' Name: ' || name || ' Semester1: ' || s1 || ' Semester2: ' || s2);
        
        IF s1 > maxs THEN
            maxs := s1;
        END IF;
    END LOOP;
    
    CLOSE student_detail;
    DBMS_OUTPUT.put_line('Maximum marks in Semester 1: ' || maxs);
END;
/
