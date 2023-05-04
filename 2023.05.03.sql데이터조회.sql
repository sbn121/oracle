desc EMPLOYEES;
select *
from EMPLOYEES;


/*
HR 스키마에 있는 테이블(=오라클 데이터베이스 객체 중 하나)
========================================================
이름               정보
--------------------------------------------------------------------
COUNTRIES          국가/나라 정보(국가ID/코드, 이름, 지역 코드)
DEPARTMENTS        부서 정보(부서 코드, 부서 이름, 매니저)
EMPLOYEES          사원 정보(사원 코드, 이름, 성, 이메일, 전화번호, 입사일, 업무 코드, 급여, 커미션율, 담당자 코드, 부서 코드)
JOB_HISTORY        
JOBS               
LOCATIONS          
REGIONS            

*/

-- 2.1 테이블 구조
-- 오라클(=데이터베이스 관리 시스템)이 데이터를 2차원 구조(표, table의 행과 열로)로 기본적으로 저장
-- 테이블 : 어떤 정보가 있는데 <--> 데이터베이스 : 관계(Relation)
-- ex> (회사) 부서 정보 테이블, 사원 정보 테이블
-- ※ Document : 행, 열 구조가 아님 vs RDBMS : 테이블(행, 열)
/*
사원 정보 테이블
사원 코드   사원 이름(성, 이름)   부서   입사일   급여 ...
----------------------------------------------------------
1           길동 홍               IT     23-02-01 2000000
1           길동 홍               IT     23-02-01 2000000
1           길동 홍               IT     23-02-01 2000000
1           길동 홍               IT     23-02-01 2000000

고객 정보 테이블
고객 코드    고객명     등급    연락처       근무지
-----------------------------------------------------
1000         이순신     우수    010.123.456  광주
1000         이순신     우수    010.123.456  광주
*/

/*
1 열(Column) : 가로 방향 [열 이름(=특성), 열의 자료형(문자, 숫자, 날짜..), 길이]
이름          널?      유형          <----행(ROW), 세로 방향
-----------------------------------
COUNTRY_ID   NOT NULL   CHAR(2)
COUNTRY_NAME            VARCHAR2(40)
REGION_ID               NUMBER

COUNTRY_ID COUNTRY_NAME                             REGION_ID
--------------------------------------------------------
AR Argentina                                2   : 가로방향의 연관된 데이터를 정보(튜플, 레코드)
AU Austrailia                               1
BE Belgium                                  3   
*/



-- 대소문자 구별x
-- 띄어쓰기, TAB을 사용해서 가독성 있게!
-- 쿼리는 절(clause) 단위로 작성
-- 자동완선 지원함! 근데, 직접 쿼리작성 빠름!


-- 2.1 DESC / DESCRIBE : 테이블의 구조 ==> 열 이름, 자료형, (저장할 수 있는 데이터) 길이 확인
--     SELECT : 데이터를 조회 ==> 테이블의 레코드 (ROW 또는 Tuple/튜플)

SELECT *        -- SELECT 절
FROM       employees; --FROM 절
-- 계속 뭔가가 추가..

-- 2.2 조건절
-- 필요한 정보만 조회하기 위한 구분, 일종의 필터링!
SELECT 열 이름1, 열 이름2, 열 이름3,...
FROM   테이블명;

-- * : 애스터리스크, ALL (모든 컬럼)
SELECT *
FROM countries; -- 25rows

[예제 2-3] 80번 부서의 사원 정보를 조회 ==> 80번 부서에 근무하는 사원들을 필터링
-- CTRL+ENTER or블럭씌우고 + F5
SELECT *
FROM employees -- 107rows, 모든 사원의 정보를 조회
WHERE department_id = 80;  -- 총 107명 중 80번 부서에 근무하는 사원은 34명(rows)
-- 오라클 연산자 : =(같다), 대입x

-- 80번 부서의 부서이름을 조회하시오!
SELECT *
FROM    departments
WHERE   department_id = 80;  -- Sale 부서 : 판매 부서 --> 소속이 많이 필요한 부서

-- Sales 부서(80)가 위치한 위치 정보를 조회해보시오! (도로주소, 우편번호, 국가 코드)
-- LOCATION_ID를 찾아서, LOCATIONS 테이블에 LOCATION_ID가 일치한 정보
SELECT location_id 위치코드 -- 별칭(Alias) : 컬럼의 이름을 약어로 표시
FROM    departments
WHERE   department_id = 80;   --부서코드로 필터링, 2500
--WHERE   department_name = 'Sales'; -- 부서 이름으로 필터링
--WHERE   department_name = 'sales'; -- 문자는 '로 작성, 대/소문자를 구분 [날짜 데이터도 '로]

-- 위치정보를 찾아보면,
SELECT  city, street_address, postal_code
FROM locations
WHERE location_id = 2500;

--  부서코드   부서명    부서위치 도시명    부서의 도로주소    부서의 우편번호
--  80         Sales     Oxford             Magdalen~          OX9 928

SELECT *
FROM job_history; --10 rows

SELECT *
FROM jobs; -- 19rows

SELECT *
FROM locations; -- 23rows

SELECT *
FROM regions;   -- 4rows

-- 미국의 어떤 회사의 정보 : 회사에 근무하는 사원을 중심으로 
-- 소속된 부서, 하는 업무, 지역(국가/대륙) 등의 정보 [작은 규모, 학습용 데이터/실제 데이터x]




