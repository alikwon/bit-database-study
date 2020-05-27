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


--------------------------------------
--2020 . 05, 27
--------------------------------------
-- 서브쿼리를 이용해서 여러 테이블에 한번에 데이터 삽입
-- 테스트 테이블 emp_hir : empno, ename, hiredate
-- 테스트 테이블 emp_mgr : empno, ename, mgr

create table emp_hir
as
select empno, ename, hiredate from emp where 1<0;

create table emp_mgr
as
select empno, ename, mgr from emp where 1<0;

desc emp_hir;
desc emp_mgr;

-- 두개 테이블에 emp 테이블의 데이터를 기반으로 삽입
insert all
into emp_hir values (empno, ename, hiredate)
into emp_mgr values (empno, ename, mgr)
select empno, ename, hiredate, mgr
from emp
--where deptno=20
;
drop table emp_hir;
drop table emp_mgr;
select * from emp_hir;
select * from emp_mgr;

--
--INSERT ALL 명령문에 WHEN 절을 추가해서 조건을 제시하여 
--조건에 맞는 행만 추출하여 테이블에 추가합니다.
--EMP_HIR02 테이블에는 1982 년 01 월01 일 이후에 입사한 사원들의 
--번호, 사원 명, 입사일을 추가합니다.
--EMP_SAL 테이블에는 급여가 2000 이상인 사원들의 
--번호, 사원 명, 급여를 추가합니다.
create table emp_hir02
as
select empno, ename, hiredate from emp where 1<0
;
create table emp_sal
as
select empno, ename, sal from emp where 1<0
;
insert all
when hiredate > '1982/01/01' then
	into emp_hir02 values(empno, ename, hiredate)
when sal>=2000 then
	into emp_sal values(empno, ename, sal)
select empno, ename, hiredate, sal
from emp
;

select * from emp_hir02;
select * from emp_sal;









