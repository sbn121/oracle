[��������6-4] 
-- ����6-28 �޿��� ���� ���� 10��!
1. �޿��� ���� ���� 5�� ����� ����, ���, �̸�, �޿��� ��ȸ�ϴ� �������� �ζ��� �� ����������
�ۼ��Ѵ�.


SELECT  ROWNUM AS rank, 
        RANK() OVER(ORDER BY e.salary ASC) AS rank1,
        DENSE_RANK() OVER(ORDER BY e.salary ASC) AS rank2,        
        e.*
FROM    (   SELECT  employee_id, first_name, salary
            FROM    employees
            ORDER BY    salary ASC ) e
WHERE   ROWNUM <= 5;        


-- �����Լ�





2. �μ����� ���� �޿��� ���� �޴� ����� ���, �̸�, �μ���ȣ, �޿�, �����ڵ带 ��ȸ�ϴ� ��������
�ζ��� �� ���������� ����Ͽ� �ۼ��Ѵ�.
-- p.57 �����÷� ��������
-- p.62 �ζ��� �� ��������
SELECT  department_id, MAX(salary)
FROM    employees
WHERE   department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1;


-- �ζ��� �� + ������ ��ȸ <--> ������ �����ϴ� �� �ƴ�����,...
SELECT  employee_id, first_name, department_id, salary, job_id
FROM    employees e1,
        (   SELECT MAX(salary) AS max_sal
            FROM    employees
            WHERE   department_id IS NOT NULL
            GROUP BY department_id ) e2
WHERE   e1.salary = e2.max_sal
ORDER BY 3;

-- �ζ��� �� ������ ���� ==> WITH ��
WITH
e1 AS ( SELECT * FROM employees),
e2 AS ( SELECT MAX(salary) AS max_sal
            FROM    employees
            WHERE   department_id IS NOT NULL
            GROUP BY department_id )
SELECT  employee_id, first_name, department_id, salary, job_id
FROM    e1, e2
WHERE   e1.salary = e2.max_sal
ORDER BY 3;



-- ������ ��������
--SELECT  ���, �̸�, �μ���ȣ, �޿�, �����ڵ�
--FROM    
--WHERE   salary IN (   SELECT  MAX(salary)
--            FROM    employees
--            GROUP BY department_id
--            )
            

