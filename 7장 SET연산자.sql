-- 7장. SET 연산자(p.63)
-- 관계없는 테이블의 데이터를 하나로 조회할때 사용 ==> 자주사용하진 않지만..

-- =======================================================================
-- 5장 JOIN연산. 테이블(의 컬럼)을 가로로 연결하는 연산
-- 7장 SET연산자. 테이블(의 데이터/행)을 세로로 연결하는 연산
-- =======================================================================

-- ※ SET 연산자로 묶이는 두 SELECT 절은 (1) 컬럼의 수  (2)데이터 타입이 일치해야 한다.
-- 조회되는 컬럼명은 첫번째 쿼리문의 컬럼명이 사용된다.
-- ORDER BY 모든 쿼리문의 가장 마지막에 사용한다.



-- 7.1 UNION  : 합집합
-- 집합에서 합집합에 해당하는 연산자, 중복을 제거한 행의 결과를 반환한다.
[예제7-1]
SELECT  1, 3, 4, 5, 7, 8, 'A' AS first -- 조회되는 컬럼명은 첫번째 쿼리문의 컬럼명이 사용된다.
FROM    dual
UNION-- 합집합 : SET 연산자
SELECT  2, 4, 5, 6, 8, null, 'B' AS second
FROM    dual
UNION
SELECT  1, 3, 4, 5, 7, 8, 'A' AS third
FROM    dual;


[예제7-2] 관리되고 있는 부서, 관리되고 있는 도시 정보를 조회한다.
SELECT  department_id AS code, department_name AS name
FROM    departments
UNION
SELECT  location_id, city
FROM    locations
UNION
SELECT  employee_id, first_name
FROM    employees;




-- 7.2 UNION ALL :  합집합
-- UNION (중복제거) vs UNION ALL (중복포함)     /    행의 결과를 반환한다.
[예제7-4]
SELECT  1, 3, 4, 5, 7, 8, 'A' AS first -- 조회되는 컬럼명은 첫번째 쿼리문의 컬럼명이 사용된다.
FROM    dual
UNION ALL-- 합집합 : SET 연산자
SELECT  2, 4, 5, 6, 8, null, 'B' AS second
FROM    dual
UNION ALL
SELECT  1, 3, 4, 5, 7, 8, 'A' AS third
FROM    dual;

-- 7.3 INTERSECT : 교집합
-- 공통된 행의 결과를 반환한다.

SELECT  1, 3, 4, 5, 7, 8, 'A' AS first -- 조회되는 컬럼명은 첫번째 쿼리문의 컬럼명이 사용된다.
FROM    dual
INTERSECT -- 교집합 : SET 연산자
SELECT  1, 3, 4, 5, 7, 8, 'A' AS third
FROM    dual;

SELECT  1, 3, 4, 5, 7, 8, 'A' AS first -- 조회되는 컬럼명은 첫번째 쿼리문의 컬럼명이 사용된다.
FROM    dual
UNION -- 교집합 : SET 연산자
SELECT  1, 3, 4, 5, 7, 8, 'A' AS third
FROM    dual;


[예제7-7] 80번 부서와 50번 부서에 공통으로 있는 사원의 이름을 조회한다.
SELECT  first_name
FROM    employees
WHERE   department_id = 80 -- 34rows / 판매 부서
INTERSECT
SELECT  first_name
FROM    employees
WHERE   department_id = 50; -- 45rows / 배송 부서



SELECT DISTINCT first_name
FROM    employees
WHERE   department_id IN (80, 50);




-- 7.4 MINUS : 차집합
-- 집합에서 차집합에 해당하는 연산자.

[예제7-9] 80번 부서원의 이름에서 50번 부서원의 이름을 제외한다.
-- 순수하게 80번 부서에만 존재하는 부서원의 이름
-- 공통 : Peter, John (INTERSECT 연산 결과)

-- A - B
SELECT  first_name
FROM    employees
WHERE   department_id = 80
MINUS
SELECT  first_name
FROM    employees
WHERE   department_id = 80; -- 39rows





