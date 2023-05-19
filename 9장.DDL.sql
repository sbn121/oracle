-- 9��. DDL

-- Data Definition Language , �����ͺ��̽� ���Ǿ�

-- [--------������-----]  [------ DBA(�����ͺ��̽� ������)-----]
-- 1) ���̺� ���� 2) ��   3) �ε���  4) �ó��(=ȣ)  5) Ŭ������ ... : �����ͺ��̽� ��ü
-- CREATE TABLE  , CREATE VIEW, CREATE INDEX , CREATE SYNONM   , CREATE CLUSTER , ..  - DBA�� �ַ�!!

-- 9.1 ������ Ÿ��  ==> ���̺� �÷� ���� �ڷ���, ����(Bytes)�� �˾ƾ� �ùٸ��� ����
-- ���� ���� ����ϴ� �ڷ���
-- 1) ������ : �������� ������ char, �������� ������(=����ó�� �ð� �ִ� ����� �ƴ�!) varchar2
--      �� (������ �� ���� ������) : nchar, nvarchar2 ==> National (������ --> �ѱ�,�߱�,�Ϻ���~)
-- 2) ������ : ����, �Ǽ�
-- 3) ��¥�� : ��¥
-- �� NLS ������ ���� �ٸ�  : KOREAN(=���� �⺻), ���� : Bytes
-- ���� > ȯ�漳�� > NLS �Ǵ�
SELECT *
FROM v$nls_parameters;

-- ���ڿ��� Bytes�� �˷��ִ� �Լ� : LENGTHB()
SELECT  LENGTHB('a') AS ENG_CHAR,
        LENGTHB('��') AS KOR_CHAR,
        LENGTHB('�') AS CN_CHAR
FROM    dual;        


-- 9.1.1 ����(��)�� ������
-- ���� ���� : char(����Ʈ ��) ==> char(5) : 5 bytes ���ڿ� �����ϴ� �÷��� ���̸� ����
-- ���� ���� : varchar2(����Ʈ ��) ==> varchar2(5) :         "              " 
-- �� 5byte �÷��� 3byte �Է��ϸ� ==> 2byte ��ȯ x, �����Ͱ� ����� ������ ����Ŭ�� �����ϴ� ��ȣ�� �����ϴ� ����
-- varchar : 21c ������ varchar Ÿ�� ==> ����Ŭ�� ���߿� ����ϰų� �ٸ� �뵵�� �������� �����ó�� �����ص� ����
-- ����Ŭ23c ���� ����Ǿ������� ���� Ȯ������ ���� (23.05.19 ������� 23c �ٿ�ε� ��ũ�� ���� �������� �ʾ���)
-- ex> varchar2(char 5) : byte�� �ƴ� ���ڷ� 5�� ���� <--- �߾��� ���´� �ƴ�.







-- 9.1.2 ������ ������
-- NUMBER(n) : ���� n����Ʈ ���̷� ����
-- NUMBER(p, s) : ��ü���� p, ���� p-s ����, �Ҽ� s ���̷� ����
-- NUMBER(5,2) : ��ü���� 5, ���� 3, �Ҽ� 2

-- INT �÷����� ==> ����Ŭ�� ==> NUMBER�� �����ع���..
-- BIGINT ==> NUMBER
-- DOUBLE ==> NUMBER


-- 9.1.3 ��¥�� ������
-- DATE Ÿ�� , ��¥�� �ð� ������ ���´�.
SELECT SYSDATE AS DATE1,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') AS DATE2
FROM    dual;

-- NLS ������ ��¥������ RRRR/MM/DD �� ���� ==> �Ź� NLS ���� ���� x, ��ȯ�Լ��� Ȱ��!!


-- DDL : �����ͺ��̽� ��ü�� ����(����,����)�ϴ� ��ɾ� : CREATE, ALTER, DROP, TRUNCATE
-- DDL�� �ڵ����� Ŀ������ �̷�� ���� : ������(x)  vs  DBA(o)
-- TRUNC(number | date) : (�Ҽ��� ����) ������ �Լ�(����,��¥)

/* ========= ���̺� ���� ��Ģ : �����ͺ��̽� ��ü ���� ��Ģ ===========
    1) �ݵ�� ���ڷ� �����Ѵ�
    2) ����+���� Ȱ��
    3) �ִ� 30����Ʈ
    4) ����Ŭ ���� ����� �� ���� ==> CREATE TABLE TABLE ( ... ); -- x
*/


-- 9.2 ���̺� ���� CREATE
-- ex> ȸ���� ������ �����ϴ� ���̺� ����
--    ������ �𵨸� - ���伳�� :    ���  <---->   �̸�, ����ó, �̸���, ...
--             "    - ������ :   MEMBERS        name(20), phone(30), email(50)
--                  - �������� : CREATE TABLE MEMBERS ( name varchar2(20), ... );

-- 1. SQL ���� : DDL
--CREATE TABLE ���̺��(
--    �÷���1 ������ Ÿ��,
--    �÷���2 ������ Ÿ��,
--    ...���...
--);

[����9-1] 3 byte ���� id �÷�, 20byte ���� fname �÷����� �̷���� TMP ���̺� �����Ͻÿ�
CREATE TABLE tmp (
    id NUMBER(3),
    fname VARCHAR2(20)
);


[����9-2] tmp ���̺� ȫ�浿�� �̼����� �����͸� �����Ͻÿ�
INSERT INTO tmp (id, fname)
VALUES (1, 'ȫ�浿');
INSERT INTO tmp (fname, id)
VALUES ('�̼���', 2);

-- or �÷� ������ ������ �ڷ����� ��ġ���Ѿ� ��
INSERT INTO tmp2
VALUES (1, 'ȫ�浿');
INSERT INTO tmp2
VALUES (2, '�̼���');

SELECT *
FROM    tmp2;

COMMIT;

[����9-3] id�� 1���� ����� name �÷��� �����͸� ȫ�浿 ==> ȫ���� �����Ͻÿ�
UPDATE tmp2
SET fname = 'ȫ��'
WHERE id = 1;


-- ����� ���̺� : �����ͺ��̽� ��ü ���� ==> ������ ����,��ųʸ� ��ȸ
SELECT * 
FROM    dict -- �Ǵ� dictionary
WHERE table_name LIKE 'DBA%';  -- HR���� : users �׷�

-- USER_ : ����� ����/����
-- ALL_  : ������~
-- DBA_  : ������ ����/����

-- 2. �׷��� : ���� > ������(HR) > ���̺� - ���콺 ��Ŭ�� > ���̺� > ����..

-- ==============================================================================================
-- Ű���� AS�� ���������� �����, �̹� �ִ� ���̺��� �����Ͽ� �����ϴ� ���·� ���̺� ���� : CTAS
CREATE TABLE ���̺�� AS
SELECT  �÷���1, �÷���2,..
FROM    ���̺��
WHERE   ����;

[����9-4] �μ� ���̺� �����͸� �����Ͽ� dept1 ���̺�� ����(=����)�Ѵ�.
CREATE TABLE dept1 AS
SELECT *
FROM    departments; -- �÷�, �ڷ���, �����ͱ��� �����ϵ���!! [����/������ ==> ����]

-- ��ȸ
SELECT *
FROM    dept1;

-- ���̺� ����, �÷���|�ڷ���
DESC dept1;

[����9-5] ��� ���̺��� 20�� �μ��� �Ҽӵ� ����� ���, �̸�, �Ի��� �÷��� �����͸� 
�����Ͽ� emp20 ���̺��� �����Ѵ�.

CREATE TABLE emp20 AS
SELECT  employee_id, first_name, hire_date
FROM    employees
WHERE   department_id = 20;

-- ��ȸ
SELECT *
FROM    emp20;


[����9-6] �μ� ���̺��� ������ ���� dept2 ���̺��� �����Ͽ� �����Ͻÿ�
-- ��ġ�ϴ� ������ �����Ͱ� ���� ��� ==> dept2 ���̺� ���� : OK, ������ : NO
-- CTAS��  WHERE ������ ��������!!    ==> �÷���, �ڷ����� �״�� ����, ������ �� ����!!
CREATE TABLE dept2 AS
SELECT *
FROM    departments
WHERE   1 = 2;

-- ��ȸ
SELECT *
FROM    dept2;

DESC dept2;



-- ==============================================================================================
--                    "                               "                       ���̺� ������ ���� : ITAS
-- ==============================================================================================
INSERT INTO ���̺��
SELECT  �÷���1, �÷���2,..
FROM    ���̺��
WHERE   ����;


-- 9.3 ���̺� ���� ���� ALTER
-- �� ���̺� ���� �����Ͱ� ������ ==> ���� �Ұ�! , ���� ���� ������ �����ҷ��� �Ҷ�~
-- 9.3.1 �÷� �߰� : ������?�� NULL ä����
-- ���� ���̺� ���ο� �÷��� �߰��ϴ� ����
ALTER TABLE ���̺��
ADD (�÷���1 �ڷ���(����), �÷���2 �ڷ���(����)...)

[����9-7] emp20 ���̺� ����Ÿ�� �޿� �÷�(salary), ����Ÿ�� �����ڵ�(job_id) �÷��� �߰��Ѵ�.
DESC emp20;
/*
�̸�          ��?       ����           
----------- -------- ------------ 
EMPLOYEE_ID          NUMBER(6)    
FIRST_NAME           VARCHAR2(20) 
HIRE_DATE   NOT NULL DATE 
*/
SELECT *
FROM    employees;

ALTER TABLE emp20
ADD (salary NUMBER, job_id VARCHAR2(10)); -- Table EMP20��(��) ����Ǿ����ϴ�.

/*
�̸�          ��?       ����           
----------- -------- ------------ 
EMPLOYEE_ID          NUMBER(6)    
FIRST_NAME           VARCHAR2(20) 
HIRE_DATE   NOT NULL DATE         
SALARY               NUMBER           <-- �߰��� �÷��� �ڷ���
JOB_ID               VARCHAR2(10)     <-- �߰��� �÷��� �ڷ���
*/

-- ������ ��ȸ
SELECT *
FROM    emp20;

-- 9.3.2 �÷� ���� (�̸�, ����, �ڷ���, ��������), ������ ���ǰ��ɼ�
-- ������ Ÿ��, ũ�⸦ �����ϴ� ����
ALTER TABLE ���̺��
MODIFY (�÷���1 ������Ÿ��, �÷���2 ������Ÿ��,...)

-- ���̺� ���� ���ų�, �÷��� NULL ���� �����ϰ� �־�� ������ Ÿ���� ������ �� �ִ�.
-- �÷��� ����Ǿ� �ִ� �������� ũ�� �̻���� �������� ũ�⸦ ���� �� �ִ�.

[����9-8] emp20 ���̺��� salary �÷��� job_id �÷��� ������ ũ�⸦ ���� �����Ѵ�.
-- ���� : salary NUMBER --> NUMBER(8, 2),   job_id VARCHAR2(5) --> 10 byte
ALTER TABLE emp20
MODIFY  (salary NUMBER(8, 2), job_id VARCHAR2(10)); -- Table EMP20��(��) ����Ǿ����ϴ�.

-- ��ȸ
DESC emp20;
/*
�̸�          ��?       ����           
----------- -------- ------------ 
EMPLOYEE_ID          NUMBER(6)    
FIRST_NAME           VARCHAR2(20) 
HIRE_DATE   NOT NULL DATE         
SALARY               NUMBER(8,2)  <-- ������ NUMBER
JOB_ID               VARCHAR2(10) <-- ������ VARCHAR2(5)
*/

SELECT *
FROM    emp20;

-- ������ 203�� ��� ���� �� MODIFY �غ���!
INSERT INTO emp20 
VALUES (203, 'Steve', SYSDATE, 10000, 'SA_MAN');  -- 1 �� ��(��) ���ԵǾ����ϴ�.

ALTER TABLE emp20
MODIFY  (salary NUMBER(5, 3), job_id VARCHAR2(5));
-- ORA-01440: ���� �Ǵ� �ڸ����� ����� ���� ��� �־�� �մϴ�

-- 9.3.3 �÷� ���� : ������ ����
-- ���̺��� �÷��� �����ϴ� ����
ALTER TABLE ���̺��
DROP COLUMN �÷���;

[����9-9] emp20 ���̺��� �����ڵ� �÷� job_id �� �����Ͻÿ�
ALTER TABLE emp20
DROP COLUMN job_id;

DESC emp20;

SELECT *
FROM    emp20;

ROLLBACK; -- DDL : CREATE, ALTER, DROP, TRUNCATE --> �ڵ� COMMIT;


/*
------------------
id fname     office      + ALTER �� �߰�/����/����!  , ���� ����,  
------------------
1  ȫ�浿    NULL
2  �̼���    NULL
*/


-- 9.4 ���̺� ���� DROP ==> ������ �ϴ� �Ű�����, �ʿ�� ����(=FLASH BACK)
-- ���̺��� �� �����Ϳ� ������ �����ϴ� ���� : DROP TABLE ���̺��
-- ���̺��� �� �����͸� �����ϰ� ������ ����� ���� : TRUNCATE TABLE ���̺��;
DROP TABLE ���̺��;

DROP TABLE emp20;
-- ���� > ������ - EMP20 �÷��� �� --> emp20back
-- ������ ���� ���̺���� ���� : �̹� �ִ� �ٸ� ���̺���� �浹�� ����

SELECT *
FROM    emp20back;


-- ���� �ȵǰ� ���̺� ���� : �������� ��ġ�� �ʰ� ������ ���� (�����Ұ�)
DROP TABLE ���̺�� PURGE
DROP TABLE emp20back PURGE;

-- ���̺��� �̸��� ����
RENAME ������ ���̺�� TO ����� ���̺��;

RENAME TMP2 TO TEST

-- 9.5 ���̺� ������ ���� TRUNCATE (������ �����, �����ʹ� ����)
select *
from tmp2;

truncate table tmp2; -- �����ʹ� ��������, ���̺�� �÷�, �ڷ����� ���Ǵ� ����

desc tmp2;
ALTER TABLE EMP
RENAME COLUMN fname TO  fisrt_name;

rollback;
