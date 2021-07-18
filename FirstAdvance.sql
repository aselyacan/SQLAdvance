--Why do we need functions in SQL?
--1)We need functions to calculate 
--2)We need functions to fetch data from database

--Note: In SQL, functions definitely return data
--      The thing does not return any data is called "Procedure" in SQL

--Note: In SQL, functions need parameters

--Note: We can use functions in SQL statement like SELECT, INSERT, UPDATE, DELETE

--Note: Inside the functions, procedures cannot be used.

--What is DUAL Table? 
--DUAL Table is 1 column, 1 row table
--Column name is DUMMY as default
--Data type of the column is VARCGHAR2(1)
--Default value of the record is X
--To get current date 
SELECT sysdate FROM dual;
--To get user name
SELECT user FROM dual;

--Create a table insert name and age, and insertion date, and user name into table for every record.
CREATE TABLE students(
    std_name VARCHAR2(50),
    std_age NUMBER(3),
    insertion_date DATE,
    inserter VARCHAR2(50)
);

DECLARE 
    current_date DATE;
    inserter VARCHAR2(50);
    std_name VARCHAR2(50);
    std_age NUMBER(3);
BEGIN
    SELECT sysdate, user
    INTO current_date, inserter
    FROM DUAL;
    
    std_name:='&Name';
    std_age:='&Age';

    INSERT INTO students VALUES(std_name, std_age, current_date, inserter);
END;


SELECT * FROM students;

--Create a function to add 2 numbers
CREATE OR REPLACE FUNCTION addf(a NUMBER, b NUMBER)
RETURN NUMBER IS
BEGIN
    RETURN a + b;
END;

--1.Way to call a function 
SELECT addf(10, 20) FROM DUAL;

--2.Way to call a function
EXECUTE DBMS_OUTPUT.PUT_LINE('The sum is ' || addf(10, 20));

--3.Way to call a function
VARIABLE RESULT NUMBER
EXECUTE :RESULT := addf(10, 20);

PRINT RESULT;

--Create a function which can do 4 mathematical operations
CREATE OR REPLACE FUNCTION calcf(a number, b number, opr char)
RETURN NUMBER IS
BEGIN
    IF opr = '+' THEN
        RETURN a+b;
    ELSIF opr = '-' THEN
        RETURN a-b;
    ELSIF opr = '*' THEN
        RETURN a*b;
    ELSIF opr = '/' THEN
        RETURN a/b; 
    ELSE
       DBMS_OUTPUT.PUT_LINE('Select one of the +, -, *, /');
       RETURN 0;    
    END IF; 
    EXCEPTION 
    WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.PUT_LINE('Do not divide by zero!!!');
    RETURN 0;    
END;

--EXECUTE DBMS_OUTPUT.PUT_LINE(calcf(24, 0, '/'));


--How to get data from user in a function
DECLARE 
a NUMBER := '&FIRST_NUMBER';
b NUMBER := '&SECOND_NUMBER';

FUNCTION calcf(a number, b number, opr char)
RETURN NUMBER IS
BEGIN
    IF opr = '+' THEN
        RETURN a+b;
    ELSIF opr = '-' THEN
        RETURN a-b;
    ELSIF opr = '*' THEN
        RETURN a*b;
    ELSIF opr = '/' THEN
        RETURN a/b; 
    ELSE
       DBMS_OUTPUT.PUT_LINE('Select one of the +, -, *, /');
       RETURN 0;    
    END IF; 
    EXCEPTION 
    WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.PUT_LINE('Do not divide by zero!!!');
    RETURN 0;    
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(calcf(a, b, '+'));
END;

--Get 2 integers from user and return the smallest one
--Call the function to print the result on the console
DECLARE
    a NUMBER := '&First_Number';
    b NUMBER := '&Second_Number';
    
FUNCTION smallest(a number, b number)
RETURN NUMBER IS
BEGIN
    IF a<b THEN
        RETURN a;
    ELSE
        RETURN b;
    END IF;
END;
BEGIN
    DBMS_OUTPUT.PUT_LINE(smallest(a, b));
END;

--Get an integer from user and calculate the factorial of the given number
DECLARE 
    a NUMBER := '&Number';
    ILLEGAL_ENTRY EXCEPTION;
    
FUNCTION factorialf(a number)
RETURN NUMBER IS

BEGIN
    IF(a<0) THEN 
        RAISE ILLEGAL_ENTRY;
    ELSIF(a=0) THEN
        RETURN 1;
    ELSE
        RETURN a*factorialf(a-1);
    END IF;
    
    EXCEPTION
    WHEN ILLEGAL_ENTRY THEN
    DBMS_OUTPUT.PUT_LINE('Do not use negative numbers in factorial...');
    RETURN 0;
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(factorialf(a));
END;

--How to drop function
    DROP FUNCTION factorialf;

--What is the Procedure in SQL?
--Procedures do not return any data
--Procedures cannot be used in SELECT, INSERT, UPDATE
--We can use Functions inside the Procedures

--Procedures have 3 types of parameters;
--1) IN Parameters
--2) OUT Parameters
--3) IN OUT Parameters

--Create a procedure to find maximum value of 2 integers
CREATE OR REPLACE PROCEDURE findMax(a IN NUMBER, b IN NUMBER, maxi OUT NUMBER) IS
BEGIN
    IF a<b THEN
        maxi := b;
    ELSE
        maxi := a;
    END IF;
END;

--How to call Procedure
DECLARE
    a NUMBER;
    b NUMBER;
    maxi NUMBER;
BEGIN
    a := '&First_Number';
    b := '&Second_Number';
    findMax(a, b, maxi);
    DBMS_OUTPUT.PUT_LINE('Maximum : ' || maxi);
END;
