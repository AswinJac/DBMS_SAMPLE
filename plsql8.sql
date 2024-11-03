create table train(
    tno int not null,
    tname VARCHAR2(20),
    tdate date,
    designation VARCHAR(20),
    seats int
);
create SEQUENCE train_no
start with 1 
increment by 1;

create or REPLACE TRIGGER train_trigger
before INSERT on train
for each row
BEGIN
select train_no.nextval into :new.tno from dual;
end;
/
