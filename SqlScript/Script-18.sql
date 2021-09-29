-- �����Խ��� : ���̺� 2�� (���α�����, �������)

create table freeboard(
	idx int 				not null auto_increment,
	name varchar(30) 		not null,					-- �ۼ��� 
	password varchar(10) 	not null,					-- �� ��й�ȣ(�ʿ��Ҷ��� ���)
	subject varchar(40) 	not null,					-- �� ����
	content varchar(2000) 	not null,					-- ����
	readCount int 			default 0,					-- ��ȸ��
	wdate datetime 			default current_timestamp,	-- ������ ���糯¥/�ð�
	ip varchar(15)			default '127.0.0.1',		-- �ۼ��� ip
	commentCount smallint 	default 0,					-- ��� ����
	primary key(idx)
);


insert into freeboard (name,password,subject,content,ip)
values ('honey','1111','����','�ȳ� �ݰ���','192.168.17.3');
insert into freeboard (name,password,subject,content,ip)
values ('��ѱ�','2222','��������','�ȳ��ϼ��� ��ѱ��Դϴ�','192.168.22.3');
insert into freeboard (name,password,subject,content,ip)
values ('������','3333','����','�ȳ��ϼ��� �갳�����Դϴ�','192.168.24.3');
insert into freeboard (name,password,subject,content,ip)
values ('�ڳ���','4444','�ѿ���','�ȳ� ���� �ڳ�����','192.168.28.3');
insert into freeboard (name,password,subject,content,ip)
values ('����','5555','����','������','192.168.26.4');
insert into freeboard (name,password,subject,content,ip)
values ('�ܽ���','6666','����','����','192.168.22.1');
insert into freeboard (name,password,subject,content,ip)
values ('�����','7777','�߿�','����','192.168.27.6');

select * from freeboard ;

alter table freeboard modify column wdate timestamp
default current_timestamp; -- timezone�� ���� ����

-- mysql ���� limit Ű���� : limit ��ȣ,����
-- mysql,oracle select ����� ���� ���࿡ ������� ��ȣ�� �ο��ϴ� �÷�(row num)�� ����� ����.
-- limit�� ��ȣ�� row num �̴�.(mysql�� 0���� ����)
select * from freeboard order by idx desc;
select * from freeboard order by idx desc limit 0,15; -- 1page ���
select * from freeboard order by idx desc limit 15,15; -- 2page ���
select * from freeboard order by idx desc limit 30,15; -- 3page ���
-- ���� : n=10 ������ ����? (n-1)*15
select * from freeboard order by idx desc limit 135,15; -- 10page ���
commit;

-- �� ���� : subject , content ����. idx �÷��� �������� �Ѵ�.
update freeboard set subject = '�ֿ˾ֿ�' ,content = '�ֿ������!!' where idx = 140 ;


-- ��ȸ�� ���� : ���� ������(url ��û �߻�) ī��Ʈ +1
update freeboard set readCount = readCount +1 where idx=140;

-- �� ���� : �� ��й�ȣ 1)���� �� 2) ������
delete from freeboard where idx=139 and password = '0000';
delete from freeboard where idx=139;
commit;

-- �� ��й�ȣ üũ
select * from freeboard f where idx=159 and password ='1111'; -- �߸��� ��й�ȣ
select * from freeboard f where idx=140 and password ='7777'; -- �ùٸ� ��й�ȣ 

-- ��� ���̺� :board_comment
create table board_comment(
	idx int 				not null auto_increment,
	mref int 				not null,					-- ���α�(�θ��)�� idx��		
	name varchar(30) 		not null,					-- �ۼ��� 
	password varchar(10) 	not null,					-- �� ��й�ȣ(�ʿ��Ҷ��� ���)
	content varchar(2000) 	not null,					-- ����
	wdate datetime 			default current_timestamp,	-- ������ ���糯¥/�ð�
	ip varchar(15)			default '127.0.0.1',		-- �ۼ��� ip
	primary key(idx),
	foreign key(mref) references freeboard(idx)
);

-- 1)
insert into board_comment(mref,name,password,content,ip)
values (142,'�Ǿ��','1234','���ϼ�','192.168.11.12');
insert into board_comment(mref,name,password,content,ip)
values (142,'���','12345','�Ǿ�� ���ϳ�','192.168.22.8');
insert into board_comment(mref,name,password,content,ip)
values (142,'�ϸ�','1234','������� ����','192.168.10.16');
insert into board_comment(mref,name,password,content,ip)
values (141,'��','1234','ȣ���� ����','192.168.12.16');
insert into board_comment(mref,name,password,content,ip)
values (141,'�䳢','1234','ȣ���� ���� ����','192.168.10.28');

-- ��� ���� (�۸�Ͽ��� �ʿ��ϴ�.)
select count(*) from board_comment where mref = 142;	-- 142������ ��� ����
select count(*) from board_comment where mref = 141;	-- 141������ ��� ����

-- 2) ��� ����Ʈ
select * from board_comment where mref = 142; 
select * from board_comment where mref = 141;

-- 3) �۸�� �����ϴ� dao.getList() ���� �տ��� ��۰����� update 
update freeboard set commentCount=(
select count(*) from board_comment where mref = 142) where idx =142;
update freeboard set commentCount=(
select count(*) from board_comment where mref = 141) where idx =141;

-- 4) �� �󼼺��⿡�� ��� �Է� �� ������ ��
update freeboard set commentCount=commentCount+1 where idx = 142 ;





