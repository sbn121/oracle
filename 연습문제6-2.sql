[��������6-2]

1. �μ���ġ�ڵ尡 1700�� �ش��ϴ� ��� ����� ���, �̸�, �μ��ڵ�, �����ڵ带 ��ȸ�ϴ� ��������
������ ���������� �ۼ��Ѵ�.
-- ����� ������ �� ==> IN, ANY(=SOME), ALL �̷���~

-- 1.1 �������� ���� ��ȸ

-- 1.2 ���������� ��ȸ
SELECT  employee_id, first_name, department_id, job_id
FROM    employees
WHERE   department_id IN  ( SELECT department_id
                          FROM  departments
                          WHERE location_id = 1700 );   -- 18rows

-- = ANY , IN �Ѵ� ����

SELECT department_id, department_name
FROM  departments
WHERE location_id = 1700; -- 10, 30, 90, 100, 110   /  120~270: �μ��� ����, ����� �Ҽ�x




-- ���� �޿��� ���� �޴� : MAX(salary) ==> ���� �� �Լ� ==> ���� �� �������� Ư¡!!
2. �μ����� ���� �޿��� ���� �޴� ����� ���, �̸�, �μ���ȣ, �޿�, �����ڵ带 ��ȸ�ϴ� ��������
���� �÷� ���������� ����Ͽ� �ۼ��Ѵ�.
-- �÷��� ����, �����Ͱ� ��ġ�ϴ� ���� �÷�/���� ��


SELECT  employee_id, first_name, department_id, salary, job_id
FROM    employees
WHERE   (department_id, salary) = ANY ( SELECT department_id, MAX(salary)
                                         FROM    employees
                                         GROUP BY department_id );
                                         
-- = ANY �Ǵ� IN ������ : ����ó��~                                         