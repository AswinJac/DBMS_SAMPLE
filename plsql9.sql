create table train(
    tno int not null,
    tname VARCHAR2(20),
    tdate date,
    designation VARCHAR(20),
    seats int
);
create SEQUENCE train_no START with 1 INCREMENT by 1;
insert into train values(train_no.nextval,'express1',TO_DATE('20-OCT-2024','DD-MON-YYYY'),'City A',200);

create or replace PROCEDURE reserve(
    train_number in int,
    seat_required in int
) AS
available_seat int;
BEGIN
SELECT seats into available_seat from train where tno=train_number;
if available_seat>seat_required THEN
update train set seats=seats-seat_required where tno=train_number;
commit;
dbms_output.put_line('Seat reserved succesfully');
ELSE
dbms_output.put_line("Error")
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN 
dbms_output.put_line("Invalid Train train_number");
END reserve;
/

create or REPLACE ticket_cancel(
    train_no in int,
    seat in int
) AS
begin
update train set seats=seats+seat where tno=train_no;
if sql%rowcount=0 THEN
dbms_output.put_line('Invalid numnber');
ELSE
commit;
DBMS_OUTPUT.PUT_LINE(p_seats_cancel || ' seats cancelled successfully'); 
END IF;
EXCEPTION 
WHEN OTHERS THEN 
DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM); 
END ticket_cancel; 
/ 

set serveroutput on;
BEGIN
dbms_output.put_line('1:Reserve seats');
dbms_output.put_line('2:Cancel seats');
END;
/
ACCEPT train_number PROMPT 'Enter train number: ';
ACCEPT seats_needed PROMPT 'Enter number of seats needed: ';
ACCEPT choice PROMPT 'Enter your choice (1 for reservation, 2 for cancellation): ';

-- Declare variables for train number, seat needed, and choice
DECLARE
    train_no INT := &train_number;    
    seat_need INT := &seats_needed;    
    ch INT := &choice;                 
BEGIN 
    -- Process user choice
    IF ch = 1 THEN 
        ReserveTicket(train_no, seat_need); 
        DBMS_OUTPUT.PUT_LINE('Reservation successful for train number ' || train_no || ' with ' || seat_need || ' seats.');
    ELSIF ch = 2 THEN 
        CancelTicket(train_no, seat_need); 
        DBMS_OUTPUT.PUT_LINE('Cancellation successful for train number ' || train_no || ' with ' || seat_need || ' seats.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Invalid choice. Please enter 1 for reservation or 2 for cancellation.'); 
    END IF; 
END;
/

