-- 6장. 서브쿼리 (p.51)

-- ※ SQL문장 안에 존재하는 또다른 SQL 문장(SELECT ~ FROM~ WHERE) 을 서브쿼리라고 한다.
-- 1) 서브쿼리는 괄호(, )로 묶어서 사용한다.
-- 2) 서브쿼리가 포함된 쿼리문을 메인 쿼리라고 한다.
-- 3) 실행순서 : 서브쿼리가 먼저 실행되고 그 결과를 반환한 뒤 메인쿼리가 실행된다.

-- ORACLE, MYSQL, MSSQL : RDBMS    vs   mongoDB(atlas), firebase(google), MS Azure, Amazon AWS
-- 관계형 데이터베이스                 <CLOUD 기반의 데이터베이스> : NoSQL (관계형 데이터베이스가 아님)

-- 오라클 ==> 서브쿼리
-- MSSQL ==> T-SQL
-- 각종 DBMS 마다 약간 다른 이름  <== 

[예제6-1] 평균 급여보다 더 적은 급여를 받는 사원의 정보를 조회한다.
-- 서브쿼리 사용 예
-- 근데 왜쓰냐? ==> 안쓰는것보다 편하다?
-- 서브쿼리를 사용하지 않고 해결 vs 서브쿼리를 사용해서 해결
-- 4장. 그룹함수 ==> 평균 급여를 구한 결과를 반환하는 함수 
-- DISTINCT : 중복을 제거한 결과를 반환하는 함수, NULL 포함
-- COUNT() : NULL 제외, 갯수를 세어서 결과를 반환
-- SUM() : 숫자데이터 컬럼의 합계
-- MAX(), MIN() : 데이터 타입과 무관하게~ 
-- AVG() : 숫자데이터 컬럼의 평균

-- 1. 평균 급여를 구한다
SELECT  ROUND(AVG(salary)) AS avg_sal
FROM    employees;   -- 평균급여 : 6462

-- 2. 평균 급여 미만을 받는 사원정보를 조회
SELECT employee_id, first_name, salary, department_id
FROM    employees
WHERE   salary < 6462; -- 56rows

-- 1+2의 효과 : 일반적인 서브쿼리(WHERE 절에) --> 행/열이 여러개 ==> 다중 행, 다중 컬럼 서브쿼리
SELECT employee_id, first_name, salary, department_id
FROM    employees
WHERE   salary < ( SELECT  ROUND(AVG(salary)) AS avg_sal
                   FROM    employees );






-- ========= 서브 쿼리의 유형 구분 ========================
-- 서브쿼리 실행 결과의 갯수에 따른 구분
-- 6.1 단일 행 (단일 컬럼) 서브쿼리 : 하나의 결과 행을 반환하는 서브쿼리
-- └ 단일 행 연산자(=, >=, >, <, <=,        <>, !=, ^=)
-- └ 4장. 그룹 함수를 사용하는 경우가 많다. (AVG, SUM, COUNT, MAX, MIN)
[예제6-2] 월 급여가 가장 많은 사원의 사번, 이름, 성 정보를 조회한다.
-- 1. 월 급여 가장 많은 금액 조회
SELECT salary
FROM    employees
ORDER BY 1 DESC; -- MAX: 24000 ==> 아직 행이 여러개?

SELECT MAX(salary) AS max_sal, MIN(salary) AS max_sal
FROM    employees; -- MAX: 24000, MIN: 2100

SELECT MIN(salary) AS max_sal
FROM    employees;

-- 2. 서브쿼리 작성
SELECT employee_id, first_name, last_name
FROM    employees
WHERE   salary = ( SELECT MAX(salary) AS max_sal
                    FROM    employees );   -- 100	Steven	King

SELECT employee_id, first_name, last_name
FROM    employees
WHERE   salary = ( SELECT MIN(salary) AS max_sal
                    FROM    employees );   -- 132	TJ	Olson
                    
[예제6-3] 사번 108번 사원의 급여보다 더 많은 급여를 받는 사원의 정보를 조회한다.
-- 1.서브쿼리를 사용하지 않을때
-- 1-1. 108번 사원의 급여를 조회
-- 1-2. 전체 사원 기준 1-1에서 구한 급여와 비교해서 더 많은 급여받는 사원 조회
SELECT  salary
FROM    employees
WHERE   employee_id = 108;  -- 108번 사원 : 12008 

SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary > ( SELECT  salary
                    FROM    employees
                    WHERE   employee_id = 108 );  -- 6rows
                    
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary < ( SELECT  salary
                    FROM    employees
                    WHERE   employee_id = 108 );  -- 99rows     
                    
                    
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary = ( SELECT  salary
                    FROM    employees
                    WHERE   employee_id = 108 );  -- 99rows                      


SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary <> ( SELECT  salary
                    FROM    employees
                    WHERE   employee_id = 108 ); 

SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary ^= ( SELECT  salary     
                    FROM    employees
                    WHERE   employee_id = 108 ); 

SELECT  employee_id, first_name, salary
FROM    employees
WHERE   salary != ( SELECT  salary     
                    FROM    employees
                    WHERE   employee_id = 108 ); 
                    
                    

[예제6-4] 월급여가 가장 많은 사원의 사번, 이름, 성, 업무제목 정보를 조회
-- employees : 사번, 이름, 성
-- jobs : 업무제목(job_title)


-- 1. 월급여 가장 큰 값 : 24000   vs  2100
SELECT MAX(salary)
FROM    employees;

SELECT MIN(salary)
FROM    employees;


-- 2. 사원의 사번, 이름, 성, 업무제목 정보
-- 2-1. 오라클 조인
-- 2-2. ANSI JOIN ==> MYSQL 사용 전제, T-SQL (MSSQL), ...

SELECT  e.employee_id, e.first_name, e.last_name,
        j.job_title
FROM    employees e, jobs j
WHERE   e.job_id = j.job_id
AND     salary = ( SELECT MAX(salary) AS max_sal
                    FROM    employees ); -- King

SELECT  e.employee_id, e.first_name, e.last_name,
        j.job_title
FROM    employees e, jobs j
WHERE   e.job_id = j.job_id
AND     salary = ( SELECT MIN(salary) AS max_sal
                    FROM    employees ); -- olson
    

-- 6.2 다중 행 서브쿼리(p.53) 
-- 다중 행 연산자 (IN, NOT, ANY(=SOME), ALL, EXISTS)
-- 6.2.1 IN 연산자
-- OR 연산자 대신 --> 간결

SELECT  employee_id, first_name, department_id
FROM    employees
--WHERE   department_id = 50
--OR      department_id = 80;
WHERE   department_id IN (50,80);

[예제 6-5] 부서(위치코드, location_id)가 영국(UK)인 부서코드, 위치코드, 부서명 정보를 조회한다.

SELECT  department_id, location_id, department_name
FROM    departments
WHERE   location_id IN (select location_id from locations where country_id = 'UK');

-- 6.2.1 NOT 연산자
-- 6.2.1 ANY(=SOME) 연산자
-- 6.2.1 ALL 연산자
-- 6.2.1 EXISTS 연산자




-- 6.3 다중 컬럼 서브쿼리





-- 연관성의 유무?
-- 6.4 상호연관 서브쿼리

-- 서브쿼리의 작성 위치에 따른 구분 : 보통은 WHERE 절에 작성/사용
-- 6.5 스칼라 서브쿼리 : SELECT 절에 작성/사용
-- 6.6 인라인 뷰 서브쿼리 : FROM 절에 작성/사용
-- ===================================================

