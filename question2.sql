CREATE TABLE CUSTOMER (
    cust_no VARCHAR(15) NOT NULL,
    name VARCHAR(15) NOT NULL,
    age INT NOT NULL,
    city VARCHAR(15) NOT NULL,
    pincode INT NOT NULL,
    state VARCHAR(15) NOT NULL,
    PRIMARY KEY (cust_no)
);

CREATE TABLE SUPPLIER (
    sno VARCHAR(10) NOT NULL,
    sname VARCHAR(15) NOT NULL,
    age INT NOT NULL,
    city VARCHAR(15) NOT NULL,
    PRIMARY KEY (sno)
);

CREATE TABLE PRODUCT (
    product_no VARCHAR(15) NOT NULL,
    description VARCHAR(15) NOT NULL,
    company VARCHAR(15) NOT NULL,
    price INT NOT NULL,
    PRIMARY KEY (product_no)
);

CREATE TABLE PURCHASE (
    order_no INT NOT NULL,
    custno VARCHAR(15) NOT NULL,
    prono VARCHAR(15) NOT NULL,
    quantity INT NOT NULL,
    order_date DATE,  
    PRIMARY KEY (order_no),
    FOREIGN KEY (custno) REFERENCES CUSTOMER(cust_no),
    FOREIGN KEY (prono) REFERENCES PRODUCT(product_no)
);

INSERT INTO CUSTOMER VALUES('C00001', 'Ivan Bayross', 35, 'Bombay', 400054, 'Maharashtra');
INSERT INTO CUSTOMER VALUES('C00002', 'Vandana Saitwal', 35, 'Madras', 780001, 'Tamilnadu');
INSERT INTO CUSTOMER VALUES('C00003', 'Pramada Jaguste', 55, 'Bombay', 400057, 'Maharashtra');
INSERT INTO CUSTOMER VALUES('C00004', 'Basu Navindgi', 45, 'Bombay', 400056, 'Maharashtra');
INSERT INTO CUSTOMER VALUES('C00005', 'Ravi Sreedharan', 25, 'Delhi', 100001, 'Delhi');
INSERT INTO CUSTOMER VALUES('C00006', 'Rukmini', 25, 'Madras', 780001, 'Tamilnadu');

INSERT INTO SUPPLIER VALUES('S001', 'Ivan Bayross',35, 'Bombay');
INSERT INTO SUPPLIER VALUES('S002', 'Nirmala Agarwal',35, 'Madras');
INSERT INTO SUPPLIER VALUES('C003', 'Susmitha',55, 'Bombay');
INSERT INTO SUPPLIER VALUES('C004', 'Basu Navindgi',45, 'Bombay');    
INSERT INTO SUPPLIER VALUES('C005', 'Ravi Sreedharan',25, 'Delhi');
INSERT INTO SUPPLIER VALUES('C006', 'Nanda Gopal',25, 'Madras'); 

INSERT INTO PRODUCT VALUES('P00001', '12 W Flood Light', 'Wipro', 5000);
INSERT INTO PRODUCT VALUES('P00002', 'Laptop Adapter', 'Dell', 1560);
INSERT INTO PRODUCT VALUES('P00003', 'Tablet', 'HCL', 11000);
INSERT INTO PRODUCT VALUES('P00004', 'Garnet 50W led', 'Wipro', 999);
INSERT INTO PRODUCT VALUES('P00005', 'Laptop Charger', 'HCL', 1690);

INSERT INTO PURCHASE VALUES(000001, 'C00002', 'P00003', 2, '20-JAN-16');
INSERT INTO PURCHASE VALUES(000002, 'C00003', 'P00002', 1, '27-JAN-16');
INSERT INTO PURCHASE VALUES(000003, 'C00006', 'P00001', 3, '20-FEB-16');
INSERT INTO PURCHASE VALUES(000004, 'C00003', 'P00005', 4, '07-APR-16');
INSERT INTO PURCHASE VALUES(000005, 'C00004', 'P00002', 2, '22-MAY-16');
INSERT INTO PURCHASE VALUES(000006, 'C00005', 'P00004', 1, '26-MAY-16');

--List all customers in Madras
SELECT NAME FROM CUSTOMER where city='Madras';

--List all customer- numbers of all who purchase the product in the month of January
SELECT custno from purchase where order_date LIKE '%-JAN-%';

--List all the name of company whose price is greater than 5000?
SELECT company from product where price>5000;
 
--List all the customers whose name is not beginning with ‘r’?
SELECT name FROM customer WHERE LOWER(NAME) not like 'r%';

--Add email field into the customer table?
ALTER TABLE customer ADD (email VARCHAR(29));

--List all the customers whose age is greater than 40 in Maharashtra?
SELECT * FROM customer where age>40 and state='Maharashtra';

--Display the company’s name in the increasing order of price?
select company from product order by price asc;

--Calculate average age of customers from table customer.
select avg(age) from customer;

--List cities of customers from states Maharashtra & Tamil Nadu.
select city from customer where state='Maharashtra' or state='Tamilnadu';

--Find average price from table product
select avg(price) from PRODUCT;

--List all customer nos in the increasing order of quantity from table purchase.
select custno from purchase order by quantity asc;

--Update product number of customer number C00003 to P00008.
INSERT INTO PRODUCT VALUES('P00008','Mouse','Artic Fox','700');
update purchase set prono='P00008' where custno='C00003';

--Find the number of customers from city Delhi.
SELECT COUNT(*) from customer where city='Delhi';

--List customer number of all customers who have purchased more than 3 items.
select custno from purchase where quantity>3;

--Modify the structure of order date field in the purchase into character
UPDATE purchase set order_date=NULL; 
ALTER TABLE purchase MODIFY  order_date VARCHAR(20);

--Find min and max price from product table
select min(price),max(price) from product;

--Find number of products by Wipro and HCL separately
SELECT company,count(product_no) from product where company in ('Wipro','HCL') GROUP BY company;

--List all customers in alphabetical order.
select name from customer order by name asc;

--Sort the content of purchase table in descending order of date.
ALTER TABLE PURCHASE MODIFY ORDER_DATE DATE;
UPDATE PURCHASE SET ORDER_DATE = '20-JAN-16' WHERE ORDER_NO = '000001';
UPDATE PURCHASE SET ORDER_DATE = '27-JAN-16' WHERE ORDER_NO = '000002';
UPDATE PURCHASE SET ORDER_DATE = '20-FEB-16' WHERE ORDER_NO = '000003';
UPDATE PURCHASE SET ORDER_DATE = '07-APR-16' WHERE ORDER_NO = '000004';
UPDATE PURCHASE SET ORDER_DATE = '22-MAY-16' WHERE ORDER_NO = '000005';
UPDATE PURCHASE SET ORDER_DATE = '26-MAY-16' WHERE ORDER_NO = '000006';
SELECT * from purchase order by order_date desc;

--Delete the product with product_no = P00003
ALTER TABLE purchase MODIFY prono varchar(20) null;
update purchase set prono=null where prono='P00003';
DELETE from PRODUCT where product_no='P00003';

--.Copy the contents of field order_no and orderdate of purchase table into new table.
create table sample as SELECT order_no,order_date from purchase;

--Delete the newly created table.
drop table sample;

--Create view of customer table.
create view customer_view as SELECT * from customer;

--List names of customers who have placed more than one order.
SELECT c.name from customer c inner join purchase p on c.cust_no=p.custno GROUP BY c.cust_no,c.name HAVING COUNT(*)>1; 

--Retrieve transaction details of customer who lives in same city, obtain the result through self -join and correlated join.
select c1.name,c2.name,p.order_no,p.order_date from customer c1 inner join customer c2 on c1.city=c2.city and c1.cust_no<>c2.cust_no inner join purchase p on c1.cust_no=p.custno order by c1.name,c2.name;

--Retrieve customer names starting with ‘R’
select name from customer where name like 'R%';

--List names of persons who are either a supplier or a customer
SELECT name from customer union select sname from supplier;

--------------------------END-------------------------------------------------------------------------END----------------------------------