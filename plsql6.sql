create table students(
    rollno int primary key not null,
    name varchar(20),
    s1 int,
    s2 int
);
INSERT INTO students VALUES (52, 'Bob', 8,8); 
INSERT INTO students VALUES (53, 'Charlie', 9, 4); 
INSERT INTO students VALUES (51, 'Alice', 5, 2); 
INSERT INTO students VALUES (54, 'David', 65, 70); 
INSERT INTO students VALUES (55, 'Eve', 80, 85); 
INSERT INTO students VALUES (56, 'Frank', 55, 60); 
INSERT INTO students VALUES (57, 'Grace', 7, 8); 
INSERT INTO students VALUES (58, 'Hannah', 88, 90);

set SERVEROUTPUT ON;
create TRIGGER student_trigger before insert or DELETE or UPDATE on students for each row
DECLARE
message varchar(20);
BEGIN
if deleting THEN
message:='Deleting: '||:old.name;
elsif inserting THEN
message:='Inserting: '||:new.name;
elsif updating THEN
if :new.name=:old.name THEN
message:='Updating: '||:new.name;
ELSE
message:='Upadting: '||:old.name||'to'||:new.name;
end if;
end if;
dbms_output.put_line(message);
end;
/