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



-- 10.2 CHECK �������� - ���� ����    : Check
-- 10.3 UNIQUE �������� - �ߺ����� (NULL ���)
-- 10.4 PRIMARY KEY �������� - UNIQUE + NOT NULL 
-- 10.5 FOREIGN KEY �������� - �ܷ�Ű 

