create table department(
    dep_no NUMBER(38) not null,
    dep_name VARCHAR2(15) not null,
    loc VARCHAR2(15) not null,
    mgr number(38) not null,
    exp_bdg number(38) not null,
    rev_bdg number(38) not null,
    PRIMARY key (dep_no)
);
CREATE TABLE EMPLOYEE ( Empno INT PRIMARY KEY NOT NULL, Name VARCHAR2(15) NOT NULL, Job VARCHAR2(15) NOT NULL, Salary INT NOT NULL, Comm VARCHAR2(15), Dep_No INT, Sex VARCHAR2(6), FOREIGN KEY(Dep_No) REFERENCES Department(Dep_No));

CREATE TABLE DEPENDANT ( Pid INT PRIMARY KEY NOT NULL, Fname VARCHAR2(15) NOT NULL, Lname VARCHAR2(15) NOT NULL, Place VARCHAR2(15) NOT NULL, Empno INT, FOREIGN KEY(Empno) REFERENCES Employee(Empno));

---inserting values------
insert into department VALUES(60,'Shipping','Trivandrum',215,90000,0);
INSERT INTO DEPARTMENT VALUES (10, 'Accounting', 'Cochin', 200, 100000, 0);
INSERT INTO DEPARTMENT VALUES (30, 'Research', 'Cochin', 105, 125000, 0);
INSERT INTO DEPARTMENT VALUES (40, 'Sales', 'Trichur', 109, 280000, 8000);
INSERT INTO DEPARTMENT VALUES (50, 'Manufacturing', 'Kottayam', 210, 130000, 0);

INSERT INTO EMPLOYEE (Empno, Name, Job, Salary, Dep_No, Sex)VALUES (100, 'Wilson', 'CLRK', 17000,10, 'M'); 
INSERT INTO EMPLOYEE VALUES (101, 'Smitha', 'SLSM', 25000,1300, 40, 'F'); 
INSERT INTO EMPLOYEE (Empno, Name, Job, Salary, Dep_No, Sex)VALUES (103, 'Roy', 'ANLST', 35000, 30, 'M'); 
INSERT INTO EMPLOYEE VALUES (105, 'Watson', 'MNGR', 45000,0,30, 'M'); 
INSERT INTO EMPLOYEE VALUES (109, 'Alan', 'MNGR', 30000,8000,40, 'M'); 
INSERT INTO EMPLOYEE (Empno, Name, Job, Salary, Dep_No, Sex)VALUES (110, 'Tina', 'CLRK', 18000, 50, 'F'); 
INSERT INTO EMPLOYEE (Empno, Name, Job, Salary, Dep_No, Sex)VALUES (200, 'Karthika', 'MNGR', 29000, 10, 'F'); 
INSERT INTO EMPLOYEE (Empno, Name, Job, Salary, Dep_No, Sex)VALUES (210, 'Rita', 'MNGR', 36500, 50, 'F'); 
INSERT INTO EMPLOYEE (Empno, Name, Job, Salary, Dep_No, Sex)VALUES (213, 'Manacy', 'CLRK', 16250, 10, 'F'); 
INSERT INTO EMPLOYEE (Empno, Name, Job, Salary, Dep_No, Sex)VALUES (214, 'Simpson', 'DRVR', 8250, 60, 'M'); 
INSERT INTO EMPLOYEE (Empno, Name, Job, Salary, Dep_No, Sex)VALUES (215, 'Deepa', 'ANLST', 27000, 60, 'F'); 
INSERT INTO EMPLOYEE VALUES (220, 'Soosan', 'SLSM', 28500,5300,60, 'F');

INSERT INTO DEPENDANT VALUES (1010, 'Anu', 'Jose', 'Trivandrum', 214);
INSERT INTO DEPENDANT VALUES (1020, 'Neenu', 'Thomas', 'Kollam', 200);
INSERT INTO DEPENDANT VALUES (1022, 'AnamikA', 'Thampi', 'Kollam', 200);
INSERT INTO DEPENDANT VALUES (1031, 'Swetha', 'Das', 'Kottayam', 109);

--Return details of all managers from employee table sorted alphabetically by name.
select * from employee where job='MNGR' order by name asc;

--Return details of all employees in department 40 ordered by EMPNO
select * from employee where Dep_No=40 order by Empno;

--Return information about all female employee ordered by NAME.
select * from employee where sex='F' order by name;

--Find Minimum, Maximum and Average salary of employees in each department
SELECT Dep_No,min(salary),max(salary),avg(salary) from employee group by Dep_No;

--Find Maximum and Minimum commission paid(COMM),total commission paid and count of employees who were paid with commission.
select max(comm),min(comm),sum(comm),count(*) from employee where comm>0;

--Number of employees listed in each job.
select job,count(*) from employee group by job;

--Total salary paid to each job in the category.
select job,sum(salary) from employee group by job;

--Return all DEPT_ÑOs in employee table(Ensure that each DEPT_ÑO appears only once).
SELECT DISTINCT(dep_No) from employee;

--Return  EMPNO,NAME and SALARY of females in department 10.
SELECT empno,name,salary from employee where dep_no=10 and sex='F';

-- Return EMPNO, NAME and SALARY of all male managers ordered by NAME.
select empno,name,salary from employee where job='MNGR' and sex='M';

--Return NAME and JOB of all female  sales man and managers.  
SELECT NAME , JOB FROM EMPLOYEE WHERE JOB IN ('SLSM','MNGR') AND SEX = 'F';

-- Display EMPNO and NAME of employees in employee table who are a either manager or   a clerk in department 50. 
SELECT empno,name from employee where job in ('MNGR','CLRK') and dep_no=50;

-- List the name of employee who are neither a clerk nor a salesman. 
SELECT NAME FROM EMPLOYEE WHERE JOB NOT IN ('CLRK','SLSM');

--Return details of all clerks working in departments other than department 10. 
SELECT * from employee where job='CLRK' and dep_no not in (10);

--Find names of employees containing letters U and E.
select name from employee where name like '%U%' and name like '%E%';

-- List all employee who earned commission.
select * from employee where comm>0;

-- Find EMPNO ,NAME and JOB of all females who are not managers.
select empno,name,job from employee where job !='MNGR' and sex='F';

--. Find EMPNO,NAME and SALARY of all employees who earn more than 10000 but less than 40000. 
select empno,name,salary from employee where salary>10000 and salary<40000;

-- Use lN operator to find NAME and EMPNO of EMPLOYEE who are analyst or manager ordered by NAME. 
SELECT NAME , EMPNO FROM EMPLOYEE WHERE JOB IN ('ANLST' , 'MNGR');

-- Find the employee number, name and salary who been paid commission and whose salary is greater than 30000 . 
SELECT EMPNO , NAME , SALARY FROM EMPLOYEE WHERE COMM>=0 AND SALARY >30000;

-- Find DEP-NO ,DEP-NAME, SALARY, JOB, SEX ordered by EMPNO within department 
select department.dep_no,department.dep_name,employee.salary,employee.job,employee.sex from employee inner join department on department.dep_no=employee.dep_no order by department.dep_No;

--Display the name of employee and dependant name if dependant is staying in the same location  where employee is working . 
SELECT E.NAME, D.FNAME FROM EMPLOYEE E INNER JOIN DEPENDANT D ON E.EMPNO = D.EMPNO INNER JOIN DEPARTMENT DEP ON E.DEP_NO = DEP.DEP_NO WHERE D.PLACE = DEP.LOC;

-- Find company location of employee named Watson.
select department.loc from employee inner join department on employee.dep_no=department.dep_No where employee.name='Watson';

--. Find name, EMPNO,DEP-NAME for all employee who work in ‘Trichur’ and order by EMPNO in descending order
select e.name,e.empno,d.dep_name from employee e inner join department d on e.dep_no=d.dep_no where d.loc='Trichur' order by empno desc;

-- Retrieve NAME and SALARY of all employee who earned more than average salary. 
select name,salary from employee where salary>(SELECT avg(salary) from employee);

--Find NAME, JOB, DEP NAME, LOCATION of all female employee order by EMPNAME. 
SELECT E.NAME , D.DEP_NAME FROM EMPLOYEE E INNER JOIN DEPARTMENT D ON E.DEP_NO = D.DEP_NO WHERE E.JOB = 'MNGR' ORDER BY D.DEP_NAME;

-- Find the EMPNAME,DEP,NAME of all manager order by department name. 
select e.name,d.dep_name from employee e inner join department d on e.dep_no=d.dep_no where e.job='MNGR' order by d.dep_name;

-- Find NAME and DEP-NAME of employee who earns highest salary. 
select e.name,d.dep_name from employee e,department d where e.dep_no=d.dep_no and salary=(SELECT max(salary) from employee);

--Find name, department name, commission of all employee who paid commission order by name. 
select e.name,d.dep_name,e.comm from employee e,department d where e.dep_no=d.dep_no and e.comm>0;

-- Display employee name and department name of all employees working in departments that has at least three employees. Order the output in alphabetical order first by department name and then by employee name.
select e.name,d.dep_name from employee e inner join department d on e.dep_no=d.dep_no where d.dep_no in (SELECT dep_no from employee group by dep_no having count(*)>=3) order by d.dep_name,e.name;

--. Find name, department name and commission of all employees who NOT paid commission order by name.
SELECT E.NAME , D.DEP_NAME , E.COMM FROM EMPLOYEE E INNER JOIN DEPARTMENT D ON E.DEP_NO = D.DEP_NO WHERE E.COMM IS NULL ORDER BY E.NAME; 

--. List name and salary of all employee in department number l0 and 30. 
SELECT NAME , SALARY FROM EMPLOYEE WHERE DEP_NO IN (10,30);

-- List jobs of employees in department 30 which are not done in department 40. 
SELECT DISTINCT JOB FROM EMPLOYEE WHERE DEP_NO = 30 EXCEPT SELECT DISTINCT JOB FROM EMPLOYEE  WHERE DEP_NO = 40;

-- List out job and salary of employees in department l0 and 40 who draw the same salary 
SELECT E1.JOB, E2.SALARY FROM EMPLOYEE E1 JOIN EMPLOYEE E2 ON E1.SALARY=E2.SALARY WHERE E1.DEP_NO = 10 AND E2.DEP_NO = 40;

--. Create a view to display EMPNO' NAME ' JOB of employee from employee table who works as manager.
create view sample as SELECT empno,name,job from employee where job='MNGR';

-- Select EMPNO, NAME,JOB and SALARY of employee who works as clerk and having salary greater than 1650. 
SELECT EMPNO , NAME , JOB , SALARY FROM EMPLOYEE WHERE JOB = 'CLERK' AND SALARY > 1650;

-- Create an index for column FNAME and LNAME in Dependant  table. 
create INDEX sample on Dependant(Fname,Lname);

-- Delete person with ID=1031 in Dependant table. 
delete from DEPENDaNT where pid=1031;

-- Return  EMPNO,NAME and SALARY of any one  of the females in department 10.
select Empno,name,salary from employee where sex='F' and dep_no=10 and ROWNUM=1;

--. Delete the employee Karthika with all her dependants.
delete from DEPENDaNT where Empno in(select empno from employee where name='Karthika');
delete from employee where name='Karthika';