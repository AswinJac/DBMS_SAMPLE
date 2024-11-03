create table bill(
    cusut_id number primary key not null,
    name varchar2(20),
    past number,
    present number
);
INSERT INTO bill VALUES (101, 'Jacob', 146, 350); 
INSERT INTO bill VALUES (102, 'Henry', 565, 200); 
INSERT INTO bill VALUES (103, 'John', 145, 650); 
INSERT INTO bill VALUES (104, 'Evan', 77, 160); 
INSERT INTO bill VALUES (105, 'Eric', 57, 380); 
INSERT INTO bill VALUES (106, 'Jim', 132, 100); 
INSERT INTO bill VALUES (107, 'Susan', 801, 99); 

DECLARE
consumer_no bill.cusut_id%TYPE;
past_reading bill.past%TYPE;
present_reading bill.present%TYPE;
cons number;
consumed number;
charge number;

CURSOR getvalues(no NUMBER) IS
select cusut_id,past,PRESENT from bill where cusut_id=no;

BEGIN
DBMS_OUTPUT.put_line('Enter consumer number :');
cons:=&cons;

OPEN getvalues(cons);
FETCH getvalues into consumer_no,past_reading,present_reading;
IF getvalues%FOUND THEN
consumed:=PRESENT-past;
IF consumed <= 100 THEN 
            charge := consumed * 5; 
        ELSIF consumed BETWEEN 101 AND 300 THEN 
            charge := (100 * 5) + (consumed - 100) * 7.5; 
        ELSIF consumed BETWEEN 301 AND 500 THEN 
            charge := (100 * 5) + (200 * 7.5) + (consumed - 300) * 15; 
        ELSE 
            charge := (100 * 5) + (200 * 7.5) + (200 * 15) + (consumed - 500) * 22.5; 
        END IF;
DBMS_OUTPUT.PUT_LINE('Consumer No: ' || consumer_no); 
        DBMS_OUTPUT.PUT_LINE('Units Consumed: ' || consumed); 
        DBMS_OUTPUT.PUT_LINE('Total Charge: ' || charge); 
    ELSE
        DBMS_OUTPUT.PUT_LINE('No data found for Consumer No: ' || consumer_no); 
    END IF;

    CLOSE getvalues;
END;
/
