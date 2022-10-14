--bbs.sql
--답변 및 댓글형 게시판

--테이블 삭제
drop table tb_bbs;

--테이블 생성
create table tb_bbs(
  bbsno    number(5)       not null -- 일련번호 -99999~99999
 ,wname    varchar2(20)    not null -- 작성자
 ,subject  varchar2(100)   not null -- 글제목
 ,content  varchar2(2000)  not null -- 글내용
 ,passwd   varchar2(10)    not null -- 글비밀번호
 ,readcnt  number(5)       default 0 not null -- 글조회수
 ,regdt    date            default  sysdate   -- 글작성일
 ,grpno    number(5)       not null  -- 글 그룹번호
 ,indent   number(5)       default 0 -- 들여쓰기
 ,ansnum   number(5)       default 0 -- 글순서
 ,ip       varchar2(15)    not null  -- 사용자 요청 PC의 IP
 ,primary key(bbsno)                 --bbsno 기본키 
);


--시퀀스 생성
create sequence bbs_seq;

--시퀀스 삭제
drop sequence bbs_seq;

--명령어 완료
commit;
/////////////////////////////////////////////////////////


--새글쓰기
bbsno                           : 시퀀스를 이용해서 일련번호
wname, subject, content, passwd : 사용자가 입력
readcnt, regdt, indent, ansnum  : default 값
ip                              : 요청 PC의 IP 저장
grpno                           : max(bbsno)+1



--그룹번호(grpno) 만들기
select max(bbsno) from tb_bbs;
 --null값이면 계산 안됨
select max(bbsno)+1 from tb_bbs;
--nvl()함수를 이용해서 max(bbsno)값이 비어있을때(null) 0으로 바꿈
select nvl(max(bbsno),0) from tb_bbs;
--nvl()함수를 이용해서 max(bbsno)값이 비어있을때(null) 0으로 바꾼 후 +1
select nvl(max(bbsno),0)+1 from tb_bbs;


--행추가
insert into tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno)
values(bbs_seq.nextval, ?,?,?,?,?, (select nvl(max(bbsno),0)+1 from tb_bbs));


--전체목록
select bbsno, wname, subject, readcnt, regdt
from tb_bbs
order by grpno desc, ansnum asc;


--상세보기
select * from tb_bbs where bbsno=?


--행삭제
delete from tb_bbs where bbsno=? and passwd=?


--행수정
update tb_bbs set wname=?, subject=?, content=?, ip=?
where bbsno=? and passwd=?


--조회수 증가
update tb_bbs set readcnt=readcnt+1 
where bbsno=?
///////////////////////////////////////////////////////////


[답변쓰기 알고리즘]

- 새글 쓰기 : 최초의 부모글
- 답변 쓰기 : 자식글

- 그룹번호(grpno)  : 부모글 그룹번호와 동일하게
- 들여쓰기(indent) : 부모글 들여쓰기 + 1
- 글순서  (ansnum) : 부모글 글순서 + 1 한 후, 글순서 재조정


번호  제목            그룹번호 들여쓰기 글순서
1    제주도            1      0      0
2    서울시            2      0      0
     ▶종로구           2      1      1
     ▶▶관철동          2      2      2
     ▶▶▶보신각         2      3      3
     ▶▶인사동          2      2      4
     ▶강남구           2      1      5
     ▶▶도곡동          2      2      6
     ▶▶역삼동          2      2      6->7
     ▶마포구           2      1      7->8
3    부산시            3      0      0


- 글순서(ansnum) 재조정
update tb_bbs
set ansnum=ansnum+1
where grpno=2 and ansnum>=6
///////////////////////////////////////////////////////////


[검색]
-- 제목+내용에서 '파스타'가 있는지 검색
where subject like '%파스타%' or content like '%파스타%'

-- 제목에서 '파스타'가 있는지 검색
where subject like '%파스타%'

-- 내용에서 '파스타'가 있는지 검색
where content like '%파스타%'

-- 작성자에서 '파스타'가 있는지 검색
where wname like '%파스타%'

/////////////////////////////////////////////////////

[과제] 제목과 댓글(자식글)의 개수를 조회하시오 (indent칼럼명 참조)

      제목         답변갯수
     ---------  --------
      무궁화
      코리아         2
      점심시간       3
      한글날
      오필승
      
select subject, grpno, indent from tb_bbs order by grpno desc;

select grpno, count(*)
from tb_bbs
group by grpno;

select BB.subjeck, AA.reply
from(
		select grpno, count(*)-1 as reply
		from tb_bbs
		group by grpno
	) AA join tb_bbs BB
on AA.grpno=BB.grpno
where BB.indent=0
order by BB.grpno desc;



--출력 줄수
set pagesize 100;
--한줄 출력 글자개수
set linesize 100;
--칼럼길이 10칸 임시 조정
col wname for a10;
col subject for a20;


[페이징]
- rownum 줄번호 활용

1)
SELECT bbsno, subject, wname, readcnt, indent, regdt
FROM tb_bbs
ORDER BY grpno DESC, ansnum ASC;

2) rownum추가 - 줄번호까지 정렬됨
SELECT bbsno, subject, wname, readcnt, indent, regdt, rownum
FROM tb_bbs
ORDER BY grpno DESC, ansnum ASC;

3) 1)의 SQL문을 셀프조인하고, rownum 추가
SELECT bbsno, subject, wname, readcnt, indent, regdt, rownum
from (
		SELECT bbsno, subject, wname, readcnt, indent, regdt
		FROM tb_bbs
		ORDER BY grpno DESC, ansnum ASC
	);

4) 줄번호 1~5 조회 (1페이지)
SELECT bbsno, subject, wname, readcnt, indent, regdt, rownum
FROM (
		SELECT bbsno, subject, wname, readcnt, indent, regdt
		FROM tb_bbs
		ORDER BY grpno DESC, ansnum ASC
	)
WHERE rownum>=1 AND rownum<=5;

5) 줄번호 6~10 조회(2페이지) -> 조회안됨. 선택된 레코드가 없습니다
SELECT bbsno, subject, wname, readcnt, indent, regdt, rownum
FROM (
		SELECT bbsno, subject, wname, readcnt, indent, regdt
		FROM tb_bbs
		ORDER BY grpno DESC, ansnum ASC
	)
WHERE rownum>=6 AND rownum<=10;

6) 줄번호가 있는 3)의 테이블을 한번 더 셀프조인하고, rownum 칼럼명을 r을 바꾼다
SELECT *
FROM (
	SELECT bbsno, subject, wname, readcnt, indent, regdt, rownum as r
	from (
			SELECT bbsno, subject, wname, readcnt, indent, regdt
			FROM tb_bbs
			ORDER BY grpno DESC, ansnum ASC
		)
	)
WHERE r>=6 AND r<=10;

7) 페이징+검색
	예) 제목에서 '파스타'가 있는 행을 검색해서 2페이지(6행~10행) 조회하시오
SELECT *
FROM (
		SELECT bbsno, subject, wname, readcnt, indent, regdt, rownum as r
		from (
				SELECT bbsno, subject, wname, readcnt, indent, regdt
				FROM tb_bbs
				WHERE subject LIKE '%파스타%'
				ORDER BY grpno DESC, ansnum ASC
			)
		)
WHERE r>=6 AND r<=10;
	
