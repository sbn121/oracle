-- 6��. �������� (p.51)

-- �� SQL���� �ȿ� �����ϴ� �Ǵٸ� SQL ����(SELECT ~ FROM~ WHERE) �� ����������� �Ѵ�.
-- 1) ���������� ��ȣ(, )�� ��� ����Ѵ�.
-- 2) ���������� ���Ե� �������� ���� ������� �Ѵ�.
-- 3) ������� : ���������� ���� ����ǰ� �� ����� ��ȯ�� �� ���������� ����ȴ�.

-- ORACLE, MYSQL, MSSQL : RDBMS    vs   mongoDB(atlas), firebase(google), MS Azure, Amazon AWS
-- ������ �����ͺ��̽�                 <CLOUD ����� �����ͺ��̽�> : NoSQL (������ �����ͺ��̽��� �ƴ�)

-- ����Ŭ ==> ��������
-- MSSQL ==> T-SQL
-- ���� DBMS ���� �ణ �ٸ� �̸�  <== 

[����6-1] ��� �޿����� �� ���� �޿��� �޴� ����� ������ ��ȸ�Ѵ�.
-- �������� ��� ��
-- �ٵ� �־���? ==> �Ⱦ��°ͺ��� ���ϴ�?
-- ���������� ������� �ʰ� �ذ� vs ���������� ����ؼ� �ذ�
-- 4��. �׷��Լ� ==> ��� �޿��� ���� ����� ��ȯ�ϴ� �Լ� 
-- DISTINCT : �ߺ��� ������ ����� ��ȯ�ϴ� �Լ�, NULL ����
-- COUNT() : NULL ����, ������ ��� ����� ��ȯ
-- SUM() : ���ڵ����� �÷��� �հ�
-- MAX(), MIN() : ������ Ÿ�԰� �����ϰ�~ 
-- AVG() : ���ڵ����� �÷��� ���

-- 1. ��� �޿��� ���Ѵ�
SELECT  ROUND(AVG(salary)) AS avg_sal
FROM    employees;   -- ��ձ޿� : 6462

-- 2. ��� �޿� �̸��� �޴� ��������� ��ȸ
SELECT employee_id, first_name, salary, department_id
FROM    employees
WHERE   salary < 6462; -- 56rows

-- 1+2�� ȿ�� : �Ϲ����� ��������(WHERE ����) --> ��/���� ������ ==> ���� ��, ���� �÷� ��������
SELECT employee_id, first_name, salary, department_id
FROM    employees
WHERE   salary < ( SELECT  ROUND(AVG(salary)) AS avg_sal
                   FROM    employees );






-- ========= ���� ������ ���� ���� ========================
-- �������� ���� ����� ������ ���� ����
-- 6.1 ���� �� (���� �÷�) �������� : �ϳ��� ��� ���� ��ȯ�ϴ� ��������
-- �� ���� �� ������(=, >=, >, <, <=,        <>, !=, ^=)
-- �� 4��. �׷� �Լ��� ����ϴ� ��찡 ����. (AVG, SUM, COUNT, MAX, MIN)
[����6-2] �� �޿��� ���� ���� ����� ���, �̸�, �� ������ ��ȸ�Ѵ�.
-- 1. �� �޿� ���� ���� �ݾ� ��ȸ
SELECT salary
FROM    employees
ORDER BY 1 DESC; -- MAX: 24000 ==> ���� ���� ������?

SELECT MAX(salary) AS max_sal, MIN(salary) AS max_sal
FROM    employees; -- MAX: 24000, MIN: 2100

SELECT MIN(salary) AS max_sal
FROM    employees;

-- 2. �������� �ۼ�
SELECT employee_id, first_name, last_name
FROM    employees
WHERE   salary = ( SELECT MAX(salary) AS max_sal
                    FROM    employees );   -- 100	Steven	King

SELECT employee_id, first_name, last_name
FROM    employees
WHERE   salary = ( SELECT MIN(salary) AS max_sal
                    FROM    employees );   -- 132	TJ	Olson
                    
[����6-3] ��� 108�� ����� �޿����� �� ���� �޿��� �޴� ����� ������ ��ȸ�Ѵ�.
-- 1.���������� ������� ������
-- 1-1. 108�� ����� �޿��� ��ȸ
-- 1-2. ��ü ��� ���� 1-1���� ���� �޿��� ���ؼ� �� ���� �޿��޴� ��� ��ȸ
SELECT  salary
FROM    employees
WHERE   employee_id = 108;  -- 108�� ��� : 12008 

SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary > ( SELECT  salary
                    FROM    employees
                    WHERE   employee_id = 108 );  -- 6rows
                    
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary < ( SELECT  salary
                    FROM    employees
                    WHERE   employee_id = 108 );  -- 99rows     
                    
                    
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary = ( SELECT  salary
                    FROM    employees
                    WHERE   employee_id = 108 );  -- 99rows                      


SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary <> ( SELECT  salary
                    FROM    employees
                    WHERE   employee_id = 108 ); 

SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary ^= ( SELECT  salary     
                    FROM    employees
                    WHERE   employee_id = 108 ); 

SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary != ( SELECT  salary     
                    FROM    employees
                    WHERE   employee_id = 108 ); 
                    
                    

[����6-4] ���޿��� ���� ���� ����� ���, �̸�, ��, �������� ������ ��ȸ
-- employees : ���, �̸�, ��
-- jobs : ��������(job_title)


-- 1. ���޿� ���� ū �� : 24000   vs  2100
SELECT MAX(salary)
FROM    employees;

SELECT MIN(salary)
FROM    employees;


-- 2. ����� ���, �̸�, ��, �������� ����
-- 2-1. ����Ŭ ����
-- 2-2. ANSI JOIN ==> MYSQL ��� ����, T-SQL (MSSQL), ...

SELECT  e.employee_id, e.first_name, e.last_name,
        j.job_title
FROM    employees e, jobs j
WHERE   e.job_id = j.job_id
AND     salary = ( SELECT MAX(salary) AS max_sal
                    FROM    employees ); -- King

SELECT  e.employee_id, e.first_name, e.last_name,
        j.job_title
FROM    employees e, jobs j
WHERE   e.job_id = j.job_id
AND     salary = ( SELECT MIN(salary) AS max_sal
                    FROM    employees ); -- olson
    

-- 6.2 ���� �� ��������(p.53) 
-- ���� �� ������ (IN, NOT, ANY(=SOME), ALL, EXISTS)
-- 6.2.1 IN ������
-- OR ������ ��� --> ����

SELECT  employee_id, first_name, department_id
FROM    employees
--WHERE   department_id = 50
--OR      department_id = 80;
WHERE   department_id IN (50,80);

[���� 6-5] �μ�(��ġ�ڵ�, location_id)�� ����(UK)�� �μ��ڵ�, ��ġ�ڵ�, �μ��� ������ ��ȸ�Ѵ�.

SELECT  department_id, location_id, department_name
FROM    departments
WHERE   location_id IN (select location_id from locations where country_id = 'UK');

-- 6.2.1 NOT ������
-- 6.2.1 ANY(=SOME) ������
-- 6.2.1 ALL ������
-- 6.2.1 EXISTS ������




-- 6.3 ���� �÷� ��������





-- �������� ����?
-- 6.4 ��ȣ���� ��������

-- ���������� �ۼ� ��ġ�� ���� ���� : ������ WHERE ���� �ۼ�/���
-- 6.5 ��Į�� �������� : SELECT ���� �ۼ�/���
-- 6.6 �ζ��� �� �������� : FROM ���� �ۼ�/���
-- ===================================================

