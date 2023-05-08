-- 2.4 데이터 정렬
-- 많이 사용하지 않는게 좋다 ==> 성능 관련 (데이터베이스 관리자, 옵티마이저(=최적화), 튜너의 역할)
-- 기본적으로 해당 테이블의 식별자(=유일하게/중복되지 않는 데이터를 구분하는 어떤 값)
-- ex> 사람의 경우 주민번호 
SELECT *
FROM    employees
ORDER BY 컬럼명 [ASC|DESC] -- [] : 옵션 , ASC(=기본값)
-- 정렬 : SELECT 구문 이하에서 조회된 결과의 특정 컬럼을 기준으로 값을 오름차순, 내림차순 정렬
-- ASC : Ascending / 오름차순 : 작은값 --> 큰 값  [기본값]
-- DESC : Descending / 내림차순 : 큰값 --> 작은값
-- ORDER BY는 너무 많이 사용하지 않는게 되려 성능 향상에 도움된다.
-- 데이터베이스 내부에서 테이블 작성할때 기본적으로 테이블의 식별자를 기준으로 정렬이 되게 해주는데,
-- 잘못 조회하게 되면 되려 조회속도가 떨어질 수 있음
-- 1) 데이터베이스 내부에서 정렬 [요즘 DB 성능이 워낙 뛰어나니까~ 권장]
-- 2) 애플리케이션(비동기통신 -- JSON 데이터 정렬)
-- ============================================================
-- desc or describe : 테이블의 구조 조회(=테이블의 컬럼 정의, 자료형, 길이값)
-- ============================================================
-- ※ SELECT문의 가장 마지막에 ORDER BY를 작성한다(위치한다) ※

SELECT *
FROM    employees
ORDER BY employee_id ASC
WHERE 조건절;    -- Wrong!!

[예제2-40] 80번 부서의 사원정보에 대해, 이름을 오름차순으로 정렬한다.
-- 오름차순 : 작은값 --> 큰값
SELECT employee_id, first_name, salary, department_id
FROM    employees
WHERE   department_id = 80
--ORDER BY first_name;
ORDER BY first_name ASC;

[예제2-41] 80번 부서의 사원정보에 대해, 이름을 내림차순으로 정렬한다.
-- 내림차순 : 큰값 --> 작은값
SELECT employee_id, first_name, salary, department_id
FROM    employees
WHERE   department_id = 80
ORDER BY first_name DESC;
