[��������4-2]

1. ��� ���̺��� Ŀ�̼��� �޴� ����� ��� ������� �� ���� ��ȸ�ϴ� �������� �ۼ��Ѵ�
-- NULL�� ���� ����
SELECT  COUNT(commission_pct) AS "Ŀ�̼� �޴� ��� ��"
FROM    employees;  -- 35rows

SELECT  *
FROM    employees
WHERE   commission_pct IS NOT NULL;

2. ���� �ֱٿ� ���� ������ �Ի��Ų ��¥�� �������� �ֱ� �Ի����ڸ� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT  MAX(hire_date)
FROM    employees; -- 08/04/21

SELECT  employee_id, first_name, hire_date
FROM    employees
WHERE   hire_date = '08/04/21';
--ORDER BY 3 DESC;

3. 90�� �μ��� ��ձ޿����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, ��ձ޿����� �Ҽ� ��°�ڸ����� ǥ��ǵ��� �Ѵ�)
-- SUM(), AVG() : ���� ������ �÷��� ��/����� ����Ͽ� ��ȯ�ϴ� �Լ�
-- MAX(), MIN() : ��� ������ �÷��� ���밡��
-- ROUND(n, [, i]) : �Ҽ��� ���� i��° �ڸ��� �ݿø��� ����� ��ȯ�ϴ� �Լ�
-- i�� ������, �����ο��� i��° �ڸ��� �ݿø��� ����� ��ȯ�ϴ� �Լ�
-- ��¥�����Ϳ��� ROUND(date [,fmt]) �������� �ݿø��� ����� ��ȯ

SELECT  TO_CHAR(ROUND(AVG(salary), 2), '999,999') AS ��ձ޿���1,
        ROUND(AVG(salary), 2) AS ��ձ޿���2
FROM    employees
WHERE   department_id = 90;