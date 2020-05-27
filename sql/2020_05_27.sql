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