CREATE TABLE students(
    id CHAR(9),
    name VARCHAR2(50),
    grade NUMBER(2),
    address VARCHAR2(80),
    update_date DATE
);

INSERT INTO students VALUES(123456789, 'John Walker', 11, '1234 Texas', '14-Apr-2020');
INSERT INTO students VALUES(223456789, 'Johnny Walker', 12, '1234 Florida', '14-Apr-2020');

SELECT * FROM students;

--In the table there are 2 ids and 2 names but our code has just a single id container and a single name container 
--because of that we get Exception
DECLARE
    student_id CHAR(9);
    student_name VARCHAR2(50);
BEGIN
    SELECT id, name
    INTO student_id, student_name
    FROM students;
END; 

                    ---PREDEFINED EXCEPTIONS---

--How to Handle TOO_MANY_ROWS Exception after it occured
DECLARE
    student_id CHAR(9);
    student_name VARCHAR2(50);
BEGIN
    SELECT id, name
    INTO student_id, student_name
    FROM students;
    DBMS_OUTPUT.PUT_LINE('Student id:' || student_id); -- Like ==> System.out.println("Student id:" + student_id);
    
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('You cannot put multiple data into a single container');
END;

--How to Handle NO_DATA_FOUND Exception after it occured
DECLARE
    student_id CHAR(9);
    student_name VARCHAR2(50);
BEGIN
    SELECT id, name
    INTO student_id, student_name
    FROM students
    WHERE grade = 23;
    DBMS_OUTPUT.PUT_LINE('Student id:' || student_id); -- Like ==> System.out.println("Student id:" + student_id);
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Are you sure, you have data like that...');
END;

--How to Handle ZER0_DIVIDE Exception after it occured
DECLARE
    num1 NUMBER(4):= 12;
    num2 NUMBER(4):= 0;
    result NUMBER(4,2);
BEGIN
    result := num1 / num2;
    DBMS_OUTPUT.PUT_LINE(num1 || '/' || num2 || ' = ' || result);
    
    EXCEPTION
    WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.PUT_LINE('Do not make divisor zero...');
END;

--How to Handle INVALID_NUMBER Exception after it occured
DECLARE
    new_grade NUMBER(3);
BEGIN
    INSERT INTO students(id, grade) VALUES('456789000', 'A');
    SELECT grade
    INTO new_grade
    FROM students
    WHERE id = '123456789';
    DBMS_OUTPUT.PUT_LINE('New grade is ' || new_grade);
    
    EXCEPTION
    WHEN INVALID_NUMBER THEN
    DBMS_OUTPUT.PUT_LINE('Be careful about data types...');
END;

                ---USER DEFINED EXCEPTIONS---
                
--Create ILLEGAL_ENTRY Exception for ages if user enters Negative Values

--a)Do not get the age from user
DECLARE
    age NUMBER(3):=-23;
    ILLEGAL_ENTRY EXCEPTION;
BEGIN 
    IF(age<0) THEN
        RAISE ILLEGAL_ENTRY;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Youd did correct entrance ' || age); 
    END IF;
    
    EXCEPTION
    WHEN ILLEGAL_ENTRY THEN
        DBMS_OUTPUT.PUT_LINE('Age cannot be negative...'); 
END;

--b)Get the age from user
DECLARE
    age NUMBER(3);
    ILLEGAL_ENTRY EXCEPTION;
BEGIN 
    age:='&Age';

    IF(age<0) THEN
        RAISE ILLEGAL_ENTRY;
    ELSE
        DBMS_OUTPUT.PUT_LINE('You did correct entrance, the age is  ' || age); 
    END IF;
    
    EXCEPTION
    WHEN ILLEGAL_ENTRY THEN
        DBMS_OUTPUT.PUT_LINE('Age cannot be negative...'); 
END;

--How to multiple Exceptions after they occured
DECLARE
    new_grade students.grade%TYPE; --I got the data type from students table grade field.
    new_name students.name%TYPE; --I got the data type from students table name field.
    INVALID_NAME EXCEPTION;
    INVALID_GRADE EXCEPTION;

BEGIN
    new_grade:='&Grade';
    new_name:='&Name';
    
    IF(new_grade<=0 or new_grade>12) THEN
        RAISE INVALID_GRADE;
    ELSE
        DBMS_OUTPUT.PUT_LINE('You entered the grade correctly.The grade is ' || new_grade); 
    END IF;
    
    IF(new_name = 'Ali Can') THEN
        RAISE INVALID_NAME;
    ELSE
        DBMS_OUTPUT.PUT_LINE(new_name || ' is our student'); 
    END IF;
    
    EXCEPTION
    WHEN INVALID_GRADE THEN
        DBMS_OUTPUT.PUT_LINE('Grade should be between 1 and 12...'); 
    WHEN INVALID_NAME THEN
        DBMS_OUTPUT.PUT_LINE('Ali Can is not our student, he is master...'); 
END;
