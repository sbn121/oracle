-- 5��.JOIN (����)
-- ����Ŭ ������ �����ͺ��̽��̴� ==> ���� : ���̺�� ���̺��� �δ�!  
-- (Relation, �����̼� - �����ͺ��̽� �����Ҷ� ���̺��� �����̼��̶�� ��)
-- JOIN ���� ���̺��� �����Ͽ� (HR: 7��, ���� : n) �����͸� ��ȸ�Ѵ�
-- ex> ��� ���̺� ~ �μ� ���̺� ���� : ��������� �μ�����(�μ��̸�, �μ���ġ�ڵ�)�� ��ȸ�Ҷ�!


-- 5.1 Cartesian Product (Decart�� �ٸ� ��, Cartesian)
-- JOIN ���� : �� �̻��� ���̺��� ���踦 ������, ������ �Ǵ� �÷��� ���� ==> ����, WHERE ���� ���...
-- JOIN ������ ������� ���� �� �߸��� ����� �߻��ϴµ�, �̰� ī�׽þ� ��(=�ռ���)�̶�� ��.
-- ������ �ȳ� ==> �����Ǵ� ������ ���� ���ٸ�, �ǽ�!!

/*
SELECT �÷���1, �÷���2,....
FROM    ���̺��1, ���̺��2, ...
WHERE   JOIN ����(=��)
*/

[����5-1] ��� ���̺�� �μ� ���̺��� �̿��� ����� ������ ��ȸ�ϰ��� �Ѵ�. ���, ��, �μ� �̸���
��ȸ�϶�!

-- ���, �� : employees (��� ���� ���̺� : ���, �̸�, ����޿�, �Ի���,..)
-- �μ��̸� : departments (�μ� ���� ���̺� : �μ��ڵ�, �μ��̸�, �μ��� ��ġ�� �����ڵ� )


-- ������̺� ������/�� �� : 107
-- �μ����̺� ������/�� �� : 27
-- ī�׽þ� �� : 2889 rows ==> 107 * 27

SELECT 107 * 27
FROM    dual;


DESC employees;
/*
�̸�             ��?       ����           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)
*/

DESC departments;
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)
*/




-- 5.2 EQUI JOIN : �������(=)�� ����� JOIN ����(=���� ����)
-- �� ���̺��� ���� �÷� : department_id (manager_id : �μ����̺��� �ĺ���x)
-- ��ü ����� 107��, ��ȸ�� ��� 106�� <---> 1���� ����!!
-- ������ ������ ����� �����ؼ� ����� �ݿ� ==> ����ε� ���(��ü �������) ==> OUTER JOIN ó��!
-- �񱳵Ǵ� �������� INNER JOIN �̶�� �� �� ����.

-- �����̺��� �̿��� JOIN ==> ��� ���̺� � �÷������� ���!


[���� 5-2]
SELECT  e.employee_id, e.last_name,  -- �ֵ� ������ ��ȸ�Ϸ��� ���̺��� �÷�
        d.department_name -- �ΰ����� ����
FROM    employees e , departments d
WHERE   e.department_id = d.department_id;
-- ORA-00918: ���� ���ǰ� �ָ��մϴ�

[����5-3] ���̺��� Alias�� ����~

SELECT  e.employee_id, e.last_name,  -- �ֵ� ������ ��ȸ�Ϸ��� ���̺��� �÷�
        d.department_name -- �ΰ����� ����
FROM    employees , departments
WHERE   e.department_id = d.department_id;


[����5-4] (������̺�, �������̺��� �̿���) ���, �̸�, �����ڵ�, �������� ������ ��ȸ�Ѵ�.
DESC jobs;

SELECT  e.employee_id, e.first_name||' '||e.last_name name, e.job_id,
        j.job_title
FROM    employees e, jobs j      -- ī�׽þ� �� : 2,033  rows
WHERE   e.job_id = j.job_id
ORDER BY 1; -- 107 rows    vs   �������+�μ��̸� : 106 (1���� �μ��ڵ尡 NULL �̾..)

-- 1) ��� ~ �μ� : �������� 1��
-- 2) ��� ~ ���� : �������� 1��
-- 3) ��� ~ �μ� ~ ���� ~ ���� ~ ����(����) ~ ���
--  ===> JOIN �ϴ� ���̺��� ���� - 1 : ���������� ����

-- JOIN �ϴ� ��� ���̺��� �߰��Ǹ�, JOIN ������ �߰��Ѵ�.

[����5-5] (��� ���̺�, �μ� ���̺�, ���� ���̺��� �̿���) ���, �̸�, �μ���, �������� ������ ��ȸ�Ѵ�.
-- employees, departments, jobs
-- �������,  �μ�����,  ��������
--    department_id

SELECT  e.employee_id AS ���, e.first_name||' '||e.last_name name,
        d.department_name,
        j.job_title
FROM    employees e, departments d, jobs j
WHERE   e.department_id = d.department_id --1���� �μ��ڵ� x
AND     e.job_id = j.job_id
ORDER BY 1;

-- WHERE �������� JOIN ���ǰ� �Ϲ� ������ �Բ� ����Ѵ�.
[����5-6] ����� 101���� ����� ���, �̸�, �μ���, �������� ������ ��ȸ�Ѵ�.
-- ���, �̸� : employees --> e , emp ...
-- �μ��� : departments  --> d , dept ...
-- �������� : jobs       --> j , job ....
-- �� ���̺��� ������ JOIN ������ ���� : ���̺� ���� - 1 (JOIN������ ����)

SELECT  e.employee_id, e.first_name,
        d.department_name,
        j.job_title
FROM    employees e, departments d, jobs j
WHERE   e.department_id = d.department_id -- �μ��ڵ尡 ���� ��� 1��
AND     e.job_id = j.job_id
AND     e.employee_id = 101; 
-- ��� : �ĺ���(PK, Primary Key / NULL �������ʰ�, �ߺ����� �ʴ� ������ ��)
-- �� ��������(constraint) : ������ �Է��� �Ǽ�/����/���� �������� ��ġ











-- 5.3 NON-EQUI JOIN               VS      EQUI JOIN (����� INNER JOIN vs OUTER JOIN)
--     �񱳿�����(>, >=, <, <=)            �������(=)  
--     BETWEEN
--     IN
-- �� NO~ EQUI :  ������� �̿��� �����ڸ� ����� JOIN ����
-- �� JOIN �ϴ� �÷��� ��ġ���� �ʰ� ����ϴ� JOIN �������� < ���� ������� �ʴ´� >
-- ����������?? ==> �ϳ��� �����Ͷ� ��ġ�� �ʰ� OUTER JOIN�� �ξ� ���� ����Ѵ�.

[����5-7] �޿��� ���� ������ ���� ���� �ִ� 10�� �μ����� ���, �̸�, �޿�, ���������� ��ȸ�Ѵ�.
-- ����� ���� : employees [���, �̸�, �޿�]
-- �������� : jobs [��������]
/*
SELECT  e.employee_id, e.first_name, e.salary,
        j.job_title
FROM    employees e, jobs j -- ī�׽þ� �� : JOIN ������ ������� �ʾ�����, ������� �ʰ��Ǿ� ��Ÿ��
WHERE   e.job_id = j.job_id
AND     e.salary >= j.min_salary
AND     e.salary <= j.max_salary
AND     e.department_id = 50; -- 10�� �μ��� 1��
*/

SELECT  e.employee_id, e.first_name, e.salary,
        j.job_title
FROM    employees e, jobs j -- ī�׽þ� �� : JOIN ������ ������� �ʾ�����, ������� �ʰ��Ǿ� ��Ÿ��
WHERE   e.salary BETWEEN j.min_salary AND j.max_salary -- ������������ = �ƴ� �񱳿�����/BETWEEN ������/IN ������
AND     e.job_id = j.job_id
AND     e.department_id = 50;

-- �μ��� �����
SELECT department_id, COUNT(*) AS cnt
FROM    employees
GROUP BY department_id
ORDER BY 1;


-- �޿��� �ְ�, ������ : ��,���� ����
-- ���� ������ ���� ??
-- ���� ==> ���� ���̺� (JOBS)
DESC jobs;
/*
�̸�         ��?       ����           
---------- -------- ------------ 
JOB_ID     NOT NULL VARCHAR2(10) 
JOB_TITLE  NOT NULL VARCHAR2(35) 
MIN_SALARY          NUMBER(6)    
MAX_SALARY          NUMBER(6)
*/


-- 5.4 OUTER JOIN : EQUI JOIN �������� JOIN �ϴ� ���̺� �������� �����Ǵ� ���� 
-- ���� ����� ������� ��ȯ�Ѵ�. ������, OUTER JOIN�� �����Ǵ� ���� ���� ����� �������(?)
-- ��ȯ�Ѵ�.

-- �� �����Ǵ� ���� ���� ���̺� �÷��� (+) ��ȣ�� ǥ���Ѵ�.
-- �������̺��� �ݴ��� (+) ǥ��!!

[����5-8] ��� ����� ���, �̸�, �޿�, �μ��ڵ�, �μ��� ������ ��ȸ�Ѵ�.
-- department_id�� NULL�� ��� 1���� ���� �����Ǵ� ��� : EQUI JOIN ����
-- ������� : ���, �̸�, �޿�, �μ��ڵ� (employees)
-- �μ����� : �μ��� (departments)
SELECT  e.employee_id AS empno, e.first_name AS ename, e.salary AS esal,
        d.department_name AS dname
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+)  -- ORA-01468: outer-join�� ���̺��� 1���� ������ �� �ֽ��ϴ�
ORDER BY 1;


[����5-9] ��� ����� ���, �̸�, �޿�, �μ��ڵ�, �μ���, ��ġ�ڵ�, �����̸� ������ ��ȸ�Ѵ�.
SELECT  e.employee_id AS empno, e.first_name AS ename, e.salary AS esal,
        d.department_name AS dname,
        l.city AS city_of_dept
FROM    employees e, departments d, locations l -- 3���� ���̺�, JOIN ������ 2�� (���̺� ���� - 1��)
WHERE   e.department_id = d.department_id(+)  -- ORA-01468: outer-join�� ���̺��� 1���� ������ �� �ֽ��ϴ�
AND     d.location_id = l.location_id(+)
ORDER BY 1;



-- 5.5 SELF JOIN : �ϳ��� ���̺��� �� �� ����Ͽ�, ������ ���̺� �ΰ��κ��� JOIN�� ����
-- �����͸� ��ȸ�� ����� ��ȯ�Ѵ�.
-- 1) ������ ���̺��� �ΰ��ΰ� �� ������? (���������� ����Ǵ� ���� ����)
-- 2) �� �� ����Ѵ� (�޸𸮻�-�ӵ� ������!-���������� �ߺ��� ������ ���� �����ʰ�!! ���δٸ�,
-- ���̺��� �����ϴ� ��ó�� JOIN ����
-- �� ���̺� ���� : ��ȯ ����(���, Recursive)

[���� 5-10] ����� ���, �̸�, �Ŵ����� ���, �Ŵ����� �̸� ������ ��ȸ�Ѵ�.
-- ����� ���� : employees [��� �÷�, �̸�]
-- �Ŵ����� ���� : manager?? [��� �÷�, �̸�]

SELECT employee_id, first_name, manager_id
FROM    employees;

-- SELF JOIN
SELECT  e.employee_id, e.first_name,
        m.employee_id AS manager_id, m.first_name AS manager_name
FROM    employees e, employees m
WHERE   e.manager_id = m.employee_id -- ID : Identifity, ~ied. ������~! NULL ���
ORDER BY 1;

--- ����Ŭ JOIN ���� ------------------------------------------------------------------------
-- 1) ī�׽þ� ��(Cartesign Product) : ���� �������� ����������~ �߸��� ���(�ʹ����� �����)
-- 2) EQUI-JOIN (��������, =) <---> INNER JOIN(=���� ����) / ����� ����
-- 3) NON-EQUI JOIN (�񱳿�����,BETWEEN,IN) <---> EQUI-JOIN (��������� ���� ����)
-- 4) OUTER JOIN (=�ܺ� ����) <---> INNER JOIN�� �ݴ�Ǵ� ����
-- 5) SELF JOIN : �ϳ��� ���̺� ����� ������ �÷��� �̿��� �ڱ��ȯ ���� JOIN


--- 5.6 ANSI JOIN (�Ƚ� ����, p.48)
-- �̱� ǥ�� ��ȸ(American National Standards Institute, ANSI)
-- ����Ŭ DBMS�� �ƴ� �ٸ� DBMS���� ���������� ����� �� �ִ� ǥ�� ����� JOIN ����
-- ��� DBMS���� ..RDBMS(Relational DBMS/������ DBMS)



-- 5.6.1 INNER JOIN <---> ����Ŭ JOIN���� INNER JOIN�� ���, EQUI-JOIN! 
-- FROM���� INNER JOIN�� ����ϰ�, JOIN ����(=WHERE)�� ON ���� ����Ѵ�.

[����5-12](���) ����� ���, �̸�, �μ��ڵ�, �μ��� ������ ��ȸ�Ѵ�.

-- ����Ŭ JOIN
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+)
AND     e.manager_id IS NOT NULL
ORDER BY 1;

-- ANSI INNER JOIN
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM    employees e INNER JOIN departments d -- 1) FROM ���� INNER JOIN �� ��� : , ���!
ON   e.department_id = d.department_id       -- 2) JOIN ������ ON ���� ǥ�� : WHERE ���~ ON!
AND     e.manager_id IS NOT NULL
ORDER BY 1; -- 105��


-- ON�� ��� USING���� ����� �� �ִ�.
-- ��, USING �� ����Ҷ� �÷��� ����ؾ� �Ѵ�
-- �� ���� �÷� �̸��� ���  ==> ���̺��� ��Ī(Alias)�� ����!!

 -- 2) SELECT���� �����÷��� ���̺� ��Ī ����

SELECT  e.employee_id, e.first_name, department_id,
        d.department_name
FROM    employees e INNER JOIN departments d 
USING   department_id       -- 1) ON ��� USING (���� �÷���)
--AND     e.manager_id IS NOT NULL   -- �ؿ���
ORDER BY 1; -- 105��
--ORA-00933: SQL ��ɾ �ùٸ��� ������� �ʾҽ��ϴ� ==> SELECT ���� Ȯ��!
--00933. 00000 -  "SQL command not properly ended"

-- ORA-00906: ������ �°�ȣ    ==> USING (�����÷�)
-- 00906. 00000 -  "missing left parenthesis"


-- 5.6.2 OUTER JOIN <---> ����Ŭ JOIN���� (+)�� ����ϴ� OUTER JOIN�� ���� ����� �ϴ� ANSI JOIN







-- 5.6 ANSI JOIN  /  ANSI ��ȸ���� ���� ǥ�� JOIN ��(ORACLE�ܿ��� MYSQL, CUBRID, ��Ÿ RDBMS ���� JOIN)


-- 5.7 OUTER JOIN

