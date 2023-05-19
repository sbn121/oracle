-- 10장. 제약조건

-- 무결성 제약조건(Integrity Constraints) : 데이터의 정확성을 보장하기 위해 두는 제약/제한 조건
-- 1) 테이블 생성시 정의 : CREATE TABLE ~
-- 2) 테이블 생성 후 추가 : ALTER TABLE ~

-- 10.1 NOT NULL 제약조건 - NULL 허용하지 않음    : Check
-- 컬럼의 데이터 값에 있어 NULL 허용하지 않음 ==> 반드시 데이터를 입력해야 한다.
-- ★ 테이블 생성시 컬럼 레벨에서 정의한다
-- ex> 테이블 생성 구문
CREATE TABLE 테이블명(
    컬럼명1 데이터타입(길이) 제약조건, -- 컬럼 레벨
    컬럼명2 데이터타입(길이),
    ...계속...
)

CREATE TABLE user(
    id VARCHAR2(20) NOT NULL, -- 컬럼 레벨
    nick VARCHAR2(20) ,
    ...계속...
)

[예제10-1] null_test 라는 테이블을 생성하되 컬럼은 col1 문자타입 5바이트 길이, NULL 허용하지 않고, 
col2 문자타입 5바이트 길이로 정의하시오~

-- 1) 테이블 생성 : null_test + not null
CREATE TABLE null_test (
    col1 VARCHAR2(5) NOT NULL, -- 컬럼 레벨 : NULL 허용하지 않음
    col2 VARCHAR2(5) -- 제약조건 x ==> NULL 허용
);

INSERT INTO null_test (col1)
VALUES ('AA'); -- AA | (null)

SELECT *
FROM    null_test;

[예제10-3] BB를 col2 에 삽입
INSERT INTO null_test (col2)
VALUES ('BB'); -- col1 NOT NULL 제약조건
-- ORA-01400: NULL을 ("HR"."NULL_TEST"."COL1") 안에 삽입할 수 없습니다

-- 2) 테이블 생성 후 NOT NULL 지정
-- 컬럼에 NULL 데이터가 없는 경우, NOT NULL을 추가할 수 있다.

-- null_test에 이미 BB가 col2 컬럼에 있는 상태
UPDATE null_test
SET col2 = 'BB'; -- col2 컬럼의 데이터를 null 에서 'BB'로 변경

SELECT *
FROM    null_test;

[예제10-4]
ALTER TABLE null_test
MODIFY  (col2 NOT NULL); -- 제약조건 추가


[예제10-5] col2를 NULL로 바꾸어보면 ==> 제약조건이 추가되었으니, 오류발생!
-- col2에 NOT NULL이 추가 ==> 데이터를 NULL
UPDATE null_test
SET col2 = NULL;  -- 에러 발생

-- 다시 col2 컬럼에 NULL 허용
ALTER TABLE null_test
MODIFY (col2 NULL); -- col1, col2 모두 데이터가 있다 <---> NULL이 아니므로

UPDATE null_test
SET col2 = NULL;    -- 1 행 이(가) 업데이트되었습니다



-- ===================================================================================
-- 데이터 사전
SELECT *
FROM    dict; -- 계정 권한에 따라서 보이지 않는 객체 ==> SYS나 SYSTEM으로 조회하면 모두 찾을 수 있음

-- ======== 사용자 계정으로 생성된 (테이블의) 제약조건이 모두 기록된 별도의 테이블 객체 : 오라클 관리 ======
SELECT *
FROM   user_constraints
WHERE   table_name = 'NULL_TEST'; -- 생성시 col1 NOT NULL, 생성 후 추가 col2 NOT NULL


SELECT *
FROM   user_constraints
WHERE   table_name = 'EMPLOYEES'; -- 어?

-- COMMIT;



-- 10.2 CHECK 제약조건 - 값의 범위    : Check
-- 10.3 UNIQUE 제약조건 - 중복방지 (NULL 허용)
-- 10.4 PRIMARY KEY 제약조건 - UNIQUE + NOT NULL 
-- 10.5 FOREIGN KEY 제약조건 - 외래키 

