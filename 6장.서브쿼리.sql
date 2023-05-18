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
  

-- 6.2 (���� �÷�) ���� �� ��������(p.53)
-- ���� �� ������ (IN, NOT, ANY(=SOME), ALL, EXISTS)

-- 6.2.1 IN ������
-- OR ������ ��� --> ����

SELECT employee_id, first_name, department_id
FROM    employees
--WHERE   department_id = 50
--OR      department_id = 80;
WHERE   department_id IN (50, 80);

[����6-5] �μ�(��ġ�ڵ�, location_id)�� ����(UK)�� �μ��ڵ�, ��ġ�ڵ�, �μ��� ������ ��ȸ�Ѵ�.
-- 1. ������ ��ġ�ڵ带 ��ȸ
SELECT  location_id
FROM    locations
WHERE   country_id = 'UK'; -- 2400, 2500, 2600 : ������ �μ� ������~

-- 2. ��������
SELECT  department_id, location_id, department_name
FROM    departments
--WHERE   location_id = (2400, 2500, 2600); 
WHERE   location_id = 2400
OR      location_id = 2500
OR      location_id = 2600
-- WHERE    location_id IN (2400, 2500, 2600)
-- ORA-01797: �������� �ڿ� ANY �Ǵ� ALL�� ������ �ֽʽÿ�  ==> = ANY () �� = ALL () ���·� �ۼ�
-- 01797. 00000 -  "this operator must be followed by ANY or ALL"

/*

> ANY : (�������� ���࿡ ���� ��ȯ����� ���������)  > �ּҰ�(MIN�Լ�) �� ����.
< ANY : (�������� ���࿡ ���� ��ȯ����� ���������)  < �ּҰ�(MAX�Լ�) �� ����.
= ANY : ��ġ�ϴ� �� �ϳ��� ������ TRUE ��� (�������� ���� ����� �������� ��ȯ�Ҷ�) ==> IN ������
= ALL : (�������� ���࿡ ���� ��ȯ����� ���������)  = ��� ����� ���ؼ� TRUE���� �ϴ� ���� ==> 
        ����� �ȳ����� ���
> ALL : (�������� ���࿡ ���� ��ȯ����� ���������) > �ִ밪(MAX�Լ�) �� ����.         
< ALL : (�������� ���࿡ ���� ��ȯ����� ���������) > �ּҰ�(MIN�Լ�) �� ����.         

NOT IN : <> ALL�� ���� ��� 
*/

[����6-10] 100�� �μ��� ����� �޿����� ���� �޿��� �޴� ����� ���, �̸�, �μ���ȣ, �޿��� �޿���
������������ ��ȸ�Ѵ�.

-- �׷��Լ� : COUNT(*) or COUNT(�÷���) or COUNT(DISTINCT �÷���)
-- COUNT() : NULL ����
-- 100�� �μ��� ��ȸ ==> �׷캰 ����� �� ����
SELECT department_id, COUNT(*) AS cnt
FROM    employees
GROUP BY department_id
ORDER BY 1;

SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE   department_id = 100
ORDER BY 3;


SELECT  employee_id, first_name, department_id, salary
FROM    employees
WHERE   salary < ALL (  SELECT   salary
                    FROM    employees
                    WHERE   department_id = 100 )  -- 6900, 7700, 7800, 8200, 9000, 12008
ORDER BY salary;                    
-- ORA-01427: ���� �� ���� ���ǿ� 2�� �̻��� ���� ���ϵǾ����ϴ�. ==> ANY ? ALL! 

-- 6.2.2 NOT ������
-- NOT IN �����ڿ� <> ALL�� ���� ���
-- ^=, <>, != : ��������
[����6-16] �μ����̺��� �μ��ڵ尡 10,20,30,40�� �ش����� �ʴ� �μ��ڵ带 ��ȸ�Ѵ�.
SELECT department_id, department_name
FROM    departments
WHERE   department_id NOT IN (10,20,30,40); -- ��ü�μ� : 27�� (10 ~ 270)  ==> <> ALL ���� ���

SELECT department_id, department_name
FROM    departments
WHERE   department_id <> ALL (10,20,30,40); -- 23rows

SELECT department_id, department_name
FROM    departments
WHERE   department_id <> ANY (10,20,30,40); -- 27rows ==> 10�� ��, 20~270 / 20�� �� , 10,30~270
-- ORA-01797: �������� �ڿ� ANY �Ǵ� ALL�� ������ �ֽʽÿ�

SELECT department_id, department_name
FROM    departments
WHERE   department_id <> (10,20,30,40);
-- ORA-01797: �������� �ڿ� ANY �Ǵ� ALL�� ������ �ֽʽÿ�

SELECT department_id, department_name
FROM    departments
WHERE   department_id != (10,20,30,40);
-- ORA-01797: �������� �ڿ� ANY �Ǵ� ALL�� ������ �ֽʽÿ�
-- NOT IN �����ڿ� <> ALL�� ������ ����� �Ѵ�.
-- 6.2.3 ANY(=SOME) ������
-- 6.2.4 ALL ������




-- 6.3 (���� ��,���� ��) ���� �÷� �������� (p.57)
-- ���������� ��������ó�� �������� �÷��� (���ϴµ�) ����� �� �ִ�.
-- WHERE ���� (�÷���1,�÷���2...) ó�� �ۼ�
-- �÷��� ������ ������ Ÿ���� ��ġ�ؾ� ��.
[����6-18] �Ŵ����� ���� ����� �Ŵ����� �ִ� �μ��ڵ�, �μ����� ��ȸ�Ѵ�.
-- ���������� ��� ��ȸ�� ����! ==> ���������� ������� �˸�, ������ �����ϰ� ���ϼ� �ִ�.
SELECT  department_id, department_name
FROM    departments
WHERE   (department_id, manager_id) IN ( SELECT  department_id, employee_id
                                                 FROM   employees
                                                 WHERE  manager_id IS NULL );

-- �����÷� �������� ==> �ѹ��� �ΰ��̻��� �÷��� ���ϴ� ��������
-- �з� ==> ���� ������� ������ ���� ==> ���� ���� vs �����Ҽ��� ?
desc departments;


-- ====== ���� �� / ���� �� / ���� �÷� �������� PART 1) ~ 3)===============

-- 6.4 ��ȣ���� ��������(p.57) / EXISTS ������(��ȣ���������������� ���)
-- ��ȣ : ����~   /   ���� : ����~ ���� ==> JOIN����    vs   SET ����
-- ���������ε�, JOIN������ Ȱ���� ��������! ==> ���������� ���̺�� ���������� ���̺��� JOIN ������ ���ȴ�.
-- ���������� �÷��� ���������� �������� ���Ǿ� ���������� ���������� ���� 

[����6-19] �Ŵ����� �ִ� �μ��ڵ忡 �Ҽӵ� ������� ���� ��ȸ�Ѵ�.
-- ���� ��� �� ����� ��ȯ�ϴ� �Լ� : COUNT() / �׷��Լ�
-- �Ŵ����� ���� �μ��ڵ� : 90�� vs �Ŵ����� �ִ� �μ��ڵ� 10~80, 100~110


SELECT *
FROM    departments;

SELECT  COUNT(*) AS �����
FROM    employees e
WHERE   department_id IN ( SELECT    department_id
                           FROM      departments d
                           WHERE     manager_id IS NOT NULL
                           AND       NVL(e.department_id, 0) = d.department_id ); 

-- ������̺��� �μ��ڵ尡 NULL�� ��� : 1�� / Ŵ����~
-- NULL ó�� �Լ� : NVL(), NVL2(), COALESCE()                           

-- ORA-00904: "E"."DEPARTMENT_ID": �������� �ĺ��� : ��ȣ������������ ==> ���� ���� ==> �������� �ܵ������ ����

-- IN �����ڸ� EXISTS �����ڷ� �ٲ� ����� �� �ִ�.
SELECT  COUNT(*) AS �����
FROM    employees e
WHERE   EXISTS ( SELECT    1
                 FROM      departments d
                 WHERE     manager_id IS NOT NULL
                 AND       e.department_id = d.department_id );
-- ORA-00920: ���� �����ڰ� �������մϴ� : IN ��� EXISTS�� ����Ҷ��� WHERE���� �� �÷��� ����� ��.
-- EXISTS �����ڴ� ���������� ����� ���� ���θ� �Ǵ��Ѵ� ==> 
-- EXISTS �����ڸ� ����Ҷ�, ���������� SELECT ��ϰ��� ������ ���� ���� �÷����� JOIN ������ �ٽ��̴�.
-- �����÷� ������������ �з��� �� �� �ִ� --> ������ ���� �ִ� --> �� ���� ����� �� �ִ�??
-- ��ȣ���� ���������� �������� ������� ���������� ���� ==> �ӵ����̰� �߻��� �� �ִ�!


-- ============ ���������� ���� ���� =================================================================
-- 1) �������� ����࿡ ���� ���� : ���� ��, ������, ���� �÷���
-- 2) �������� ���� ����(=JOIN���� ���) : ��ȣ���� ��������
-- 3) �������� �����ġ�� ���� ���� : ��Į�� ��������, �ζ��� �� ����������, (�Ϲ�, WHERE���� )����������
-- ==================================================================================================


-- 6.5 ��Į�� ��������
-- ��Į�� : (����) ������ ���� �ʰ� ũ�⸸ ���� ����(1����) vs ���� : ũ��� ������ ��� ���� ����(2����)
-- SELECT ���� ����ϴ� �������� ==> SELECT ���� �÷�(�ϳ��ϳ�)�� �ۼ��ϴ� ��(CLAUSE, ��)
-- �ڵ强 ���̺��� �ڵ���� ��ȸ�ϰų� �׷��Լ��� ������� ��ȸ�Ҷ� ����Ѵ�. / �ִ밪,�ּҰ�,�հ�,���,����..

[����6-22] ����� �̸�, �޿�, �μ��ڵ�, �μ����� ��ȸ�Ѵ�.
-- JOIN ����
-- employees: �̸�, �޿�, �μ��ڵ�
-- departments : �μ���

SELECT  first_name, salary, department_id,
        ( SELECT    department_name
          FROM      departments d
          WHERE     e.department_id = d.department_id ) AS department_name -- ��Į�� �������� , ������ ���� �������� - ��ȣ���� ��������
          --WHERE     NVL(e.department_id, 0) = d.department_id ) AS department_name
FROM    employees e;        

-- �ڵ强 ���̺�?? �μ���ձ޿��� ����ص� �������� ���̺��� ������, �ִ°�ó�� ���������� ��ȸ
[����6-23] ����� ���, �̸�, �޿�, �μ��ڵ�, �μ���ձ޿�
-- ROUND() : �Ҽ���/������ �ڸ����� �ݿø� �Լ�
-- AVG() : ��հ��� ���Ͽ� ��ȯ�ϴ� (�׷�)�Լ�
-- TO_CHAR() : �ڸ���, ������ȭ
SELECT  employee_id, first_name, TO_CHAR(salary, '999,999'), department_id, 
        ( SELECT    ROUND(AVG(salary))
          FROM      employees e1
          WHERE     e1.department_id = e2.department_id ) AS dept_avg_sal
FROM    employees e2;



-- 6.6 �ζ��� �� ��������
-- FROM ���� ���Ǵ� �������� ==> FROM���� ���̺� ���� ==> �ζ��� �� ������
-- �� : ������ ���̺�(=�޸𸮿��� ����, ���� ����� �޸𸮿��� ����, ����� ��ȯ�ϰ� �������..)
-- SELECT ���� ���Ǵ� �������� ==> ��Į�� ��������
-- ���� ������ �������̰� ==> ������ ���̺��̴ϱ�
-- WHERE ���� ���� ������ ���̺�� JOIN�� ���� ���踦 �δ´�.

--> ������ WHERE���� (�Ϲ�) �������� : ���� ���� ����Ѵ�.

[����6-24] �޿��� ȸ�� ��ձ޿� �̻��̰�, �ִ�޿� ������ ����� ���, �̸�, �޿�, 
ȸ����ձ޿�, ȸ���ִ�޿��� ��ȸ�Ѵ�.
-- HR ���� : ȸ���� �޿���� ���� ���̺��� ���� ==> �������� �ִ°�ó�� �������� ��ȸ

SELECT  employee_id, first_name, salary,
        avg_sal, max_sal
FROM    employees,
        (   SELECT  ROUND(AVG(salary)) AS avg_sal, MAX(salary) AS max_sal
            FROM    employees  ) 
--WHERE   e.salary >= a.avg_sal 
--AND     e.salary <= a.max_sal;
WHERE   salary BETWEEN avg_sal AND max_sal;  

-- JOIN ������ NON-EQUI JOIN ���� : = �̿��� �����ڻ���ϴ� JOIN����(�����񱳿�����, BETWEEN, IN)
-- ���� ������� �ʴ� ����
-- NON-EQUI JOIN������ �ζ��� �� �������� ==> ���̺��� ��Ī�� AS�� �����ϰ�, �÷��� ���̴� ��� �����߻�!
SELECT  e.employee_id, e.first_name, e.salary,
        a.avg_sal, a.max_sal
FROM    employees e,
        (   SELECT  ROUND(AVG(salary)) AS avg_sal, MAX(salary) AS max_sal
            FROM    employees  ) AS a 
--WHERE   e.salary >= a.avg_sal 
--AND     e.salary <= a.max_sal;
WHERE   e.salary BETWEEN a.avg_sal AND a.max_sal;  
-- ORA-00933: SQL ��ɾ �ùٸ��� ������� �ʾҽ��ϴ� : ��Ÿ�� �޸�, AND �������θ� Ȯ�� (������ü����)



[����6-25, 26] ���� �Ի� ��Ȳ ���̺��� ������, �ζ��� �� �������� ��������, ���� �Ի��� ��Ȳ�� ��ȸ�Ͻÿ�
-- �䱸�Ǵ� ���̺��� ����
-- 1��  ...6��... 12��
-- 14(��)..11(��)...7��(��)
-- 1) ������� �ϳ��̴�.
-- 2) �÷��� ���� 1��~12������ 12��
-- 3) �����ʹ� ������� �հ��̴�.
-- DECODE / �Լ�     vs     CASE ~ END / ǥ����    <------> ����Ŭ IF~ELSE��!
--  ����񱳸�!                    �����, ������~
-- DECODE (exp, search1, result1,            CASE exp WHEN search1 THEN result      or  CASE WHEN condition THEN result
--              search2, result2,                      WHEN search1 THEN result 
--              ....���...                            ELSE �⺻��
--              0 ) AS ��Ī                  END AS ��Ī

--     TO_CHAR()       TO_DATE()
-- ���� --------> ���� ----------> ��¥
--      <-------- ���� <---------- ��¥
--    TO_NUMBER()      TO_CHAR()
-- ���� --> ��¥ ��ȯ�ȵǹǷ�, ��ȯ�Լ��� Ȱ��!
-- ��¥���� ==> NLS Ȯ�� �ʿ�!

SELECT  DECODE(TO_CHAR(hire_date, 'MM'), '01', COUNT(*), 0) AS "1��",
        DECODE(TO_CHAR(hire_date, 'MM'), '02', COUNT(*), 0) AS "2��",
        DECODE(TO_CHAR(hire_date, 'MM'), '03', COUNT(*), 0) AS "3��",
        DECODE(TO_CHAR(hire_date, 'MM'), '04', COUNT(*), 0) AS "4��",
        DECODE(TO_CHAR(hire_date, 'MM'), '05', COUNT(*), 0) AS "5��",
        DECODE(TO_CHAR(hire_date, 'MM'), '06', COUNT(*), 0) AS "6��",
        DECODE(TO_CHAR(hire_date, 'MM'), '07', COUNT(*), 0) AS "7��",
        DECODE(TO_CHAR(hire_date, 'MM'), '08', COUNT(*), 0) AS "8��",
        DECODE(TO_CHAR(hire_date, 'MM'), '09', COUNT(*), 0) AS "9��",
        DECODE(TO_CHAR(hire_date, 'MM'), '10', COUNT(*), 0) AS "10��",
        DECODE(TO_CHAR(hire_date, 'MM'), '11', COUNT(*), 0) AS "11��",
        DECODE(TO_CHAR(hire_date, 'MM'), '12', COUNT(*), 0) AS "12��"
FROM    employees
-- WHERE
GROUP BY TO_CHAR(hire_date, 'MM')
ORDER BY TO_CHAR(hire_date, 'MM');
-- �׷��Լ��� ���� �����κ��� �ϳ��� ������� ��ȯ�Ѵ�.


-- ���������� �ζ��� �� �ǽ���
-- ���� ==> ���輺 ���̺��� ���� DB�� �ݿ��ϰ�, ��� �濵�ϴµ� �ʿ��� �����ͷ� �����ؼ� �����ؾ���!
-- ���̺��� �����Ͱ� ��û���� ������, ���ε����� �����ϸ� ó���ӵ�/�����ð� ==> ���̺��� �Ϻθ� �����Ҷ� ���



-- ROWNUM �Ǵ� ROW_NUMBER()  : ���̺� �������� �ʴ� �ǻ��÷�(Pseudo Column)����, SELECT����
-- ============= ��ũ(����) ���� �Լ� ================
-- ROW_NUMBER () OVER (rank_clause) : 1,2,3,4,5,... (�������� ǥ�� x)
-- RANK() : �Ϲ����� ���� �Լ�    :  1,2,3,3,5,... (�������� ǥ��, ��������+1 ǥ�� )
-- DENSE_RANK() : RANK �Լ�ó�� ���� �Լ�   : 1,2,3,3,4,... (������ ǥ��, �������� ǥ��) 

-- AVERAGE_RANK() : ��հ��� �̿��� ���� �Լ� : 1,2,3.5,3.5,5,.. (������ �Ǽ��� ǥ��, ��������+1 ǥ��)
-- �� ����Ŭ 21c ������ ����ȵ�.(���ŵǰų� �ٸ� �Լ��� ����Ǿ��� ���ɼ�)




-- WHERE ���� ����Ѵ�.
-- �������� ���� ����� ���� �� �࿡ ���� �������� ��Ÿ����.

SELECT ROWNUM AS rank, employee_id, first_name, salary
FROM    employees
WHERE   ROWNUM <= 5
ORDER BY salary DESC;

[���� 6-27] ���, �̸��� 10�� ��ȸ�Ѵ�.
SELECT  employee_id, first_name
FROM    employees
WHERE   ROWNUM <= 10;


[����6-28]
SELECT ROWNUM AS rank, e.*
FROM    (   SELECT  employee_id, last_name, salary
            FROM    employees   
            ORDER BY    salary DESC ) e
WHERE   ROWNUM <= 10;       

-- �����Լ��� ����Ҷ�
SELECT  employee_id, last_name, salary,
        ROWNUM AS,                                                   -- 1,2,3,4,.. + �ζ��κ� ��������
        RANK() OVER(ORDER BY salary DESC) AS rank1,            -- 1,2,3,3,5,6,....
        DENSE_RANK() OVER(ORDER BY salary DESC) AS rank2      -- 1,2,3,3,4,5,6....
--        AVERAGE_RANK() OVER(ORDER BY salary DESC) AS salary_rank   1,2,3.5,3.5,5,6,7...
FROM    employees;

-- ����Ŭ21c ������ ORA-00904: "AVERAGE_RANK": �������� �ĺ��� <--> AVERAGE_RANK() �Լ� ��� 
-- �̸��� �ٲ��ų�,..��� ������ ����� ���� �ʴ��� Ȯ�� �ʿ�!!




