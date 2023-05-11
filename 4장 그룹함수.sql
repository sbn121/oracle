-- 4��. �׷� �Լ�
-- �׷����, �׷� ���� �����͸� ��ȸ
-- �μ��� �޿� �հ�, �޿� ��� ��ȸ�ϰ��� �Ҷ� / �հ�, ���, �ְ�, ������ ������� ����� ���ϱ� ���� �Լ�

-- 4.1 DISTINCT
-- �ߺ��� ������ ����� ��ȯ�ϴ� �Լ� --> SYSDATEó�� �Ķ���Ͱ� ����.
-- DISTINCT �÷���1, �÷���2, ... : ��� �÷��� (�ߺ�����)����ȴ�.
-- NULL�� �������� ����.

[���� 4-1] ������� �Ҽӵ� �μ��� ��ȸ�Ѵ�.
-- DISTINCT  :�ߺ��� ������ ����� �����ش� �Լ�
SELECT DISTINCT department_id
FROM    employees; 

-- ALL : �ߺ��� ������ ����� �����ִ� �Լ� (�⺻���̹Ƿ� ��ҿ��� ������ �Ͱ� ����)
SELECT ALL department_id
FROM    employees;

-- DEPARTMENTS ���̺� : 27�� �μ� (11�� �μ��� ����� �Ҽ�, ������??)
/*
           �μ�(�ڵ�)
------------------------------------------------
...
��浿     �Ǹ� [10]
ȫ�浿     �ѹ� [20]
�̼���     �Ǹ� [10]
������     �Ǹ� [10]
...
*/


[���� 4-1] ������� �Ҽӵ� �μ��� ����� ��ȸ�Ѵ�.
-- �÷����� �����ؼ� �ߺ��� ���� ==> _ID : �ĺ���(�ߺ����� ���� ������ ��, NULL ���x)
SELECT DISTINCT department_id, employee_id
FROM    employees; --107 rows


-- 4.2 COUNT() : ������ ���� �� �� �����ϴ��� ������ ��� ��ȯ�ϴ� �Լ�
-- �����Ͱ� NULL�� ���� ���ܵȴ�.

[���� 4-3]
-- * : �ֽ��͸���ũ / ��� ��
-- �˻��ӵ��� ���̰� �ִٰ� �˷��� ����.
-- ������� 10~110�� �μ��� �ҼӵǾ� ����.
SELECT COUNT(*), COUNT(employee_id), COUNT(department_id), -- Ŵ����~ ����
        COUNT(DISTINCT department_id)
FROM    employees;


-- 4.3 SUM() : ���� ������ �÷��� ��ü �հ踦 ����Ͽ� �� ����� ��ȯ�ϴ� �Լ�
-- �����ʹ� �̱� ����, salary�� $ ����!
SELECT TO_CHAR(SUM(salary), 'L999,999') AS �޿�����, 
       TO_CHAR(ROUND(SUM(salary) / COUNT(*), 0),'9,999') AS �޿����
FROM    employees;


-- 4.4 MAX() : ������ �÷����� ���� ū ���� ��ȯ�ϴ� �Լ�
-- 4.5 MIN() : ���� ���� ���� ��ȯ�ϴ� �Լ�

-- ��� ������ ������ ���! (���ڵ����� �÷����� ����ϴ� �� �ƴϴ�??)
    
-- (��)�޿�
-- ����(12*���޿�)
SELECT MAX(salary) AS �ְ�޿���, --24000$
       MIN(salary) AS �����޿���  --2100$
FROM    employees;

[���� 4-6]
SELECT  employee_id, first_name||' '||last_name AS name, job_id, salary
FROM    employees
--WHERE   salary = 24000
--OR      salary = 2100;
WHERE   salary IN (24000,2100);

SELECT  *
FROM    job_history; -- ���/�����/�����/����(����)/�μ��ڵ�

SELECT  *
FROM    jobs; -- ����(����)/��������/�����޿�/�ְ�޿�

----- �޿� : ������ �������� �ִ�.
-- AD_PRES : ��ǥ��
-- ST_CLERK : ��� �����
-- �ְ�ݾ� vs �����ݾ� 10�� ������ ����?


-- MAX(), MIN() : ��� ������ �÷����� ��� ����
DESC employees;

SELECT employee_id, first_name, MAX(hire_date), MIN(hire_date), MAX(commission_pct), MIN(commission_pct)
FROM    employees
WHERE   commission_pct IS NOT NULL; -- �ǸŻ������ �Ի���(�ְ�, ����), Ŀ�̼���(�ְ�, ����)
--ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
--00937. 00000 -  "not a single-group group function"
-- �׷��Լ��� ������� �ʰ�, �Բ� ������ �Ϲ� �÷��� ��� GROUP BY ���� ��ø� �ؾ���!!

SELECT MAX(hire_date), MIN(hire_date)
FROM    employees; -- 08/04/21,           01/01/13
                   -- ���� ���� �Ի���, ���� ���� �Ի���
                   
SELECT employee_id, first_name, hire_date, commission_pct, department_id
FROM    employees
WHERE   hire_date = '08/04/21';

SELECT MAX(commission_pct), MIN(commission_pct)
FROM    employees
WHERE   commission_pct IS NOT NULL; -- 0.4  / 0.1

SELECT employee_id, first_name, hire_date, commission_pct, department_id
FROM    employees
WHERE   commission_pct = 0.4;


-- 4.6 AVG() : ���ڵ����� �÷��� ��հ��� ����� ����� ��ȯ�ϴ� �Լ�

SELECT SUM(salary) AS �޿��Ѿ�,
       ROUND(AVG(salary)) AS �޿����1,
       ROUND(SUM(salary)/COUNT(*)) AS �޿����2
FROM    employees;


-- ���ݱ��� �����ߴ� SQL ����
SELECT
FROM
WHERE
GROUP BY
ORDER BY -- ���� �������� �ۼ��Ѵ�(*)

-- 4.3 GROUP BY �� (�׷��Լ�)
-- 1) Ư�� ������ ����Ͽ� ������ ���� �ϳ��� �׷����� ���� �� �ִ�.
-- 2) �׷����� ������ �Ǵ� �÷��� �����Ѵ�.
-- �׷��Լ��� ����� �÷��� �Ϲ� �÷��� �Բ� select���� �ۼ��� ���,
-- GROUP BY ���� �߰��ؼ� �׷����� ���� �÷��� ����ؾ� '����'�� �߻����� ����.
-- SELECT ��Ͽ� ���Ǵ� �׷� �Լ� �̿��� �÷��� �ݵ�� GROUP BY ���� ����ؾ� �Ѵ�!!!

[���� 4-8] �μ��� <=== (�μ��� ����) �޿� �Ѿ�, ��� ��, ��� �޿��� ��ȸ�Ѵ�.

SELECT department_id, TO_CHAR(SUM(salary), '999,999') AS �޿��Ѿ�, COUNT(*) AS �����, TO_CHAR(ROUND(AVG(salary)), '999,999') AS ��ձ޿�
FROM    employees
GROUP BY department_id
ORDER BY 1;


-- SELECT���� �Ϲ��÷�, �׷��Լ��� ������ ���� ���� ���� ===> GROUP BY ������ ���صǴ� �÷��� ǥ���ؾ� ��
SELECT TO_CHAR(SUM(salary), '999,999') AS �޿��Ѿ�, COUNT(*) AS �����, TO_CHAR(ROUND(AVG(salary)), '999,999') AS ��ձ޿�
FROM    employees
GROUP BY department_id
ORDER BY 1;

[���� 4-9] �μ���, ������ <=== (�μ��� ����) �޿� �Ѿ�, ��� �޿��� ��ȸ�Ѵ�.

SELECT department_id, job_id, TO_CHAR(SUM(salary), '999,999') AS �޿��Ѿ�, COUNT(*) AS �����, TO_CHAR(ROUND(AVG(salary)), '999,999') AS ��ձ޿�
FROM    employees
GROUP BY department_id, job_id
ORDER BY 1;

[���� 4-10] 80�� �μ��� �޿��Ѿװ� ��ձ޿��� ��ȸ�Ѵ�.
SELECT  department_id, 
        TO_CHAR(ROUND(SUM(salary)), '999,999') AS �޿��Ѿ�, 
        TO_CHAR(ROUND(AVG(salary)), '999,999') AS ��ձ޿�
FROM    employees
WHERE   department_id = 80
GROUP BY department_id;

-- HAVING
SELECT
FROM
WHERE       -- �Ϲ� ������
GROUP BY    
HAVING      -- �׷��Լ� ������
ORDER BY    -- �׻�, SQL �������� ��ġ!
-- ======================SQL �ۼ� ����======================


-- 4.4 HAVING ��
-- HAVING ���� ����Ͽ� �׷��� �����Ѵ�.
-- WHERE ������ ����ϴ� ������ HAVING ���� ����� ���� ������, ==> �Ϲ������϶�
-- �׷��Լ��� ���Ե� ������ HAVING �������� ����� �� �ִ�. ==> ex) ��


[���� 4-11] 80�� �μ��� ��ձ޿��� ��ȸ�Ѵ�.
SELECT  department_id, ROUND(AVG(salary), 0) AS avg_sal
FROM    employees
--WHERE   department_id = 80; -- 8956 $
GROUP BY department_id
HAVING  department_id = 80; -- 8956$


-- �μ��� ��� �� ��ȸ
-- where ���� �ĺ��� ��� x
-- �׷� �Լ��� �㰡���� �ʽ��ϴ� : where ���� �׷��Լ� ��� x
-- where �� ���� ����!, having, group by  : �׷��Լ��� �Բ� ����� ��
SELECT  department_id, COUNT(*) AS cnt
FROM    employees
--WHERE   cnt(*) <= 5
GROUP BY department_id
ORDER BY 1;

-- 4.5 ROLLUP, CUBE
-- �м��� �Լ�
-- 4.5.1 ROLLUP : GROUP BY ���� ROLLUP �Լ��� ����� GROUP BY ������ ���� ����� �Բ�,
--                �ܰ躰 �Ұ�, �Ѱ�
-- 4.5.2 CUBE : ROLLUP �� ����, **��� ����� ���տ� ����** �Ұ�, �Ѱ� ������ ���� �� �ִ�.
--              ==> ��µǴ� ������ �� ��? ����ȭ/�ٸ���

[���� 4-13] �μ��� ��� ���� �޿��հ�, (���, �޿�)�Ѱ踦 ��ȸ�Ѵ�.
SELECT  department_id, job_id, COUNT(*), SUM(salary)
FROM    employees
GROUP BY CUBE(department_id, job_id)
ORDER BY 1;













