-- 3장. 기본함수
-- 내장함수 + 사용자 정의 함수 ==> PL/SQL (SQL을 이용한 프로그래밍 문법)
-- 함수 : 대게는 Return값이 있다.
-- 프로시저 : Return값이 없는 함수 형태
-- 프로그래밍 언어에서 사용하는 함수와 비슷하다
-- 자주 사용하는 기능을 함수로 정의하여 만들어둔 뒤, 필요할 때마다 호출한다.
-- 예) 전체 사원의 급여 평균을 조회 ==> AVG()
-- 예) sal_avg() : 사용자 정의 함수 만들 수 있는데..수학/삼각/재무/통계함수는 대게 제공함.
-- 기본적으로 사용자 정의 함수는 기본함수에 없는 특별한 처리와 결과 값 반환을 위해 만듦.(PL/SQL)

-- 기본함수 : 행 당 하나의 결과를 반환하는 "단일 행" 함수
-- 함수에서 사용하는 파라미터, 값의 유형에 따라 함수를 구분한다.
-- 함수의 종류 : 숫자/문자/날짜/변환/일반 함수

-- ※ 모든 함수를 교재에서 다룬 것은 아님!!
-- 3.1 숫자함수
-- 3.1.1 ABS() : 절대값으로 반환하는 함수
-- dual : 가짜 테이블
SELECT  ABS(32), ABS(-32)
FROM    dual;


-- 3.1.2 SIGN() : 부호(음수, 양수, 0)
SELECT  SIGN(32), SIGN(-32), SIGN(0)
FROM    dual;

-- 3.1.3 ROUND(n [,i]) : 반올림 함수 ..n을 소수점 i번째 자리로 반올림한 결과를 반환하는 함수
[예제 3-3]
SELECT ROUND(123.45678) avg1,
        ROUND(123.45678, 1) avg2,
        ROUND(123.45678, 0) avg3,
        ROUND(123.45678, -1) avg4
FROM    dual;

-- i가 음수는 경우, 정수부 i번째 자리에서 반올림
-- [,i] : 옵션(=생략), 생략시 기본값 0으로..
--3.1.3 TRUNC(n [,i]) : 버림 함수 .. 기본적으로 ROUND와 같다.
[예제 3-5]
SELECT  TRUNC(123.456787) T1,
        TRUNC(123.456787, 0) T2,
        TRUNC(123.456787, 2) T3,
        TRUNC(123.456787, -2) T4 -- 정수부 i번째 자리에서 버림
FROM    dual;


-- 3.1.4 CEIL(n) : n과 같거나 큰 가장 작은 정수 (단어 뜻 : 천정, 올림?)
[예제 3-6]
SELECT  CEIL(0.12345) CEIL1,
        CEIL(123.45) CEIL2
FROM    DUAL;

-- 3.1.5 FLOOR(n) : n과 같거나 작은 가장 큰 정수 (단어 뜻 : 바닥, 내림)
[예제 3-7]
SELECT  FLOOR(0.12345) FLOOR1,
        FLOOR(123.45) FLOOR2
FROM    DUAL;

-- 3.1.6 MOD(m, n) : m을 n으로 나눈 나머지 값을 반환하는 함수
-- % : LIKE 연산자와 함께 '여러 문자열' 찾는 패턴의 기호로 사용됨.

[예제 3-8]
SELECT  MOD(17, 4) MOD1,
        MOD(17, -4) MOD2,
        MOD(-17, -4) MOD3,
        MOD(17, 0) MOD4
FROM    DUAL;

-- 0으로 나누는 쿼리 ==> Zero Divide 에러 발생가능!

[연습문제 3-1]
                                                                    (급여*1.15)
1. 사원 테이블에서 100번 부서와 110번 부서의 사원에 대해 사번, 이름, 급여와 15% 인상된 급여를 조회하는 쿼리문을 작성한다.
    단, 15% 인산된 급여는 정수로 표시하고 컬럼명은 Increased Salary라고 표시한다.

SELECT  employee_id, first_name, salary, 
        ROUND(salary*1.15, 0) AS "Increased Salary ROUND", 
--        TRUNC(salary*1.15, 0) AS "Increased Salary TRUNC", 
--        CEIL(salary*1.15) AS "Increased Salary CEIL", 
--        FLOOR(salary*1.15) AS "Increased Salary FLOOR", 
        department_id
FROM    employees
--WHERE   부서코드 = 100
--OR      부서코드 = 110
WHERE   department_id IN (100, 110);


-- 100번, 110번 부서 : Finance, Accounting
SELECT  *
FROM    departments
WHERE   department_id = 110;


-- 3.2 문자함수
-- 3.2.1 CONCAT(char1, char2) : 두 문자열 char1, char2를 연결하여 반환하는 함수
-- || : 문자열 연결 연산자 (간결)

[예제 3-9]
SELECT  CONCAT('Hello', 'Oracle') CONCAT1,
        'Hello'||'Oracle' CONCAT2
FROM    DUAL;

-- 3.2.2 INITCAP(char) : 알파벳 단어 단위로 첫 글자를 대문자화하여 반환하는 함수
-- 3.2.3 UPPER(char) : 알파벳을 모두 대문자화하여 반환하는 함수
-- 3.2.4 LOWER(char) : 알파벳을 모두 소문자화하여 반환하는 함수

[예제 3-10]
SELECT  INITCAP('i am a boy') CAP1,
        UPPER('i am a boy') CAP2,
        LOWER('I AM A BOY') CAP3,
        LOWER('대한민국') CAP4
FROM    DUAL;

-- 3.2.5 LPAD(char1, n [,char2])
-- 3.2.6 RPAD(char1, n [,char2])
-- * n : 전체 문자열 길이, (n 생략시, 기본값으로 공백문자 1개가 지정된다.)
-- ※ LPAD는 왼쪽에 공백(=생략, 기본값)/문자열 채우고, RPAD는 오른쪽에 공백/문자열(char2)을 채워 반환한다.
-- ※ 업무상 추가보다는 제거할 일이 훨씬 많다.

[예제 3-11]
SELECT  LPAD('abc', 7) AS LPAD1,
        LPAD('abc', 7, '*') AS LPAD2,
        RPAD('abc', 5)|| ']' AS RPAD2,
        RPAD('abc', 7, '#') AS RPAD2
FROM    DUAL;

-- p.23
-- 3.2.7 LTRIM(char1 [,char2]) : 문자열 char1에서 char2로 지정한 문자를 제거한 결과를 반환한다.
-- 3.2.8 RTRIM(char1 [,char2]) : 문자열 char1에서 char2로 지정한 문자를 제거한 결과를 반환한다.
-- ※ 제거하고자 하는 문자열 생략 : 디폴트로 공백문자 한 개가 사용된다.
-- 왼쪽에서 오른쪽으로 스캔하면서 일치하지 않는 문자가 나오기 전까지 제거
[예제 3-12]
SELECT  '['||LTRIM('  ABCDEFG   ')||']' LTRIM1,
        LTRIM('ABCDEFG', 'AB') LTRIM2,
        LTRIM('ABCDEFG', 'BA') LTRIM3,
        LTRIM('ABCDEFG', 'BC') LTRIM4 -- B, C가 아닌 A로
FROM    DUAL;

[예제 3-13]
--
SELECT  '['||RTRIM('  ABCDEFG   ')||']' RTRIM1,
        RTRIM('ABCDEFG', 'FG') RTRIM2,
        RTRIM('ABCDEFG', 'GF') RTRIM3,
        RTRIM('ABCDEFG', 'BC') RTRIM4 -- B, C가 아닌 A로
FROM    DUAL;

-- 3.2.9 TRIM([LEADING, TRAILING, BOTH] [trim_char] [FROM] char) : 문자열 char의 왼쪽(LEADING)이나
-- 오른쪽(TRAILING) 또는 양쪽(BOTH)에서 지정된(=제거할) trim_char 문자를 제거한 결과를 반환하는 함수
-- 방향 : LEADING(=left), TRAILING(=right), BOTH(=left and right) (기본값은 생략시 BOTH 기본값 = 양쪽제거)

[예제 3-14]
SELECT  '['||TRIM('    ABCDEFG    ')||']' TRIM1,        --공백제거
        '['||TRIM(LEADING 'A' FROM 'ABCDEFG')||']' TRIM2,
        '['||TRIM(TRAILING 'G' FROM 'ABCDEFG')||']' TRIM3,
        '['||TRIM(BOTH '1' FROM '1ABCDEFG1')||']' TRIM4,
        '['||TRIM('1' FROM 'ABCDEFG')||']' TRIM5,
        '['||TRIM(TRAILING 'C' FROM 'ABCDEFG')||']' TRIM6
FROM    DUAL;

-- 3.3.0 SUBSTR(char, position [,length]) : 문자열의 일부를 추출/분리해서 반환하는 함수 
-- chr : 지정된 문자열
-- position : 지정된 위치, 값을 0으로 명시할 경우 1로 적용(=문자열의 첫 번째 자리)
-- length : 길이, 갯수 --> length 생략시 문자열의 끝까지

-- JOB_ID
-- SA_MAN
-- SA_REP
-- 0505.040.
-- EMAIL ID : manager@hr.com

[예제 3-15]
SELECT  SUBSTR('You are not alone', 9, 3) SUBSTR1, -- 9번째 위치부터 3자를 분리해서 반환
        SUBSTR('You are not alone', 5) SUBSTR2, -- (length 생략시) 5번째 위치에서 끝까지 분리해서 반환
        SUBSTR('You are not alone', 0, 3) SUBSTR3, -- position을 0으로 명시하면 1로 기본값
        SUBSTR('You are not alone', -9, 3) SUBSTR4, -- position 음수면, 문자열 뒤에서부터..
        SUBSTR('You are not alone', -5) SUBSTR5 -- position이 음수이고 length생략시 뒤에서 끝까지
FROM    DUAL;

-- =================================================================
-- position 값이 음수일 경우 그 위치가, 오른쪽부터 시작된다
-- =================================================================

SELECT  SUBSTR('admin@hanuledu.co.kr', 1, 5) EMAIL_ID,
        SUBSTR('admin@hanuledu.co.kr', 7) EMAIL_DOMAIN,
        SUBSTR('062-362-7797', 1, 3) LOCAL_NUMBER,
        SUBSTR('062-362-7797', 5) REMAINDER_NUMBER
FROM    DUAL;

SELECT  INSTR('admin@hanuledu.co.kr', '@') at_pos   
FROM    DUAL;

SELECT  'admin@hanuledu.co.kr' origin_email,
        SUBSTR('admin@hanuledu.co.kr', 1, INSTR('admin@hanuledu.co.kr', '@')-1) email_id,
        SUBSTR('admin@hanuledu.co.kr', INSTR('admin@hanuledu.co.kr', '@')+1) email_domain
FROM    DUAL;


-- 3.3.1 REPLACE(char, search_str [,replace_str]) : 문자열중 일부를 다른 문자열로 변경하여 반환하는 함수(=치환)
-- char : 문자열
-- search_string : 찾을 문자열
-- replace_string : 변경할 문자열. 생략할 경우, NULL이 오면 search_string 문자열을 제외한 결과를 반환한다.

[예제 3-17]
SELECT  REPLACE('You are not alone', 'You', 'We') REP1,
        REPLACE('You are not alone', 'not ') REP2, -- replace_str생략, search_str 제외한 char 반환
        REPLACE('You are not alone', 'not ', null) REP3
FROM    DUAL;

-- 3.3.2 TRANSLATE(char, from_string, to_stirng) : from_string에서 해당하는 문자를 찾아 to_string 해당하는 문자로 1:1 변환한다.
-- 1대 1로 문자 변환 : 
[예제 3-18]
SELECT  TRANSLATE('u! You are not alone', 'You', 'We') TRANS1,
        REPLACE('u! You are not alone', 'You', 'We') REPLACE2
FROM    DUAL;


-- ==================================================================
-- 너는 나를 모르는데 나는 너를 알겠느냐,  이 문자열을 REPLACE() 와 TRANSLATE()로 아래와 같이 변경하세요
SELECT  REPLACE('너는 나를 모르는데 나는 너를 알겠느냐', '너', '나') REPLACE1,
        TRANSLATE('너는 나를 모르는데 나는 너를 알겠느냐', '너나', '나너') TRANSLATE2
FROM    DUAL;


-- 3.3.3 INSTR(char, search_string [,position] [,th]) : 문자열에서 특정 문자열의 시작 위치를 반환하는 함수
-- char : 문자열
-- search_string : 찾을 문자
-- position : 문자를 찾는 시작 위치, 생략시 기본값 1이다.
-- _th : 몇 번째 문자열인지, 생략시 기본값 1
-- ※ 문자열의 position위치에서부터 특정 문자를 찾기 시작해 _th번째에 해당하는 시작 위치를 반환하는 함수
-- 찾을 문자열이 발견되지 않으면 0을 반환
-- 찾을 문자열이 발견되면 해당 위치값을 반환

[예제 3-19]
SELECT  INSTR('Every Sha-la-la-la', 'la') INSTR1, -- 1의 위치, 첫번째 la의 시작하는 위치 반환
        INSTR('Every Sha-la-la-la', 'la', 7) INSTR2, -- 7번째 위치에서 찾기 시작해서 첫번째 la의 위치
        INSTR('Every Sha-la-la-la', 'la', 1, 2) INSTR3, -- 두번째 la의 위치
        INSTR('Every Sha-la-la-la', 'la', 12, 2) INSTR4, -- 12번째 위치에서 찾기 시작, 두번째 la의 위치
        INSTR('Every Sha-la-la-la', 'la', 15, 2) INSTR5 -- 15번째 위치에서 찾기 시작, 두번째 la의 위치
FROM    DUAL;


-- 3.3.4 LENGTH(char) : 문자열의 길이를 반환한다.
-- 3.3.5 LENGTHB(char) : 문자열의 바이트값을 반환한다.
[예제 3-20]
SELECT  LENGTH('Every Sha-la-la-la') LEN1,
        LENGTH('무궁화 꽃이 피었습니다.') LEN2,
        LENGTHB('Every Sha-la-la-la')||' Bytes' LEN3,
        LENGTHB('무궁화 꽃이 피었습니다')||' Bytes' LEN4 -- 한글은 3Bytes, NLS 설정 ==> 오라클 설치시 자동 적용!
FROM    DUAL;



-- 3.3 날짜함수
-- 날짜와 더불어 시간을 연산 대상으로 한다.

-- 3.3.1 SYSDATE()
-- 시스템의 현재 날짜를 가져와 반환하는 함수
-- 이 날짜는 시각을 포함하고 있다.
-- SYSDATE함수는 다른 함수와 다르게 파라미터가 없다. ()를 사용하지 않는다.
-- SYSDATE() : 엄청 자주, 일반적으로 쓰는 함수 --> SYSDATE로 표기

SELECT  SYSDATE
FROM    DUAL; --23/05/09 <==> 시스템 날짜 형식 : RR/MM/DD
-- YY vs RR 표기법 : 50 이상이면 1900년대, 50 미만이면 2000년대 표기
-- 99/05/09 ==> 1999/05/09
-- 03/05/09 ==> 2003/05/09

-- 날짜 형식(Format) 을 확인하는 SQL
SELECT  *
FROM    v$nls_parameters; -- : 공용뷰(누구나 쓸 수) vs 권한마다 다름..
-- NLS_DATE_FORMAT : RR/MM/DD --> YY/MM/DD, YYYY/MM/DD, YY/MM/DD HH:MI:SS ... [날짜/시간 형식 지정]

-- 일시적으로 날짜 포맷을 기존 : 날짜 --> 변경 : 날짜+시간 형식으로 변경
-- 영구적인 설정 X, 현재 로그인된 HR 세션에서만 유효!
-- 도구 > 환경설정 > 데이터베이스 > NLS : 날짜 포맷
ALTER SESSION SET nls_date_format = 'RR/MM/DD HH24:MI:SS';  -- 24시간제 표시, HH 12시간제
ALTER SESSION SET nls_date_format = 'RR/MM/DD'; -- 원래 기본 설정

SELECT  SYSDATE, SYSTIMESTAMP
FROM    DUAL;

-- =======================================================================
-- 설정을 매번 바꾸어서 날짜, 시간을 출력하는 것은 불편하므로,
-- 변환 함수를 사용하여, 그때그때 원하는 형식으로 출력하는 편이 낫다
-- =======================================================================
SELECT SYSDATE, -- 설정에 의해서 날짜+시간 출력
        TO_DATE('2023-05-09 17:32:20', 'RR/MM/DD HH24:MI:SS') SYSDATE_TIME  --변환함수로 문자 --> 날짜
FROM    DUAL;


                          
-- 테이블 / table (객체) : 데이터를 저장
-- 뷰 / view(객체) : 테이블의 일부만 추출해서 마치 테이블처럼 사용(조회 | 저장...)
-- HR 계정, EMP_DETAILS_VIEW (사원_세부정보 담은 뷰)
SELECT  *
FROM    EMP_DETAILS_VIEW; -- 뷰를 조회! (임시 뷰 - 메모리에서 존재)

-- 3.3.1 ADD_MONTHS(date, n) : date에 개월 수 n을 더해서 그 결과(날짜)를 반환하는 함수
-- n : integer
[예제 3-21] 
SELECT  ADD_MONTHS(SYSDATE, 1) MONTH1,
        ADD_MONTHS(SYSDATE, 2) MONTH2,
        ADD_MONTHS(SYSDATE, -3) MONTH3 -- 3개월전
FROM    DUAL;

-- 3.3.2 MONTHS_BETWEEN(date1, date2) : 두 날짜 사이의 개월 수를 구하여 반환하는 함수
-- date1 : 이후 날짜
-- date2 : 이전 날짜
-- ※ date1 - date2 형식으로 계산


[예제 3-22]
-- ROUND(n, 0)
-- TRUNC(n, 0)
-- CEIL(n)
-- FLOOR(n)
-- ABS(n)
SELECT  ROUND(MONTHS_BETWEEN('2013-03-20', SYSDATE)) AS REMAINED, 
        ABS(TRUNC(MONTHS_BETWEEN(SYSDATE, '2013-08-28'))) AS PASS
FROM    DUAL;

-- 3.3.3 LAST_DAY(date) : date에 해당하는 달의 마지막 날짜를 반환한다.
-- 3월이면 31 반환, 4월이면 30 반환
-- 오늘 날짜 5월은 31일!
-- 매월 말 보고서를 자동으로 생성하거나, 관련 데이터(비용 지출 내역?) 등을 월말 보고로 자동생성하는
-- 서비스를 생성하거나 하는 기능에서 필요할 수 있는 함수
SELECT  LAST_DAY(SYSDATE) LAST1,
        LAST_DAY('2013-03-20') AS LAST2
FROM    DUAL;


SELECT  employee_id, first_name, hire_date
FROM    employees;

-- 3.3.4 NEXT_DAY(date, char) : date 이후 날짜중에 char로 명시된 첫 번째 일자를 반환하는 함수
--                              돌아오는 요일(char)의 날짜를 반환하는 함수
-- NLS : 언어 설정이 KOREAN(요일 : SUNDAY, MONDAY... <---> 일요일, 월요일...)

[예제 3-24]
--ORA-01846: 지정한 요일이 부적합합니다.
--01846. 00000 -  "not a valid day of the week"
SELECT  NEXT_DAY(SYSDATE, '월요일') NEXT1,
        NEXT_DAY(SYSDATE, '금요일') NEXT2,
        NEXT_DAY(SYSDATE, '일') NEXT3,
        NEXT_DAY(SYSDATE, '화') NEXT4,
        NEXT_DAY(SYSDATE, 4) NEXT5
FROM    DUAL;

--NLS 설정 : 한국에서 오라클 설치 ==> 자동으로 KOREAN, 요일명도 한글로!

SELECT  *
FROM    v$nls_parameters; -- NLS_LANGUAGE : KOREAN, 요일명도 한글로!

-- 도구 > 환경설정 > 데이터베이스 > NLS - 날짜언어 : KOREAN


-- 3.3.5 반올림함수, 버림함수
-- ※ 숫자, 날짜에도 적용 가능한 함수, 하지만! 평소에는 숫자에..어떤 특정 업무? 특수한 직무에서 사용할 수 있음.
-- 특수한 직무에서 사용할 수 있음. (함수의 특징으로만 구분)
-- ROUND(n [,i]), ROUND(date, fmt) : fmt - 출력 형식
-- TRUNC(n [,i]), TRUNC(date, fmt)

[예제 3-25]
-- 자동형변환 (=묵시적 형변환)
SELECT  10+'5'
FROM    DUAL; -- '10'를 10으로 알아서 변환해서 연산한 결과 15를 변환

SELECT  10+'ABCD'
FROM    DUAL; -- ORA-01722: 수치가 부적합합니다 ==> 숫자라고 판단할 수 있는 문자데이터는 형변환
-- ※

-- 형변환 : 강제로, NUMBER --> DATE 바로 변환 x
--        TO_NUMBER()       TO_CHAR()
-- NUMBER <---------- CHAR <-------- DATE
--        ---------->      -------->
--          TO_CHAR()       TO_DATE()

-- TO_DATE() : 문자를 날짜 형식으로 변환하는 함수
-- TO_DATE() : 문자로 바꾸는 함수
-- TO_NUMBER() : 숫자로 바꾸는 함수
-- YYYY or RRRR : 년도를 4자리로 표현
[예제 3-25]
SELECT  ROUND(TO_DATE('2013-06-30'), 'YYYY') AS R1,
        ROUND(TO_DATE('2013-07-01'), 'YEAR') AS R2,
        ROUND(TO_DATE('2013-12-16'), 'MONTH') AS R3,
        ROUND(TO_DATE('2013-12-16'), 'MM') AS R4,
        ROUND(TO_DATE('2013-05-27 11:59:59', 'YYYY-MM-DD HH24:MI:SS'), 'DD') AS R5,
        ROUND(TO_DATE('2013-05-27 12:00:00', 'YYYY-MM-DD HH:MI:SS'), 'DD') AS R6,
        ROUND(TO_DATE('2013_05_29'), 'DAY') AS R7,
        ROUND(TO_DATE('2013_05-30'), 'DAY') AS R8
FROM    DUAL;

[예제 3-26]
SELECT  TRUNC(TO_DATE('2013-06-30'), 'YYYY') AS T1,
        TRUNC(TO_DATE('2013-07-01'), 'YEAR') AS T2,
        TRUNC(TO_DATE('2013-12-16'), 'MONTH') AS T3,
        TRUNC(TO_DATE('2013-12-16'), 'MM') AS T4,
        TRUNC(TO_DATE('2013-05-27 11:59:59', 'YYYY-MM-DD HH24:MI:SS'), 'DD') AS T5,
        TRUNC(TO_DATE('2013-05-27 12:00:00', 'YYYY-MM-DD HH:MI:SS'), 'DD') AS T6,
        TRUNC(TO_DATE('2013_05_29'), 'DAY') AS T7,
        TRUNC(TO_DATE('2013_05-30'), 'DAY') AS T8
FROM    DUAL;

-- 3.4 변환함수 (p.30)
-- 오라클은 묵시적인 형변환 ==> 숫자+'숫자' (ok), 숫자+'문자' (nol)
-- 명시적인 형변환 함수들 3가지!! (기본 사용법, 형식)
-- 형변환 : NUMBER --> DATE 바로 변환 x

--        TO_NUMBER()       TO_CHAR()
--       <----------       <-------- 
-- NUMBER             CHAR            DATE
--  3rd                1st            2nd
--        ---------->      -------->
--          TO_CHAR()       TO_DATE()

-- 3.4.1 TO_CHAR(date [,fmt])
-- fmt : 년, 월, 일, 시, 분, 초 형식
-- ※ 밀리세컨드 ==> 출퇴근 기록부(?) + SYSTIMESTAMP or ??
SELECT  SYSDATE 현재시간날짜, SYSTIMESTAMP 현재시간날짜밀리세컨즈_GMT표준시
FROM    DUAL;

-- ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD HH:MI:SS'; -- 이것보다는 가급적이면 변환함수!!

[예제 3-27]
SELECT  TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS DATE_FMT1,
        TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS DATE_FMT2,
        TO_CHAR(SYSDATE, 'YYYY/MONTH/DD') AS DATE_FMT3,
        TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MI:SS') AS DATE_FMT4,
        TO_CHAR(SYSDATE, 'YYYY/MM/DD DAY') AS DATE_FMT5
FROM    DUAL;


-- 3.4.2 TO_DATE()
-- 문자를 날짜로 변환한 결과를 반환하는 함수
-- TO_CHAR와 같은 fmt (날짜 포맷 모델)을 사용한다.
-- 문자, 날짜는 '(single quote)'로 표시
[예제 3-30]
SELECT  TO_DATE('2013-05-27') DATE1,
        TO_DATE('2013-06-27 11:12:35', 'YYYY/MM/DD HH:MI:SS AM') DATE2,
        TO_DATE('2013-06-27 11:12:35', 'YYYY/MM/DD HH:MI:SS PM') DATE3
FROM    DUAL; -- 단순한 연산, 함수의 결과값 확인할 때 쓰는 테이블(SYS/SYSTEM 계정)

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD HH:MI:SS'; -- AM(오전), PM(오후)

SELECT  employee_id, first_name, salary, department_id
FROM    employees; -- 숫자: 오른쪽, 문자 : 왼쪽 정렬
-- 100	Steven	24000	90
-- 101	Neena	17000	90

-- 3.4.3 TO_NUMBER()
-- 문자를 숫자로 변환하여 반환하는 함수

[예제 3-29]
SELECT  TO_NUMBER('12345')+1000 "문자를 숫자로1",
        TO_NUMBER('123.45') "문자를 숫자로2"
FROM    DUAL;

-- 3.5 NULL 관련함수(p.32)
-- ※ NULL 자체는 빈값, 비교 연산 등을 할 수 없음 ==> 올바른 데이터 조회가 되지 않기에..
-- IS NULL, IS NOT NULL로만 NULL 데이터를 조회 vs department_id = ' '(x)

-- 3.5.1 NVL(exp1, exp2) : exp1이 NULL이면 exp2 반환, exp1 NULL 아니면 exp1 반환하는 함수
-- NVL의 파라미터인 exp1, exp2는 데이터 유형이 서로 같아야 한다.
-- 커미션 금액이 1000(달러) 미만인 사람에게만, 보너스 지급!!
-- 커미션 금액 = 급여(salary) * commission_pct

[예제 3-31]
-- 총 107명
-- 커미션율 NULL 아닌, 35명
-- 커미션금액 1000달러 미만 : 6명
SELECT  employee_id, first_name, salary, commission_pct, salary * commission_pct AS comm -- 거래 수수료 
FROM    employees
WHERE   salary * commission_pct < 1000; --1000달러 미만인자
-- 판매부서가 대다수, 부서가 배정되지 않은 사람 1명 (kimberely)
-- 1000달러 미만의 커미션을 받는 사람이 6명 밖에 없지는 않을 것 같은데
-- 커미션 요율이 없는 일반 사원은 ==> 커미션 금액이 NULL 아닌, 0으로 처리하도록!

[예제 3-32]
SELECT  employee_id, first_name, salary, commission_pct, salary * NVL(commission_pct, 0) AS comm -- 거래 수수료 
FROM    employees
WHERE   salary * NVL(commission_pct, 0) < 1000; --1000달러 미만인자 ~ 0원 : 78 rows


-- 3.5.2 NVL2(exp1, exp2, exp3) : exp1이 NULL이면 exp3 반환, exp1이 NULL 아니면 exp2를 반환하는 함수
-- salary와 커미션 금액 합한 금액이 '총 급여(TOTAL_SALARY)'
-- 커미션을 받지 않으면,  salary가 '총 급여'
SELECT  employee_id, first_name, salary, commission_pct, 
        NVL2(commission_pct, salary+salary*commission_pct, salary) AS "TOTAL SALARY"
FROM    employees;




-- ※ 이름이 같고, 파라미터 객수가 조금 다름 ==> 쓰임새를 놓고 보면 NVL2가 활용도가 높다.

-- NULL이 왜 있을까? ==> 당연히 NULL이 없어야 하나, 입력하는 과정(=데이터 입력하는 사람)
-- 데이터 처리 --> 이상치(abnormal), NULL 처리 ==> 데이터 전처리

-- 3.5.3 COALESCE(exp1, exp2, exp3, ...) : 파라미터 목록에서 첫 번째로 NULL이 아닌 exp를 반환하는 함수
-- 파라미터 목록에 NULL아닌 값이 하나는 존재해야함 ==> 모두 NULL이면 NULL반환!!
--  전화번호    집    사무실    연락처     phone
--  362.7797   NULL    NULL      NULL      NULL
--    NULL     NULL    NULL      NULL      010-1234-5678    

[예제 3-35]
SELECT  COALESCE('A', 'B', 'C', NULL) first,
        COALESCE(NULL, 'B', 'C', 'D') second,
        COALESCE(NULL, NULL, 'C', NULL) third
FROM    DUAL;

------------------------------------------------------------
------------- 집전화1 집전화2 사무실전화 휴대폰 ------------
------------------------------------------------------------
SELECT  COALESCE('362-7797', NULL, NULL, NULL) first,
        COALESCE(NULL, '010-1234-5678', NULL, NULL) second,
        COALESCE(NULL, NULL, '362-7797', NULL) third
FROM    DUAL;


-- 3.6 DECODE와 CASE
-- 보통 조건에 따른 처리, IF~ELSE / SWITCH(case) ..
-- 오라클에서는 조건에 따른 처리 ==> 함수 DECODE
-- 오라클PL/SQL에서는 IF~ELSE 있음.

-- 3.6.1 DECODE(exp, search1, result1, search2, result2, ... [,default]) : IF~ELSE처럼 exp를 검사
-- search와 일치하면 result1 반환, search2와 일치하면 result2 반환, ... [일치하는게 없으면, 기본반환]
-- 등가비교(=동등비교)

[예제 3-36] 보너스 지급에 있어, 20번 부서는 20%   (salary의 20%)
                                30번 부서는 30%,  (salary의 30%)
                                40번 부서는 40%,  (salary의 40%)
                                그 외 부서는 0(=지급하지 않는다)    전체사원 대상으로 조회한다.
                                
SELECT  employee_id, last_name, department_id, salary, 
        DECODE(department_id, 20, salary * 0.2 
                            , 30, salary * 0.3 
                            , 40, salary * 0.4
                            , 0) AS bonus
FROM    employees;



-- 3.6.2 CASE : 함수라기보다 더 큰 개념을 가진 표현식이다.
-- 동등비교, 더 다양한 비교 연산을 할 수 있다. ex>범위비교 (크다, 작다...)
-- 3.6.2.1 CASE I (동등비교) <---> DECODE와 같은 역할 : 바꿔서 쓸 수도?
/*
CASE exp WHEN search1 THEN result1
         WHEN serach2 THEN result2
         ...계속...
         [ELSE default]
END
*/
[예제 3-37] 보너스 지급에 있어, 20번 부서는 20%   (salary의 20%)
                                30번 부서는 30%,  (salary의 30%)
                                40번 부서는 40%,  (salary의 40%)
                                그 외 부서는 0(=지급하지 않는다)    전체사원 대상으로 조회한다.
                                
SELECT  employee_id, last_name, department_id, salary, 
        CASE department_id WHEN 20 THEN salary*0.2
                           WHEN 30 THEN salary*0.3
                           WHEN 40 THEN salary*0.4
                           ELSE 0
        END AS bonus
FROM    employees;



-- 3.6.2.2 CASE II (다양한 비교) <---> DECODE는 할 수 없는..범위에 따른 비교
/*
CASE WHEN condition1 THEN result1
     WHEN condition2 THEN result2
     ...계속...
     [ELSE default]
END
*/

보너스 지급에 있어서 30번 미만 부서는 급여의 10%를 보너스로 지금,
                     30번부터 50번 부서까지는 급여의 20%를 보너스로 지급,
                     60번부터 80번 부서까지는 급여의 30%를 지급하고, 
                     그 외의 부서는 40%를 지급한다고 할 때,
CASE 표현식을 이용해, 전 사원의 정보와 보너스 금액의 조회하시오.

SELECT  employee_id, last_name, department_id, salary, 
        CASE WHEN department_id <30 THEN salary*0.1
             WHEN department_id BETWEEN 30 AND 50 THEN salary*0.2
             WHEN department_id BETWEEN 60 AND 80 THEN salary*0.3
             ELSE ROUND(salary*0.4)
        END AS bonus
FROM    employees;








-- 고급함수 : 데이터 사이언티스트(DS), 데이터 분석가(DA)들이 사용하는 함수
