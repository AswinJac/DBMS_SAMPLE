create table customer(
    cust_id INT PRIMARY KEY not null,
    cust_name VARCHAR2(20) not null,
    city VARCHAR2(20) not null,
    amount int not null,
    discount int not null,
    salesman_id VARCHAR2(20) not null
);
INSERT INTO CUSTOMER VALUES (100, 'Deepa', 'Trivandrum', 1050, 2, 'K0010');
INSERT INTO CUSTOMER VALUES (101, 'Don', 'Trivandrum', 8040, 4, 'K0010');
INSERT INTO CUSTOMER VALUES (102, 'Manacy', 'Kollam', 20030, 6, 'A200tmp');
INSERT INTO CUSTOMER VALUES (103, 'Karthika', 'Ernakulam', 8400, 20, 'EkmX1050');
INSERT INTO CUSTOMER VALUES (104, 'Tulasi', 'Ernakulam', 2500, 2, 'EkmY2342');
INSERT INTO CUSTOMER VALUES (105, 'Roy', 'Trivandrum', 2900, 4, 'L1045');
INSERT INTO CUSTOMER VALUES (106, 'Vivek', 'Trivandrum', 3200, 8, 'L1045');
INSERT INTO CUSTOMER VALUES (108, 'Bhasi', 'Kottayam', 12860, 10, 'KtmP1028');
INSERT INTO CUSTOMER VALUES (109, 'Anurag', 'Kottayam', 3860, 12, 'KtmB158tmp');
INSERT INTO CUSTOMER VALUES (110, 'antony', 'Kottayam', 9800, 8, 'KtmP1028');
INSERT INTO CUSTOMER VALUES (111, 'Meeran', 'Trichur', 6700, 6, 'R3085');

--Select all customers with a customername starting with "a" 
select cust_name from customer where cust_name like 'a%';

--Select all customers with a customername starting with "a"  or "A"
select cust_name from customer where cust_name like 'a%'or cust_name like 'A%';

--Modify customer names such that all customer names start with a capital letter 
update customer set cust_name=initcap(cust_name);

--Find city values  ending with "a"
select city from customer where city like '%a';

--Return first 3 characters of salesman_ID
select substr(salesman_id,1,3) from customer;

--Find s salesmanids  with "tmp" in any position 
select salesman_ID from customer where salesman_ID like '%tmp%';

--Find count of  city values that start with "T"
select count(*) from customer where city like 'T%';

-- Select customer names starting with D and of atleast 4 characters 
select cust_name from customer where cust_name like 'D%' and LENGTH(cust_name)>=4;

--Finds city values that start with "K" and are at least 2 characters in length 
select city from customer where city like 'K%' and length(city)>=2;

-- Finds city values that start with "K" and are at least 7 characters in length 
select DISTINCT(city) from customer where city like 'K%' and length(city)>=7;

-- Finds city values that start with "K" and ends with "m" 
select DISTINCT(city) from customer where city like 'K%' and cilty like '%m';

-- Display salesman details with salesman_ID, total amount given as discount and maximum discount provided by him in percentage with % symbol 
select salesman_ID,sum(amount) as total_amount,concat(max(discount),'%') from customer group by salesman_ID;

-- Display city names in uppercase 
select DISTINCT(UPPER(city)) as CITY_NAME from customer;

-- Update salesman_ID of all salesman from Ernakulam by removing the prefix "Ekm"
update customer set salesman_ID=substr(salesman_id,4) where city='Ernakulam';

--. Display total sales amount of each salesperson  till today with today's date in dd-mon-yyyy
SELECT salesman_ID,sum(amount) as TOTAL_AMOUNT,to_char(systimestamp,'dd-mm-yyyy') as CurrentDATE from customer group by salesman_ID;




