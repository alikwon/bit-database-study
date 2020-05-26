drop table phoneinfo_basic;
drop table phoneinfo_univ;
drop table phoneinfo_com;

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
	constraint phoneinfo_univ_idx_fk foreign key(fr_ref) references phoneinfo_basic(idx)
);
create table phoneinfo_com(
	idx number(6) primary key,
	fr_u_company varchar2(20) default 'N' not null,
	fr_ref number(6) not null,
	constraint phoneinfo_com_idx_fk foreign key(fr_ref) references phoneinfo_basic(idx)
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
select * from phoneinfo_basic;
select * from phoneinfo_com;
select * from phoneinfo_univ;


-- 친구 전체 목록 출력
select *
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

-- 전체친구 기본정보 출력
select *
from phoneinfo_basic;

-- 대학 친구 목록
select *
from phoneinfo_basic b right outer join phoneinfo_univ u
on b.idx = u.fr_ref ;

-- 회사 친구 목록
select *
from phoneinfo_basic b right outer join phoneinfo_com c
on b.idx = c.fr_ref;