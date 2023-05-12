-- 게시판 (TBL_BOARD) BOARD_NO (number) key, Board_title, board_content, writer, write_date

CREATE TABLE TBL_BOARD (
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TITLE VARCHAR2(100) NOT NULL,
    BOARD_CONTENT VARCHAR2(2000) NOT NULL,
    WRITER VARCHAR2(100),
    WRITE_DATE VARCHAR2(20)
);

DROP TABLE TBL_BOARD;

-- 게시판 글을 5건 정도 추가해보기.
-- INSERT INTO TABLE_TBL(COL..., ) VALUES(VAL,...);
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (8, 'title', 'content', 'writer', '2023-05-12');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (2, 'title', 'content', 'writer', '2023-05-12');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES ('3', 'title', 'content', 'writer', '2023-05-12');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES ('4', 'title', 'content', 'writer', '2023-05-12');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES ('5', 'title', 'content', 'writer', '2023-05-12');


commit;

ROLLBACK;

select * from    TBL_BOARD WHERE UPPER(BOARD_TITLE) LIKE UPPER('%e2%');  --E2, e2 => E2 == E2

-- UPDATE TABLE명 SET 바꿀 컬럼 = 바꿀 값 WHERE 조건
-- UPDATE & DELETE는 조건을 별도로 만들지 않으면 전체 행에 대한 수정이 발생함 (삭제)
UPDATE TBL_BOARD SET BOARD_TITLE = 'titleAA' WHERE board_no = 1;

DELETE FROM TBL_BOARD WHERE BOARD_NO = 2;

SELECT  *
FROM    TBL_BOARD
WHERE   board_no = 2
OR      board_title LIKE '%2%' 
OR      board_content LIKE '%2%';

-- ↓ 숫자를 조회를 따로 하나를 java코드로 가져옴  => title, content 입력받아 글 insert시킴
SELECT  MAX(board_no)+1
FROM    board;


























