--데이터 딕셔너리 TAB
--  : 테이블의 정보를 알려줌
 select * from tab;

-- null 값 표현하는 nvl
select ename ||'의 Final Sal 은 '|| (sal*12+nvl(comm, 0)) as "final sal" from emp;

-- 두컬럼 distinct 는 c1의 값에 해당하는 c2가 다르면 중복되지 않은걸로 침
select distinct deptno, job
from emp
order by deptno;

