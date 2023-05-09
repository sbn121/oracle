-- ��������3-2


1. ��� ���̺��� �̸�(first_name)�� A�� �����ϴ� ��� ����� �̸��� �̸��� ���̸� ��ȸ�Ѵ�
SELECT  first_name, LENGTH(first_name)
FROM    employees
WHERE   first_name LIKE 'A%';



2. 80�� �μ����� �̸��� �޿��� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, �޿��� 15�� ����, ���ʿ� $ ��ȣ�� ä���� ���·� ǥ���Ѵ�)
SELECT  first_name, LPAD(salary, 15, '$') AS salary, '$'||salary AS salary2
FROM    employees
WHERE   department_id = 80;



3. 60�� �μ�, 80�� �μ�, 100�� �μ��� �Ҽӵ� ����� ���, �̸�, ��ȭ��ȣ, ��ȭ��ȣ�� ������ȣ�� ��ȸ�Ѵ�
(��, ������ȣ�� Local Number��� ǥ���ϰ�, ������ȣ 515.124.4169���� 515�� ������ȣ�̴�)

SELECT  employee_id, first_name, phone_number, SUBSTR(phone_number, 1, INSTR(phone_number, '.')-1) AS "Local Number", department_id
FROM    employees
WHERE   department_id IN (60,80,100)
ORDER BY department_id ASC;





