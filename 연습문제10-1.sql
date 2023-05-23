-- [��������10-1] 
-- HANUL �����֢֢֢֢� ���� Ǯ��

-- 1~3. ������ ���̺��� �����Ͻÿ� (DDL: CREATE TABLE~)

-- ���̺� �����ϸ鼭 ����
-- 1. ��ȭ ���� ���̺� ����
CREATE TABLE star_wars (
    episode_id NUMBER(5),
    episode_name VARCHAR2(50) NOT NULL,
    open_year NUMBER(4),
    CONSTRAINT star_wars_episode_id_pk PRIMARY KEY (episode_id)
); -- Table STAR_WARS��(��) �����Ǿ����ϴ�.

-- �߰� ���� : NN �������� �߰� x --> �÷� ���� �����ϴ� ���
ALTER TABLE star_wars
MODIFY episode_name NOT NULL;


-- ���̺� ���� �� �����ϴ� ���
-- ALTER TABLE star_wars
-- ADD CONSTRAINT star_wars_episode_id_pk PRIMARY KEY (episode_id)


-- 2. �����ι� ���� ���̺� ����
CREATE TABLE characters (
    character_id NUMBER(5) CONSTRAINT characters_id_pk PRIMARY KEY, -- �÷����� : SYS_C008981??
    charater_name VARCHAR(30) NOT NULL,
    master_id NUMBER(5),
    role_id NUMBER(5),
    email VARCHAR2(40)
);

SELECT *
FROM    user_constraints
WHERE   table_name = 'CHARACTERS';

ALTER TABLE characters
DROP CONSTRAINT characters_id_pk;

ALTER TABLE characters
ADD CONSTRAINT characters_id_pk PRIMARY KEY (character_id);


-- 3. �����ι��� �����迪���� ���̺� ����
CREATE TABLE casting (
    episode_id NUMBER(5),
    character_id NUMBER(5),
    real_name VARCHAR2(30) NOT NULL,
    CONSTRAINT casting_episode_id_pk PRIMARY KEY (episode_id, character_id) -- ����Ű
);


--  4. star_wars ���̺� ������ �Է�
-- �˾Ƽ� COMMIT;

INSERT INTO star_wars
VALUES (4, '���ο� ���(A New Hope)', 1977);
INSERT INTO star_wars
VALUES (5, '������ ����(The Empire Strikes Back)', 1980);
INSERT INTO star_wars
VALUES (6, '�������� ��ȯ(Return of Jedi)', 1983);
INSERT INTO star_wars
VALUES (1, '������ �ʴ� ����(The Phantom Menace)', 1999);
INSERT INTO star_wars
VALUES (2, 'Ŭ���� ����(Attack of the Clones)', 2002);
INSERT INTO star_wars
VALUES (3, '�ý��� ����(Revenge of the Sith)', 2005);

SELECT *
FROM    star_wars;

COMMIT;

-- 5. characters ���̺� ������ ����
INSERT INTO characters (character_id, character_name, email)
VALUES (1, '��ũ ��ī�̿�Ŀ', 'luke@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (2, '�� �ַ�', 'solo@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (3, '���̾� ����', 'leia@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (4, '����� �ɳ��', 'Obi-Wan@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (5, '�پ� ���̴�', 'vader@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (6, '�پ� ���̴�(��Ҹ�)', 'vader_voice@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (7, 'C-3PO', 'c3po@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (8, 'R2-D2', 'r2d2@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (9, '���ī', 'Chewbacca@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (10, '���� Į���þ�', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (11, '���', 'yoda@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (12, '�پ� �õ�', 'sidious@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (13, '�Ƴ�Ų ��ī�̿�Ŀ', 'Anakin@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (14, '���̰� ��', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (15, '�ƹ̴޶� ����', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (16, '�Ƴ�Ų ��Ӵ�', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (17, '���ں�ũ��(��Ҹ�)',NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (18, '�پ� ��', 'maul@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (19, '��� ��', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (20, '������ ����', 'windu@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (21, '���� ����', 'dooku@jedai.com');

-- �÷��� ��Ÿ
ALTER TABLE characters
RENAME COLUMN charater_name TO character_name;

-- Ȯ��
SELECT *
FROM    characters;

-- Ŀ��
COMMIT;


-- 6. roles ���̺� ���� , ������ ����
CREATE TABLE roles (
    role_id NUMBER(4),
    role_name VARCHAR2(20)
);

INSERT INTO roles
VALUES (1001, '������');
INSERT INTO roles
VALUES (1002, '�ý�');
INSERT INTO roles
VALUES (1003, '�ݶ���');

SELECT *
FROM    roles;

COMMIT;


-- 7. characters ���̺��� role_id �÷��� �����Ͱ� roles ���̺��� role_id �÷��� �����͸�
-- �����ϵ��� charaters ���̺� ����Ű(=�ܷ�Ű, FK)�� �����Ͻÿ�

-- 7.1 roles ���̺��� ROLE_ID�� �⺻Ű ����
ALTER TABLE roles
ADD CONSTRAINT roles_id_pk PRIMARY KEY (role_id); -- Table ROLES��(��) ����Ǿ����ϴ�.

-- 7.2 ���̺� ������ �� �������� ���� : characters ���̺��� role_id�� roles ���̺��� role_id �ܷ�Ű ����
ALTER TABLE characters
ADD CONSTRAINT characters_role_id_fk FOREIGN KEY (role_id) REFERENCES roles (role_id);
-- Table CHARACTERS��(��) ����Ǿ����ϴ�.

-- 7.3 Ȯ�� [���� �˾Ƽ�..�ʿ��ϸ�]
INSERT INTO characters (character_id, character_name, role_id, email)
VALUES (22, '���� �Ǵ�', 1004 ,'dooku@jedai.com');
-- ORA-02291: ���Ἲ ��������(HANUL.CHARACTERS_ROLE_ID_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�

INSERT INTO characters (character_id, character_name, role_id, email)
VALUES (22, '���� �Ǵ�', 1003 ,'real_devil@jedai.com');

rollback;

SELECT *
FROM    characters;

-- 8. DML : UPDATE - �����ؼ� �����͸� ����
UPDATE characters
SET role_id = 1002
WHERE   email LIKE '%sith%'; -- 4rows

UPDATE characters
SET role_id = 1003
WHERE   email LIKE '%alliance%'; -- 5rows

UPDATE characters
SET role_id = 1001
WHERE   character_name IN ('��ũ ��ī�̿�Ŀ', '����� �ɳ��', '���', '�Ƴ�Ų ��ī�̿�Ŀ', '���̰� ��', '������ ����', '���� ����');
-- 7rows


SELECT *
FROM    characters;

-- �˾Ƽ� Ŀ��
COMMIT;


