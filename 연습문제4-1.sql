[�������� 4-1]

1. ��� ���̺��� �� ȸ���� �Ŵ������� ��ȸ�Ͻÿ�
-- manager_id : ��� �� �Ŵ����� �ش��ϴ� ����� ���(=employee_id)
-- employee_id
DESC    employees;

SELECT DISTINCT manager_id
FROM    employees
WHERE   manager_id IS NOT NULL; -- 18��

-- �Ŵ����� ���� ��� ==> BOSS(��ǥ��) 1��

