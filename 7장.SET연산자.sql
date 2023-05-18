-- 7��. SET ������(p.63)
-- ������� ���̺��� �����͸� �ϳ��� ��ȸ�Ҷ� ��� ==> ���ֻ������ ������..

-- =======================================================================
-- 5�� JOIN����. ���̺�(�� �÷�)�� ���η� �����ϴ� ����
-- 7�� SET������. ���̺�(�� ������/��)�� ���η� �����ϴ� ����
-- =======================================================================

-- �� SET �����ڷ� ���̴� �� SELECT ���� (1) �÷��� ��  (2)������ Ÿ���� ��ġ�ؾ� �Ѵ�.
-- ��ȸ�Ǵ� �÷����� ù��° �������� �÷����� ���ȴ�.
-- ORDER BY ��� �������� ���� �������� ����Ѵ�.



-- 7.1 UNION  : ������
-- ���տ��� �����տ� �ش��ϴ� ������, �ߺ��� ������ ���� ����� ��ȯ�Ѵ�.
[����7-1]
SELECT  1, 3, 4, 5, 7, 8, 'A' AS first -- ��ȸ�Ǵ� �÷����� ù��° �������� �÷����� ���ȴ�.
FROM    dual
UNION-- ������ : SET ������
SELECT  2, 4, 5, 6, 8, null, 'B' AS second
FROM    dual
UNION
SELECT  1, 3, 4, 5, 7, 8, 'A' AS third
FROM    dual;


[����7-2] �����ǰ� �ִ� �μ�, �����ǰ� �ִ� ���� ������ ��ȸ�Ѵ�.
SELECT  department_id AS code, department_name AS name
FROM    departments
UNION
SELECT  location_id, city
FROM    locations
UNION
SELECT  employee_id, first_name
FROM    employees;




-- 7.2 UNION ALL :  ������
-- UNION (�ߺ�����) vs UNION ALL (�ߺ�����)     /    ���� ����� ��ȯ�Ѵ�.
[����7-4]
SELECT  1, 3, 4, 5, 7, 8, 'A' AS first -- ��ȸ�Ǵ� �÷����� ù��° �������� �÷����� ���ȴ�.
FROM    dual
UNION ALL-- ������ : SET ������
SELECT  2, 4, 5, 6, 8, null, 'B' AS second
FROM    dual
UNION ALL
SELECT  1, 3, 4, 5, 7, 8, 'A' AS third
FROM    dual;

-- 7.3 INTERSECT : ������
-- ����� ���� ����� ��ȯ�Ѵ�.

SELECT  1, 3, 4, 5, 7, 8, 'A' AS first -- ��ȸ�Ǵ� �÷����� ù��° �������� �÷����� ���ȴ�.
FROM    dual
INTERSECT -- ������ : SET ������
SELECT  1, 3, 4, 5, 7, 8, 'A' AS third
FROM    dual;

SELECT  1, 3, 4, 5, 7, 8, 'A' AS first -- ��ȸ�Ǵ� �÷����� ù��° �������� �÷����� ���ȴ�.
FROM    dual
UNION -- ������ : SET ������
SELECT  1, 3, 4, 5, 7, 8, 'A' AS third
FROM    dual;


[����7-7] 80�� �μ��� 50�� �μ��� �������� �ִ� ����� �̸��� ��ȸ�Ѵ�.
SELECT  first_name
FROM    employees
WHERE   department_id = 80 -- 34rows / �Ǹ� �μ�
INTERSECT
SELECT  first_name
FROM    employees
WHERE   department_id = 50; -- 45rows / ��� �μ�



SELECT DISTINCT first_name
FROM    employees
WHERE   department_id IN (80, 50);




-- 7.4 MINUS : ������
-- ���տ��� �����տ� �ش��ϴ� ������.

[����7-9] 80�� �μ����� �̸����� 50�� �μ����� �̸��� �����Ѵ�.
-- �����ϰ� 80�� �μ����� �����ϴ� �μ����� �̸�
-- ���� : Peter, John (INTERSECT ���� ���)

-- A - B
SELECT  first_name
FROM    employees
WHERE   department_id = 80
MINUS
SELECT  first_name
FROM    employees
WHERE   department_id = 50; -- 39rows





