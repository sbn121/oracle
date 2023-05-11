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
-- ���̺��� �̿��� JOIN ==> ��� ���̺� � �÷������� ���!

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






-- 5.3 NON-EQUI JOIN



-- 5.4 OUTER JOIN


-- 5.5 SELF JOIN


-- 5.6 ANSI JOIN  /  ANSI ��ȸ���� ���� ǥ�� JOIN ��(ORACLE�ܿ��� MYSQL, CUBRID, ��Ÿ RDBMS ���� JOIN)


-- 5.7 OUTER JOIN

