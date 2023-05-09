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
-- 3.4 변환함수
-- 3.5 일반함수

-- 고급함수 : 데이터 사이언티스트(DS), 데이터 분석가(DA)들이 사용하는 함수
