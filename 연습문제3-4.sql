[��������3-4]

1. ����� ���, �̸�, �μ��ڵ�, �Ŵ�����ȣ�� ��ȸ�ϴ� �������� �ۼ��Ѵ�
(��, �Ŵ����� �ִ� ����� Manager_id��, �Ŵ����� ���� ����� 'No Manager'�� ǥ���ϵ��� �Ѵ�)
-- �Ŵ���_���̵� NULL : BOSS (��ǥ��, �����/ȸ���)
-- �Ϲ� ��� : �μ��� �ҼӵǾ� �ְ�, �����ϴ� ���(=�Ŵ���)�� �ִ�.
-- �� manager_id : ����� �ĺ���
-- ��ȯ�Լ� :   ����  ����  ��¥
--             number char  date

DESC    employees; -- DATE : ��¥, NUMBER : ����, VARCHAR2 : ����+������ �ý������� Ÿ�Ե��� ����

SELECT  employee_id, first_name||' '||last_name AS name, department_id,
        NVL2(manager_id, TO_CHAR(manager_id), 'No Manager') AS manager
FROM    employees;

-- 1) NVL(exp1, exp2) : exp1�� NULL�̸� exp2 ��ȯ, �ƴϸ� exp1 ��ȯ
-- 2) NVL2(exp1, exp2, exp3) : exp1�� NULL�̸� exp3 ��ȯ, NULL �ƴϸ� exp2 ��ȯ
-- 3) COALESCE()

-- NULL �÷� : commission_pct, manager_id, department_id