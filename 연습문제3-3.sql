[연습문제3-3]

1. 사원 테이블에서 30번 부서원의 사번, 성명, 급여, 근무 개월 수를 조회하는 쿼리문을 작성한다.
(단, 근무 개월 수는 오늘 날짜를 기준으로 날짜 함수를 사용하여 계산한다)
-- 날짜 함수
-- 1. 개월 수 n 더한 날짜 반환 : ADD_MONTHS(date, n)
-- 2. 두 날짜 사이의 개월 수를 계산, 반환 : MONTHS_BETWEEN(date1, date2) / date1 : 이후 날짜
SELECT  employee_id, first_name, salary, 
        ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "근무 개월 수",
        TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "근무 개월 수"
FROM    employees           -- 1. 테이블을 먼저 찾는다.
WHERE   department_id = 30; -- 2. 필터링


2. 급여가 12000 달러 이상인 사원의 사번, 성명, 급여를 조회하여 급여 순으로 결과를 정렬한다.
(단, 급여는 천단위 구분 기호를 사용하여 표시하도록 한다)
-- p.31 TO_CHAR(number, [,fmt])
-- , : 천 단위 표기
-- 9 : 숫자 하나 표기
-- $ : 달러 표기
-- L : 지역 통화기호 표기(WON, YEN, ...)
SELECT  employee_id, first_name||' '||last_name name, TRIM(TO_CHAR(salary, '999,999,999')) AS salary
FROM    employees
WHERE   salary >= 12000
ORDER BY 3 ASC;

3. 2005년 이전에 입사한 사원들의 사번, 성명, 입사일, 업무 시작 요일을 조회하는 쿼리문을 작성한다.
-- TO_CHAR(date, YYYY) : 년도 4자릿수를 문자로 변환하여 반환하는 함수
-- 2004년 12월 31일까지
-- 2005년 1월 1일 미만
-- NEXT_DAY(date, '요일형식') : 돌아오는 요일 반환하는 함수
-- LAST_DAY(date) : date의 달의 마지막 일자를 반환하는 함수
SELECT  employee_id, first_name||' '||last_name name, hire_date, 
        TO_CHAR(hire_date, 'DAY') AS "업무 시작 요일1",
        TO_CHAR(hire_date, 'DY') AS "업무 시작 요일2"
FROM    employees
--WHERE hire_date < '2005-12-31'; --묵시적 형변환
WHERE   TO_CHAR(hire_date, 'YYYY') < '2005'
ORDER BY 3 DESC;

DESC EMPLOYEES;
-- HIRE_DATE    NOT NULL DATE : DATE(날짜 형식 컬럼)

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';
