-- 3��. �⺻�Լ�
-- �����Լ� + ����� ���� �Լ� ==> PL/SQL (SQL�� �̿��� ���α׷��� ����)
-- �Լ� : ��Դ� Return���� �ִ�.
-- ���ν��� : Return���� ���� �Լ� ����
-- ���α׷��� ���� ����ϴ� �Լ��� ����ϴ�
-- ���� ����ϴ� ����� �Լ��� �����Ͽ� ������ ��, �ʿ��� ������ ȣ���Ѵ�.
-- ��) ��ü ����� �޿� ����� ��ȸ ==> AVG()
-- ��) sal_avg() : ����� ���� �Լ� ���� �� �ִµ�..����/�ﰢ/�繫/����Լ��� ��� ������.
-- �⺻������ ����� ���� �Լ��� �⺻�Լ��� ���� Ư���� ó���� ��� �� ��ȯ�� ���� ����.(PL/SQL)

-- �⺻�Լ� : �� �� �ϳ��� ����� ��ȯ�ϴ� "���� ��" �Լ�
-- �Լ����� ����ϴ� �Ķ����, ���� ������ ���� �Լ��� �����Ѵ�.
-- �Լ��� ���� : ����/����/��¥/��ȯ/�Ϲ� �Լ�

-- �� ��� �Լ��� ���翡�� �ٷ� ���� �ƴ�!!
-- 3.1 �����Լ�
-- 3.1.1 ABS() : ���밪���� ��ȯ�ϴ� �Լ�
-- dual : ��¥ ���̺�
SELECT  ABS(32), ABS(-32)
FROM    dual;


-- 3.1.2 SIGN() : ��ȣ(����, ���, 0)
SELECT  SIGN(32), SIGN(-32), SIGN(0)
FROM    dual;

-- 3.1.3 ROUND(n [,i]) : �ݿø� �Լ� ..n�� �Ҽ��� i��° �ڸ��� �ݿø��� ����� ��ȯ�ϴ� �Լ�
[���� 3-3]
SELECT ROUND(123.45678) avg1,
        ROUND(123.45678, 1) avg2,
        ROUND(123.45678, 0) avg3,
        ROUND(123.45678, -1) avg4
FROM    dual;

-- i�� ������ ���, ������ i��° �ڸ����� �ݿø�
-- [,i] : �ɼ�(=����), ������ �⺻�� 0����..
--3.1.3 TRUNC(n [,i]) : ���� �Լ� .. �⺻������ ROUND�� ����.
[���� 3-5]
SELECT  TRUNC(123.456787) T1,
        TRUNC(123.456787, 0) T2,
        TRUNC(123.456787, 2) T3,
        TRUNC(123.456787, -2) T4 -- ������ i��° �ڸ����� ����
FROM    dual;


-- 3.1.4 CEIL(n) : n�� ���ų� ū ���� ���� ���� (�ܾ� �� : õ��, �ø�?)
[���� 3-6]
SELECT  CEIL(0.12345) CEIL1,
        CEIL(123.45) CEIL2
FROM    DUAL;

-- 3.1.5 FLOOR(n) : n�� ���ų� ���� ���� ū ���� (�ܾ� �� : �ٴ�, ����)
[���� 3-7]
SELECT  FLOOR(0.12345) FLOOR1,
        FLOOR(123.45) FLOOR2
FROM    DUAL;

-- 3.1.6 MOD(m, n) : m�� n���� ���� ������ ���� ��ȯ�ϴ� �Լ�
-- % : LIKE �����ڿ� �Բ� '���� ���ڿ�' ã�� ������ ��ȣ�� ����.

[���� 3-8]
SELECT  MOD(17, 4) MOD1,
        MOD(17, -4) MOD2,
        MOD(-17, -4) MOD3,
        MOD(17, 0) MOD4
FROM    DUAL;

-- 0���� ������ ���� ==> Zero Divide ���� �߻�����!

[�������� 3-1]
                                                                    (�޿�*1.15)
1. ��� ���̺��� 100�� �μ��� 110�� �μ��� ����� ���� ���, �̸�, �޿��� 15% �λ�� �޿��� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
    ��, 15% �λ�� �޿��� ������ ǥ���ϰ� �÷����� Increased Salary��� ǥ���Ѵ�.

SELECT  employee_id, first_name, salary, 
        ROUND(salary*1.15, 0) AS "Increased Salary ROUND", 
--        TRUNC(salary*1.15, 0) AS "Increased Salary TRUNC", 
--        CEIL(salary*1.15) AS "Increased Salary CEIL", 
--        FLOOR(salary*1.15) AS "Increased Salary FLOOR", 
        department_id
FROM    employees
--WHERE   �μ��ڵ� = 100
--OR      �μ��ڵ� = 110
WHERE   department_id IN (100, 110);


-- 100��, 110�� �μ� : Finance, Accounting
SELECT  *
FROM    departments
WHERE   department_id = 110;


-- 3.2 �����Լ�
-- 3.2.1 CONCAT(char1, char2) : �� ���ڿ� char1, char2�� �����Ͽ� ��ȯ�ϴ� �Լ�
-- || : ���ڿ� ���� ������ (����)

[���� 3-9]
SELECT  CONCAT('Hello', 'Oracle') CONCAT1,
        'Hello'||'Oracle' CONCAT2
FROM    DUAL;

-- 3.2.2 INITCAP(char) : ���ĺ� �ܾ� ������ ù ���ڸ� �빮��ȭ�Ͽ� ��ȯ�ϴ� �Լ�
-- 3.2.3 UPPER(char) : ���ĺ��� ��� �빮��ȭ�Ͽ� ��ȯ�ϴ� �Լ�
-- 3.2.4 LOWER(char) : ���ĺ��� ��� �ҹ���ȭ�Ͽ� ��ȯ�ϴ� �Լ�

[���� 3-10]
SELECT  INITCAP('i am a boy') CAP1,
        UPPER('i am a boy') CAP2,
        LOWER('I AM A BOY') CAP3,
        LOWER('���ѹα�') CAP4
FROM    DUAL;

-- 3.2.5 LPAD(char1, n [,char2])
-- 3.2.6 RPAD(char1, n [,char2])
-- * n : ��ü ���ڿ� ����, (n ������, �⺻������ ���鹮�� 1���� �����ȴ�.)
-- �� LPAD�� ���ʿ� ����(=����, �⺻��)/���ڿ� ä���, RPAD�� �����ʿ� ����/���ڿ�(char2)�� ä�� ��ȯ�Ѵ�.
-- �� ������ �߰����ٴ� ������ ���� �ξ� ����.

[���� 3-11]
SELECT  LPAD('abc', 7) AS LPAD1,
        LPAD('abc', 7, '*') AS LPAD2,
        RPAD('abc', 5)|| ']' AS RPAD2,
        RPAD('abc', 7, '#') AS RPAD2
FROM    DUAL;

-- p.23
-- 3.2.7 LTRIM(char1 [,char2]) : ���ڿ� char1���� char2�� ������ ���ڸ� ������ ����� ��ȯ�Ѵ�.
-- 3.2.8 RTRIM(char1 [,char2]) : ���ڿ� char1���� char2�� ������ ���ڸ� ������ ����� ��ȯ�Ѵ�.
-- �� �����ϰ��� �ϴ� ���ڿ� ���� : ����Ʈ�� ���鹮�� �� ���� ���ȴ�.
-- ���ʿ��� ���������� ��ĵ�ϸ鼭 ��ġ���� �ʴ� ���ڰ� ������ ������ ����
[���� 3-12]
SELECT  '['||LTRIM('  ABCDEFG   ')||']' LTRIM1,
        LTRIM('ABCDEFG', 'AB') LTRIM2,
        LTRIM('ABCDEFG', 'BA') LTRIM3,
        LTRIM('ABCDEFG', 'BC') LTRIM4 -- B, C�� �ƴ� A��
FROM    DUAL;

[���� 3-13]
--
SELECT  '['||RTRIM('  ABCDEFG   ')||']' RTRIM1,
        RTRIM('ABCDEFG', 'FG') RTRIM2,
        RTRIM('ABCDEFG', 'GF') RTRIM3,
        RTRIM('ABCDEFG', 'BC') RTRIM4 -- B, C�� �ƴ� A��
FROM    DUAL;

-- 3.2.9 TRIM([LEADING, TRAILING, BOTH] [trim_char] [FROM] char) : ���ڿ� char�� ����(LEADING)�̳�
-- ������(TRAILING) �Ǵ� ����(BOTH)���� ������(=������) trim_char ���ڸ� ������ ����� ��ȯ�ϴ� �Լ�
-- ���� : LEADING(=left), TRAILING(=right), BOTH(=left and right) (�⺻���� ������ BOTH �⺻�� = ��������)

[���� 3-14]
SELECT  '['||TRIM('    ABCDEFG    ')||']' TRIM1,        --��������
        '['||TRIM(LEADING 'A' FROM 'ABCDEFG')||']' TRIM2,
        '['||TRIM(TRAILING 'G' FROM 'ABCDEFG')||']' TRIM3,
        '['||TRIM(BOTH '1' FROM '1ABCDEFG1')||']' TRIM4,
        '['||TRIM('1' FROM 'ABCDEFG')||']' TRIM5,
        '['||TRIM(TRAILING 'C' FROM 'ABCDEFG')||']' TRIM6
FROM    DUAL;

-- 3.3.0 SUBSTR(char, position [,length]) : ���ڿ��� �Ϻθ� ����/�и��ؼ� ��ȯ�ϴ� �Լ� 
-- chr : ������ ���ڿ�
-- position : ������ ��ġ, ���� 0���� ����� ��� 1�� ����(=���ڿ��� ù ��° �ڸ�)
-- length : ����, ���� --> length ������ ���ڿ��� ������

-- JOB_ID
-- SA_MAN
-- SA_REP
-- 0505.040.
-- EMAIL ID : manager@hr.com

[���� 3-15]
SELECT  SUBSTR('You are not alone', 9, 3) SUBSTR1, -- 9��° ��ġ���� 3�ڸ� �и��ؼ� ��ȯ
        SUBSTR('You are not alone', 5) SUBSTR2, -- (length ������) 5��° ��ġ���� ������ �и��ؼ� ��ȯ
        SUBSTR('You are not alone', 0, 3) SUBSTR3, -- position�� 0���� ����ϸ� 1�� �⺻��
        SUBSTR('You are not alone', -9, 3) SUBSTR4, -- position ������, ���ڿ� �ڿ�������..
        SUBSTR('You are not alone', -5) SUBSTR5 -- position�� �����̰� length������ �ڿ��� ������
FROM    DUAL;

-- =================================================================
-- position ���� ������ ��� �� ��ġ��, �����ʺ��� ���۵ȴ�
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


-- 3.3.1 REPLACE(char, search_str [,replace_str]) : ���ڿ��� �Ϻθ� �ٸ� ���ڿ��� �����Ͽ� ��ȯ�ϴ� �Լ�(=ġȯ)
-- char : ���ڿ�
-- search_string : ã�� ���ڿ�
-- replace_string : ������ ���ڿ�. ������ ���, NULL�� ���� search_string ���ڿ��� ������ ����� ��ȯ�Ѵ�.

[���� 3-17]
SELECT  REPLACE('You are not alone', 'You', 'We') REP1,
        REPLACE('You are not alone', 'not ') REP2, -- replace_str����, search_str ������ char ��ȯ
        REPLACE('You are not alone', 'not ', null) REP3
FROM    DUAL;

-- 3.3.2 TRANSLATE(char, from_string, to_stirng) : from_string���� �ش��ϴ� ���ڸ� ã�� to_string �ش��ϴ� ���ڷ� 1:1 ��ȯ�Ѵ�.
-- 1�� 1�� ���� ��ȯ : 
[���� 3-18]
SELECT  TRANSLATE('u! You are not alone', 'You', 'We') TRANS1,
        REPLACE('u! You are not alone', 'You', 'We') REPLACE2
FROM    DUAL;


-- ==================================================================
-- �ʴ� ���� �𸣴µ� ���� �ʸ� �˰ڴ���,  �� ���ڿ��� REPLACE() �� TRANSLATE()�� �Ʒ��� ���� �����ϼ���
SELECT  REPLACE('�ʴ� ���� �𸣴µ� ���� �ʸ� �˰ڴ���', '��', '��') REPLACE1,
        TRANSLATE('�ʴ� ���� �𸣴µ� ���� �ʸ� �˰ڴ���', '�ʳ�', '����') TRANSLATE2
FROM    DUAL;


-- 3.3.3 INSTR(char, search_string [,position] [,th]) : ���ڿ����� Ư�� ���ڿ��� ���� ��ġ�� ��ȯ�ϴ� �Լ�
-- char : ���ڿ�
-- search_string : ã�� ����
-- position : ���ڸ� ã�� ���� ��ġ, ������ �⺻�� 1�̴�.
-- _th : �� ��° ���ڿ�����, ������ �⺻�� 1
-- �� ���ڿ��� position��ġ�������� Ư�� ���ڸ� ã�� ������ _th��°�� �ش��ϴ� ���� ��ġ�� ��ȯ�ϴ� �Լ�
-- ã�� ���ڿ��� �߰ߵ��� ������ 0�� ��ȯ
-- ã�� ���ڿ��� �߰ߵǸ� �ش� ��ġ���� ��ȯ

[���� 3-19]
SELECT  INSTR('Every Sha-la-la-la', 'la') INSTR1, -- 1�� ��ġ, ù��° la�� �����ϴ� ��ġ ��ȯ
        INSTR('Every Sha-la-la-la', 'la', 7) INSTR2, -- 7��° ��ġ���� ã�� �����ؼ� ù��° la�� ��ġ
        INSTR('Every Sha-la-la-la', 'la', 1, 2) INSTR3, -- �ι�° la�� ��ġ
        INSTR('Every Sha-la-la-la', 'la', 12, 2) INSTR4, -- 12��° ��ġ���� ã�� ����, �ι�° la�� ��ġ
        INSTR('Every Sha-la-la-la', 'la', 15, 2) INSTR5 -- 15��° ��ġ���� ã�� ����, �ι�° la�� ��ġ
FROM    DUAL;


-- 3.3.4 LENGTH(char) : ���ڿ��� ���̸� ��ȯ�Ѵ�.
-- 3.3.5 LENGTHB(char) : ���ڿ��� ����Ʈ���� ��ȯ�Ѵ�.
[���� 3-20]
SELECT  LENGTH('Every Sha-la-la-la') LEN1,
        LENGTH('����ȭ ���� �Ǿ����ϴ�.') LEN2,
        LENGTHB('Every Sha-la-la-la')||' Bytes' LEN3,
        LENGTHB('����ȭ ���� �Ǿ����ϴ�')||' Bytes' LEN4 -- �ѱ��� 3Bytes, NLS ���� ==> ����Ŭ ��ġ�� �ڵ� ����!
FROM    DUAL;



-- 3.3 ��¥�Լ�
-- ��¥�� ���Ҿ� �ð��� ���� ������� �Ѵ�.

-- 3.3.1 SYSDATE()
-- �ý����� ���� ��¥�� ������ ��ȯ�ϴ� �Լ�
-- �� ��¥�� �ð��� �����ϰ� �ִ�.
-- SYSDATE�Լ��� �ٸ� �Լ��� �ٸ��� �Ķ���Ͱ� ����. ()�� ������� �ʴ´�.
-- SYSDATE() : ��û ����, �Ϲ������� ���� �Լ� --> SYSDATE�� ǥ��

SELECT  SYSDATE
FROM    DUAL; --23/05/09 <==> �ý��� ��¥ ���� : RR/MM/DD
-- YY vs RR ǥ��� : 50 �̻��̸� 1900���, 50 �̸��̸� 2000��� ǥ��
-- 99/05/09 ==> 1999/05/09
-- 03/05/09 ==> 2003/05/09

-- ��¥ ����(Format) �� Ȯ���ϴ� SQL
SELECT  *
FROM    v$nls_parameters; -- : �����(������ �� ��) vs ���Ѹ��� �ٸ�..
-- NLS_DATE_FORMAT : RR/MM/DD --> YY/MM/DD, YYYY/MM/DD, YY/MM/DD HH:MI:SS ... [��¥/�ð� ���� ����]

-- �Ͻ������� ��¥ ������ ���� : ��¥ --> ���� : ��¥+�ð� �������� ����
-- �������� ���� X, ���� �α��ε� HR ���ǿ����� ��ȿ!
-- ���� > ȯ�漳�� > �����ͺ��̽� > NLS : ��¥ ����
ALTER SESSION SET nls_date_format = 'RR/MM/DD HH24:MI:SS';  -- 24�ð��� ǥ��, HH 12�ð���
ALTER SESSION SET nls_date_format = 'RR/MM/DD'; -- ���� �⺻ ����

SELECT  SYSDATE, SYSTIMESTAMP
FROM    DUAL;

-- =======================================================================
-- ������ �Ź� �ٲپ ��¥, �ð��� ����ϴ� ���� �����ϹǷ�,
-- ��ȯ �Լ��� ����Ͽ�, �׶��׶� ���ϴ� �������� ����ϴ� ���� ����
-- =======================================================================
SELECT SYSDATE, -- ������ ���ؼ� ��¥+�ð� ���
        TO_DATE('2023-05-09 17:32:20', 'RR/MM/DD HH24:MI:SS') SYSDATE_TIME  --��ȯ�Լ��� ���� --> ��¥
FROM    DUAL;


                          
-- ���̺� / table (��ü) : �����͸� ����
-- �� / view(��ü) : ���̺��� �Ϻθ� �����ؼ� ��ġ ���̺�ó�� ���(��ȸ | ����...)
-- HR ����, EMP_DETAILS_VIEW (���_�������� ���� ��)
SELECT  *
FROM    EMP_DETAILS_VIEW; -- �並 ��ȸ! (�ӽ� �� - �޸𸮿��� ����)

-- 3.3.1 ADD_MONTHS(date, n) : date�� ���� �� n�� ���ؼ� �� ���(��¥)�� ��ȯ�ϴ� �Լ�
-- n : integer
[���� 3-21] 
SELECT  ADD_MONTHS(SYSDATE, 1) MONTH1,
        ADD_MONTHS(SYSDATE, 2) MONTH2,
        ADD_MONTHS(SYSDATE, -3) MONTH3 -- 3������
FROM    DUAL;

-- 3.3.2 MONTHS_BETWEEN(date1, date2) : �� ��¥ ������ ���� ���� ���Ͽ� ��ȯ�ϴ� �Լ�
-- date1 : ���� ��¥
-- date2 : ���� ��¥
-- �� date1 - date2 �������� ���


[���� 3-22]
-- ROUND(n, 0)
-- TRUNC(n, 0)
-- CEIL(n)
-- FLOOR(n)
-- ABS(n)
SELECT  ROUND(MONTHS_BETWEEN('2013-03-20', SYSDATE)) AS REMAINED, 
        ABS(TRUNC(MONTHS_BETWEEN(SYSDATE, '2013-08-28'))) AS PASS
FROM    DUAL;

-- 3.3.3 LAST_DAY(date) : date�� �ش��ϴ� ���� ������ ��¥�� ��ȯ�Ѵ�.
-- 3���̸� 31 ��ȯ, 4���̸� 30 ��ȯ
-- ���� ��¥ 5���� 31��!
-- �ſ� �� ������ �ڵ����� �����ϰų�, ���� ������(��� ���� ����?) ���� ���� ����� �ڵ������ϴ�
-- ���񽺸� �����ϰų� �ϴ� ��ɿ��� �ʿ��� �� �ִ� �Լ�
SELECT  LAST_DAY(SYSDATE) LAST1,
        LAST_DAY('2013-03-20') AS LAST2
FROM    DUAL;


SELECT  employee_id, first_name, hire_date
FROM    employees;

-- 3.3.4 NEXT_DAY(date, char) : date ���� ��¥�߿� char�� ��õ� ù ��° ���ڸ� ��ȯ�ϴ� �Լ�
--                              ���ƿ��� ����(char)�� ��¥�� ��ȯ�ϴ� �Լ�
-- NLS : ��� ������ KOREAN(���� : SUNDAY, MONDAY... <---> �Ͽ���, ������...)

[���� 3-24]
--ORA-01846: ������ ������ �������մϴ�.
--01846. 00000 -  "not a valid day of the week"
SELECT  NEXT_DAY(SYSDATE, '������') NEXT1,
        NEXT_DAY(SYSDATE, '�ݿ���') NEXT2,
        NEXT_DAY(SYSDATE, '��') NEXT3,
        NEXT_DAY(SYSDATE, 'ȭ') NEXT4,
        NEXT_DAY(SYSDATE, 4) NEXT5
FROM    DUAL;

--NLS ���� : �ѱ����� ����Ŭ ��ġ ==> �ڵ����� KOREAN, ���ϸ� �ѱ۷�!

SELECT  *
FROM    v$nls_parameters; -- NLS_LANGUAGE : KOREAN, ���ϸ� �ѱ۷�!

-- ���� > ȯ�漳�� > �����ͺ��̽� > NLS - ��¥��� : KOREAN


-- 3.3.5 �ݿø��Լ�, �����Լ�
-- �� ����, ��¥���� ���� ������ �Լ�, ������! ��ҿ��� ���ڿ�..� Ư�� ����? Ư���� �������� ����� �� ����.
-- Ư���� �������� ����� �� ����. (�Լ��� Ư¡���θ� ����)
-- ROUND(n [,i]), ROUND(date, fmt) : fmt - ��� ����
-- TRUNC(n [,i]), TRUNC(date, fmt)

[���� 3-25]
-- �ڵ�����ȯ (=������ ����ȯ)
SELECT  10+'5'
FROM    DUAL; -- '10'�� 10���� �˾Ƽ� ��ȯ�ؼ� ������ ��� 15�� ��ȯ

SELECT  10+'ABCD'
FROM    DUAL; -- ORA-01722: ��ġ�� �������մϴ� ==> ���ڶ�� �Ǵ��� �� �ִ� ���ڵ����ʹ� ����ȯ
-- ��

-- ����ȯ : ������, NUMBER --> DATE �ٷ� ��ȯ x
--        TO_NUMBER()       TO_CHAR()
-- NUMBER <---------- CHAR <-------- DATE
--        ---------->      -------->
--          TO_CHAR()       TO_DATE()

-- TO_DATE() : ���ڸ� ��¥ �������� ��ȯ�ϴ� �Լ�
-- TO_DATE() : ���ڷ� �ٲٴ� �Լ�
-- TO_NUMBER() : ���ڷ� �ٲٴ� �Լ�
-- YYYY or RRRR : �⵵�� 4�ڸ��� ǥ��
[���� 3-25]
SELECT  ROUND(TO_DATE('2013-06-30'), 'YYYY') AS R1,
        ROUND(TO_DATE('2013-07-01'), 'YEAR') AS R2,
        ROUND(TO_DATE('2013-12-16'), 'MONTH') AS R3,
        ROUND(TO_DATE('2013-12-16'), 'MM') AS R4,
        ROUND(TO_DATE('2013-05-27 11:59:59', 'YYYY-MM-DD HH24:MI:SS'), 'DD') AS R5,
        ROUND(TO_DATE('2013-05-27 12:00:00', 'YYYY-MM-DD HH:MI:SS'), 'DD') AS R6,
        ROUND(TO_DATE('2013_05_29'), 'DAY') AS R7,
        ROUND(TO_DATE('2013_05-30'), 'DAY') AS R8
FROM    DUAL;

[���� 3-26]
SELECT  TRUNC(TO_DATE('2013-06-30'), 'YYYY') AS T1,
        TRUNC(TO_DATE('2013-07-01'), 'YEAR') AS T2,
        TRUNC(TO_DATE('2013-12-16'), 'MONTH') AS T3,
        TRUNC(TO_DATE('2013-12-16'), 'MM') AS T4,
        TRUNC(TO_DATE('2013-05-27 11:59:59', 'YYYY-MM-DD HH24:MI:SS'), 'DD') AS T5,
        TRUNC(TO_DATE('2013-05-27 12:00:00', 'YYYY-MM-DD HH:MI:SS'), 'DD') AS T6,
        TRUNC(TO_DATE('2013_05_29'), 'DAY') AS T7,
        TRUNC(TO_DATE('2013_05-30'), 'DAY') AS T8
FROM    DUAL;

-- 3.4 ��ȯ�Լ� (p.30)
-- ����Ŭ�� �������� ����ȯ ==> ����+'����' (ok), ����+'����' (nol)
-- ������� ����ȯ �Լ��� 3����!! (�⺻ ����, ����)
-- ����ȯ : NUMBER --> DATE �ٷ� ��ȯ x

--        TO_NUMBER()       TO_CHAR()
--       <----------       <-------- 
-- NUMBER             CHAR            DATE
--  3rd                1st            2nd
--        ---------->      -------->
--          TO_CHAR()       TO_DATE()

-- 3.4.1 TO_CHAR(date [,fmt])
-- fmt : ��, ��, ��, ��, ��, �� ����
-- �� �и������� ==> ����� ��Ϻ�(?) + SYSTIMESTAMP or ??
SELECT  SYSDATE ����ð���¥, SYSTIMESTAMP ����ð���¥�и�������_GMTǥ�ؽ�
FROM    DUAL;

-- ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD HH:MI:SS'; -- �̰ͺ��ٴ� �������̸� ��ȯ�Լ�!!

[���� 3-27]
SELECT  TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS DATE_FMT1,
        TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS DATE_FMT2,
        TO_CHAR(SYSDATE, 'YYYY/MONTH/DD') AS DATE_FMT3,
        TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MI:SS') AS DATE_FMT4,
        TO_CHAR(SYSDATE, 'YYYY/MM/DD DAY') AS DATE_FMT5
FROM    DUAL;


-- 3.4.2 TO_DATE()
-- ���ڸ� ��¥�� ��ȯ�� ����� ��ȯ�ϴ� �Լ�
-- TO_CHAR�� ���� fmt (��¥ ���� ��)�� ����Ѵ�.
-- ����, ��¥�� '(single quote)'�� ǥ��
[���� 3-30]
SELECT  TO_DATE('2013-05-27') DATE1,
        TO_DATE('2013-06-27 11:12:35', 'YYYY/MM/DD HH:MI:SS AM') DATE2,
        TO_DATE('2013-06-27 11:12:35', 'YYYY/MM/DD HH:MI:SS PM') DATE3
FROM    DUAL; -- �ܼ��� ����, �Լ��� ����� Ȯ���� �� ���� ���̺�(SYS/SYSTEM ����)

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD HH:MI:SS'; -- AM(����), PM(����)

SELECT  employee_id, first_name, salary, department_id
FROM    employees; -- ����: ������, ���� : ���� ����
-- 100	Steven	24000	90
-- 101	Neena	17000	90

-- 3.4.3 TO_NUMBER()
-- ���ڸ� ���ڷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�

[���� 3-29]
SELECT  TO_NUMBER('12345')+1000 "���ڸ� ���ڷ�1",
        TO_NUMBER('123.45') "���ڸ� ���ڷ�2"
FROM    DUAL;

-- 3.5 NULL �����Լ�(p.32)
-- �� NULL ��ü�� ��, �� ���� ���� �� �� ���� ==> �ùٸ� ������ ��ȸ�� ���� �ʱ⿡..
-- IS NULL, IS NOT NULL�θ� NULL �����͸� ��ȸ vs department_id = ' '(x)

-- 3.5.1 NVL(exp1, exp2) : exp1�� NULL�̸� exp2 ��ȯ, exp1 NULL �ƴϸ� exp1 ��ȯ�ϴ� �Լ�
-- NVL�� �Ķ������ exp1, exp2�� ������ ������ ���� ���ƾ� �Ѵ�.
-- Ŀ�̼� �ݾ��� 1000(�޷�) �̸��� ������Ը�, ���ʽ� ����!!
-- Ŀ�̼� �ݾ� = �޿�(salary) * commission_pct

[���� 3-31]
-- �� 107��
-- Ŀ�̼��� NULL �ƴ�, 35��
-- Ŀ�̼Ǳݾ� 1000�޷� �̸� : 6��
SELECT  employee_id, first_name, salary, commission_pct, salary * commission_pct AS comm -- �ŷ� ������ 
FROM    employees
WHERE   salary * commission_pct < 1000; --1000�޷� �̸�����
-- �Ǹźμ��� ��ټ�, �μ��� �������� ���� ��� 1�� (kimberely)
-- 1000�޷� �̸��� Ŀ�̼��� �޴� ����� 6�� �ۿ� ������ ���� �� ������
-- Ŀ�̼� ������ ���� �Ϲ� ����� ==> Ŀ�̼� �ݾ��� NULL �ƴ�, 0���� ó���ϵ���!

[���� 3-32]
SELECT  employee_id, first_name, salary, commission_pct, salary * NVL(commission_pct, 0) AS comm -- �ŷ� ������ 
FROM    employees
WHERE   salary * NVL(commission_pct, 0) < 1000; --1000�޷� �̸����� ~ 0�� : 78 rows


-- 3.5.2 NVL2(exp1, exp2, exp3) : exp1�� NULL�̸� exp3 ��ȯ, exp1�� NULL �ƴϸ� exp2�� ��ȯ�ϴ� �Լ�
-- salary�� Ŀ�̼� �ݾ� ���� �ݾ��� '�� �޿�(TOTAL_SALARY)'
-- Ŀ�̼��� ���� ������,  salary�� '�� �޿�'
SELECT  employee_id, first_name, salary, commission_pct, 
        NVL2(commission_pct, salary+salary*commission_pct, salary) AS "TOTAL SALARY"
FROM    employees;




-- �� �̸��� ����, �Ķ���� ������ ���� �ٸ� ==> ���ӻ��� ���� ���� NVL2�� Ȱ�뵵�� ����.

-- NULL�� �� ������? ==> �翬�� NULL�� ����� �ϳ�, �Է��ϴ� ����(=������ �Է��ϴ� ���)
-- ������ ó�� --> �̻�ġ(abnormal), NULL ó�� ==> ������ ��ó��

-- 3.5.3 COALESCE(exp1, exp2, exp3, ...) : �Ķ���� ��Ͽ��� ù ��°�� NULL�� �ƴ� exp�� ��ȯ�ϴ� �Լ�
-- �Ķ���� ��Ͽ� NULL�ƴ� ���� �ϳ��� �����ؾ��� ==> ��� NULL�̸� NULL��ȯ!!
--  ��ȭ��ȣ    ��    �繫��    ����ó     phone
--  362.7797   NULL    NULL      NULL      NULL
--    NULL     NULL    NULL      NULL      010-1234-5678    

[���� 3-35]
SELECT  COALESCE('A', 'B', 'C', NULL) first,
        COALESCE(NULL, 'B', 'C', 'D') second,
        COALESCE(NULL, NULL, 'C', NULL) third
FROM    DUAL;

------------------------------------------------------------
------------- ����ȭ1 ����ȭ2 �繫����ȭ �޴��� ------------
------------------------------------------------------------
SELECT  COALESCE('362-7797', NULL, NULL, NULL) first,
        COALESCE(NULL, '010-1234-5678', NULL, NULL) second,
        COALESCE(NULL, NULL, '362-7797', NULL) third
FROM    DUAL;


-- 3.6 DECODE�� CASE
-- ���� ���ǿ� ���� ó��, IF~ELSE / SWITCH(case) ..
-- ����Ŭ������ ���ǿ� ���� ó�� ==> �Լ� DECODE
-- ����ŬPL/SQL������ IF~ELSE ����.

-- 3.6.1 DECODE(exp, search1, result1, search2, result2, ... [,default]) : IF~ELSEó�� exp�� �˻�
-- search�� ��ġ�ϸ� result1 ��ȯ, search2�� ��ġ�ϸ� result2 ��ȯ, ... [��ġ�ϴ°� ������, �⺻��ȯ]
-- ���(=�����)

[���� 3-36] ���ʽ� ���޿� �־�, 20�� �μ��� 20%   (salary�� 20%)
                                30�� �μ��� 30%,  (salary�� 30%)
                                40�� �μ��� 40%,  (salary�� 40%)
                                �� �� �μ��� 0(=�������� �ʴ´�)    ��ü��� ������� ��ȸ�Ѵ�.
                                
SELECT  employee_id, last_name, department_id, salary, 
        DECODE(department_id, 20, salary * 0.2 
                            , 30, salary * 0.3 
                            , 40, salary * 0.4
                            , 0) AS bonus
FROM    employees;



-- 3.6.2 CASE : �Լ���⺸�� �� ū ������ ���� ǥ�����̴�.
-- �����, �� �پ��� �� ������ �� �� �ִ�. ex>������ (ũ��, �۴�...)
-- 3.6.2.1 CASE I (�����) <---> DECODE�� ���� ���� : �ٲ㼭 �� ����?
/*
CASE exp WHEN search1 THEN result1
         WHEN serach2 THEN result2
         ...���...
         [ELSE default]
END
*/
[���� 3-37] ���ʽ� ���޿� �־�, 20�� �μ��� 20%   (salary�� 20%)
                                30�� �μ��� 30%,  (salary�� 30%)
                                40�� �μ��� 40%,  (salary�� 40%)
                                �� �� �μ��� 0(=�������� �ʴ´�)    ��ü��� ������� ��ȸ�Ѵ�.
                                
SELECT  employee_id, last_name, department_id, salary, 
        CASE department_id WHEN 20 THEN salary*0.2
                           WHEN 30 THEN salary*0.3
                           WHEN 40 THEN salary*0.4
                           ELSE 0
        END AS bonus
FROM    employees;



-- 3.6.2.2 CASE II (�پ��� ��) <---> DECODE�� �� �� ����..������ ���� ��
/*
CASE WHEN condition1 THEN result1
     WHEN condition2 THEN result2
     ...���...
     [ELSE default]
END
*/

���ʽ� ���޿� �־ 30�� �̸� �μ��� �޿��� 10%�� ���ʽ��� ����,
                     30������ 50�� �μ������� �޿��� 20%�� ���ʽ��� ����,
                     60������ 80�� �μ������� �޿��� 30%�� �����ϰ�, 
                     �� ���� �μ��� 40%�� �����Ѵٰ� �� ��,
CASE ǥ������ �̿���, �� ����� ������ ���ʽ� �ݾ��� ��ȸ�Ͻÿ�.

SELECT  employee_id, last_name, department_id, salary, 
        CASE WHEN department_id <30 THEN salary*0.1
             WHEN department_id BETWEEN 30 AND 50 THEN salary*0.2
             WHEN department_id BETWEEN 60 AND 80 THEN salary*0.3
             ELSE ROUND(salary*0.4)
        END AS bonus
FROM    employees;








-- ����Լ� : ������ ���̾�Ƽ��Ʈ(DS), ������ �м���(DA)���� ����ϴ� �Լ�
