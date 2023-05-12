-- ����, ����, ����
-- DCL(Data Control Language) - ����(GRANT(���Ѻο�), REVOKE(���ѻ���)) <- ���� x
-- DML(Data Manipulation Language) - INSERT, UPDATE, DELETE (SELECT)
-- CRUD(WEB���� �⺻ 4���� ������ ��� CRUD��� ǥ���� �Ѵ�.)
-- DDL(Data Definition Language) - CREATE, ALTER, DROP (���̺��� �����ϰ�, �����ϰ�, ����)

-- JAVA (JDBC) -> (SQL)DBMS -> DB(Exceló�� ���常 �ϴ� â��)

SELECT  1 
FROM    DUAL;
-- KEY �����ͺ��̽��� ����ȭ ������ ��ġ�µ� �� �� �����͸� �ϳ��� ���ų� �����ϰ� �� �� �ְ� ����
-- �ĺ��� (������� ġ�� �� �ĺ��� : �ֹε�Ϲ�ȣ, �� �ĺ��� : �θ���� �ֹε�Ϲ�ȣ)
-- NUMBER(int), VARCHAR2(String), NVARCHAR2(String)
CREATE TABLE SBN ( -- String col1, col4; int col2;
    COL1 VARCHAR2(1000),
    COL2 NUMBER,
    COL3 VARCHAR2(1000),
    COL4 VARCHAR2(1000),
    COL5 VARCHAR2(1000)
);
--DROP TABLE SBN;


INSERT INTO SBN (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '10000', 'A', 'A', 'A');
INSERT INTO SBN (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '10000', 'A', 'A', 'A');
INSERT INTO SBN (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '10000', 'A', 'A', 'A');
INSERT INTO SBN (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '10000', 'A', 'A', 'A');
INSERT INTO SBN (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '10000', 'A', 'A', 'A');

ROLLBACK;
COMMIT;

-- ��� �۾��� ��� �͵��� �ǵ�����. (ROLLBACK) ROLLBACK �Ǵ� COMMIT�� �� ���� �����ϰ� �Ѵ�.
-- ��� �۾��� ��� �� Ȯ�� (COMMIT)
-- Ʈ����� : ��� �۾��� �ּ��� ���� : DBMS�� �۾��� �س��� Ȯ���Ұ����� ��ٸ��� ����

SELECT * FROM SBN;

ROLLBACK;

UPDATE SBN SET COL1 = '��ȣ��ٲ�' WHERE COL3 = '10000';

DELETE FROM SBN;

-- DATA TYPE : NUMBER (int), VARCHAR2 (String)
-- CREATE TABLE ���̺��̸� (
--  �÷��̸� ������Ÿ��(ũ��), <- �÷��� ��������� �޸��� �������� �÷� �̸� ������Ÿ�� �κ��� �ݺ�
--);

ROLLBACK;
DROP TABLE KOREA_PEOPLE;
CREATE TABLE KOREA_PEOPLE(
    JUMIN_NUM NUMBER PRIMARY KEY, --�ߺ��Ǹ� �� �Ǵ� ������(key, �ĺ���)�� �ǹ���.
    NAME VARCHAR2(20),
    GENDER NUMBER
);

INSERT INTO KOREA_PEOPLE (JUMIN_NUM, NAME, GENDER) VALUES ('2', '�̸�1', '2');

SELECT * FROM korea_people;

COMMIT;
-- ��ȣ�� : �ҳ���, �ָ޴� : ���, �ָ޴� : ���, �ּ� : ~~, ���� : 11
-- ���� ���������� ���п��� ������ �����͸� ���� DB�� ������ �ϰ�ʹٸ� ��� �ؾ��ұ�?
-- �ش� ������ ������ ���̺��� �����, INSERT���� �̿��ؼ� �����͸� �־��(2��)

CREATE TABLE CRIME (
    CRIME1 VARCHAR2(100),
    CRIME2 VARCHAR2(100) PRIMARY KEY,
    LOCAL VARCHAR2(100)
);
DROP TABLE CRIME;
INSERT INTO CRIME (CRIME1, CRIME2, LOCAL) VALUES ('��Ÿ����', '��Ÿ����', '����');
INSERT INTO CRIME (CRIME1, CRIME2, LOCAL) VALUES ('��������', '��������', '����');
INSERT INTO CRIME (CRIME1, CRIME2, LOCAL) VALUES ('���Ź���', '���Ź���', '����');
INSERT INTO CRIME (CRIME1, CRIME2, LOCAL) VALUES ('�Ⱥ�����', '�Ⱥ�����', '����');

UPDATE CRIME SET CRIME1 = '�������' WHERE CRIME2 = '��Ÿ����';

SELECT * FROM CRIME;

ROLLBACK;

COMMIT;