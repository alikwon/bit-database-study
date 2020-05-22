---------------------------------
--조인(JOIN)
---------------------------------
select *
from emp, dept;

------------------------------------
-- Equi Join : 동일 컬럼 기준으로 join
select ename, dname
from emp, dept
where emp.deptno = dept.deptno; --emp에있는 deptno와 dept에 있는 deptno를 join

select ename, dname, e.deptno, d.deptno
from emp e, dept d --별칭 사용
where e.deptno = d.deptno; 

---------------------------
-- Cross Join : 스키마 결합
select *
from orders o, book b, customer c;

select *
from orders o, book b, customer c
where o.bookid= b.bookid and o.custid = c.custid;

----------------------------
-- Non-Rqui Join
--   : 조인 조건에 특정범위 내에 있는지 조사(비교연산)
select * from emp;
select * from salgrade;

select e.ename, e.sal, s.grade
from emp e , salgrade s
where sal between losal and hisal
;

------------------------------
-- Self Join
-- 관리자의 이름을 알아보기

select *
from emp e, emp m
where e.mgr = m.empno; -- null 이기때문에 비교가 되지 않을수 있다

select e.ename || '의 상사는' || m.ename || '입니다'
from emp e, emp m
where e.mgr = m.empno;

-- outer join
select e.ename, e.empno, e.sal, e.comm, nvl(m.ename,'(관리자없음)')
from emp e, emp m
where e.mgr = m.empno(+);


-- ANSI Inner Join
select ename, dname
from emp inner join dept
on emp.deptno = dept.deptno;

select ename, dname
from emp inner join dept
using(deptno);

select *
from emp e left outer join emp m
on e.mgr = m.empno
order by e.ename;

