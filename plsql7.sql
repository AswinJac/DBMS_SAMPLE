CREATE TABLE student (std INTEGER,name VARCHAR(10),subj1 
INTEGER,subj2 INTEGER,subj3 INTEGER,Total INTEGER,Avg FLOAT);
set SERVEROUT on;
create or REPLACE trigger student_trigger 
BEFORE INSERT on student
for EACH ROW
BEGIN
:new.Total:=:new.subj1+:new.subj2+:new.subj3;
:new.Avg:=:new.Total/3;
END;
/