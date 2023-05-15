-- 5장.JOIN (연산)
-- 오라클 관계형 데이터베이스이다 ==> 관계 : 테이블과 테이블이 맺는!  
-- (Relation, 릴레이션 - 데이터베이스 설계할때 테이블을 릴레이션이라고 함)
-- JOIN 여러 테이블을 연결하여 (HR: 7개, 업무 : n) 데이터를 조회한다
-- ex> 사원 테이블 ~ 부서 테이블 연결 : 사원정보에 부서정보(부서이름, 부서위치코드)를 조회할때!


-- 5.1 Cartesian Product (Decart의 다른 말, Cartesian)
-- JOIN 조건 : 둘 이상의 테이블의 관계를 맺을때, 기준이 되는 컬럼을 지정 ==> 보통, WHERE 절에 기술...
-- JOIN 조건을 기술하지 않을 때 잘못된 결과가 발생하는데, 이걸 카테시안 곱(=합성곱)이라고 함.
-- 오류는 안남 ==> 예측되는 데이터 보다 많다면, 의심!!
-- CROSS JOIN 이라고도 함. (테이블의 데이터(=ROW)가 적다면 문제x, 많다면~ ==> 대기시간, 연산 오래걸리는..)

/*
SELECT 컬럼명1, 컬럼명2,....
FROM    테이블명1, 테이블명2, ...
WHERE   JOIN 조건(=비교)
*/

[예제5-1] 사원 테이블과 부서 테이블을 이용해 사원의 정보를 조회하고자 한다. 사번, 성, 부서 이름을
조회하라!

-- 사번, 성 : employees (사원 정보 테이블 : 사번, 이름, 사원급여, 입사일,..)
-- 부서이름 : departments (부서 정보 테이블 : 부서코드, 부서이름, 부서가 위치한 지역코드 )


-- 사원테이블 데이터/행 수 : 107
-- 부서테이블 데이터/행 수 : 27
-- 카테시안 곱 : 2889 rows ==> 107 * 27

SELECT 107 * 27
FROM    dual;


DESC employees;
/*
이름             널?       유형           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)
*/

DESC departments;
/*
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)
*/




-- 5.2 EQUI JOIN : 동등연산자(=)를 사용해 JOIN 연산(=동등 조인)
-- 두 테이블의 공통 컬럼 : department_id (manager_id : 부서테이블의 식별자x)
-- 전체 사원은 107명, 조회된 결과 106건 <---> 1명의 누락!!
-- 누락된 데이터 행까지 포함해서 결과를 반영 ==> 제대로된 결과(전체 사원기준) ==> OUTER JOIN 처리!
-- 비교되는 개념으로 INNER JOIN 이라고도 할 수 있음.

-- ※테이블을 이용한 JOIN ==> 어느 테이블에 어떤 컬럼인지를 명시!


[예제 5-2]
SELECT  e.employee_id, e.last_name,  -- 주된 내용을 조회하려는 테이블의 컬럼
        d.department_name -- 부가적인 정보
FROM    employees e , departments d
WHERE   e.department_id = d.department_id;
-- ORA-00918: 열의 정의가 애매합니다

[예제5-3] 테이블의 Alias를 적용~

SELECT  e.employee_id, e.last_name,  -- 주된 내용을 조회하려는 테이블의 컬럼
        d.department_name -- 부가적인 정보
FROM    employees , departments
WHERE   e.department_id = d.department_id;


[예제5-4] (사원테이블, 업무테이블을 이용해) 사번, 이름, 업무코드, 업무제목 정보를 조회한다.
DESC jobs;

SELECT  e.employee_id, e.first_name||' '||e.last_name name, e.job_id,
        j.job_title
FROM    employees e, jobs j      -- 카테시안 곱 : 2,033  rows
WHERE   e.job_id = j.job_id
ORDER BY 1; -- 107 rows    vs   사원정보+부서이름 : 106 (1명이 부서코드가 NULL 이어서..)

-- 1) 사원 ~ 부서 : 조인조건 1개
-- 2) 사원 ~ 업무 : 조인조건 1개
-- 3) 사원 ~ 부서 ~ 업무 ~ 도시 ~ 나라(국가) ~ 대륙
--  ===> JOIN 하는 테이블의 갯수 - 1 : 조인조건의 갯수

-- JOIN 하는 대상 테이블이 추가되면, JOIN 조건을 추가한다.

[예제5-5] (사원 테이블, 부서 테이블, 업무 테이블을 이용해) 사번, 이름, 부서명, 업무제목 정보를 조회한다.
-- employees, departments, jobs
-- 사원정보,  부서정보,  업무정보
--    department_id

SELECT  e.employee_id AS 사번, e.first_name||' '||e.last_name name,
        d.department_name,
        j.job_title
FROM    employees e, departments d, jobs j
WHERE   e.department_id = d.department_id --1명이 부서코드 x
AND     e.job_id = j.job_id
ORDER BY 1;

-- WHERE 조건절에 JOIN 조건과 일반 조건을 함께 사용한다.
[예제5-6] 사번이 101번인 사원의 사번, 이름, 부서명, 업무제목 정보를 조회한다.
-- 사번, 이름 : employees --> e , emp ...
-- 부서명 : departments  --> d , dept ...
-- 업무제목 : jobs       --> j , job ....
-- ※ 테이블의 갯수와 JOIN 조건의 관계 : 테이블 갯수 - 1 (JOIN조건의 갯수)

SELECT  e.employee_id, e.first_name,
        d.department_name,
        j.job_title
FROM    employees e, departments d, jobs j
WHERE   e.department_id = d.department_id -- 부서코드가 없는 사람 1명
AND     e.job_id = j.job_id
AND     e.employee_id = 101; 
-- 사번 : 식별자(PK, Primary Key / NULL 허용되지않고, 중복되지 않는 유일한 값)
-- ※ 제약조건(constraint) : 데이터 입력의 실수/삭제/수정 막기위한 조치











-- 5.3 NON-EQUI JOIN               VS      EQUI JOIN (개념상 INNER JOIN vs OUTER JOIN)
--     비교연산자(>, >=, <, <=)            동등연산자(=)  
--     BETWEEN
--     IN
-- ※ NO~ EQUI :  동등연산자 이외의 연산자를 사용한 JOIN 연산
-- ※ JOIN 하는 컬럼이 일치하지 않게 사용하는 JOIN 조건으로 < 거의 사용하지 않는다 >
-- 업무에서는?? ==> 하나의 데이터라도 놓치지 않게 OUTER JOIN을 훨씬 많이 사용한다.

[예제5-7] 급여가 업무 상하한 범위 내에 있는 10번 부서원의 사번, 이름, 급여, 업무제목을 조회한다.
-- 사원의 정보 : employees [사번, 이름, 급여]
-- 업무정보 : jobs [업무제목]
/*
SELECT  e.employee_id, e.first_name, e.salary,
        j.job_title
FROM    employees e, jobs j -- 카테시안 곱 : JOIN 조건을 기술하지 않았을때, 결과행이 초과되어 나타남
WHERE   e.job_id = j.job_id
AND     e.salary >= j.min_salary
AND     e.salary <= j.max_salary
AND     e.department_id = 50; -- 10번 부서원 1명
*/

SELECT  e.employee_id, e.first_name, e.salary,
        j.job_title
FROM    employees e, jobs j -- 카테시안 곱 : JOIN 조건을 기술하지 않았을때, 결과행이 초과되어 나타남
WHERE   e.salary BETWEEN j.min_salary AND j.max_salary -- 조인조건절에 = 아닌 비교연산자/BETWEEN 연산자/IN 연산자
AND     e.job_id = j.job_id
AND     e.department_id = 50;

-- 부서별 사원수
SELECT department_id, COUNT(*) AS cnt
FROM    employees
GROUP BY department_id
ORDER BY 1;


-- 급여의 최고, 최저선 : 상,하한 범위
-- 업무 상하한 범위 ??
-- 업무 ==> 업무 테이블 (JOBS)
DESC jobs;
/*
이름         널?       유형           
---------- -------- ------------ 
JOB_ID     NOT NULL VARCHAR2(10) 
JOB_TITLE  NOT NULL VARCHAR2(35) 
MIN_SALARY          NUMBER(6)    
MAX_SALARY          NUMBER(6)
*/


-- 5.4 OUTER JOIN : EQUI JOIN 쿼리문은 JOIN 하는 테이블간 공통으로 만족되는 값을 
-- 가진 경우의 결과만을 반환한다. 하지만, OUTER JOIN은 만족되는 값이 없는 경우의 결과까지(?)
-- 반환한다.

-- ※ 만족되는 값이 없는 테이블 컬럼명에 (+) 기호를 표시한다.
-- 기준테이블의 반대편에 (+) 표시!!

[예제5-8] 모든 사원의 사번, 이름, 급여, 부서코드, 부서명 정보를 조회한다.
-- department_id가 NULL인 사원 1명의 정보 누락되는 결과 : EQUI JOIN 연산
-- 사원정보 : 사번, 이름, 급여, 부서코드 (employees)
-- 부서정보 : 부서명 (departments)
SELECT  e.employee_id AS empno, e.first_name AS ename, e.salary AS esal,
        d.department_name AS dname
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+)  -- ORA-01468: outer-join된 테이블은 1개만 지정할 수 있습니다
ORDER BY 1;


[예제5-9] 모든 사원의 사번, 이름, 급여, 부서코드, 부서명, 위치코드, 도시이름 정보를 조회한다.
SELECT  e.employee_id AS empno, e.first_name AS ename, e.salary AS esal,
        d.department_name AS dname,
        l.city AS city_of_dept
FROM    employees e, departments d, locations l -- 3개의 테이블, JOIN 조건은 2개 (테이블 갯수 - 1개)
WHERE   e.department_id = d.department_id(+)  -- ORA-01468: outer-join된 테이블은 1개만 지정할 수 있습니다 ==> 양쪽에 (+) 기호 표시하여 에러발생
AND     d.location_id = l.location_id(+)
ORDER BY 1;



-- 5.5 SELF JOIN : 하나의 테이블을 두 번 명시하여, 동일한 테이블 두개로부터 JOIN을 통해
-- 데이터를 조회한 결과를 반환한다.
-- 1) 실제로 테이블을 두개인게 더 나을까? (물리적으로 저장되는 공간 낭비)
-- 2) 두 번 명시한다 (메모리상-속도 빠르죠!-물리적으로 중복된 데이터 저장 하지않고!! 서로다른,
-- 테이블이 존재하는 것처럼 JOIN 연산
-- ※ 테이블 관계 : 순환 참조(재귀, Recursive)

[예제 5-10] 사원의 사번, 이름, 매니저의 사번, 매니저의 이름 정보를 조회한다.
-- 사원의 정보 : employees [사번 컬럼, 이름]
-- 매니저의 정보 : manager?? [사번 컬럼, 이름]

SELECT employee_id, first_name, manager_id
FROM    employees;

-- SELF JOIN
SELECT  e.employee_id, e.first_name,
        m.employee_id AS manager_id, m.first_name AS manager_name
FROM    employees e, employees m
WHERE   e.manager_id = m.employee_id -- ID : Identifity, ~ied. 유일한~! NULL 허용
ORDER BY 1;

--- 오라클 JOIN 연산 ------------------------------------------------------------------------
-- 1) 카테시안 곱(Cartesign Product) : 조인 조건절을 생략했을때~ 잘못된 결과(너무많은 결과행)
-- 2) EQUI-JOIN (동등조인, =) <---> INNER JOIN(=내부 조인) / 개념상 구분
-- 3) NON-EQUI JOIN (비교연산자,BETWEEN,IN) <---> EQUI-JOIN (사용할일이 거의 없다)
-- 4) OUTER JOIN (=외부 조인) <---> INNER JOIN과 반대되는 개념
-- 5) SELF JOIN : 하나의 테이블에 공통된 데이터 컬럼을 이용한 자기순환 참조 JOIN


--- 5.6 ANSI JOIN (안시 조인, p.48)
-- 미국 표준 협회(American National Standards Institute, ANSI)
-- 오라클 DBMS가 아닌 다른 DBMS에서 공통적으로 사용할 수 있는 표준 방식의 JOIN 연산
-- 모든 DBMS에서 ..RDBMS(Relational DBMS/관계형 DBMS)



-- 5.6.1 INNER JOIN <---> 오라클 JOIN에서 INNER JOIN은 사실, EQUI-JOIN! 
-- FROM절에 INNER JOIN을 사용하고, JOIN 조건(=WHERE)은 ON 절에 명시한다.

[예제5-12](모든) 사원의 사번, 이름, 부서코드, 부서명 정보를 조회한다.

-- 오라클 JOIN
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+)
AND     e.manager_id IS NOT NULL
ORDER BY 1;

-- ANSI INNER JOIN
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM    employees e INNER JOIN departments d -- 1) FROM 절에 INNER JOIN 을 사용 : , 대신!
ON   e.department_id = d.department_id       -- 2) JOIN 조건은 ON 절에 표시 : WHERE 대신~ ON!
AND     e.manager_id IS NOT NULL
ORDER BY 1; -- 105명


-- ON절 대신 USING절을 사용할 수 있다.
-- 단, USING 을 사용할때 컬럼명만 기술해야 한다
-- ※ 공통 컬럼 이름만 기술  ==> 테이블의 별칭(Alias)을 생략!!

 -- 2) SELECT절에 공통컬럼도 테이블 별칭 제거

SELECT  e.employee_id, e.first_name, department_id,
        d.department_name
FROM    employees e INNER JOIN departments d 
WHERE     e.manager_id IS NOT NULL   -- ※오류
USING   (department_id)       -- 1) ON 대신 USING (공통 컬럼명만)
--WHERE     e.manager_id IS NOT NULL   -- ※오류 ==> WHERE 처리
ORDER BY 1; -- 105명
--ORA-00933: SQL 명령어가 올바르게 종료되지 않았습니다 ==> SELECT 절도 확인!
--00933. 00000 -  "SQL command not properly ended"

-- ORA-00906: 누락된 좌괄호    ==> USING (공통컬럼)
-- 00906. 00000 -  "missing left parenthesis"

[예제5-13] 
SELECT  e.employee_id, e.first_name, department_id,
        d.department_name
FROM    employees e JOIN departments d -- INNER가 옵션~
USING   (department_id)
WHERE   e.manager_id IS NOT NULL
ORDER BY    1;

-- 오라클 조인 : Cartesian Product, EQUI JOIN(=), NON-EQUI JOIN(>,>=,<,<=, BETWEEN, IN), OUTER JOIN(+)
-- ANSI JOIN   :  (CROSS JOIN)    , INNER JOIN ,                 OUTER JOIN



[예제5-15] 사원의 사번, 이름, 부서코드, 부서명, 위치코드, 도시정보, [국가, 대륙]를 조회한다.
-- 오라클 JOIN / ANSI JOIN
-- 테이블이 3개 이상일때 ==> 첫번째 JOIN의 결과에, 두번째 JOIN을 추가하는 형태로 JOIN 연산
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name,
        l.city
FROM    employees e INNER JOIN departments d
ON      e.department_id = d.department_id
INNER JOIN locations l
ON      d.location_id = l.location_id;


SELECT  e.employee_id, e.first_name, department_id,
        d.department_name,
        city
FROM    employees e INNER JOIN departments d
USING      (department_id)
INNER JOIN locations l
USING      (location_id);

-- ORACLE JOIN
SELECT  e.employee_id, e.first_name, d.department_id,
        d.department_name,
        l.city
FROM    employees e, departments d, locations l
WHERE   e.department_id = d.department_id
AND     d.location_id = l.location_id; -- 106rows



-- 5.6.2 OUTER JOIN <---> 오라클 JOIN에서 (+)를 사용하는 OUTER JOIN과 같은 기능을 하는 ANSI JOIN
-- 오라클 JOIN의 OUTER JOIN은 조인 조건절에 모두 (+) 붙였음.
-- ANSI JOIN의 OUTER JOIN은 FROM절에 [LEFT|RIGHT|FULL] OUTER JOIN을 사용하고,
-- JOIN 조건은 ON절에 명시한다.

[예제5-16] 사원의 사번, 이름, 부서코드, 부서명 정보를 조회한다.
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM    employees e FULL OUTER JOIN departments d-- INNER: 생략가능
ON      e.department_id = d.department_id --WHERE 대신 ON 또는 USING(공통 컬럼명)
ORDER BY 1;

-- OUTER JOIN 으로 FULL 생략시 발생!
-- ORA-00905: 누락된 키워드
-- 00905. 00000 -  "missing keyword"


-- [LEFT|RIGHT|FULL] OUTER JOIN 도 INNER JOIN 처럼,
-- 1) ON 절에 조인조건 또는
-- 2) USING 절에 조인조건 명시



-- 5.6 ANSI JOIN  /  ANSI 협회에서 만든 표준 JOIN 식(ORACLE외에도 MYSQL, CUBRID, 기타 RDBMS 공통 JOIN)


-- 5.7 OUTER JOIN

