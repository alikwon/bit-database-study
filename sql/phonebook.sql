-- ===== 전화번호 부( Contact )

-- 대리키 : 일련번호 -> pIdx

-- 이름, 전화번호, 주소, 이메일 <- 기본정보

-- 주소값과 이메일은 입력이 없을 때 기본값 입력

-- 친구의 타입 (카테고리) : univ, com, cafe 세가지 값만 저장 가능

------ 선택 정보
-- 전공, 학년
-- 회사이름, 부서이름, 직급
-- 모임이름, 닉네임
drop table pbook;
create table PBook(
	pidx number(6) constraint contact01_pidx_pk primary key,
	name varchar2(20) constraint contact01_name_nn not null,
	phonenumber varchar2(20) constraint contact01_pnumber_nn not null ,
	address varchar2(20) default '입력없음' constraint contact01_address_nn not null,
	email varchar2(20) default '입력없음' constraint contact01_email_nn not null,
	category varchar2(10) constraint contact01_category_ck check(category in('univ', 'com', 'cafe')),
	
	major varchar2(10),
	grade number(2),
	company varchar2(10),
	dept varchar2(10),
	job varchar2(20),
	cafename varchar2(20),
	nickname varchar2(20)
);

alter table pbook
modify(cafename varchar2(20));
---------------------------------------------------------

-- 입력 SQL작성
desc pbook;
select * from pbook;

-- 기본 정보 입력
insert into pbook(pidx,name,phonenumber,address,category) 
	values (1,'손흥민','010-1111-1111', 'ENGLAND',null);
-- 학교 친구 정보 입력
insert into pbook(pidx,name, phonenumber,address,category,major,grade)
	values (2, '개똥이', '010-2222-2222', 'SEOUL', 'univ', 'computer', 3);
-- 회사 친구 정보 입력
insert into pbook(pidx,name,phonenumber,address,category,company,dept,job)
	values(3, '박지성', '010-3333-3333', 'SEOUL', 'com', 'AIAcademy', 'A','MANAGER');
-- 모임 친구 정보 입력
insert into pbook(pidx,name,phonenumber,address,category,cafename,nickname)
	values(4, '권현준', '010-4444-4444', 'SUWON', 'cafe','Programming','KHJ');

update pbook
set email ='son@naver'
where name ='손흥민';


---------------------------------------------
-- 1. 기본 정보 출력
select pidx, name, phonenumber from pbook;

-- 2. 대학친구 정보 출력
select name, phonenumber, major, grade 
from pbook
where category = 'univ';

--3. 회사친구 정보 출력
select name, phonenumber, company, dept, job 
from pbook
where category = 'com';

--4. 모임친구 정보 출력
select name, phonenumber, cafename, nickname 
from pbook
where category = 'cafe';