-- 정의, 조작, 제어
-- DML(Data Manipulation Language) - INSERT, UPDATE, DELETE (SELECT)
-- CRUD(WEB에서 기본 4가지 로직을 묶어서 CRUD라고 표현을 한다.)
-- DDL(Data Definition Language) - CREATE, ALTER, DROP (테이블을 생성하고, 삭제하고, 수정)

-- JAVA (JDBC) -> (SQL)DBMS -> DB(Excel처럼 저장만 하는 창고)

SELECT  1 
FROM    DUAL;
-- KEY 데이터베이스가 정규화 과정을 거치는데 그 때 데이터를 하나로 묶거나 구분하게 할 수 있게 해줌
-- 식별자 (사람으로 치면 주 식별자 : 주민등록번호, 부 식별자 : 부모님의 주민등록번호)
-- NUMBER(int), VARCHAR2(String), NVARCHAR2(String)
CREATE TABLE SBN ( -- String col1, col4; int col2;
    COL1 VARCHAR2(1000),
    COL2 NUMBER,
    COL3 VARCHAR2(1000),
    COL4 VARCHAR2(1000),
    COL5 VARCHAR2(1000)
);
--DROP TABLE SBN;





