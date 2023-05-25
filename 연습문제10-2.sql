-- [연습문제10-2] 
-- HANUL 계정↗↗↗↗↗ 으로 풀이

-- 1. 이메일 정보가 없는 배역들의 모든 정보(=모든 컬럼)를 조회
SELECT *
FROM    characters
WHERE   email IS NULL;


-- 2. 역할이 시스에 해당하는 등장인물을 조회
-- 역할 정보 테이블 : roles
SELECT *
FROM    roles; -- 시스 : 1002 (role_id)

-- 캐릭터 정보 테이블 : characters
SELECT *
FROM    characters -- 시스, 제다이, 반란군 ==> 시스만 필터링!
WHERE   role_id = ( SELECT role_id
                    FROM    roles
                    WHERE   role_name = '시스' );
                    
                    
-- 3. 에피소드 4에 출연한 배우들의 실제 이름을 조회     
-- star_wars : 영화정보(에피소드 아이디, 에피소드명, 개봉연도)
-- characters : 등장인물정보(아이디,이름,마스터id,역할id,이메일)
-- casting : 등장인물과 배우정보(에피소드 id, 캐릭터id, 실제이름)
-- 연습문제10-2CASTING데이터.sql 데이터 활용

INSERT INTO casting
VALUES (4, 1, '마크 해밀');
INSERT INTO casting
VALUES (4, 2, '해리슨 포드');
INSERT INTO casting
VALUES (4, 3, '캐리 피셔');

INSERT INTO casting
VALUES (5, 4, '앨릭 기니스');
INSERT INTO casting
VALUES (5, 5, '데이비드 프로스');
INSERT INTO casting
VALUES (5, 6, '제임스 얼 존스');

INSERT INTO casting
VALUES (6, 7, '앤서니 대니얼스');
INSERT INTO casting
VALUES (6, 8, '케니 베이커');
INSERT INTO casting
VALUES (6, 9, '피터 메이휴');

INSERT INTO casting
VALUES (1, 10, '빌리 디 윌리엄스');
INSERT INTO casting
VALUES (1, 11, '프랭크 오즈');
INSERT INTO casting
VALUES (1, 12, '이더 맥더미드');

INSERT INTO casting
VALUES (2, 13, '헤이든 크리스텐슨');
INSERT INTO casting
VALUES (2, 14, '리엄 니슨');
INSERT INTO casting
VALUES (2, 15, '나탈리 포트만');

INSERT INTO casting
VALUES (3, 16, '페르닐라 오거스트');
INSERT INTO casting
VALUES (3, 17, '아메드 베스트');
INSERT INTO casting
VALUES (3, 18, '레이 파크');

INSERT INTO casting
VALUES (3, 19, '테뮤라 모리슨');
INSERT INTO casting
VALUES (3, 20, '새뮤얼 L. 잭슨');
INSERT INTO casting
VALUES (3, 21, '크리스토퍼 리');

COMMIT;

SELECT real_name
FROM    casting
WHERE   episode_id = 4;
/*
마크 해밀
해리슨 포드
캐리 피셔
*/

-- 4. 에피소드5에 출연한 배우들의 배역이름과 실제이름
-- 배역이름 : character_name       <characters 테이블>
-- 실제이름 : real_name            <casting 테이블>
-- 조인 연산 : 다른 테이블의 컬럼을 가져와 마치 하나의 테이블인것처럼 데이터를 조회 (수평)
-- SET 연산 :  컬럼갯수, 데이터 타입만 맞으면 마지 하나의 테이블에서 데이터 조회한 결과 (수직)
-- 4.1 오라클 조인
-- 4.2 ANSI 조인 : MYSQL등 기타 다른 RDBMS에서 각기 다른 조인 문법 ==> 표준 문법으로 만든 조인

SELECT  ch.character_name AS 배역이름,
        ca.real_name AS 실제이름
FROM    characters ch, casting ca
WHERE   ch.character_id = ca.character_id
AND     ca.episode_id = 5;



-- 5. 국제표준 조인문으로 바꾸어 작성하시오
-- ANSI 조인 : INNER JOIN, OUTER JOIN
-- ON절 : where 조건절 대신
-- USING : 컬럼의 별칭/약어 사용x 
-- 테이블 여러개 일때 : 먼저 조인한 결과에 다시 추가로 조인하는 형식
-- (+) : 오라클 아우터 조인 <---> [LEFT|RIGHT|FULL] OUTER JOIN
SELECT c.character_name, p.real_name, r.role_name
FROM    characters c LEFT OUTER JOIN casting p
ON      c.character_id = p.character_id
RIGHT OUTER JOIN roles r
ON      c.role_id = r.role_id
AND     p.episode_id = 2;

-- 에피소드 2편 출연자 3명의 배역명 | 실제배우명 | 역할이름 이 나와야 함
-- characters 데이터와 casting 데이터간 불일치 : 교재 제공 vs 직접 데이터




-- 6. 문자 함수를 이용해 chracters 테이블의 배역이름, 이메일, 이메일 아이디를 조회하시오
-- SUBSTR() : 문자열 추출하여 반환
-- INSTR() : 특정 문자열의 시작위치를 반환
-- REPLACE(), TRANSLATE() : 치환/1:1 변환
-- TRIM(),LTRIM(),RTRIM() : 문자열/기본값 공백 제거
-- LPAD(), RPAD() : 문자열/공백 추가
-- LENGTH() : 문자열 길이 반환
-- 단, 이메일이 아이디@도메인일때! 
SELECT  character_name AS 배역이름,
        email AS 이메일,
        SUBSTR(email, 1, INSTR(email, '@') -1 ) AS 이메일_아이디
FROM    characters;        
    

-- 7. 역할이 제다이에 해당하는 배역들의 배역이름, 그의 마스터
-- 서브쿼리 : SELECT 절에 괄호 ==> 스칼라 서브쿼리 : 컬럼처럼 사용 ==> 단일 값
-- NULL 처리 함수 : NVL(exp1, exp2), NVL2(exp1,exp2,exp3)
-- COALESCE() : 최소 하나는 NULL 아니어야 하는 .. 최초 NULL아닌 값 반환 함수
SELECT  m.character_name AS master_name
FROM    characters c, characters m
WHERE   c.master_id = m.character_id; -- 셀프조인 : 캐릭터/마스터 테이블 조인

-- 스칼라 서브쿼리 : 단일 행 반환 (컬럼처럼) : x
-- NULL 처리 함수 :   O   
SELECT  c.character_name, NVL(m.character_name, '제다이 중의 제다이') AS master_name
FROM    characters c, roles r, characters m
WHERE   c.role_id = r.role_id
AND     r.role_name = '제다이'
AND     NVL(c.master_id, 0) = m.character_id(+)   -- master_id가 NULL이 있을수 있는데, 문제에서는 혼란을..;
ORDER BY 1;

SELECT *
FROM    characters;


-- 8.역할이 제다이 ==> 기사의 이메일이 있으면 제다이의 이메일을 없으면 마스터의 이메일을 조회 (EMAILS)
SELECT  c.character_name, 
        NVL(c.email, NULL) AS JEDAI_EMAIL,
        NVL(m.email, NULL) AS MASTER_EMAIL
FROM    characters c, roles r, characters m
WHERE   c.role_id = r.role_id
AND     r.role_name = '제다이'
AND     NVL(c.master_id, 0) = m.character_id(+)   -- master_id가 NULL이 있을수 있는데, 문제에서는 혼란을..;
ORDER BY 1;
        
        
-- 9. 스타워즈 시리즈별 출연한 배우의 수
-- 에피소드 이름, 출연배우 수를 개봉연도 순
SELECT  s.episode_name, COUNT(*) AS cnt
FROM    star_wars s, casting c
WHERE   s.episode_id = c.episode_id
GROUP BY    episode_name, open_year
ORDER BY    open_year;


-- 10. 스타워즈 전체 시리즈에서 각 배우별 배역이름, 실제이름, 출연횟수를 조회
-- 출연횟수가 많은 배역이름, 실제이름 순으로 조회

SELECT  ch.character_name, ca.real_name, COUNT(*) AS times
FROM    characters ch, casting ca
WHERE   ch.character_id = ca.character_id
GROUP BY  ch.character_name, ca.real_name;

-- 가공한 CASTING 데이터가 모두 각 시리즈별 3명씩 ==> 21명이 출연 (실제 데이터와 차이발생 가능)
-- 실제로는 같은 배우가 시리즈 1~3에 이르기까지 출연하거나 목소리로 출연한 사례가 있음


-- 11. 위 쿼리문을 참고한 상위 3명의 배역명, 실명, 출연횟수
-- 인라인 뷰 서브쿼리 활용 하거나 : WHERE ROWNUM <= 5;
-- 서브쿼리에서 ORDER BY 절은 아주 특별한 경우가 아니라면  사용하지 않는다.
SELECT e.*
FROM    (   SELECT  ch.character_name, ca.real_name, COUNT(*) AS times
            FROM    characters ch, casting ca
            WHERE   ch.character_id = ca.character_id
            GROUP BY  ch.character_name, ca.real_name ) e    --  ORDER BY 1
WHERE ROWNUM <= 3;

-- 가공한 CASTING 데이터가 모두 각 시리즈별 3명씩 ==> 21명이 출연 (실제 데이터와 차이발생 가능)
-- 실제 랭킹을 메기는 함수 : AVERAGE_RANK()만 21c에서는 사용x
SELECT  ch.character_name, ca.real_name, COUNT(*) AS times,
        RANK() OVER (ORDER BY COUNT(*) ASC) AS RANK,
        DENSE_RANK() OVER (ORDER BY COUNT(*) ASC) AS DENSE_RANK
FROM    characters ch, casting ca
WHERE   ch.character_id = ca.character_id
GROUP BY  ch.character_name, ca.real_name; 



-- 12. 스타워즈 시리즈별 어떤 시리즈에 몇명의 배우가 출연했는지 조회
-- 에피소드 번호, 이름, 출연배우 수 조회, 출연배우수가 많은 순으로 조회

SELECT  s.episode_id, s.episode_name, COUNT(*) AS cnt
FROM    star_wars s, casting c
WHERE   s.episode_id = c.episode_id
GROUP BY    s.episode_id, s.episode_name
ORDER BY 3 DESC;

-- 실제 스타워즈 영화정보와 일치하는지는 따져봐야 알수 있고, 가공된 CASTING 테이블 데이터에 따라
-- 다를 수 있음.

COMMIT;












