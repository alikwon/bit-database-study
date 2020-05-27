drop table phoneinfo_basic;
drop table phoneinfo_univ;
drop table phoneinfo_com;
-- 외래키 설정시에 상위테이블의 행이 삭제될 때를 설정
-- reference phoneinfo_basic(idx) on delete 설정 옵션
-- 	no action : 모두 삭제 불가
--	cascade 	: 참조하고 있는 하위 테이블의 모든 행도 같이 삭제
--	set null	: 참조하고 있는 자식테이블의 모든 행의 외래키 컬럼의 값을 null로 변경
-- 	set default : 참조하고 있는 자식테이블의 모든 행의 외래키 컬럼의 값을 기본값으로 변경

create table phoneinfo_basic(
	idx number(6) primary key,
	fr_name varchar2(20) not null,
	fr_phonenumber varchar2(20) not null,
	fr_email varchar2(20),
	fr_address varchar2(20),
	fr_regdate date default sysdate
);
create table phoneinfo_univ(
	idx number(6) primary key,
	fr_u_major varchar2(20) default 'N' not null,
	fr_u_year number(1) default '1' check(fr_u_year between 1 and 4) not null,
	fr_ref number(1) not null,
	constraint phoneinfo_univ_idx_fk foreign key(fr_ref) 
		references phoneinfo_basic(idx) on delete cascade
);
create table phoneinfo_com(
	idx number(6) primary key,
	fr_u_company varchar2(20) default 'N' not null,
	fr_ref number(6) not null,
	constraint phoneinfo_com_idx_fk foreign key(fr_ref) 
		references phoneinfo_basic(idx) on delete cascade
);
-- 기본정보
insert into phoneInfo_basic (idx,fr_name, fr_phonenumber, fr_email, fr_address)
	values (1,'손흥민','010-1111-1111','son@naver.com','영국');
insert into phoneinfo_basic (idx,fr_name,fr_phonenumber,fr_email,fr_address,fr_regdate) 
	values (2, '박지성','010-2222-2222','jisung@naver.com','서울','20/01/01');
insert into phoneinfo_basic (idx, fr_name, fr_phonenumber) 
	values (3, '권재준','010-3333-3333');
insert into phoneinfo_basic (idx, fr_name, fr_phonenumber, fr_address, fr_regdate) 
	values (4, '권소영', '010-4444-4444','오산', '19/12/12');
insert into phoneinfo_basic (idx, fr_name, fr_phonenumber, fr_email, fr_address, fr_regdate) 
	values (5, '정웅종', '010-5555-5555','ung@naver.com','성남', '20/05/26');

-- 학교정보 insert
insert into phoneinfo_univ (idx, fr_u_major,fr_u_year ,fr_ref)
	values (1,'COMPUTER',4,1);
insert into phoneinfo_univ (idx, fr_ref) 
	values (2, 2);
insert into phoneinfo_univ 
	values (3, 'ELECTRONIC', 3, 4);

-- 회사정보 insert
insert into phoneinfo_com (idx,fr_u_company , fr_ref)
	values ( 1,'AIACADEMY',1);
insert into phoneinfo_com 
	values (2, 'SBS', 5);
insert into phoneinfo_com (idx, fr_ref) 
	values (3, 3);


-------------------------------
-- 친구 전체 목록 출력
select rownum, b.idx,b.FR_NAME
from phoneinfo_basic b, phoneinfo_univ u, phoneinfo_com c
where b.idx = u.fr_ref(+) and b.idx = c.fr_ref(+);
-- ANSI join 사용
select *
from phoneinfo_basic b 
left outer join phoneinfo_univ u
on b.idx = u.fr_ref
left outer join phoneinfo_com c
on b.idx = c.fr_ref
;

--view : pb_all_view
create or replace view pb_all_view
as
select 
	b.IDX IDX,
	b.FR_NAME FR_NAME,
	b.FR_PHONENUMBER FR_PHONENUMBER,
	b.FR_EMAIL FR_EMAIL,
	b.FR_ADDRESS FR_ADDRESS,
	b.FR_REGDATE FR_REGDATE,
	u.IDX IDX_0,
	u.FR_U_MAJOR FR_U_MAJOR,
	u.FR_U_YEAR FR_U_YEAR,
	u.FR_REF FR_REF,
	c.IDX IDX_1,
	c.FR_U_COMPANY FR_U_COMPANY,
	c.FR_REF FR_REF_2
from phoneinfo_basic b, phoneinfo_univ u, phoneinfo_com c
where b.idx = u.fr_ref(+) and b.idx = c.fr_ref(+);

-- 전체친구 기본정보 출력
select *
from phoneinfo_basic;

-- 대학 친구 목록
select *
from phoneinfo_basic b join phoneinfo_univ u
on b.idx = u.fr_ref ;

--view : pb_univ_view
create or replace view pb_univ_view
as
select 
	b.IDX IDX,
	b.FR_NAME FR_NAME,
	b.FR_PHONENUMBER FR_PHONENUMBER,
	b.FR_EMAIL FR_EMAIL,
	b.FR_ADDRESS FR_ADDRESS,
	b.FR_REGDATE FR_REGDATE,
	u.IDX IDX_0,
	u.FR_U_MAJOR FR_U_MAJOR,
	u.FR_U_YEAR FR_U_YEAR,
	u.FR_REF FR_REF
from phoneinfo_basic b join phoneinfo_univ u
on b.idx = u.fr_ref ;

-- 회사 친구 목록
select *
from phoneinfo_basic b join phoneinfo_com c
on b.idx = c.fr_ref;

--view : pb_com_view
create or replace view pb_com_view
as
select 
	b.IDX IDX,
	b.FR_NAME FR_NAME,
	b.FR_PHONENUMBER FR_PHONENUMBER,
	b.FR_EMAIL FR_EMAIL,
	b.FR_ADDRESS FR_ADDRESS,
	b.FR_REGDATE FR_REGDATE,
	c.IDX IDX_0,
	c.FR_U_COMPANY FR_U_COMPANY,
	c.FR_REF FR_REF
from phoneinfo_basic b join phoneinfo_com c
on b.idx = c.fr_ref;
-----------------------------------------------------
-- 수정을 위한 SQL
---------------------------------------------------
--1. 회사 친구의 정보 변경
-- 기본정보 + 회사정보 변경
update phoneinfo_basic
set fr_email = 'son@gmail.com',
    fr_address = '서울',
    fr_phonenumber = '010-9999-9999'
where fr_name = '손흥민' 
	and fr_phonenumber like '%1111%1111%'
;
update phoneinfo_com
set fr_u_company = 'NAVER'
where fr_ref = (
	select idx
	from phoneinfo_basic
	where fr_name='손흥민'
		and fr_phonenumber like '%9999%9999%'
	)
;

--2. 학교 친구의 정보 변경 
update phoneinfo_univ
set  fr_u_major = 'PHYSICAL EDUCATION',
	fr_u_year = 4
where fr_ref = (
	select idx
	from phoneinfo_basic
	where fr_name = '박지성'
	)
;
commit;
---------------------------------------------------
-- 삭제를 위한 sql
---------------------------------------------------
select * from phoneinfo_basic;
select * from phoneinfo_univ;
select * from phoneinfo_com;
--1. 회사 친구 정보를 삭제
delete from phoneinfo_com
where fr_ref =(
	select idx
	from phoneinfo_basic
	where fr_name ='권재준' 
	and fr_phonenumber = '010-3333-3333'
	)
;
delete from phoneinfo_basic
where fr_name ='권재준' 
	and fr_phonenumber = '010-3333-3333'
;
--2. 학교 친구 정보를 삭제
delete from phoneinfo_univ
where fr_ref = (
	select idx
	from phoneinfo_basic
	where fr_name = '권소영'
	and fr_phonenumber like '%4444%4444%'
	)
;
delete from phoneinfo_basic
where fr_name = '권소영'
	and fr_phonenumber like '%4444%4444%'
;