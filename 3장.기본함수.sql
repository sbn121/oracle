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
-- 3.4 ��ȯ�Լ�
-- 3.5 �Ϲ��Լ�

-- ����Լ� : ������ ���̾�Ƽ��Ʈ(DS), ������ �м���(DA)���� ����ϴ� �Լ�
