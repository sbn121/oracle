-- 정의, 조작, 제어
-- DCL(Data Control Language) - 제어(GRANT(권한부여), REVOKE(권한삭제)) <- 공부 x
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


INSERT INTO SBN (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '10000', 'A', 'A', 'A');
INSERT INTO SBN (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '10000', 'A', 'A', 'A');
INSERT INTO SBN (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '10000', 'A', 'A', 'A');
INSERT INTO SBN (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '10000', 'A', 'A', 'A');
INSERT INTO SBN (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '10000', 'A', 'A', 'A');

ROLLBACK;
COMMIT;

-- 방금 작업한 모든 것들을 되돌리다. (ROLLBACK) ROLLBACK 또는 COMMIT을 할 때는 신중하게 한다.
-- 방금 작업한 모든 것 확정 (COMMIT)
-- 트랜잭션 : 디비 작업에 최소의 단위 : DBMS가 작업을 해놓고 확정할건지를 기다리는 상태

SELECT * FROM SBN;

ROLLBACK;

UPDATE SBN SET COL1 = '상호명바꿈' WHERE COL3 = '10000';

DELETE FROM SBN;

-- DATA TYPE : NUMBER (int), VARCHAR2 (String)
-- CREATE TABLE 테이블이름 (
--  컬럼이름 데이터타입(크기), <- 컬럼이 여러개라면 콤마를 기준으로 컬럼 이름 데이터타입 부분이 반복
--);

ROLLBACK;
DROP TABLE KOREA_PEOPLE;
CREATE TABLE KOREA_PEOPLE(
    JUMIN_NUM NUMBER PRIMARY KEY, --중복되면 안 되는 데이터(key, 식별자)를 의미함.
    NAME VARCHAR2(20),
    GENDER NUMBER
);

INSERT INTO KOREA_PEOPLE (JUMIN_NUM, NAME, GENDER) VALUES ('2', '이름1', '2');

SELECT * FROM korea_people;

COMMIT;
-- 상호명 : 소나무, 주메뉴 : 고기, 주메뉴 : 고기, 주소 : ~~, 연변 : 11
-- 내가 공공데이터 포털에서 가져온 데이터를 나의 DB에 저장을 하고싶다면 어떻게 해야할까?
-- 해당 내용을 가지고 테이블을 만들고, INSERT문을 이용해서 데이터를 넣어보기(2건)

CREATE TABLE CRIME (
    CRIME1 VARCHAR2(100),
    CRIME2 VARCHAR2(100) PRIMARY KEY,
    LOCAL VARCHAR2(100)
);
DROP TABLE CRIME;
INSERT INTO CRIME (CRIME1, CRIME2, LOCAL) VALUES ('기타범죄', '기타범죄', '광주');
INSERT INTO CRIME (CRIME1, CRIME2, LOCAL) VALUES ('병역범죄', '병역범죄', '광주');
INSERT INTO CRIME (CRIME1, CRIME2, LOCAL) VALUES ('선거범죄', '선거범죄', '광주');
INSERT INTO CRIME (CRIME1, CRIME2, LOCAL) VALUES ('안보범죄', '안보범죄', '광주');

UPDATE CRIME SET CRIME1 = '교통범죄' WHERE CRIME2 = '기타범죄';

SELECT * FROM CRIME;

ROLLBACK;

COMMIT;