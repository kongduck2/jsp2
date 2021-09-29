-- 자유게시판 : 테이블 2개 (메인글저장, 댓글저장)

create table freeboard(
	idx int 				not null auto_increment,
	name varchar(30) 		not null,					-- 작성자 
	password varchar(10) 	not null,					-- 글 비밀번호(필요할때만 사용)
	subject varchar(40) 	not null,					-- 글 제목
	content varchar(2000) 	not null,					-- 내용
	readCount int 			default 0,					-- 조회수
	wdate datetime 			default current_timestamp,	-- 서버의 현재날짜/시간
	ip varchar(15)			default '127.0.0.1',		-- 작성자 ip
	commentCount smallint 	default 0,					-- 댓글 갯수
	primary key(idx)
);


insert into freeboard (name,password,subject,content,ip)
values ('honey','1111','웰컴','안녕 반가워','192.168.17.3');
insert into freeboard (name,password,subject,content,ip)
values ('비둘기','2222','구구구구','안녕하세요 비둘기입니다','192.168.22.3');
insert into freeboard (name,password,subject,content,ip)
values ('개구리','3333','개굴','안녕하세요 산개구리입니다','192.168.24.3');
insert into freeboard (name,password,subject,content,ip)
values ('코끼리','4444','뿌우우우','안녕 나는 코끼리야','192.168.28.3');
insert into freeboard (name,password,subject,content,ip)
values ('사자','5555','어흥','사자임','192.168.26.4');
insert into freeboard (name,password,subject,content,ip)
values ('햄스터','6666','찍찍','쥐임','192.168.22.1');
insert into freeboard (name,password,subject,content,ip)
values ('고양이','7777','야옹','고영희','192.168.27.6');

select * from freeboard ;

alter table freeboard modify column wdate timestamp
default current_timestamp; -- timezone에 따라 설정

-- mysql 에는 limit 키워드 : limit 번호,갯수
-- mysql,oracle select 결과에 대해 각행에 순서대로 번호를 부여하는 컬럼(row num)이 만들어 진다.
-- limit의 번호는 row num 이다.(mysql은 0부터 시작)
select * from freeboard order by idx desc;
select * from freeboard order by idx desc limit 0,15; -- 1page 목록
select * from freeboard order by idx desc limit 15,15; -- 2page 목록
select * from freeboard order by idx desc limit 30,15; -- 3page 목록
-- 계산식 : n=10 페이지 글은? (n-1)*15
select * from freeboard order by idx desc limit 135,15; -- 10page 목록
commit;

-- 글 수정 : subject , content 수정. idx 컬럼을 조건으로 한다.
update freeboard set subject = '애옹애옹' ,content = '애요오오옹!!' where idx = 140 ;


-- 조회수 변경 : 읽을 때마다(url 요청 발생) 카운트 +1
update freeboard set readCount = readCount +1 where idx=140;

-- 글 삭제 : 글 비밀번호 1)있을 때 2) 없을때
delete from freeboard where idx=139 and password = '0000';
delete from freeboard where idx=139;
commit;

-- 글 비밀번호 체크
select * from freeboard f where idx=159 and password ='1111'; -- 잘못된 비밀번호
select * from freeboard f where idx=140 and password ='7777'; -- 올바른 비밀번호 

-- 댓글 테이블 :board_comment
create table board_comment(
	idx int 				not null auto_increment,
	mref int 				not null,					-- 메인글(부모글)의 idx값		
	name varchar(30) 		not null,					-- 작성자 
	password varchar(10) 	not null,					-- 글 비밀번호(필요할때만 사용)
	content varchar(2000) 	not null,					-- 내용
	wdate datetime 			default current_timestamp,	-- 서버의 현재날짜/시간
	ip varchar(15)			default '127.0.0.1',		-- 작성자 ip
	primary key(idx),
	foreign key(mref) references freeboard(idx)
);

-- 1)
insert into board_comment(mref,name,password,content,ip)
values (142,'악어새','1234','뭐하셈','192.168.11.12');
insert into board_comment(mref,name,password,content,ip)
values (142,'비버','12345','악어야 뭐하냐','192.168.22.8');
insert into board_comment(mref,name,password,content,ip)
values (142,'하마','1234','밥먹으러 가자','192.168.10.16');
insert into board_comment(mref,name,password,content,ip)
values (141,'뱀','1234','호랑아 모해','192.168.12.16');
insert into board_comment(mref,name,password,content,ip)
values (141,'토끼','1234','호랑이 생일 ㅊㅋ','192.168.10.28');

-- 댓글 개수 (글목록에서 필요하다.)
select count(*) from board_comment where mref = 142;	-- 142번글의 댓글 갯수
select count(*) from board_comment where mref = 141;	-- 141번글의 댓글 갯수

-- 2) 댓글 리스트
select * from board_comment where mref = 142; 
select * from board_comment where mref = 141;

-- 3) 글목록 실행하는 dao.getList() 보다 앞에서 댓글갯수를 update 
update freeboard set commentCount=(
select count(*) from board_comment where mref = 142) where idx =142;
update freeboard set commentCount=(
select count(*) from board_comment where mref = 141) where idx =141;

-- 4) 글 상세보기에서 댓글 입력 후 저장할 때
update freeboard set commentCount=commentCount+1 where idx = 142 ;





