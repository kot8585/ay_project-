# ay_project-

```
  drop table reply CASCADE CONSTRAINTS;
CREATE TABLE reply(
    num NUMBER PRIMARY KEY NOT NULL,
    qna_num NUMBER NOT NULL REFERENCES qna(num) on delete CASCADE,
    writer VARCHAR2(20) NOT NULL,
    content VARCHAR2(1000), 
    r_date date,
    path varchar2(500)
);

create SEQUENCE seq_qna;
drop table qna CASCADE CONSTRAINTS;
CREATE TABLE qna(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(20) REFERENCES member(id) on delete CASCADE,
	
    q_cate VARCHAR2(50) NOT NULL,
    pwd VARCHAR2(50),
    title VARCHAR2(50) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    state VARCHAR2(50) NOT NULL,
    regdate date default sysdate,
    updatedate date default sysdate,
   path VARCHAR2(50) DEFAULT ''
    );
    
    drop table board CASCADE CONSTRAINTS;
create table board(
    num NUMBER PRIMARY KEY,
    type VARCHAR2(20) NOT NULL, 
    writer VARCHAR2(20) NOT NULL REFERENCES admin(id) on delete CASCADE, 
    title VARCHAR2(50) NOT NULL,
    content VARCHAR2(1000), 
    regdate date default sysdate,
    updatedate date default sysdate
);

NSERT INTO board VALUES(seq_board.nextval, 'faq', 'admin', '자주묻는 질문1', '자주묻는 내용1', sysdate, sysdate);
INSERT INTO board VALUES(seq_board.nextval, 'faq', 'admin', '자주묻는 질문2', '자주묻는 내용2', sysdate, sysdate);
INSERT INTO board VALUES(seq_board.nextval, 'faq', 'admin', '자주묻는 질문3', '자주묻는 내용3', sysdate, sysdate);
INSERT INTO board VALUES(seq_board.nextval, 'faq', 'admin', '자주묻는 질문4', '자주묻는 내용4', sysdate, sysdate);
INSERT INTO board VALUES(seq_board.nextval, 'faq', 'admin', '자주묻는 질문5', '자주묻는 내용5', sysdate, sysdate);
INSERT INTO board VALUES(seq_board.nextval, 'faq', 'admin', '자주묻는 질문6', '자주묻는 내용6', sysdate, sysdate);

INSERT INTO board VALUES(seq_board.nextval, 'notice', 'admin', '공지사항1', '공지사항내용입니다1', sysdate, sysdate);
INSERT INTO board VALUES(seq_board.nextval, 'notice', 'admin', '공지사항2', '공지사항내용입니다2', sysdate, sysdate);
INSERT INTO board VALUES(seq_board.nextval, 'notice', 'admin', '공지사항3', '공지사항내용입니다3', sysdate, sysdate);
INSERT INTO board VALUES(seq_board.nextval, 'notice', 'admin', '공지사항4', '공지사항내용입니다4', sysdate, sysdate);
INSERT INTO board VALUES(seq_board.nextval, 'notice', 'admin', '공지사항5', '공지사항내용입니다5', sysdate,sysdate);
commit; 
