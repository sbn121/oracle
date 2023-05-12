[��������5-1]

1. �̸��� �ҹ��� v�� ���Ե� ��� ����� ���, �̸�, �μ����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT  e.employee_id, e.first_name, 
        d.department_name 
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+) -- ����Ŭ �ƿ��� ����
AND     e.first_name LIKE '%v%';


2. Ŀ�̼��� �޴� ����� ���, �̸�, �޿�, Ŀ�̼� �ݾ�, �μ����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, Ŀ�̼� �ݾ��� ���޿��� ���� Ŀ�̼� �ݾ��� ��Ÿ����)
-- commission_pct : NULL (�Ǹźμ��� �ƴ� �����)
-- NULL ó�� : �񱳴��x ==> NVL(), NVL2()
-- Ŀ�̼� �ݾ� : salary * commission_pct
-- Ŀ�̼� �޴� ��� : 35��(1���� �μ��� ������)
SELECT  e.employee_id, e.first_name, TO_CHAR(e.salary, '999,999'), TO_CHAR(e.salary * e.commission_pct, 'L999,999') AS comm_pct,
        d.department_name
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+)
AND     e.commission_pct IS NOT NULL
ORDER BY 3;


3. �� �μ��� �μ��ڵ�, �μ���, ��ġ�ڵ�, ���ø�, �����ڵ�, �������� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
-- ���� ���̺� : �μ����� ���̺�(�μ��ڵ�, �μ���, ��ġ�ڵ�)
-- ������̺� : ��ġ

SELECT  d.department_id, d.department_name, d.location_id,
        l.city, l.country_id, 
        c.country_id, c.country_name
FROM    departments d, locations l, countries c
WHERE   d.location_id = l.location_id
AND     l.country_id = c.country_id
ORDER BY 1;

4. ����� ���, �̸�, �����ڵ�, �Ŵ����� ���, �Ŵ����� �̸�, �Ŵ����� �����ڵ带 ��ȸ�Ͽ�
����� ��� ������ �����ϴ� �������� �ۼ��Ѵ�.
-- ��ȯ����(SELF JOIN)
SELECT  e.employee_id, e.first_name, e.job_id,
        m.employee_id AS manager_id, m.first_name AS manager_name, m.job_id AS job_id
FROM    employees e, employees m
WHERE   e.employee_id = m.employee_id;


5. ��� ����� ���, �̸�, �μ���, ���ø�, �����ּ� ������ ��ȸ�Ͽ� ��� ������ �����ϴ�
�������� �ۼ��Ѵ�.

SELECT  e.employee_id, e.first_name, 
        d.department_name, 
        l.city, l.street_address
FROM    employees e, departments d, locations l
WHERE   e.department_id = d.department_id(+)
AND     d.location_id = l.location_id(+)
ORDER BY 1;

-- ����Ŭ JOIN ����
-- 1) ī�׽þ� ��(Cartesign Product) : ���� �������� �������� ��~ �߸��� ���(�ʹ� ���� �����)
-- 2) EQUI-JOIN (��������, =) <---> INNER JOIN(=���� ����)
-- 3) NON-EQUI JOIN (�񱳿�����, BETWEEN, IN) <---> EQUI-JOIN (����� ���� ���� ����)
-- 4) OUTER JOIN(=�ܺ� ����) <---> INNER JOIN�� �ݴ�Ǵ� ����
-- 5) SELF JOIN : �ϳ��� ���̺� ����� �÷��� �̿��� �ڱ��ȯ ���� JOIN


        