--데이터 딕셔너리 TAB
--  : 테이블의 정보를 알려줌
 select * from tab;

-- null 값 표현하는 nvl
select ename ||'의 Final Sal 은 '|| (sal*12+nvl(comm, 0)) as "final sal" from emp;

-- 두컬럼 distinct 는 c1의 값에 해당하는 c2가 다르면 중복되지 않은걸로 침
select distinct deptno, job
from emp
order by deptno;

-- sal 정렬 후 같은 sal있을때 이름 정렬
select *
from emp
order by sal,ename;

select initcap('qeWERsfdbEFJjhGjh')
from dual;


select ename, deptno, rpad(substr(ename,0,2), length(ename), '*')
from emp;

select nvl2(comm, sal+comm, sal) as comm
from emp;

select avg(sal), '10' as deptno from emp where deptno=10;

select deptno,job,avg(sal), count(*)
from emp
where sal <2000
group by deptno, job
having avg(sal) < 3000
order by deptno;

