CREATE TABLE CUSTOMER (
    ID NUMBER PRIMARY KEY,
    NAME NVARCHAR2(17) NOT NULL,
    GENDER NVARCHAR2(1) DEFAULT '��' CHECK (GENDER IN ('��', '��')) ,
    EMAIL VARCHAR2(100),
    PHONE VARCHAR2(50)
);
--�ٱ��� ó���� �������� ���̰� �߿��� �ܿ� => NVARCHAR2 ���

DROP TABLE CUSTOMER;

SELECT * FROM CUSTOMER;

INSERT INTO CUSTOMER 
VALUES (1, '�����', '��', 'shm@naver.com', '010-1234-5678');
INSERT INTO CUSTOMER 
VALUES (2, '��â��', '��', 'gch@naver.com', '010-1234-5678');
INSERT INTO CUSTOMER 
VALUES (3, '������', '��', 'ohg@naver.com', '010-1234-5678');
INSERT INTO CUSTOMER 
VALUES (4, '���쿵', '��', 'jyy@naver.com', '010-1234-5678');
INSERT INTO CUSTOMER 
VALUES (5, '���Լ�', '��', 'jgs@naver.com', '010-1234-5678');

UPDATE CUSTOMER
SET GENDER = '��'
WHERE ID = 1;

COMMIT;

SELECT * FROM CUSTOMER WHERE ID = 1;  -- ?<-


