-- 8��. DML 
-- Data Manipulation Language, �����͸� �����ϴ� ��ɹ�
-- 8.1 SELECT : ������ ��ȸ ===> DQL(Data Query Language) : Query ���� --> ��û
-- 8.2 INSERT : �� �����͸� �����ϴ� ���
-- 8.3 UPDATE : ���� �����͸� �����ؼ� �����ϴ� ���
-- 8.4 DELETE : ���� ������ �����ϴ� ���
-- �� DML�� TCL(Transaction Control Language)�� �Բ� ����Ѵ�.
-- COMMIT : ������ ���� (�޸�) ==> (�������� ������ġ��) �ݿ�
-- ROLLBACK : ������ ����        ==> ��������� ���� ==> ���� �� ���·�!



-- 8.1 INSERT
-- ������ ���� ��� ==> ���̺� ����!
INSERT INTO ���̺�� [�÷���1, �÷���2, ...] -- �÷��� ������, �÷��� ������ ���Ѿ� ��!
VALUES (��1, ��2, ...) -- �÷� ������ ���� ����, Ÿ��(=�ڷ���) / ��ȯ�Լ�

-- 1) �����͸� ������ �÷� ��ϰ� �ϴ��� �����ǵ��� ���� �� �����  VALUES�� �����Ѵ�.
-- 2) �������� �ʴ� �÷����� �ڵ����� NULL�� ����ȴ�.
-- 3) ��¥ �����ʹ� ��¥ ���� ����(YYYY-MM-DD, RR/MM/DD..)�� ����ؼ� ������ �� �ִ�.

[����8-1] emp ���̺� 300�� ��� �̸��� 'Steven', ���� 'jobs'�� ����� ������ ���� ��¥ ��������
����Ͻÿ�
-- 1. emp ���̺� ���� (�÷���, �÷��� �ڷ���, ���̰� ����) ==> DDL(Data Definition Language, ������ ���Ǿ�)
CREATE TABLE emp(
    emp_id NUMBER,  -- emp_id��� �÷��� NUMBER(���� �ڷ���,����-�Ǽ�) ���� ����
    fname VARCHAR2(30),   -- fname �̶�� �÷��� VARCHAR2(���� ���� �ڷ���, 30����Ʈ ����)�� ����
    lname VARCHAR2(20),   -- lname �̶�� �÷��� VARCHAR2(���� ���� �ڷ���, 20����Ʈ ����)�� ����  
    hire_date DATE DEFAULT SYSDATE,   -- hire_date �÷��� DATE(��¥ �ڷ���)���� ����, ������ �ý����� ���糯¥�� ���
    job_id  VARCHAR2(20), -- job_id��� �÷��� �������� 20����Ʈ�� ����
    salary NUMBER(9,2), -- salary ��� �÷��� ������(������ : 7, �Ҽ��� : 2) ���̷� ����
    comm_pct NUMBER(3,2), -- comm_pct�� ������(������: 1, �Ҽ���: 2)���̷� ����
    dept_id NUMBER(3)  -- dept_id�� ������(������: 3byte)
);

-- ���̺� ���� 
-- DDL : �����ͺ��̽� ��ü ����, ����, ����, �߰��ϴ� ��ɾ� ==> ������ �Ƚ�Ŵ ==> DBA �����ڰ�..
DROP TABLE ���̺��;  -- ���̺�, ���̺� ������ ������..(�ڵ����� COMMIT�Ǵϱ�, ����!)
-- �Ǵ�
-- ���� > �ش� ���̺� + ��Ŭ�� > ���̺� > ���� [v] - ����~
DROP TABLE emp;
-- Table EMP��(��) �����Ǿ����ϴ�. ==> �ڵ����� COMMIT!
ROLLBACK;


-- NLS ���� : �⺻ ũ�� (bytes* / chars)   


-- ���̺� ������ Ȯ���ϴ� ���1. SQL�� ����~ ����� ���̺� EMP��� ���̺��� �ִ���?
SELECT *
FROM    user_tables  -- ����� �������� ������ ���̺���� ����Ǵ� ���̺�(��ü)
WHERE   table_name='EMP';

-- �ƴϸ�, ���� > HR ���� ������ ���ΰ�ħ Ŭ��!

-- 2. �����͸� ����
-- 2.1 ���̺��� ���� ��ȸ : desc or describe
DESC emp;

INSERT INTO emp (emp_id, fname, lname, hire_date)
VALUES (300, 'Steven', 'Jobs', SYSDATE);

SELECT *
FROM    emp;

[����8-2] ����� 301�̰� �̸��� 'Bill', ���� 'Gate'�� ����� 2013�� 5�� 26���ڷ� emp ���̺� �����Ͻÿ�

INSERT INTO emp  -- �÷����� ���� ==> ����, ���������� ���Ѿ���
VALUES (301, 'Bill', 'Gates', TO_DATE('2013-05-26 10:00:00','YYYY-MM-DD HH:MI:SS'), NULL, NULL, NULL, NULL);

SELECT *
FROM    emp;

-- Ʈ����� ó�� : Ŀ�� or �ѹ�
COMMIT;


INSERT INTO emp  -- �÷����� ���� ==> ������ ���Ѿ���
VALUES (303, 'Elon', 'Musk', TO_DATE('2015-05-26 10:00:00','YYYY-MM-DD HH:MI:SS'));

ROLLBACK;

-- p.69 �÷� ��� ���� ���̺��� ��� �÷��� ���� ���尪 ����� VALUES ���� �����ؾ� �Ѵ�.
-- ���ڿ� : NULL �Ǵ� ''�� ����ؼ� �������� NULL ������ �� �ִ�.
-- NULL ==> UPDATE�� �����ؼ� �ٽ� ������ �� �ִ�.
-- �� ���������� NULL �Է��ϴ� �� ����.


[����8-3]
desc departments;
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)
*/

SELECT *
FROM    departments;

INSERT INTO departments -- �÷��� ��! ������ Ÿ��!
VALUES (300, 'Health Servces', NULL, NULL);

ROLLBACK;


[����8-4]
INSERT INTO emp (emp_id, fname, lname, hire_date, job_id, salary)
VALUES (302, 'Warren', 'Buffett', SYSDATE, '',''); -- ���������鿡���� '' ��� NULL��!

SELECT *
FROM    emp;

-- VALUES �� ���� SELECT���� ����� ���������� ���̺�κ��� ���� ������ ���� ����, ������ �� �ִ�.
-- INSERT���� ������ �÷� ��ϰ� SELECT ���� �÷� ����� ������ ��ġ�ؾ� �Ѵ�.

INSERT INTO ���̺� [(�÷���1, �÷���2,..)]  -- 2. Ư�� ���̺� (�״��)���� (=����)
--VALUES (��1, ��2, ...)
SELECT �÷���1, �÷���2,...    -- 1. ���� ���̺��� Ư�� �÷���(=������) �����ؼ�
FROM    ���̺��
WHERE   ������;


[����8-5] ������̺��� �μ��ڵ� 10�Ǵ� 20�� �Ҽӵ� ����� ������ ���, �̸�, ��, �Ի���, �����ڵ�, �μ��ڵ带 
emp ���̺� �����Ͻÿ�!

INSERT INTO emp (emp_id, fname, lname, hire_date, job_id, dept_id)
SELECT  employee_id, first_name, last_name, hire_date, job_id, department_id
FROM    employees
WHERE   department_id IN (10, 20);

SELECT *
FROM    emp;

-- =============================================================================================
-- ITAS : INSERT INTO ~ AS SELECT ~   // SELECT ����� �ٸ� ���̺� �����ϴ� ��� [DML]
-- CTAS : CREATE TABLE ~ AS SELECT ~ // SELECT ����� �ٸ� ���̺��� �����ϴ� ���(������ ����, ������)[DDL]
-- =============================================================================================

[����8-6] ���� �޿� ���� ���̺�(month_salary)�� �μ����̺��� �μ��ڵ� �� �����͸� �����Ͻÿ�
-- �Ϲ� ���̺� ���� ���, �����͸� ���� ����
/*
CREATE TABLE ���̺�� (
    �÷��� ������Ÿ�� ��������,
    �÷��� ������Ÿ�� ��������,
    ....���..
);
*/
-- ������ �Է� : 4000����Ʈ,
CREATE TABLE month_salary (
    dept_id NUMBER(3), 
    emp_count NUMBER,
    sum_sal NUMBER,
    avg_sal NUMBER(9,2)
);

INSERT INTO month_salary (dept_id)
SELECT  department_id
FROM    departments
WHERE   manager_id IS NOT NULL;

SELECT *
FROM    month_salary;

ROLLBACK;


INSERT INTO month_salary (dept_id, emp_count, sum_sal, avg_sal)
SELECT  department_id, COUNT(*), SUM(salary), ROUND(AVG(salary), 2)
FROM    employees
WHERE   department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1;

-- CTAS�� ���̺� ���� ��� ==> �����͸� �����ϸ鼭 �����ϰų� �Ǵ� ������ �����ϰ� �����ʹ� ����x


[����8-7] ������̺��� �μ��ڵ尡 30���� 60���� �ش��ϴ� ������� ���, �̸�, ��, �Ի���, �����ڵ�, �޿�,
Ŀ�̼���, �μ��ڵ带 ��ȸ�ؼ� emp ���̺� �����Ͻÿ�

SELECT *
FROM    emp; -- ���� 6��,

INSERT INTO emp
SELECT  employee_id, first_name, last_name, hire_date, job_id, salary, commission_pct, department_id
FROM    employees
WHERE   department_id BETWEEN 30 AND 60; -- ��ȸ�� �����ʹ� 57��

COMMIT;

-- ������ : 63��
SELECT *
FROM    emp; 



-- 8.3 ������ ���� UPDATE
-- INSERT : �� ������ ����(=����)
-- UPDATE : ���� ������ �����ؼ� ���� (WHERE ���� ���ǿ� ��ġ�ϴ� ���� �÷� �����͸� ���ο� ������ ����)
/*
UPDATE ���̺��
SET �÷���=��
WHERE   ����;
*/

-- WHERE ���� ==>  ��� ������ �࿡ ����
-- ex> �޿��� Ư�� ���/�μ��� �������� ������ ��� ����� �޿���~ Ŀ�̼���~

[����8-8] emp ���̺��� ����� 300�� �̻��� ����� �μ��ڵ带 20 ���� �����Ͻÿ�
-- emp : ���� 300�� �̻� 3�� + employees ���̺� 30~60�� �μ��� 60�� ==> 63��
SELECT *
FROM    emp;

UPDATE emp
SET dept_id = 20
WHERE   emp_id >= 300; -- 3���� �μ��ڵ� NULL --> 20����

ROLLBACK;

-- WHERE �� ������, ��� �����Ͱ� ���� ==> emp ���̺��� ��� ����� �μ��� 20���� �����
UPDATE emp
SET dept_id = 20
--WHERE   emp_id >= 300;

SELECT *
FROM    emp;

COMMIT; -- Ȯ��

[����8-9] ����� 300���� ����� �޿�, Ŀ�̼���, �����ڵ带 �����Ѵ�.
UPDATE emp
SET salary = 2000,
    comm_pct = 0.1,
    job_id = 'IT_PROG' -- �μ�: IT , ���������� : PROGRAMMER
WHERE   emp_id = 300;    
    
ROLLBACK; -- ���


-- ���������� ����� �����͸� ������ �� �ִ�. 
-- �����ڵ�, �޿�, Ŀ�̼��� ===> ���� �÷� �������� ==> UPDATE �Ҷ� ����Ѵ�.
-- MAX() : ������ �Լ� (����� ����) ==> �����Լ�
[���� 8-11] emp ���̺� ��� 103�� ����� �޿��� employees ���̺��� 20�� �μ��� �ִ� �޿��� �����Ѵ�.
-- 1. 20�� ~ �ִ�޿� ��ȸ
-- 2. UPDATE�� 103�� ����� �޿��� ����
-- or  ���������� �̿�!!

UPDATE emp
SET salary = ( SELECT   MAX(salary)
               FROM     employees
               WHERE    department_id = 20 ) -- ��������
WHERE   emp_id = 103;


[����8-12] emp ���̺� ��� 180�� ����� ���� �ؿ� �Ի��� ������� �޿���, employees ���̺� 50�� �μ���
��� �޿��� �����Ͻÿ�

-- ��(year)
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY') AS YEAR,
        TO_CHAR(SYSDATE, 'MM') AS MONTH,
        TO_CHAR(SYSDATE, 'DD') AS DAY
FROM    dual;        

-- employees ���̺� 50�� �μ��� ��� �޿�
SELECT  AVG(salary)
FROM    employees
WHERE   department_id = 50;  -- 3475.555555555555555555555555555555555556

desc emp;

-- emp ���̺� ��� 180�� ����� �Ի��� �� 
SELECT TO_CHAR(hire_date, 'YYYY')
FROM    emp
WHERE   emp_id = 180;   -- 2006


UPDATE emp
SET salary = ( SELECT  AVG(salary)
               FROM    employees
               WHERE   department_id = 50 )
WHERE   TO_CHAR(hire_date, 'YYYY') = ( SELECT TO_CHAR(hire_date, 'YYYY')
                                       FROM    emp
                                       WHERE   emp_id = 180 );
-- SQL ����: ORA-01861: ���ͷ��� ���� ���ڿ��� ��ġ���� ����
-- hire_date�� DATE Ÿ�� --> 180�� ����� �Ի�⵵�� CHAR Ÿ�� <=== ��ȯ�Լ�


SELECT *
FROM    emp;

-- commit : �޸� --> (����/��ȯ) --> ������ġ(HDD,SSD..)�� ����� <===> ORACLE�� ���� <--> SQL ��ȸ,����,����,����..



-- [���� 8.6] ==> [���� 8.13] : ���������� ó��
-- �μ��ڵ常 ����, ������ NULL --> �� �÷����� ���������� ó��!!
-- month_salary2 �� ����, 
CREATE TABLE month_salary2 (
    dept_id NUMBER(3), 
    emp_count NUMBER,
    sum_sal NUMBER,
    avg_sal NUMBER(9,2)
);

-- ������̺��� ������� �Ҽ� �μ��ڵ常 ����
INSERT INTO month_salary2 (dept_id)
SELECT  department_id
FROM    employees
WHERE   department_id IS NOT NULL -- Ŵ������ �μ��� ���� ���
GROUP BY department_id;

-- month_salary2 ��ȸ
SELECT *
FROM    month_salary2;

-- UPDATE�� emp_count, sum_sal, avg_sal�� ������Ʈ
UPDATE month_salary2 m
SET emp_count = ( SELECT COUNT(*)
                  FROM  employees e
                  WHERE e.department_id = m.dept_id
                  GROUP BY  e.department_id ),
    sum_sal = ( SELECT SUM(e.salary)
                  FROM  employees e
                  WHERE e.department_id = m.dept_id
                  GROUP BY e.department_id ),
    avg_sal = ( SELECT AVG(e.salary)
                  FROM  employees e
                  WHERE e.department_id = m.dept_id
                  GROUP BY e.department_id )
                  
-- month_salary ó�� month_salary2�� ���������� ó��
-- �� ���������� �ݺ���..WHERE��, GROUP BY ��! ==> �����÷� ���������� ó���ϸ� �ξ� �����ϴ�!
-- ���� �÷� �������� ==> UPDATE ������ Ȱ��!

    




