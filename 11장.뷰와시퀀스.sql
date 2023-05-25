-- 11��. ��� ������

-- �����ͺ��̽� �뵵 , ���� ���� �ٸ� (�ܼ�����)
-- ������  vs   �����ͺ��̽� ������
-- ���̺�       ���̺�, ��, �Լ�, ������, �ε���, Ŭ������, ���Ǿ�(SYNONYM)...
-- ������
-- Ʈ����


-- 11.1 �� (VIEW)
-- ��� �����Ͱ� �������� �ʴ� ���� ���̺� : �޸𸮿��� --> ������ �����ߴٰ� ������ ��� ��ȯ�� �Ҹ�
-- ���Ȱ� ����� ���Ǹ� ���� ����Ѵ� : ����Ǹ� �ȵǴ°�(HR-salary), ����? ���� ��û--> ������ �����ϰų�..
-- HR������ �⺻ �並 ��ȸ
SELECT *
FROM    emp_details_view;

-- ���� emp_details_view�� SQL�� ����� �����_�� ������ü
SELECT  *
FROM    user_views;

[����11-1] 80�� �μ��� �ٹ��ϴ� ������� ������ ��� v_emp80�� �並 �����Ͻÿ�!
-- ITAS : SELECT�� �����͸� Ư�� ���̺� ����(������ ����)
-- CTAS : SELECT�� �����͸� �����ϴ� ���̺��� ����(����+������ ���� | ������)
CREATE OR REPLACE VIEW v_emp80 AS -- �̹� ������? REPLACE!
SELECT  employee_id AS emp_id, first_name, last_name, email, hire_date
FROM    employees
WHERE   department_id = 80
-- WITH READ ONLY; -- �б� ���� �� �����ɼ� : �並 ���� ������ ������ �� ������!!

-- Q. ��� ������ ���̺� ==> ������ ���� | ���� | ������ �Ҽ� �ִ� ������ü, �׷��� �䵵?
-- A. ����� ����! WITH READ ONLY ����ؼ� VIEW ������ �ʾұ� ������!!
-- 1. ���� ���̺� ������ ���� --> �信 ����?
/*
DESC employees; -- employee_id(PK), department_id(FK)
SELECT
SELECT *
FROM    jobs;
SELECT *
FROM    job_history;
SELECT *
FROM    departments;
SELECT *
FROM    employees
ORDER BY employee_id DESC;
*/
-- ȫ�浿 ��� ���
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES (207, 'Gildong', 'Hong', 'GILDONGHONG', SYSDATE, 'SA_REP', 6500, 80);

-- v_emp80 �並 ��ȸ : ȫ�浿�� �߰��Ǿ�����?
SELECT *
FROM    v_emp80;

SELECT MAX(emp_id)
FROM    v_emp80; -- 208

-- ��� : ���� ���̺� ������ ���� --> v_emp80�� ��ȸ�ϸ� �߰��� �����Ͱ� ��Ÿ��!

-- 2. �信 ������ ���� --> ���� ���̺� ���� : employees
-- DESC v_emp80;
INSERT INTO v_emp80 (emp_id, first_name, last_name, email, hire_date, job_id)
VALUES (208, 'SUNSHIN', 'LEE', 'SUNSHINLEE', SYSDATE, 'SA_REP');

-- ���� employees ���̺��� �ʼ��Է� �÷��� v_emp80���� �����ϱ�, Ȯ�ο� ��ü ��� �� ����

CREATE OR REPLACE VIEW v_emp_all AS -- �̹� ������? REPLACE!
SELECT  *
FROM    employees; -- View V_EMP_ALL��(��) �����Ǿ����ϴ�.


-- ���� ������ : �̼��� ����
INSERT INTO v_emp_all (employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES (208, 'SUNSHIN', 'LEE', 'SUNSHINLEE', SYSDATE, 'SA_REP', 6600, 80); -- 1 �� ��(��) ���ԵǾ����ϴ�.

-- ���� employees ���̺��� ������ Ȯ�� ==> ��: ���̺�ó�� ����/����/�����Ҽ� �ֱ���?! VS WITH READ ONLY
SELECT *
FROM    employees
ORDER BY 1 DESC;

ROLLBACK;

-- �� ������ ������ ����/����/������ �������� WITH READ ONLY; �� �߰�!


[����11-2] v_dept �並 ���� - �μ��ڵ�, �μ���, �����޿�, �ִ�޿�, ��ձ޿� ������ ����ִ�.
CREATE OR REPLACE VIEW v_dept AS
SELECT  d.department_id, d.department_name,
        MIN(e.salary) AS min_sal, MAX(e.salary) AS max_sal, ROUND(AVG(e.salary)) AS avg_sal
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
GROUP BY  d.department_id, d.department_name, location_id  --ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
ORDER BY 1
WITH READ ONLY;

-- DROP VIEW v_dept; -- �ٽ� ����� �ƴ϶�, v_dept�� �÷��� �߰�|�����Ǹ� CREATE OR REPLACE ó��!


[����11-3]
-- EMP_DETAILS_VIEW : hr ��Ű�� �߰��Ҷ� �ڵ����� ������ �� <������������!>
DROP VIEW v_dept;
DROP VIEW v_emp80;
DROP VIEW v_emp_all;
-- �並 �����? ���� ���̺��� ���� x

SELECT *
FROM    employees; -- ���� 107��

-- ȫ�浿 : ��-> ������ ���� -> ���̺� �ݿ� vs WITH READ ONLY�� ������ �ʾƼ�...
DELETE FROM employees
WHERE   employee_id = 207;

--COMMIT;



/* �� ������
    CREATE [OR REPLACE] VIEW ��� AS
    SELECT ����
    
    �� ����
    DROP VIEW ���;
*/
/* ���̺� ������
    CREATE TABLE ���̺�� (
        ...   
    )
    ���̺� ����
    DROP TABLE ���̺��;
*/

-- 11.2 ������ (SEQUENCE)
-- �������� ��ȣ�� ������ �ʿ��� ��� SEQUENCE�� ����Ͽ� , �ڵ����� ������ִ� ���
-- �ǻ��÷� CURRVAL, NEXTVAL�� ���� ��ȸ�ϰ� ����� �� �ִ�.

SELECT *
FROM    user_sequences; -- �ý��� ���� �� : ������ ����� �� �ְ�~

/*
DEPARTMENTS_SEQ : �μ���� (10�� ���� --> 9990����)
EMPLOYEES_SEQ  : ������ (1�� ���� --> 9999999999999999999999999)
LOCATIONS_SEQ : �μ���ġ ���(100�� ���� --> 9900����)
*/

-- �� �������� �����? ������ �Է��Ҷ�����, Ư�� ������ ���� ����ص� �ʿ䰡 �������Ƿ�..

/* ���̺� ����, �� ����, ������ ����...���� ���ƿ�!
   CREATE SEQUENCE ��������
   START WITH ���۰�
   MAXVALUE    �ִ밪
   INCREMENT BY ������
   NOCACHE | CACHE
   NOCYCLE | CYCLE
   
   ���̺� ����, �� ����, ������ ����...����.
   DROP SEQUENCE ��������;
   
   ���̺� ����, �� ����(=x), ������(=x)
   ALTER TABLE ���̺��
   MODIFY  �÷��� ������Ÿ��(����Ʈ��);
*/   

-- �׷��� �ٸ� �����ͺ��̽� ��ü�� �� ���� �ֳ�? ��� ���峪~ ��� �����ϳ�!
-- ������ ���� �����ͺ��̽� �����ڰ� ����Ǵ� ����?!


-- ���̺��� ã�� ���� ���?
SELECT *
FROM    all_tables -- �ý��� �������� ������ ��
WHERE   OWNER = 'HANUL';


[����11-4] �������� ����
CREATE SEQUENCE emp_seq
START WITH 103
MAXVALUE 9999999
MINVALUE 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- CURRVAL, NEXTVAL ���� ��ȸ�ϰ� ���
SELECT emp_seq.CURRVAL,
        emp_seq.NEXTVAL
FROM    dual;        

[����11-5] emp_test�� ������ ����
SELECT *
FROM    emp_test;

DESC emp_test;

INSERT INTO emp_test
VALUES (emp_seq.CURRVAL - 1, 'Choi', 20, 'ST_CLERK');

-- ȫ�浿, 20�� �μ�, ''
INSERT INTO emp_test
VALUES (emp_seq.NEXTVAL, 'ȫ�浿', 20, '');


-- emp_dept_seq ���� : 40�� ���� 10�� ����~ �ִ� 999999999990 ����~
CREATE SEQUENCE emp_test_dept_seq
START WITH 40
MINVALUE 10
MAXVALUE 999999999990
INCREMENT BY 10
NOCACHE
NOCYCLE;  -- Sequence EMP_TEST_DEPT_SEQ��(��) �����Ǿ����ϴ�.

-- �̼���
INSERT INTO emp_test
VALUES (emp_seq.NEXTVAL, '�̼���', emp_test_dept_seq.NEXTVAL, ''); -- FK ���� vs ��������: ������ �Է�!

-- HANUL ���� ������ ���̺��� �������� Ȯ��
SELECT *
FROM    user_constraints
WHERE   table_name = 'EMP_TEST'; -- EMP_TEST_DEPT_ID_FK

SELECT emp_test_dept_seq.NEXTVAL, emp_test_dept_seq.CURRVAL
FROM    dual; -- ���������� DISABLE�� ���¿��� �Է�

SELECT *
FROM    dept_test;

-- �׽�Ʈ| ���� |�ǽ��� ���������� �Ͻ������� ����ȭ or ����
-- ���� : oracle database disable constraint
-- ���Ĺ��� : 
/*
alter table table_name
[ENABLE | DISABLE] constraint  constraint_name
*/
ALTER TABLE emp_test
DISABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST�� �ɸ� det_test_id_fk�� ����

ALTER TABLE emp_test
ENABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST�� �ɸ� det_test_id_fk�� ���� : �������ǰ� ���� �ʴ� �� ����
-- ORA-02298: ���� (HANUL.EMP_TEST_DEPT_ID_FK)�� ��� �����ϰ� �� �� ���� - �θ� Ű�� �����ϴ�
-- �ܷ�Ű �������� : 10,20,30 ������ ���� 230�� ������ ����!!

SELECT *
FROM    emp_test;

-- 117�� �̼��� 230�� �μ� --> 10~ 30�� �ϳ��� ���� �� �������� ENABLE

UPDATE emp_test
SET dept_id = 30
WHERE   emp_id = 117;

ALTER TABLE emp_test
ENABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST�� �ɸ� det_test_id_fk�� ����

-- �������� ENABLE/DISABLE : �׽�Ʈ �Ҷ� ���� ����� ���� �ִ�.
-- ��, �ٽ� ���������� ENABLE �Ҷ� �׽�Ʈ �ϴ� ���̺� �������ǰ� ��ġ�ϴ� �����Ͱ� �ִ��� Ȯ��!

COMMIT;


-- 12.����Ŭ �����ͺ��̽� ��ü
-- 12.1 ������ ����/������ ��ųʸ� : �����ͺ��̽��� �߿��� ����, ��ü���� �����ϰ� �ִ� ��ü
-- ����Ŭ�̶�� �ý����� ����ϴ� ������ + ����� ������

-- 12.2 ������ ���� ��ȸ
SELECT *
FROM    dict;

SELECT *
FROM    dictionary;

-- ���̺�, �並 ������ �����ͺ��̽� ��ü ���� : ��������, �ε���, Ŭ������, �ó��(=���Ǿ�), ...
-- ���, �����ͺ��̽� �����ڰ� ���� ����
-- ����ڰ� Ȱ���ϴ� ������ ����ִ�.

-- ��ȸ�غ� �� �ִ� ������ ���� ���̺�/���� ����
-- 1) ALL_ �����ϴ� �� : ���� ������� ������ ��ȸ�� �� �ִ� ������
-- 2) DBA_ �����ϴ� �� : DBA ������ ������ ��ȸ
-- 3) USER_�����ϴ� �� : ������ ������ ���Ե� �����͸� ��ȸ
-- 4) v$ �����ϴ� �� : ����Ŭ �����ͺ��̽����� ����,Ư¡���� ������ ��ȸ

SELECT *
FROM    v$nls_parameters;

SELECT  *
FROM    all_tables
WHERE   owner = 'HANUL';

SELECT  *
FROM    all_objects
WHERE   owner = 'HANUL';

-- 12.3 �����ͺ��̽� ��ü ����
-- [���� URL] https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/constraint.html#GUID-1055EA97-BA6F-4764-A15F-1024FD5B6DFE
-- 1) ���̺�
-- 2) ��
-- 3) ������
-- 4) �Լ� : ����� ���� �Լ� vs MAX() ������~ MID() ����ڴٸ�!  ==> ��ȯ���� ����
-- 5) Ʈ���� : ��ȯ���� ���� �Լ�
-------------------- �����ڡ�   DBA �� ���� -----------------------------------------
-- 6) �ε��� : �˻� ���� ��󶧹���
-- 7) Ŭ������ :           "
-- 8) �ó�� : ��ü�� �Ǵٸ� �̸�(=����) ����
-- 9) ��Ű�� : PL/SQL�� �Լ��� Ʈ���ŵ��� �ѵ� ���� ����

/* 
[����URL] https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/CREATE-TRIGGER-statement.html#GUID-AF9E33F1-64D1-4382-A6A4-EC33C36F237B
SQL vs PL/SQL - �Լ�, Ʈ����, ��Ű�� + �⺻ ���α׷��� ���� 
       Procedural Language + SQL : �������� ���α׷��� ��� + SQL ==> SQL���� ���α׷���!
       ����, ���, ������, ���ǹ�, �ݺ���...       
       I. �͸� ��(Anonymous Block)    /   II. �������α׷�(Named Block)
                                                - �Լ�
                                                - Ʈ����
*/       
       

-- Ʈ���� ���� : DML ó���� ����
CREATE OR REPLACE TRIGGER Ʈ���Ÿ�
[BEFORE | AFTER]
    INSERT OR 
    UPDATE OF salary, department_id OR  -- 2.� �۾��� �̷�����
    DELETE
  ON employees -- 1.� ���̺����� 
BEGIN
    -- 3. �Ʒ����� ������ ó���� �Ǵ� PL/SQL
    -- PL/SQL ����� : ����, ������, ���ǹ�, �ݺ��� ....
    -- ����ó���� : EXCEPTION 
END;

[���Ĺ��� ����] HR �������� ����
CREATE OR REPLACE TRIGGER t
  BEFORE | AFTER
    INSERT OR
    UPDATE OF salary, department_id OR
    DELETE
  ON employees
BEGIN
  CASE
    WHEN INSERTING THEN
      DBMS_OUTPUT.PUT_LINE('Inserting');
    WHEN UPDATING('salary') THEN
      DBMS_OUTPUT.PUT_LINE('Updating salary');
      -- ���� ó�� ����: ����� �޿����� ���̺�, ��������� �ڵ����� �Է�ó��
      INSERT INTO salary_changes (employee_id, salary_before, salary_after, reason)
      VALUES (��,��,��,��);      
      DBMS_OUTPUT.PUT_LINE('writing slarry change OK!');
      
    WHEN UPDATING('department_id') THEN
      DBMS_OUTPUT.PUT_LINE('Updating department ID');
    WHEN DELETING THEN
      DBMS_OUTPUT.PUT_LINE('Deleting');
  END CASE;
END;
/

 employees ������Ʈ --> salary 
 
 SELECT *
 FROM   employees; -- 205 Shelley �� �޿��� 12008 --> 12000 ���� ������Ʈ
 
-- DBMS_OUTPUT ��Ű�� : ȭ�鿡 ����ϴ� ����� ���� ---> .PUT_LINE()  : �ٹٲ޾��� �ؽ�Ʈ ���
-- SQL DEVELOPER ��� Ȯ�� ��, [���� > DBMS ���] â�� �����ؼ� Ȱ��ȭ ==> + ������ HR ���� ����!
UPDATE employees
SET salary = 12000
WHERE   employee_id = 205;

-- ���� �ڵ忡���� �ܼ� ��� �޽�����,
-- �����δ� Ư�� ���̺� ��������� �߰� �Է�, ��� �뵵�� Ȱ��
-- ex> �ֹ� ���̺� : ��ǰ�� ��� �ڵ����� ����   vs   ������ ���� ��� ������Ʈ �ؾ���!
-- ��SQLPLUS Ȯ���Ϸ���? SET SERVEROUTPUT ON | OFF;

DROP TRIGGER t;


-- 12.4 ����/����/����
-- CREATE ����
-- ALTER ����
-- DROP ����

ROLLBACK;

