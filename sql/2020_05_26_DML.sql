--2020 . 05. 26 

----------------------------------------------
-- DML
----------------------------------------------

drop table dept01;
create table dept01
as 
select * from dept where 1<0
;

-- 새로운 부서 정보를 입력 : 행단위 입력
-- insert into 테이블 이름 (입력하고자 하는 컬럼) values(데이터들)
-- 입력컬럼의 순서와 입력 데이터의 순서는 같아야 한다.

insert into dept01 (deptno, dname, loc) values (10, 'MARKETING', 'SEOUL');
insert into dept01 values (20, 'DESIGN', 'BUSAN');
insert into dept01 (loc, deptno, dname) values ('LONDON', 30, 'SALES');
insert into dept01(deptno, dname) values(40, 'DEV');
desc dept01;

select * from dept01;

----------------------------

create table dept02(
	deptno number(2) not null,
	dname varchar2(20) not null,
	loc varchar2(20) default 'SEOUL'
);
insert into dept02 (deptno, dname, loc) values (10, 'MARKETING', 'SEOUL');
insert into dept02 (deptno, dname, loc) values (20, 'MARKETING', null);
insert into dept02 (deptno, dname, loc) values (30, 'MARKETING', ''); -- 공백 ==> null
insert into dept02(deptno, dname) values(40, 'DEV');

select * from dept02;
desc dept02;