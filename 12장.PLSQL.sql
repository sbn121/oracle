-- 12��. PL/SQL
-- SQL --> ��������|�������� ���α׷��� --> PL/SQL
-- Procedural Language extension to SQL : �������� ���α׷��� ��� + SQL ==> SQL���� ���α׷���!(Ȯ��)
-- 1) ���α׷���                 2) SQL : DML (������)
-- (�����ͺ��̽��� �ٷ�� ���α׷�)
-- ���߱��� : PL/SQL�� �и��� ��ŭ �з��� ����� ==> �Ϻ��ϰ� ����?
-- ==========================================================================
-- DBMS_OUTPUT ��Ű�� : ȭ�鿡 ����ϴ� ����� ���� ---> .PUT_LINE()  : �ٹٲ޾��� �ؽ�Ʈ ���
-- SQL DEVELOPER ��� Ȯ�� ��, [���� > DBMS ���] â�� �����ؼ� Ȱ��ȭ ==> + ������ HR ���� ����!
-- ��SQLPLUS Ȯ���Ϸ���? SET SERVEROUTPUT ON | OFF;
-- ==========================================================================
/* PL/SQL has these advantages(=����)

Tight Integration with SQL 
High Performance : �������
High Productivity : ���꼺?
Portability : 
Scalability 
Manageability : ������ ���̼�
Support for Object-Oriented Programming : ��ü���� ���α׷���
*/

SELECT *
FROM employees;

-- 12.1 PL/SQL ����
DECLARE
    -- �ɼ�
    -- ����� : ����, ����� �����ϴ� �κ�
    -- ����� ����� ���ÿ� �ʱ�ȭ ==> ���ϸ� ����!
BEGIN
    -- �ʼ�
    -- ����� : �Ϲ����� ó�� ������ �ۼ�
    -- ���ǹ�, ���ù�, �ݺ���, SQL(=DML)�� ��ġ
    
    EXCEPTION
    -- ����ó���� : �ɼ�
END;


-- ������ �ڷ��� := ��;    - ������ ���� �Ҵ��ϴ� �κ�
-- ����)
DECLARE
    -- ����� ���� üũ, count?
    nInt INTEGER := 10;  -- ����,�ʱ�ȭ
    nString VARCHAR2(50); -- ����   
    nConstant CONSTANT NUMBER(1) := 5; -- ����,�ʱ�ȭ
BEGIN
    dbms_output.put_line('nInt : '||nInt);
    dbms_output.put_line('nConstant : '||nConstant);
END;

DESC employees;
-- ===========================
-- SQL ���ε� ���� -----------
SELECT  salary
FROM    employees
WHERE   employee_id =: emp_num;

-- ===========================




-- ��) SQL�� ������ ����
DECLARE
    nSalary NUMBER(8, 2); -- employees ���̺��� ����� �޿� �÷�
    isTrue BOOLEAN; -- pl/sql������ �����ϴ� �Ҹ� Ÿ��
BEGIN
    SELECT  salary
    INTO    nSalary -- ���� nSalary : 100�� ����� �޿� �Ҵ�
    FROM    employees
    WHERE   employee_id = 206;
    
    DBMS_OUTPUT.PUT_LINE('nSalary : '||nSalary);
    -- �Լ����, RETURN�� ����ϰ�,
    -- ���ν������, �ܼ��� DML(������ ����) ==> ���
END;


-- ��) �����ڿ� ����ó��
DECLARE
    num1 INTEGER := 5;
    num2 INTEGER := 2;
    result INTEGER;
BEGIN
    num2 := 0;
    result := num1 / num2;
    DBMS_OUTPUT.PUT_LINE('result : '||result);
    EXCEPTION WHEN ZERO_DIVIDE THEN -- ����ó�� : 0���� ������~ ����!
        num2 := 1;
        result := num1 / num2;
        DBMS_OUTPUT.PUT_LINE('result: '||result);
END;


-- ============================================================
-- 1) ������ ���ǵ� ����(Pre-defined EXCEPTION)
-- 2) ����� �����ϴ� ����(User-defined EXCEPTION)
-- �� https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-error-handling.html#GUID-8C327B4A-71FA-4CFB-8BC9-4550A23734D6
EXCEPTION
  WHEN ���ܸ�1 THEN ó������1                 -- Exception handler
  WHEN ���ܸ�2 OR ���ܸ�3 THEN ó������2  -- Exception handler
  WHEN OTHERS THEN ó������3             -- � ���ܶ� �߻��ϸ�, Exception ó��!
END;
-- =================================



-- ���ǹ� : IF ��
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-control-statements.html#GUID-1D6FD34F-F58B-4D0B-B7FC-F7C2C22377C3
-- FORTRAN, COBOL, PASCAL, C�� �����ؼ� ���� ����Ŭ�� '���α׷��� ������ SQL'
-- ���� 1��
IF ���� THEN
ó����   
END IF;

-- ���� 1�� : ó���� 2��
IF ���� THEN
ó����1
ELSE
ó����2
END IF;

-- ������ ������
IF ����1 THEN
ó����1
ELSIF ����2 THEN
ó����2
ELSIF ����2 THEN
ó����3
...���...
ELSE
ó����n
END IF;

-- ��) ���� ==> ������ ���� A���, B���, C���... A����̸� Excellent! ���~

DECLARE
    grade CHAR(1) := 'A';
BEGIN
    IF  grade = 'A' THEN
        DBMS_OUTPUT.PUT_LINE('Excellent!');
    ELSIF grade = 'B' THEN
        DBMS_OUTPUT.PUT_LINE('Good!');
    ELSIF grade = 'C' THEN
        DBMS_OUTPUT.PUT_LINE('Not Bad!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('WORK HARD!');
    END IF;
END;


-- �ݺ���
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-control-statements.html#GUID-4CD12F11-2DB8-4B0D-9E04-DF983DCF9358
-- Basic LOOP : LOOP ~statements~ END LOOP;
-- FOR LOOP : FOR ������ IN �ּҰ�..�ִ밪 LOOP ~ statements ~ END LOOP;
-- Cursor FOR LOOP
-- WHILE LOOP : WHILE condition LOOP ~ statements(EXIT WHEN condition)~ END LOOP;

-- FOR ������ ���ڰ� ���
DECLARE
    start_num INTEGER := 1; -- ����
    num CONSTANT INTEGER := 2;    -- ���
    result INTEGER; -- ����, �ʱ�ȭx
BEGIN
    FOR start_num IN 1..9 LOOP
        result := num * start_num; -- �ʱ�ȭ
        DBMS_OUTPUT.PUT_LINE(num||' x '||start_num||' = '|| result);
    END LOOP;
END;


-- ���� ��(Named Block) <---> ����Ŭ, �������α׷��̶�� ��
-- A PL/SQL subprogram is a named PL/SQL block that can be invoked repeatedly. If the subprogram has parameters, their values can differ for each invocation.
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-subprograms.html#GUID-117C2D94-EB7C-4A9E-A080-99F4829D69B0
-- �������α׷� ���� ���� : ������, ���뼺
-- 1) ���ν��� : ����� ���, �÷��� �޿��� �ְ� �����ϴ� ���ν��� --> DML ���� ������ ������Ʈ
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-subprograms.html#GUID-9ACD7C7D-861B-4410-AC6F-8536C191E2EF
-- ���ν��� ����(=����)
-- DECLARE ���
CREATE OR REPLACE PROCEDURE ���ν����� (�Ķ����1 ������Ÿ��, �Ķ����2 ������Ÿ��,...) IS
    -- ���� �����;
    -- raise_salary(���, �÷��� �޿�)
BEGIN
    -- ���� ó��
    UPDATE employees
    SET salary = �÷��� �޿�
    WHERE   employee_id = ���;
    COMMIT;
END;

-- ���ν��� ����  : EXEC �޿�����_���ν���(���, ������ salary)
EXEC raise_salary(120, 18000); -- vs DML�� ó���ϴ� �Ͱ� ��

-- ���� �޿��� �÷��ִ� ���� : ���� �޿� * ��·� + ������ ���� ���ʽ� ==> ���� �޿�
-- EMPLOYEES ���̺��� ��� �� �޿� : salary + (commission_pct * salary)

-- ���� ����� ����
CREATE OR REPLACE PROCEDURE update_emp_salary(
    emp_id NUMBER, 
    final_salary NUMBER
) 
IS
BEGIN
    UPDATE employees
    SET salary = final_salary
    WHERE   employee_id = emp_id;
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('====== Error �߻�!! =======');
        ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('====== process ó�� �Ϸ�!! =======');    
END;
-- Procedure UPDATE_EMP_SALARY��(��) �����ϵǾ����ϴ�.

-- ��� 1���� �����ϰ�, �޿��� �Է� ==> JOBS ���̺��� MIX_SAL, MAX_SAL ���������� �ɷ�������?
SELECT *
FROM    user_constraints
WHERE   constraint_name LIKE '%SALARY%'; -- salary�� ������ 0 �ʰ�

SELECT employee_id, salary
FROM    employees
WHERE   employee_id = 206; -- 8300 --> 18000���� �����ϴ� udpate���ν����� ���� �׽�Ʈ

EXEC update_emp_salary(206, 18000); -- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

SELECT employee_id, salary
FROM    employees
WHERE   employee_id = 206; -- �� ������Ʈ �Ǿ��� Ȯ��

-- �� ���ν����� ��ȯ ���� ����   vs   �Լ��� ��ȯ ���� �ִ� 

-- Quiz. ����� ����ϴ� ���ν��� : ����� ������ �ʼ� �Է°� < ���� ���� �� : �μ�x, ����x , �Ի��� ���|����>
-- 1.employees ���̺��� �������� Ȯ��
DESC employees;

CREATE OR REPLACE PROCEDURE add_emp(
    e_id NUMBER, 
    l_name VARCHAR2, -- number�� VARCHAR2�� ����
    e_mail VARCHAR2,
    h_date DATE,
    j_id VARCHAR2
) 
IS
BEGIN
    INSERT INTO employees (employee_id, last_name, email, hire_date, job_id)
    VALUES (e_id,l_name,e_mail,h_date,j_id);
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('====== Error �߻�!! =======');
        ROLLBACK;    
END;

EXEC add_emp(employees_seq.NEXTVAL, '��','JANGBOGO',SYSDATE,'ST_CLERK');
-- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC add_emp(employees_seq.NEXTVAL, '��','GAMCHAN',SYSDATE,'ST_CLERK');
EXEC add_emp(employees_seq.NEXTVAL, '��','KIMGU',SYSDATE,'ST_CLERK');

SELECT *
FROM    employees;

SELECT *
FROM    job_history;



-- Quiz. ����� �μ���ġ�ϴ� ���ν��� : < ��༭ �ۼ�, �޿� ����, �μ� ����, ���� ���� >
-- ���� '��'�� ����� 80�� �μ��� ��ġ�Ѵٸ�?
-- set_emp('��', 80); ==> ����� department_id�� 80���� ����

-- Quiz. ����� ���ó�� ���ν��� : ������� ����, �����/���� ����/�μ����� �����ϴ� ó��
-- del_emp(208) ==> job_history ���, employees���� delete �׸��� commit;





-- 2) �Լ� : MAX() ó��, ���ο� �Լ��� ����!
-- ��) �ִ밪 �Լ�, �ּҰ� �Լ�,..���̰� �Լ�....80�� �μ����� �޿������ ��ȯ�ϴ� �Լ�
SELECT AVG_SAL(80)
FROM    employees; -- 80�� �μ��� ��� �޿��� ��ȸ�ϰ� ��ȯ�ϴ� �Լ��� ���!



CREATE OR REPLACE FUNCTION AVG_SAL(

)
IS

BEGIN

END;

























