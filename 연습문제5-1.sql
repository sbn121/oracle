[연습문제5-1]

1. 이름에 소문자 v가 포함된 모든 사원의 사번, 이름, 부서명을 조회하는 쿼리문을 작성한다.

SELECT  e.employee_id, e.first_name, 
        d.department_name 
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+) -- 오라클 아우터 조인
AND     e.first_name LIKE '%v%';


2. 커미션을 받는 사원의 사번, 이름, 급여, 커미션 금액, 부서명을 조회하는 쿼리문을 작성한다.
(단, 커미션 금액은 월급여에 대한 커미션 금액을 나타낸다)
-- commission_pct : NULL (판매부서가 아닌 사원들)
-- NULL 처리 : 비교대상x ==> NVL(), NVL2()
-- 커미션 금액 : salary * commission_pct
-- 커미션 받는 사원 : 35명(1명이 부서가 없지만)
SELECT  e.employee_id, e.first_name, TO_CHAR(e.salary, '999,999'), TO_CHAR(e.salary * e.commission_pct, 'L999,999') AS comm_pct,
        d.department_name
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+)
AND     e.commission_pct IS NOT NULL
ORDER BY 3;


3. 각 부서의 부서코드, 부서명, 위치코드, 도시명, 국가코드, 국가명을 조회하는 쿼리문을 작성한다.
-- 기준 테이블 : 부서정보 테이블(부서코드, 부서명, 위치코드)
-- 대상테이블 : 위치

SELECT  d.department_id, d.department_name, d.location_id,
        l.city, l.country_id, 
        c.country_id, c.country_name
FROM    departments d, locations l, countries c
WHERE   d.location_id = l.location_id
AND     l.country_id = c.country_id
ORDER BY 1;

4. 사원의 사번, 이름, 업무코드, 매니저의 사번, 매니저의 이름, 매니저의 업무코드를 조회하여
사원의 사번 순서로 정렬하는 쿼리문을 작성한다.
-- 순환참조(SELF JOIN)
SELECT  e.employee_id, e.first_name, e.job_id,
        m.employee_id AS manager_id, m.first_name AS manager_name, m.job_id AS job_id
FROM    employees e, employees m
WHERE   e.employee_id = m.employee_id;


5. 모든 사원의 사번, 이름, 부서명, 도시명, 도로주소 정보를 조회하여 사번 순으로 정렬하는
쿼리문을 작성한다.

SELECT  e.employee_id, e.first_name, 
        d.department_name, 
        l.city, l.street_address
FROM    employees e, departments d, locations l
WHERE   e.department_id = d.department_id(+)
AND     d.location_id = l.location_id(+)
ORDER BY 1;

-- 오라클 JOIN 연산
-- 1) 카테시안 곱(Cartesign Product) : 조인 조건절을 생략했을 때~ 잘못된 결과(너무 많은 결과행)
-- 2) EQUI-JOIN (동등조인, =) <---> INNER JOIN(=내부 조인)
-- 3) NON-EQUI JOIN (비교연산자, BETWEEN, IN) <---> EQUI-JOIN (사용할 일이 거의 없다)
-- 4) OUTER JOIN(=외부 조인) <---> INNER JOIN과 반대되는 개념
-- 5) SELF JOIN : 하나의 테이블에 공통된 컬럼을 이용한 자기순환 참조 JOIN


        