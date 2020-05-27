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


----------------------------------------
drop table emp01;

create table emp01
as
select * from emp
;

--컬럼의 데이터 변경(수정)
--update 테이블이름 set 컬럼이름1=값, 컬럼이름2=값, ...where 행을 찾는 조건식
-- where 절이 없는경우 모든행이 영향을 받는다
select * from emp01;
--1. 모든사원의 부서번호를 30번으로 수정하자.
update emp01
set deptno=30
;

--2. 모든사원의 급여를 10%인상시키자
update emp01
set sal = sal*1.1;

--3. 모든 사원의 입사일을 오늘로 수정시키자
update emp01
set hiredate = sysdate;

select * from emp01;

commit;

rollback; -- 마지막 커밋 시점으로 간다.
-----------------------------------------
--1. 부서번호가 10번인 사원의 deptno를 30번으로 수정
update emp01
set deptno = 30
where deptno =10;

-- 2. 급여가 3000이상인 사원만 10%인상
update emp01
set sal = sal *1.1
where sal >= 3000;

--3. 1987년에 입사한 사원의 입사일이 오늘로 수정합시다. 
--사원의 입사일을 오늘로 수정한 후에 테이블 내용을 살펴봅시다.
update emp01
set hiredate = sysdate
where substr(hiredate,1,2)='87'
;

-----------------------------
-- 복수 컬럼 값 변경
------------------------------
--1.SCOTT 사원의 부서번호는 10번으로, 
-- 직급은 MANAGER로 한꺼번에 수정하도록 합시다.
update emp01 
set deptno=10, job= 'MANAGER'
where ename = 'SCOTT';

--2.SCOTT 사원의 입사일자는 오늘로, 
-- 급여를 50 으로 커미션을 4000 으로 수정합시다.
update emp01
set sal= 50, comm=4000, hiredate = sysdate
where ename = 'SCOTT';

select * from emp01 where ename= 'SCOTT';

------------------------------------------
--서브쿼리로 데이터 수정

--1. 20번 부서의 지역명을 40번 부서의 지역명으로 변경하기 위해서 
-- 서브 쿼리문을 사용해 봅시다.
drop table dept01;
create table dept01
as
select * from dept;

update dept01
set loc = (
	select loc
	from dept01
	where deptno=40
	)
	where deptno=20;
select * from dept01;

--서브 쿼리를 이용해서 부서번호가 20인 부서의 부서명과 지역명을
-- 부서 번호가 40번인 부서와 동일하게 변경하도록 해 봅시다.
update dept01
set 
dname = (
	select dname
	from dept01 
	where deptno=40),
loc = (
	select loc
	from dept01
	where deptno=40)
where deptno=20
;

update dept01
set (dname, loc) = (
	select dname, loc 
	from dept
	where deptno=40)
where deptno=20
;

----------------------------------------
-- DELETE 문

--delete from 테이블명 where 조건
--where 절이 없으면 모든 테이블에 영향

-- 부서테이블의 모든행을 삭제
delete from dept01;
select * from dept01;
-- 물리적으로 삭제되는것이 아닌 논리적으로 삭제된 상태
-- commit 조건에 맞추는 것이 아닌이상 다른프로그램에서는 여전히 데이터 확인가능

--부서 테이블에서 30번 부서만 삭제
rollback;
delete from dept01
where deptno=30;
-- 삭제하는 특성은 최대한PK 기반으로 삭제하는것이 좋다
-- 은연중에 중복되는 데이터를 의도와는 다르게 같이 삭제할수 있기때문

--사원 테이블에서 부서명이 SALES인 사원을 모두 삭제
delete from emp01
where deptno = (
	select deptno 
	from dept01 
	where dname ='SALES')
;
select * from emp01;