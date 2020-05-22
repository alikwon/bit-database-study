 --평균 급여를 구하는 쿼리문을 서브 쿼리로 사용하여 
 --평균 급여보다 더 많은 급여를 받는 사원을 검색하는 문장
 SELECT ENAME, SAL 
 FROM EMP 
 WHERE SAL > ( SELECT AVG(SAL) FROM EMP);
 
 --그룹함수 못 씀
 select ename, sal
 from emp
 where sal > avg(sal);
 
 --3000 이상 받는 사원이 소속된 부서(10번, 20번)와 
 --동일한 부서에서 근무하는 사원이기에 서브 쿼리의 결과 중에서 
 --하나라도 일치하면 참인 결과를 구하는 IN 연산자와 함께 사용되어야 합니다
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN ( SELECT DISTINCT DEPTNO
                  FROM EMP
                  WHERE SAL>=3000);
                  
--30번 소속 사원들 중에서 급여를 가장 많이 받는 사원보다 
--더 많은 급여를 받는 사람의 이름, 급여를 출력
select ename, sal, deptno
from emp
where sal > all(select sal
                from emp
                where deptno =30);

--부서번호가 30번인 사원들의 급여 중 
--가장 작은 값(950)보다 많은 급여를 받는 사원의 이름, 급여를 출력
select ename, sal, deptno
from emp
where sal > (select min(sal) from emp where deptno=30)
order by ename;

select ename, sal, deptno
from emp
where sal > any (select sal from emp where deptno=30)
order by ename;

-- rownow : 입력순서에 따른 번호
select rownum, ename
from emp;

--스칼라 서브쿼리
-- 마당 서점의 고객별 판매액
select name, sum(saleprice)
from orders o inner join customer c
on o.custid= c.custid
group by name;

select custid, 
       (select name 
       from customer cs 
       where cs.custid = od.custid)  "name", 
       sum(saleprice)"총액"
from orders od
group by custid;

--고객번호가 2 이하인 고객의 판매액을 보이시오 
--(결과는 고객이름과 고객별 판매액 출력)
select *
from customer
where custid<=2;

select cs.name, sum(od.saleprice)
from customer cs, orders od
where cs.custid = od.custid and od.custid <=2
group by cs.name;

select rownum, ename from emp; -- 기존 rownum

-- 이름순으로 rownum을 재정렬
-- inline view : 논리적인 테이블
select rownum,ename, empno, sal
from (select ename, empno, job, deptno, sal from emp order by sal desc) 
where rownum <=3;

-------------------------------
-- 중첩서브쿼리
--평균 주문금액(subquery로 만듦) 이하의 주문에 대해서 주문번호와 금액을 보이시오.
select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice) from orders);

--각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 
--주문번호, 고객번호, 금액을 보이시오.
select orderid, custid, saleprice
from orders od
where saleprice > (select avg(saleprice)
from orders so
where od.custid = so.custid);

--대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
select custid from customer where address like '%대한민국%';

select sum(saleprice) 
from orders 
where custid in(select custid 
                from customer 
                where address like '%대한민국%');

--3번 고객이 주문한 도서의 최고 금액보다 
--더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
select max(saleprice) from orders where custid=3;

select orderid, saleprice
from orders
where saleprice > (select max(saleprice) from orders where custid=3);

-- all 사용
select orderid, saleprice
from orders
where saleprice > all(select saleprice from orders where custid=3);

--EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
select *
from customer
where address like '%대한민국%';

select o.custid ,saleprice
from orders o
where exists (select *
              from customer c
              where address like '%대한민국%' and o.custid = c.custid)
;