--Procedure: 
--1)They do not return any value
--2)We have 3 types of parameters in procedures
--  a)IN b)OUT c)IN OUT
--3)Inside the Procedures we can use Functions
--  Inside the Functions we cannot use Procedures
--4)Procedures cannot use SELECT, UPDATE, DELETE, INSERT SQL Statements if they return multiple data

--Get 2 numbers from user, then calculate their multiplication by using procedure
CREATE OR REPLACE PROCEDURE multiply(x IN NUMBER, y IN NUMBER, z OUT NUMBER) IS
BEGIN
   z:= x*y;
END;

DECLARE
    a NUMBER := '&FirstNumber';
    b NUMBER := '&SecondNumber';
    c NUMBER;
BEGIN
    multiply(a, b, c);
    DBMS_OUTPUT.PUT_LINE('The result is ' || c);
END;

--Create a calculator to do 4 main operations. Get the numbers and operation from the user 
CREATE OR REPLACE PROCEDURE calculator(x IN NUMBER, y IN NUMBER, z IN CHAR, t OUT NUMBER) IS
BEGIN

    IF(z='+') THEN
        t := x+y;
    ELSIF(z='-') THEN
        t := x-y;
    ELSIF(z='*') THEN
        t := x*y;
    ELSIF(z='/') THEN
        t := x/y;
    END IF;

END;

DECLARE
    a NUMBER := '&FirstNumber';
    b NUMBER := '&SecondNumber';
    c CHAR := '&Operation';
    d NUMBER;
BEGIN
    calculator(a, b, c, d);
    DBMS_OUTPUT.PUT_LINE('The result is ' || d);
END;

--Create table and insert values
CREATE TABLE workers
(
    id NUMBER(5),
    name VARCHAR2(50),
    salary NUMBER(5)
);

INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);

SELECT * FROM workers;

--Create a procedure to increase the salary of the selected worker.
DECLARE
    worker_id NUMBER:= '&Worker_Id';
    amount NUMBER := '&Amount';
    newSalary NUMBER;
PROCEDURE increaseSalary(w_id IN NUMBER, amount IN NUMBER, updatedSalary OUT NUMBER) IS
BEGIN 
    UPDATE workers
    SET salary = salary + amount
    WHERE id = w_id;
    
    SELECT salary 
    INTO updatedSalary 
    FROM workers 
    WHERE id= w_id;
END;

BEGIN 
    increaseSalary(worker_id, amount, newSalary);
     DBMS_OUTPUT.PUT_LINE('New Salary : ' || newSalary);
END;

--Create a procedure to withdraw money from an account.
--Account id and withdraw amount will be given by user.
--If the withdraw amount is greater than the balance withdraw cannot be done
--otherwise do withdraw and display the remaining balance on the output console.
CREATE TABLE accounts
(
    id NUMBER(3),
    name VARCHAR2(50),
    balance NUMBER(10,2)
);

INSERT INTO accounts VALUES(101, 'Ali Can', 12000);
INSERT INTO accounts VALUES(102, 'Veli Han', 2000);
INSERT INTO accounts VALUES(103, 'Mary Star', 7000);
INSERT INTO accounts VALUES(104, 'Angie Ocean', 8500);

SELECT * FROM accounts;

DECLARE
    a_id NUMBER := '&CustomerId';
    w_amount NUMBER := '&WithdrawAmount';
    r_balance NUMBER;
    a_balance NUMBER;

PROCEDURE withdraw(a_id IN NUMBER, w_amount IN NUMBER, r_balance OUT NUMBER) IS
BEGIN
    SELECT balance
    INTO a_balance
    FROM accounts
    WHERE id = a_id;
    
    IF(w_amount <= a_balance) THEN
        UPDATE accounts
        SET balance = balance - w_amount
        WHERE id = a_id;
    ELSE
        DBMS_OUTPUT.PUT_LINE(w_amount || ' is greater than the balance'); 
    END IF;
    
    SELECT balance
    INTO r_balance
    FROM accounts
    WHERE id = a_id;  
END;

BEGIN
    withdraw(a_id, w_amount, r_balance);
    DBMS_OUTPUT.PUT_LINE(r_balance || ' is the remaining balance');
END;


---SEQUENCE in SQL
--1.Type: Starts from 1, increase 1 by 1
CREATE SEQUENCE seq01;

CREATE TABLE seq_table(
    id NUMBER(3),
    seq_name VARCHAR2(20)
);

INSERT INTO seq_table VALUES(seq01.NEXTVAL, '&Sequence_Name');


SELECT * FROM seq_table;


--2.Type: Starts from a specific number, increase 1 by 1
CREATE SEQUENCE seq02
START WITH 101;

INSERT INTO seq_table VALUES(seq02.NEXTVAL, '&Sequence_Name');

--3.Type: Starts from a specific number, increased by a selected number
CREATE SEQUENCE seq03
START WITH 201
INCREMENT BY 10;

INSERT INTO seq_table VALUES(seq03.NEXTVAL, '&Sequence_Name');

--4.Type: Starts from a specific number, increased by a selected number, has a maximum value
CREATE SEQUENCE seq04
START WITH 301
INCREMENT BY 5
MAXVALUE 315;

INSERT INTO seq_table VALUES(seq04.NEXTVAL, '&Sequence_Name');

--5.Type: Starts from a specific number, increased by a selected number, has a maximum value, and has a cycle
CREATE SEQUENCE seq05
START WITH 401
INCREMENT BY 2
MAXVALUE 406
MINVALUE 399
CYCLE CACHE 3;

INSERT INTO seq_table VALUES(seq05.NEXTVAL, '&Sequence_Name');

INSERT INTO seq_table VALUES(seq01.NEXTVAL, '&Sequence_Name');