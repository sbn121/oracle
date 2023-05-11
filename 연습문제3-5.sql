[��������3-5]

1. ����� ���, �̸�, ����, ��������� ��ȸ�ϴ� �������� DECODE �Լ��� ����Ͽ� �ۼ��Ѵ�.
��, ���� ����� ������ ���� ����ȴ�
-- DECODE() .. exp, search1, result1, ... [,default] ... ���..
-- CASE WHEN~THEN [ELSE default] END : �޸�, ��ȣ ����
SELECT  employee_id, first_name||' '||last_name AS name, job_id,
        DECODE(job_id, 'AD_PRES', 'A'
                     , 'ST_MAN', 'B'
                     , 'IT_PROG', 'C'
                     , 'SA_REP', 'D'
                     , 'ST_CLERK', 'E'
                     , 'X') AS job_grade
FROM    employees
ORDER BY 4;

-------------------
����        ���
------------------
AD_PRES     A
ST_MAN      B
IT_PROG     C
SA_REP      D
ST_CLERK    E
��Ÿ        X
------------------

SELECT  employee_id, first_name||' '||last_name AS name, job_id,
        CASE job_id WHEN 'AD_PRES' THEN 'A'
                    WHEN 'ST_MAN' THEN 'B'
                    WHEN 'IT_PROG' THEN 'C'
                    WHEN 'SA_REP' THEN 'D'
                    WHEN 'ST_CLERK' THEN 'E'
                    ELSE 'X' 
        END AS job_grade
FROM    employees
ORDER BY job_grade;

2. ����� ���, �̸�, �Ի���, �ٹ����, �ټӻ��¸� ��ȸ�ϴ� �������� �ۼ��Ѵ�
��, �ٹ������ ���� ��¥�� �������� �������·� ǥ���Ѵ�  ex> 3.56 ==> 3
�ټӻ��´� �ٹ����   3�� �̸�  '3�� �̸�'
                      3�� ~ 5��  '3��ټ�'
                      5�� ~ 7��  '5�� �ټ�'
                      8�� ~ 10�� '7�� �ټ�'
                      10��~      '10�� �̻� �ټ�'
                      
-- �ٹ����?
-- MONTHS_BETWEEN(����, �Ի���) : �� ��¥�� ���� ���� ��ȯ�ϴ� �Լ� ==> ���� �� /12 ==> ���
-- ��¥(��/��/��) ��ȯ�Լ� : ���ó�¥ ��� - �Ի����� ���
-- �� 23�� ����, �ٹ���� 15~22�� 
--                       10~15�� '10�� �̻� �ټ�'
--                       15_20�� '15�� �̻� �ټ�'
--                       20��~   '20�� �̻� �ټ�'
SELECT  employee_id, first_name||' '||last_name AS name, hire_date AS �Ի�⵵, 
        ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)/12) AS �ٹ����1,
        TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(hire_date, 'YYYY') AS �ٹ����2 -- ������ ����ȯ(�ڵ�����ȯ)
        CASE WHEN ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) >= 10 AND ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) <15 THEN '10�� �̻� �ټ�'
            WHEN ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) >= 15 AND ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) <20 THEN '15�� �̻� �ټ�'            
            WHEN ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) >= 20 THEN '20�� �̻� �ټ�'            
            ELSE ' '
       END AS �ټӻ���
FROM    employees
ORDER BY 4 DESC, 5 DESC;
                      
                      
                      