
-- 1. Create Tables
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);


CREATE SEQUENCE Transactions_seq START WITH 1001 INCREMENT BY 1;


INSERT INTO Customers VALUES (1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 1000, SYSDATE);
INSERT INTO Customers VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Accounts VALUES (1, 1, 'Savings', 1000, SYSDATE);
INSERT INTO Accounts VALUES (2, 2, 'Checking', 1500, SYSDATE);

INSERT INTO Transactions VALUES (1, 1, SYSDATE, 200, 'Deposit');
INSERT INTO Transactions VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

INSERT INTO Loans VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Employees VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));
INSERT INTO Employees VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

-- Scenario 1:
INSERT INTO Customers VALUES (3, 'Senior A', TO_DATE('1940-01-01', 'YYYY-MM-DD'), 3000, SYSDATE);
INSERT INTO Customers VALUES (4, 'Senior B', TO_DATE('1955-05-10', 'YYYY-MM-DD'), 4000, SYSDATE);

INSERT INTO Loans VALUES (2, 3, 8000, 6.5, SYSDATE, ADD_MONTHS(SYSDATE, 24));
INSERT INTO Loans VALUES (3, 4, 6000, 5.8, SYSDATE, ADD_MONTHS(SYSDATE, 36));

-- Scenario 2:
INSERT INTO Customers VALUES (5, 'Wealthy Customer', TO_DATE('1988-11-11', 'YYYY-MM-DD'), 20000, SYSDATE);
INSERT INTO Accounts VALUES (3, 5, 'Savings', 20000, SYSDATE);

-- Scenario 3:
INSERT INTO Customers VALUES (6, 'Soon Due', TO_DATE('1975-08-25', 'YYYY-MM-DD'), 6000, SYSDATE);
INSERT INTO Loans VALUES (4, 6, 3000, 4.5, SYSDATE - 300, SYSDATE + 15);

COMMIT;


CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    UPDATE Accounts
    SET Balance = Balance * 1.01,
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';

    COMMIT;
END;
/

select * from ACCOUNTS;
select * from EMPLOYEES;
select * from ACCOUNTS;

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    dept_name IN VARCHAR,
    bonus_percent IN NUMBER
) AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * bonus_percent / 100)
    WHERE Department = dept_name;

    COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE TransferFunds (
    from_account IN NUMBER,
    to_account IN NUMBER,
    amount IN NUMBER
) AS
    insufficient_balance EXCEPTION;
    from_balance NUMBER;
BEGIN
    SELECT Balance INTO from_balance
    FROM Accounts
    WHERE AccountID = from_account
    FOR UPDATE;

    IF from_balance < amount THEN
        RAISE insufficient_balance;
    END IF;

    UPDATE Accounts
    SET Balance = Balance - amount,
        LastModified = SYSDATE
    WHERE AccountID = from_account;


    UPDATE Accounts
    SET Balance = Balance + amount,
        LastModified = SYSDATE
    WHERE AccountID = to_account;

    INSERT INTO Transactions VALUES (Transactions_seq.NEXTVAL, from_account, SYSDATE, amount, 'Debit');
    INSERT INTO Transactions VALUES (Transactions_seq.NEXTVAL, to_account, SYSDATE, amount, 'Credit');

    COMMIT;
EXCEPTION
    WHEN insufficient_balance THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transfer failed: Insufficient funds.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
END;
/

-- 8. Test Procedure Calls

EXEC ProcessMonthlyInterest;

EXEC UpdateEmployeeBonus('IT', 10);

EXEC TransferFunds(1, 2, 200);
SHOW ERRORS PROCEDURE UpdateEmployeeBonus;