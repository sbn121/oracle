[�������� 4-3]

1. ������̺��� �Ȱ��� �̸��� �� �̻� �ִ� �̸��� �� �̸��� ��� �� �������� ��ȸ�Ѵ�.
-- John, Peter, David :
SELECT  first_name, COUNT(*) AS cnt
FROM    employees
--WHERE   
GROUP BY first_name
HAVING  COUNT(*) >=2
ORDER BY 2 DESC;





2. �μ���ȣ, �� �μ��� �޿��Ѿװ� ��ձ޿��� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, �μ� ��ձ޿��� 8000 �̻��� �μ��� ��ȸ)

SELECT  department_id, SUM(salary) AS sum_sal, ROUND(AVG(salary)) AS avg_sal
FROM    employees
GROUP BY department_id
HAVING  AVG(salary) >= 8000
ORDER BY 1;



3. �⵵, �⵵���� �Ի��� ��� ���� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, �⵵�� 2014�� ���·� ǥ��ǵ��� �Ѵ�.)

SELECT  TO_CHAR(hire_date, 'YYYY') AS YEAR, COUNT(*) AS cnt
FROM    employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY  1;
