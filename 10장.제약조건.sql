-- 10��. ��������

-- ���Ἲ ��������(Integrity Constraints) : �������� ��Ȯ���� �����ϱ� ���� �δ� ����/���� ����
-- 1) ���̺� ������ ���� : CREATE TABLE ~
-- 2) ���̺� ���� �� �߰� : ALTER TABLE ~

-- 10.1 NOT NULL �������� - NULL ������� ����    : Check
-- �÷��� ������ ���� �־� NULL ������� ���� ==> �ݵ�� �����͸� �Է��ؾ� �Ѵ�.
-- �� ���̺� ������ �÷� �������� �����Ѵ�
-- ex> ���̺� ���� ����
CREATE TABLE ���̺��(
    �÷���1 ������Ÿ��(����) ��������, -- �÷� ����
    �÷���2 ������Ÿ��(����),
    ...���...
)

CREATE TABLE user(
    id VARCHAR2(20) NOT NULL, -- �÷� ����
    nick VARCHAR2(20) ,
    ...���...
)

[����10-1] null_test ��� ���̺��� �����ϵ� �÷��� col1 ����Ÿ�� 5����Ʈ ����, NULL ������� �ʰ�, 
col2 ����Ÿ�� 5����Ʈ ���̷� �����Ͻÿ�~

-- 1) ���̺� ���� : null_test + not null
CREATE TABLE null_test (
    col1 VARCHAR2(5) NOT NULL, -- �÷� ���� : NULL ������� ����
    col2 VARCHAR2(5) -- �������� x ==> NULL ���
);

INSERT INTO null_test (col1)
VALUES ('AA'); -- AA | (null)

SELECT *
FROM    null_test;

[����10-3] BB�� col2 �� ����
INSERT INTO null_test (col2)
VALUES ('BB'); -- col1 NOT NULL ��������
-- ORA-01400: NULL�� ("HR"."NULL_TEST"."COL1") �ȿ� ������ �� �����ϴ�

-- 2) ���̺� ���� �� NOT NULL ����
-- �÷��� NULL �����Ͱ� ���� ���, NOT NULL�� �߰��� �� �ִ�.

-- null_test�� �̹� BB�� col2 �÷��� �ִ� ����
UPDATE null_test
SET col2 = 'BB'; -- col2 �÷��� �����͸� null ���� 'BB'�� ����

SELECT *
FROM    null_test;

[����10-4]
ALTER TABLE null_test
MODIFY  (col2 NOT NULL); -- �������� �߰�


[����10-5] col2�� NULL�� �ٲپ�� ==> ���������� �߰��Ǿ�����, �����߻�!
-- col2�� NOT NULL�� �߰� ==> �����͸� NULL
UPDATE null_test
SET col2 = NULL;  -- ���� �߻�

-- �ٽ� col2 �÷��� NULL ���
ALTER TABLE null_test
MODIFY (col2 NULL); -- col1, col2 ��� �����Ͱ� �ִ� <---> NULL�� �ƴϹǷ�

UPDATE null_test
SET col2 = NULL;    -- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�



-- ===================================================================================
-- ������ ����
SELECT *
FROM    dict; -- ���� ���ѿ� ���� ������ �ʴ� ��ü ==> SYS�� SYSTEM���� ��ȸ�ϸ� ��� ã�� �� ����

-- ======== ����� �������� ������ (���̺���) ���������� ��� ��ϵ� ������ ���̺� ��ü : ����Ŭ ���� ======
SELECT *
FROM   user_constraints
WHERE   table_name = 'NULL_TEST'; -- ������ col1 NOT NULL, ���� �� �߰� col2 NOT NULL


SELECT *
FROM   user_constraints
WHERE   table_name = 'EMPLOYEES'; -- ��?

-- COMMIT;



-- 10.2 CHECK �������� - ���� ����/������ (p.80)
-- ���ǿ� �´� �����͸� ������ �� �ֵ��� �ϴ� ���������̴�.
-- �÷� ����, ���̺� �������� �����Ѵ�.

-- I. ���̺� �����ϸ鼭 �������� ����
[����10-6]
CREATE TABLE check_test (
    name VARCHAR2(10) NOT NULL, -- �÷� ����
    gender VARCHAR2(10) NOT NULL CHECK (gender IN ('����','����','male','female','man','woman')),
    salary  NUMBER(8),
    dept_id NUMBER(4),
    CONSTRAINT check_test_salary_ck CHECK (salary > 2000) -- ���̺� ����
);

-- ���̺��_�÷���_�������� ���(NN: NOT NULL, CK: CHECK, PK: PRIMARY KEY, FK: FOREIGN, UK: UNIQUE KEY)

SELECT constraint_name, constraint_type, search_condition
FROM    user_constraints
WHERE   table_name = 'CHECK_TEST';

[����10-7] �����͸� check_test ���̺� �����غ��ÿ�

INSERT INTO check_test
VALUES ('ȫ�浿', '����', 3000, 10); -- gender, salary üũ : ���

INSERT INTO check_test
VALUES ('��浿', '����', 3000, 20); -- gender, salary üũ : ���

INSERT INTO check_test
VALUES ('�ֱ浿', 'man', 0, 20); -- gender üũ : man, salary : 0

INSERT INTO check_test
VALUES ('��û', '����', 0, 20); -- gender üũ : ���� vs ����

[����10-9]
UPDATE check_test
SET salary = 2000
WHERE   name = 'ȫ�浿';  -- RA-02290: üũ ��������(HANUL.CHECK_TEST_SALARY_CK)

-- II. ���̺� ���� �� �������� �߰�/����
[����10-10]
-- DDL : CREATE, ALTER, DROP
--        ����,  ���� , ����
-- check_test�� �ɸ� ���������� Ȯ���ϰ�, �׷����� ���� �ߴٰ� �ٽ� �߰� �ϴ� ����
SELECT constraint_name, constraint_type, search_condition
FROM    user_constraints
WHERE   table_name = 'CHECK_TEST';

/*
SYS_C008409	C	"NAME" IS NOT NULL
SYS_C008410	C	"GENDER" IS NOT NULL
SYS_C008411	C	gender IN ('����','����','male','female','man','woman')
CHECK_TEST_SALARY_CK	C	salary > 2000
*/
-- ����
ALTER TABLE check_test
DROP CONSTRAINT check_test_salary_ck; -- Table CHECK_TEST��(��) ����Ǿ����ϴ�.

-- �ٽ� �߰�
[����10-11]
ALTER TABLE check_test
ADD CONSTRAINT check_salary_dept_ck CHECK (salary BETWEEN 2000 AND 10000 AND dept_id IN (10, 20, 30));
-- �޿� 2000~1000 �̸鼭 �μ��ڵ� 10,20,30 �̾�� �Է��� ��

SELECT *
FROM    check_test;
/*
NAME       GENDER         SALARY    DEPT_ID
---------- ---------- ---------- ----------
ȫ�浿     ����             3000         10
*/

[����10-12] 
UPDATE check_test
SET salary = 12000
WHERE   name='ȫ�浿'; -- ORA-02290: üũ ��������(HANUL.CHECK_SALARY_DEPT_CK)�� ����Ǿ����ϴ�


UPDATE check_test
SET     dept_id = 40
WHERE   name='ȫ�浿'; -- ORA-02290: üũ ��������(HANUL.CHECK_SALARY_DEPT_CK)�� ����Ǿ����ϴ�



-- 10.3 UNIQUE �������� - �ߺ����� (NULL ���)
-- �����Ͱ� �ߺ����� �ʵ��� ���ϼ��� �����ϴ� ��������
-- �÷� ����, ���̺� �������� ����
-- �ں���Ű(Composite Key)�� ������ �� �ִ١� ��) ���� ��� vs ���+�̸�
-- PRIMARY KEY : UNIQUE + NOT NULL
-- ���̺� ������ UNIQUE ����
-- I.�÷����� ����
[����10-13]
CREATE TABLE unique_test (
    col1    VARCHAR2(5) UNIQUE NOT NULL,
    col2    VARCHAR2(5),
    col3    VARCHAR2(5) NOT NULL,
    col4    VARCHAR2(5) NOT NULL,
    CONSTRAINT uni_col2_uk UNIQUE (col2),
    CONSTRAINT uni_col34_uk UNIQUE (col3, col4) -- ����Ű : �� �̻��� �÷��� ���� ==> ���+��ȭ��ȣ, ���+�̸�,...
);

SELECT constraint_name, constraint_type, search_condition
FROM    user_constraints
WHERE   table_name = 'UNIQUE_TEST';

[����10-14] �ߺ����� �����ϴ��� �Է� �׽�Ʈ
INSERT INTO unique_test (col1, col2, col3, col4)
VALUES ('A1', 'B1', 'C1', 'D1');

SELECT *
FROM    unique_test;

INSERT INTO unique_test
VALUES ('A2', 'B2', 'C2', 'D2');

[����10-15] ������Ʈ �׽�Ʈ --> �ߺ��� ������ --> �������ǿ� ���� ���� �߻�!
UPDATE unique_test
SET col1='A1'
WHERE   col1='A2'; -- ORA-00001: ���Ἲ ���� ����(HANUL.SYS_C008417)�� ����˴ϴ�

SELECT *
FROM    user_constraints
WHERE   table_name='UNIQUE_TEST';

DESC unique_test;

[����10-16] ������ �Է� �׽�Ʈ --> �ߺ��� Ȯ��
INSERT INTO unique_test
VALUES ('A3', '', 'C3', 'D3'); -- col2, '' ��� NULL ����ϴ°� ������ ���鿡���� ����


INSERT INTO unique_test
VALUES ('A4', NULL, 'C4', 'D4'); -- col2, '' ��� NULL ����ϴ°� ������ ���鿡���� ����
-- COMMIT;

INSERT INTO unique_test
VALUES ('A4', 'B5', 'C5', 'D5'); -- col2, '' ��� NULL ����ϴ°� ������ ���鿡���� ����

INSERT INTO unique_test
VALUES ('A6', 'B6', NULL, NULL); -- col2, '' ��� NULL ����ϴ°� ������ ���鿡���� ����

-- II.���̺� ���� ����
-- ���̺� ���� �� UNIQUE �߰�/���� : ������ �ۼ��� UNIQUE ���� --> �߰�

-- ������ ���� : 
SELECT *
FROM    dict;


SELECT  constraint_name, constraint_type
FROM    user_constraints
WHERE   table_name='UNIQUE_TEST';

[����10-18] UNI_COL34_UK ���������� �����ϰ� col2,col3,col4�� UNIQUE ����Ű�� �����ϴ�!
ALTER TABLE unique_test
DROP CONSTRAINT UNI_COL34_UK;  --Table UNIQUE_TEST��(��) ����Ǿ����ϴ�

[����10-19] UNI_COL234_UK �������� �߰�
ALTER TABLE unique_test
ADD CONSTRAINT UNI_COL234_UK UNIQUE (col2, col3, col4);  --Table UNIQUE_TEST��(��) ����Ǿ����ϴ�

SELECT *
FROM    unique_test;

/*
         <------------->
unique  null
COL1    COL2  COL3  COL4 
-----    ----- ----- -----
A1        B1    C1    D1   
A2        B2    C2    D2   
A3       (null) C3    D3   
A4       (null) C4    D4
*/

[����10-20]
INSERT INTO unique_test
VALUES ('A7',NULL,'C4','D4');



-- 10.4 PRIMARY KEY ��������  
-- ������ ��(ROW)�� ��ǥ�ϵ��� �����ϰ� �ĺ��ϱ� ���� ��������
-- UNIQUE + NOT NULL�� ����
-- �⺻Ű, �ĺ���, �� Ű, PK �� �Ѵ�.
-- �÷�����, ���̺��� ���� ����  �ں���Ű�ڸ� ������ �� �ִ�.
-- ��) ��� - �ֹι�ȣ (= ����Ű),  ȸ��� - �����ȣ

-- I. �÷����� ����
�÷��� ������ Ÿ�� PRIMARY KEY  : ��� --> SYS_C008XXX 
�÷��� ������ Ÿ�� CONSTRAINT �������Ǹ� PRIMARY KEY --> ���̺��_�÷���_�������Ǿ��

-- II.���̺��� ����
CONSTRAINT ���̺��_�÷���_�������Ǿ�� PRIMARY KEY (�÷���)

[����10-21] dept_test ���̺��� �����ϰ� dept_id, dept_name �÷� ���� ���� 4����Ʈ, �������� 30����Ʈ��
������ �����ϵ� dept_name�� NULL�� ������� �ʰ�, dept_id�� �⺻Ű�� �����ϴ� ������ �ۼ��Ͻÿ�

CREATE TABLE dept_test (
    dept_id NUMBER(4),
    dept_name VARCHAR2(30) NOT NULL,
    CONSTRAINT dept_test_dept_id_pk PRIMARY KEY (dept_id) -- dept_id �÷��� ���ϼ��� �����ϰ� NULL�ƴ� ���� ������ �����ϴ� ��������
);

SELECT  constraint_name, constraint_type
FROM    user_constraints
WHERE   table_name='DEPT_TEST';

[����10-22] �μ��ڵ� 10, �μ����� �������� �μ� �����͸� �Է��Ͻÿ�
INSERT INTO dept_test (dept_id, dept_name)
VALUES (10, '������');

INSERT INTO dept_test (dept_id, dept_name)
VALUES (10, '���ߺ�');

INSERT INTO dept_test (dept_id, dept_name)
VALUES (NULL, '���ߺ�');

-- ���̺� ���� �� PK (�߰�)����
-- �ϴ� ���� ����
ALTER TABLE dept_test
DROP CONSTRAINT DEPT_TEST_DEPT_ID_PK; -- Table DEPT_TEST��(��) ����Ǿ����ϴ�.

-- �ٽ� �߰�����
ALTER TABLE dept_test
ADD CONSTRAINT DEPT_TEST_DEPT_ID_PK PRIMARY KEY (dept_id); -- Table DEPT_TEST��(��) ����Ǿ����ϴ�.

SELECT *
FROM    dept_test;

INSERT INTO dept_test
VALUES (20, '���ߺ�');

UPDATE dept_test
SET dept_id = 10
WHERE   dept_name = '���ߺ�'; -- ORA-00001: ���Ἲ ���� ����(HANUL.DEPT_TEST_DEPT_ID_PK)�� ����˴ϴ�

INSERT INTO dept_test
VALUES (20, '�Ǹź�');  --ORA-00001: ���Ἲ ���� ����(HANUL.DEPT_TEST_DEPT_ID_PK)�� ����˴ϴ�



-- 10.5 FOREIGN KEY �������� - �ܷ�Ű (p.85)
-- �θ� ���̺��� �÷��� �����ϴ� �ڽ� ���̺��� �÷���, �������� ���Ἲ�� �����ϱ� ���� �����ϴ� ��������
-- NULL ��� <---> UNIQUE : �ߺ�����, NULL ���
-- ����Ű, �ܷ�Ű, FK
-- �÷�����     �ں���Ű�ڸ� ������ �� �ִ�.
-- �÷��� ������ Ÿ�� REFERENCES �θ����̺� (�����Ǵ� �÷���)
-- �÷��� ������ Ÿ�� CONSTRAINT �������Ǹ� REFERNECES �θ����̺� (�����Ǵ� �÷���)

-- ���̺������� ����
-- CONSTRAINT ���̺��_�������Ǹ�_�������Ǿ�� FOREIGN KEY (�����ϴ� �÷���) REFERENCES �θ����̺� (�����Ǵ� �÷���)
-- ���̺�� ���̺��� ���迡 ����,...
-- ��� ���� ���̺� <---> �μ� ���� ���̺�
-- ����� �μ��� �Ҽӵȴ�(=����) N : 1     [1:��] ���� : RDBMS���� �ڰ��� �⺻����!
-- �μ��� ����� �����Ѵ�(=����  1 : N     [��:��], [M:N] ���� ==> �����ؼ� 
-- HR ��Ű�� ==> ���� �Ը��� �����ͺ��̽� ==> ���ʿ� ����� ���̺� ����

-- �������  ===> employees (���̺�)
-- ���(PK),�̸�, �޿�,�̸���, �μ��ڵ�(FK) ==> first_name, employee_id,salary, email (�÷�)

-- �μ�����  ===> departments (���̺�)
-- �μ��ڵ�(PK), �μ���, ��ġ�ڵ� (�÷�)

-- ������ �𵨸� : �𵨷� ==> ���̺� ����, �÷�, �������� ����

-- ������̺�,
-- �μ����̺�     <---> � ȸ���� ������ �ľ�, �м� --> �����ͺ��̽� �ý��� ���� : ���伳��->������->��������
-- �׹ۿ�..


-- ���θ� ���� : ���ι� ���� �ľ� (��-��ǰ �ֹ�,����,   ȸ��-��ǰ ����, �߼�..)
-- ���伳�� : ���� ���� �߿� Ű���带 ���� ==>  ����Ƽ(=��ü), �÷�(=Ư��) ....
-- ������ : Entity Relational Diagram (ERD) ==> �׸����� ��ü,Ư��, ���踦 ǥ���ϴ� ����
-- �������� : CREATE TABLE ~ ALTER TABLE~ INSERT INTO ~

-- (��� - �μ�) I.���伳��
-- �� ������ ��� ���̺� : CUSTOMERS (��ID, ����, ����ó...)
-- ��ǰ ������ ��� ���̺� : ITEMS (��ǰID, ��ǰ��, ����)

-- II. ������         <----> ERD (���̾�׷�, ����ȭ)
-- ������
------------------------------------
��ID    ����     ��ȭ��ȣ �̸��� ����ȭ �繫����ȭ ..
 PK       NN            
NUMBER   VARCHAR2     VARCHAR(11) 
------------------------------------
0001     ȫ�浿       010-1234-5645
0002     �̱浿     
0003     �ڱ浿

-- ��ǰ����
-----------------------------------------------------------
��ǰID   �з�     ������    ������/������   ��������  ...
  PK     NN
NUMBER   VARCHAR2   VARCHAR2   VARCHAR2     DATE  
-----------------------------------------------------------
0001    ��ȭ(D)    �ѱ�      H��
0002    ��ǰ(F)    �±�      Y��
0003


-- III.�������� : SQL

CREATE TABLE customers (
    id  NUMBER(4),
    name    VARCHAR2(20) NOT NULL,
    phone   VARCHAR2(11),
    CONSTRAINT customers_id_pk PRIMARY KEY (id)
);

CREATE TABLE items (
    p_id NUMBER(4),
    p_type CHAR(2) NOT NULL,
    p_born CHAR(2) NOT NULL,
    p_manufactor VARCHAR2(50),
    regdate DATE,
    CONSTRAINT items_p_id_pk PRIMARY KEY (p_id)
)

-- DBA, ������ �𵨷� : ���忡 ���� ���� ==> ���� ���� ==> �ΰ����� Ȱ��ȭ ==>



[����10-26] emp_test : employees ���̺��� �����ϰ�, �������� �Žÿ�

CREATE TABLE emp_test (       
    emp_id NUMBER(4) PRIMARY KEY, -- �ߺ�x, NULL ���! : ���ϼ� ����
    ename VARCHAR2(30) NOT NULL, -- NULL ������� ����
    dept_id NUMBER(4),
    job_id VARCHAR2(10),
    CONSTRAINT emp_test_dept_id_fk FOREIGN KEY (dept_id) REFERENCES dept_test (dept_id)    
); -- Table EMP_TEST��(��) �����Ǿ����ϴ�.

-- hanul ������ ����(ROLE)�� HR ������ �ִ� ���̺� ������ �� ���� ���¶��, ������ �߻�
-- ������ �ο�(DCL)�� �ʿ���.
-- CONSTRAINT emp_test_dept_id_fk FOREIGN KEY (dept_id) REFERENCES HR.departments (department_id)

-- dept_test [dept_id, dept_name]
SELECT *
FROM    dept_test; -- 10, 20�� �μ��� ���� <--> ��� ��Ͻ� �μ��ڵ�� 10�̳� 20�̾�� ����� ��.

[����10-27]
INSERT INTO emp_test (emp_id, ename, dept_id, job_id)
VALUES (100, 'King', 10, 'ST_MAN'); -- ok

INSERT INTO emp_test (emp_id, ename, dept_id, job_id)
VALUES (101, 'Kong', 30, 'AC_MG'); -- �μ����̺� 30�� �μ��� �������� �ʴµ�, �Է� �õ�

-- ORA-02291: ���Ἲ ��������(HANUL.EMP_TEST_DEPT_ID_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
-- 30�� �μ������� dept_test �� �Է� �� ��������� ���Է� ==> ����
INSERT INTO dept_test (dept_id, dept_name)
VALUES (30, '�Ǹź�');

-- �ٽ� ��������� �Է�
INSERT INTO emp_test (emp_id, ename, dept_id, job_id)
VALUES (101, 'Kong', 30, 'AC_MG'); -- �μ����̺� 30�� �μ��� ������ ���¿��� �Է½õ�

INSERT INTO emp_test (emp_id, ename, dept_id, job_id)
VALUES (102, 'Jack', 50, 'ST_CLERK');

SELECT *
FROM    emp_test;


-- ���̺� ���� �� FK �߰�����
-- �ϴ� ���� ������ ==> ���� ���� �̸��� ����
SELECT constraint_name, constraint_type
FROM    user_constraints
WHERE   table_name = 'EMP_TEST';

-- EMP_TEST_DEPT_ID_FK �� ����
ALTER TABLE emp_test
DROP CONSTRAINT EMP_TEST_DEPT_ID_FK; -- Table EMP_TEST��(��) ����Ǿ����ϴ�.

-- �ٽ� ���� : ���� ������~ �����ϰ� (�����)
ALTER TABLE emp_test
ADD CONSTRAINT emp_test_dept_id_fk FOREIGN KEY (dept_id) REFERENCES dept_test (dept_id);

-- UPDATE �غ��ô�
SELECT *
FROM    emp_test;

UPDATE emp_test
SET dept_id = 50
WHERE   emp_id = 101;  -- ORA-02291: ���Ἲ ��������(HANUL.EMP_TEST_DEPT_ID_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�



-- ���� ���� Ȯ��

SELECT *
FROM    dict
WHERE table_name LIKE '%PRIVS%';

SELECT *
FROM    USER_ROLE_PRIVS; -- ����� ���� ��_����

SELECT *
FROM    ALL_TAB_PRIVS -- ����� ���� ��_����
WHERE   grantee='HANUL';



-- DEFAULT
-- �÷� ������ �����Ǵ� �Ӽ�, �����͸� �Է����� �ʾƵ� ������ ���� �⺻ �Էµǵ��� �Ѵ�.
-- ���������� �ƴ�����, �÷� �������� �ۼ��Ѵ�.

[����10-30]
CREATE TABLE default_test (
    name    VARCHAR2(10) NOT NULL,
    hire_date DATE DEFAULT SYSDATE NOT NULL,
    salary NUMBER(8) DEFAULT 2500
);

INSERT INTO default_test (name, hire_date, salary)
VALUES ('ȫ�浿',TO_DATE('2023-05-22', 'YYYY-MM-DD'), 3000);


INSERT INTO default_test (name)
VALUES ('��浿'); -- ���ó���, 2500 �޿�

SELECT *
FROM    default_test;

