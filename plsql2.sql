CREATE TABLE students (
    id VARCHAR2(10) PRIMARY KEY NOT NULL,
    name VARCHAR2(10) NOT NULL,
    mark INT
);

INSERT INTO students VALUES ('S01', 'Aswin', 45);
INSERT INTO students VALUES ('S02', 'Rayan', 49);
INSERT INTO students VALUES ('S03', 'Bayern', 40);

SET SERVEROUTPUT ON;

DECLARE 
    avg_mark NUMBER;  -- Changed to NUMBER for average
    current_date VARCHAR2(20);  -- Corrected to VARCHAR2
    current_day VARCHAR2(20);
BEGIN
    -- Calculate average marks
    SELECT AVG(mark) INTO avg_mark FROM students;
    DBMS_OUTPUT.PUT_LINE('Average: ' || avg_mark);  -- Added space after Average

    -- Check average and display appropriate message
    IF avg_mark < 40 THEN
        DBMS_OUTPUT.PUT_LINE('Warning! Low Average Marks Needs Improvement!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Good Average Marks! Keep it up!');
    END IF;

    -- Get current date and day
    current_date := TO_CHAR(SYSTIMESTAMP, 'DD-MM-YYYY');
    current_day := TO_CHAR(SYSTIMESTAMP, 'Day');

    -- Display current date and day
    DBMS_OUTPUT.PUT_LINE('Current Date: ' || current_date);  -- Added label for clarity
    DBMS_OUTPUT.PUT_LINE('Current Day: ' || TRIM(current_day));  -- Trim to remove extra spaces
END;
/
