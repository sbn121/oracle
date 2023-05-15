[��������5-2]


1. ����� 110, 130, 150�� �ش��ϴ� ����� ���, �̸�, �μ����� ��ȸ�ϴ� �������� ANSI JOIN����
�ۼ��Ѵ�.
--                                  SQL              vs      NoSQL
-- ����Ŭ �н� ==> ȸ��~ ����!! [MySQL, MSSQL,..]            mongoDB, firebase,.. [DOCUMENT, COLLECTION]
SELECT  e.employee_id, e.first_name,
        d.department_name
FROM    employees e INNER JOIN departments d
ON      e.department_id = d.department_id
AND     e.employee_id IN (110, 130, 150); -- 107rows




2. ��� ����� ���, �̸�, �μ���, �����ڵ�, ���������� ��ȸ�Ͽ� ��� ������ �����ϴ� ������ �ۼ��Ѵ�.
SELECT  e.employee_id, e.first_name,
        d.department_name,
        j.job_title
FROM    employees e LEFT OUTER JOIN departments d
ON      e.department_id = d.department_id
INNER JOIN jobs j
ON      e.job_id = j.job_id
ORDER BY 1; -- 107 rows



-- ����Ŭ OUTER JOIN
SELECT  e.employee_id, e.first_name,
        d.department_name,
        j.job_title
FROM    employees e, departments d, jobs j
WHERE      e.department_id = d.department_id(+)
AND      e.job_id = j.job_id
ORDER BY 1;
