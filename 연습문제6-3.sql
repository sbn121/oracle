[��������6-3]

1. �� �μ��� ���� �μ��ڵ�, �μ���, �μ��� ��ġ�� �����̸��� ��ȸ�ϴ� ��������
��Į�� ���������� �ۼ��Ѵ�.
-- ��ȣ���� �������� ���� : �������� �÷��� ���������� ���� �������� ���Ǵ� --> ���������� ����?
SELECT  department_id, department_name,
        ( SELECT city
          FROM   locations l
          WHERE  l.location_id = d.location_id   ) AS city_name
FROM    departments d;
