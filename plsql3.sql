CREATE TABLE customers(
    cid varchar(20) primary key not null,
    amount number 
);
insert into customers values ('E01',1000);
insert into customers values ('E02',2000);
insert into customers values ('E03',3000);

DECLARE
    FUNCTION categorize(bal in NUMBER)
    RETURN VARCHAR IS
            category VARCHAR2(20);
    BEGIN
             IF bal > 50000 THEN
            category := 'Platinum';
            ELSIF bal > 10000 THEN
            category := 'Gold';
            ELSE
            category := 'Silver';
            END IF;
            RETURN CATEGORY;
    END;
BEGIN
    For customer IN (select cid,amount from customers) LOOP
        dbms_output.put_line('CID: '||customer.cid||',bal: '||customer.amount||',category:'|| categorize(customer.amount));
    END LOOP;

END;
/    

