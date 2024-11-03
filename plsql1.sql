CREATE TABLE accounts(
    account NUMBER(5) NOT NULL,
    balance NUMBER(10)
);

-- Sample Data
INSERT INTO accounts VALUES(1, 1000);
INSERT INTO accounts VALUES(2, 2000);
INSERT INTO accounts VALUES(3, 3000);

-- Enable output display
SET SERVEROUTPUT ON;

-- Prompt for account and transaction amounts
ACCEPT acc NUMBER PROMPT 'Enter Account Number: ';
ACCEPT debit_amount NUMBER PROMPT 'Enter value to debit: ';
ACCEPT credit_amount NUMBER PROMPT 'Enter value to credit: ';

DECLARE
    debit NUMBER := &debit_amount;
    credit NUMBER := &credit_amount;
    flag INT := 0;
    bal NUMBER(10);
BEGIN
    -- Check if account exists
    SELECT COUNT(*) INTO flag FROM accounts WHERE account = &acc;
    IF flag = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Account invalid');
    ELSE
        -- Perform credit operation
        IF credit > 0 THEN
            UPDATE accounts SET balance = balance + credit WHERE account = &acc;
        END IF;

        -- Perform debit operation
        IF debit > 0 THEN
            UPDATE accounts SET balance = balance - debit WHERE account = &acc;
        END IF;

        -- Retrieve and display the updated balance
        SELECT balance INTO bal FROM accounts WHERE account = &acc;
        DBMS_OUTPUT.PUT_LINE('BALANCE: ' || bal);

        -- Check for minimum balance warning
        IF bal < 500 THEN
            DBMS_OUTPUT.PUT_LINE('Warning: Maintain a minimum balance of 500!');
        END IF;
    END IF;
END;
/
DROP TABLE accounts;