 --1.덧셈연산자를 이용하여 모든 사원에 대해서 $300의 급여 인상을 계산한 후 
 --사원의 이름, 급여, 인상된 급여를 출력하시오.
 select ename, sal, sal+300
 from emp;
 
-- 2.사원의 이름, 급여, 연간 총 수입을 총 수입이 많은 것부터 작은 순으로 출력하시오,
-- 연간 총수입은 월급에 12를 곱한 후 $100의 상여금을 더해서 계산하시오.
select ename, sal, sal*12+100
from emp
order by sal desc;

--3.급여가 2000을 넘는 사원의 이름과 급여를 표현, 급여가 많은 것부터 작은 순으로 출력하시오.
select ename, sal
from emp
where sal >= 2000
order by sal desc;

--4.사원번호가 7788인 사원의 이름과 부서번호를 출력하시오.
select ename, deptno
from emp
where empno = 7788;

--5.급여가 2000에서 3000 사이에 포함되지 않는 사원의 이름과 급여를 출력하시오.
select ename, sal
from emp
where sal not between 2000 and 3000;

--6. 1981년 2월 20일 부터 1981년 5월 1일 사이에 입사한 사원의 이름, 담당업무, 입사일을 출력하시오
select ename, job, hiredate from emp
where hiredate between '1981/02/20' and '1981/05/01';

--7. 부서번호가 20 및 30에 속한 사원의 이름과 부서번호를 출력,
--이름을 기준(내림차순)으로 영문자순으로 출력하시오.
select ename, deptno from emp
where deptno=20 or deptno=30
order by ename desc;

--8. 사원의 급여가 2000에서 3000사이에 포함되고 
--부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력, 이름순(오름차순)으로 출력하시오.
select ename, sal, deptno from emp
where sal between 2000 and 3000 and deptno in(20,30)
order by ename;

--9. 1981년도에 입사한 사원의 이름과 입사일을 출력하시오. (like 연산자와 와일드카드 사용)
select ename, hiredate from emp
where hiredate like '81%';

--10. 관리자가 없는 사원의 이름과 담당 업무를 출력하시오.
select ename, job from emp
where mgr is null;

--11. 커미션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되
--급여 및 커미션을 기준으로 내림차순 정렬하여 표시하시오.
select ename, sal, comm from emp
where comm is not null
order by sal desc, comm desc;

--12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오.
select ename from emp
where ename like '__R%';

--13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하시오.
select ename from emp
where ename like '%A%' and ename like '%E%';

--14. 담당업무가 CLERK, 또는 SALESMAN이면서 
--급여가 $1600, $950 또는 $1300이 아닌 사원의 이름, 담당업무, 급여를 출력하시오.
select ename, job, sal from emp
where job in('CLERK','SALESMAN') and sal not in(1600,950,1300);

--15. 커미션이 $500 이상인 사원의 이름과 급여 및 커미션을 출력하시오.
select ename, sal, comm from emp
where comm>=500;


select ename, sal, nvl(comm,0) from emp
where comm <=500 or comm is null;

--16. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력하시오.
 select hiredate,substr(hiredate, 1, 5)
 from emp;
 
--17. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력하시오.
 select ename
 from emp
 where substr(hiredate,4,2) = 04;
 
--18. MOD 함수를 사용하여 사원번호가 짝수인 사람만 출력하시오.
 select ename, empno
 from emp
 where mod(empno,2)=0;
 
--19. 입사일을 년도는 2자리(YY), 월은 숫자(MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력하시오.
select hiredate, to_char(hiredate, 'YY.MM(MON) DY')
from emp;
 
--20. 올해 몇 칠이 지났는지 출력하시오.
--현재날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여 데이터 형을 일치 시키시오.
select trunc(sysdate - to_date('2020/01/01'))
from dual;
 
--21. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 NULL 값 대신 0으로 출력하시오.
select nvl(mgr,0)
from emp;

--22. DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 
--직급이 ‘ANALIST”인 사원은 200, ‘SALESMAN’인 사원은 180, 
--      ‘MANAGER’인 사원은 150, ‘CLERK”인 사원은 100을 인상하시오.
select ename, sal,
nvl(decode(job, 'ANALYST', sal+150,
            'SALESMAN', sal+180,
            'MANAGER', sal+150,
            'CLERK', sal+100),sal)
as "인상된 급여"
from emp;
 
--23. 모든 사원의 급여 최고액, 최저액, 총액 및 평균 급여를 출력하시오.
-- 평균에 대해서는 정수로 반올림하시오.
select max(sal) as "최고액",
       min(sal) as "최저액",
       sum(sal) as "총 액",
       round(avg(sal)) as "평균 액"
from emp;
 
--24. 각 담당 업무 유형별로 급여 최고액, 최저액, 총액 및 평균 액을 출력하시오. 
-- 평균에 대해서는 정수로 반올림 하시오.
select job as "업무 유형",
       max(sal) as "최고액",
       min(sal) as "최저액",
       sum(sal) as "총 액",
       round(avg(sal)) as "평균 액"
from emp
group by job;
 
--25. COUNT(*) 함수를 이용하여 담당업무가 동일한 사원 수를 출력하시오.
select job as "업무",count(*) as "사원 수"
from emp
group by job;
 
--26. 관리자 수를 나열하시오.
select count(distinct(mgr)) as "관리자수"
from emp;

--27. 급여 최고액, 급여 최저액의 차액을 출력하시오.
select max(sal)-min(sal) as "최고급여 최저급여 차액"
from emp;
 
--28. 직급별 사원의 최저 급여를 출력하시오. 
--관리자를 알 수 없는 사원의 최저 급여가 2000 미만인 그룹은 제외시키고 
--결과를 급여에 대한 내림차순으로 정렬하여 출력하시오.
select job, max(sal)
from emp
where mgr is not null
group by job
order by max(sal) desc;

--29. 각 부서에 대해 부서번호, 사원 수, 부서 내의 모든 사원의 평균 급여를 출력하시오. 
--평균 급여는 소수점 둘째 자리로 반올림 하시오.
select deptno, count(*) as "사원 수", 
               round(avg(sal),2) as "평균급여"
from emp
group by deptno;

--30. 각 부서에 대해 부서번호 이름, 지역 명, 사원 수, 부서내의 모든 사원의 평균 급여를 출력하시오. 
-- 평균 급여는 정수로 반올림 하시오. DECODE 사용.
select deptno,
decode(deptno, 10, 'ACCOUNTING',
               20, 'RESEARCH',
               30, 'SALES',
               40, 'OPERATIONS') as "DEPT NAME",
decode(deptno, 10, 'NEW YORK',
               20, 'DALLAS',
               30, 'CHICAGO',
               40, 'BOSTON') as "LOC",
               count(empno) as "사원 수", round(avg(sal)) as "평균급여"
from emp
group by deptno;
 
--31. 업무를 표시한 다음 해당 업무에 대해 
--부서 번호별 급여 및 부서 10, 20, 30의 급여 총액을 각각 출력하시오. 
--별칭은 각 job, dno, 부서 10, 부서 20, 부서 30, 총액으로 지정하시오. ( hint. Decode, group by )
select job, deptno as dno,
nvl(decode(deptno, 10, sum(sal)),0) as "부서10",
nvl(decode(deptno, 20, sum(sal)),0) as "부서20",
nvl(decode(deptno, 30, sum(sal)),0) as "부서30",
sum(sal)as 총액
from emp group by job, deptno order by deptno;

--32. EQUI 조인을 사용하여 SCOTT 사원의 부서번호와 부서 이름을 출력하시오.
select e.empno, d.dname
from emp e, dept d
where e.deptno = d.deptno;

-- ANSI Inner Join
select e.empno, d.dname
from emp e inner join dept d
using (deptno);

--33. INNER JOIN과 ON 연산자를 사용하여 사원 이름과 함께 
--그 사원이 소속된 부서이름과 지역 명을 출력하시오.
select e.ename, d.dname, d.loc
from emp e inner join dept d
on e.deptno = d.deptno;

select e.ename, d.dname, d.loc
from emp e inner join dept d
using (deptno);

select e.ename, d.dname, d.loc
from emp e natural join dept d
;

--36. 조인과 WildCARD를 사용하여 이름에 ‘A’가 포함된
--모든 사원의 이름과 부서명을 출력하시오.
select e.ename, d.dname
from emp e, dept d
where e.deptno=d.deptno and e.ename like '%A%';

select e.ename, d.dname
from emp e inner join dept d
on e.deptno=d.deptno and e.ename like '%A%';


--37. JOIN을 이용하여 NEW YORK에 근무하는 
--모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오.
select e.ename, e.job, d.deptno, d.dname
from emp e, dept d
where e.deptno=d.deptno and d.loc = 'NEW YORK';

select e.ename, e.job, d.deptno, d.dname
from emp e inner join dept d
on e.deptno=d.deptno and d.loc = 'NEW YORK';

select e.ename, e.job, d.deptno, d.dname
from emp e left outer join dept d
on e.deptno=d.deptno and d.loc = 'NEW YORK';
--38. SELF JOIN을 사용하여 사원의 이름 및 사원번호, 관리자 이름을 출력하시오.
select e.ename, e.empno, m.ename
from emp e, emp m
where e.mgr = m.empno;

select e.ename, e.empno, m.ename
from emp e cross join emp m
where e.mgr = m.empno;

--39. OUTER JOIN, SELF JOIN을 사용하여 
--관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력하시오.
select e.ename, e.empno, nvl(m.ename,'(없음)') as mgr
from emp e, emp m
where e.mgr = m.empno(+)
order by e.empno desc;

select e.ename, e.empno, nvl(m.ename,'(없음)') as mgr
from emp e left outer join emp m
on e.mgr = m.empno
order by e.empno desc;

--40. SELF JOIN을 사용하여 지정한 사원의 이름, 부서번호, 
--지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. ( SCOTT )
select e.ename, e.deptno, c.ename
from emp e, emp c
where e.ename = 'SCOTT' 
--and not e.ename=c.ename 
and c.ename != 'SCOTT'
and e.deptno= c.deptno;

--41. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 
--이름과 입사일을 출력하시오.
select c.ename as " WARD 보다 늦게입사한 사원" , c.hiredate 
from emp e, emp c
where e.hiredate < c.hiredate and e.ename='WARD'
order by hiredate;

--42. SELF JOIN 을 사용하여 관리자보다 먼저 입사한 모든 사원의 이름 및 
-- 입사일을 관리자의 이름 및 입사일과 함께 출력하시오.
select e.ename , e.hiredate, m.ename as mgr, m.hiredate
from emp e, emp m
where e.mgr = m.empno and e.hiredate < m.hiredate;

--subquery
--43. 사원 번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원 이름과 담당업무)하시오.
select ename, job
from emp
where job = (select job 
             from emp
             where empno = 7788) 
             and not empno = 7788; -- 7788은 표시 안함 

--44. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시하시오. 사원이름과 담당 업무
select ename, job
from emp
where sal > (select sal
             from emp
             where empno = 7499);
             
--45. 최소급여를 받는 사원의 이름, 담당업무 및 급여를 표시하시오. (그룹함수 사용)
select ename, job, sal
from emp
where sal = (select min(sal)
              from emp);

--46. 평균급여가 가장 적은 직급의 직급 이름과 직급의 평균을 구하시오.
select job, avg(sal)
from emp
group by job
having avg(sal) = (select min(avg(sal)) 
                   from emp
                   group by job);

--이중으로 서브쿼리
select job, avg(sal)
from emp
group by job
having avg(sal) =(select min(av)
                  from (select job, avg(sal) as av from emp group by job));

-- inline view, rownum 이용
select job, sal
from (select job, avg(sal) as sal 
      from emp 
      group by job 
      order by sal)
where rownum =1;            

--47. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
select ename, sal, deptno 
from emp e
where sal in (select min(sal) from emp group by deptno)
order by deptno; 


--48. 담당업무가 ANALYST 인 사원보다 급여가 적으면서 
--업무가 ANALYST가 아닌 사원들을 표시(사원번호, 이름, 담당 업무, 급여)하시오.
select e.empno,e.ename,e.job,e.sal
from emp e
where sal < any(select m.sal 
                from emp m
                where m.job = 'ANALYST') 
      and job != 'ANALYST'
order by e.sal;

--49. 부하직원이 없는 사원의 이름을 표시하시오.
select ename
from emp
where empno not in(select distinct(mgr)
                   from emp
                   where mgr is not null)
;

--50. 부하직원이 있는 사원의 이름을 표시하시오.
select ename
from emp
where empno in(select distinct(mgr)
               from emp
               where mgr is not null)
;

select distinct(e.empno), e.ename
from emp e inner join emp m
on e.empno = m.mgr
order by empno;

--51. BLAKE와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오. 
--( 단 BLAKE는 제외 )
select ename, hiredate
from emp
where deptno in (select deptno
                from emp
                where ename = 'BLAKE')
      and ename != 'BLAKE'
;

--52. 급여가 평균 급여보다 많은 사원들의 사원 번호와 이름을 표시하되
--  결과를 급여에 대해서 오름차순으로 정렬하시오.
select empno, ename
from emp
where sal > (select avg(sal)
             from emp)
order by sal;


--53. 이름에 K가 포함된 사원과 같은 부서에서 일하는 사원의 사원 번호와 이름을 표시하시오.
select empno, ename, deptno
from emp
where deptno = any(select deptno
                   from emp
                   where ename like '%K%')
      and ename not like '%K%';

--54. 부서위치가 DALLAS인 사원의 이름과 부서번호 및 담당업무를 표시하시오.
select ename, deptno, job
from emp
where deptno = (select deptno
                from dept
                where loc = 'DALLAS');

select e.ename,e.deptno, e.job
from emp e, dept d
where e.deptno = d.deptno and d.loc = 'DALLAS';


--55. KING에게 보고하는 사원의 이름과 급여를 표시하시오.
select ename, sal
from emp
where mgr = (select empno
             from emp
             where ename = 'KING'); 

--56. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시하시오.
select deptno, ename, job
from emp
where deptno in (select deptno 
                 from dept
                 where dname ='RESEARCH')
;

--57. 평균 월급보다 많은 급여를 받고 이름에 M이 포함된 사원과 
-- 같은 부서에서 근무하는 사원의 사원 번호, 이름, 급여를 표시하시오.
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)
      and deptno = any(select deptno
                       from emp
                       where ename like '%M%');

--58. 평균급여가 가장 적은 업무를 찾으시오.
select job, avg(sal)
from emp
group by job
having avg(sal) = (select min(avg(sal)) 
                   from emp
                   group by job);


--59. 담당업무가 MANAGER 인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.
select ename
from emp
where deptno = any(select deptno
                   from emp
                   where job = 'MANAGER');

--SQL 추가문제
-- 1. 마당서점의고객이요구하는다음질문에대해SQL 문을작성하시오.
--  (1) 도서번호가1인도서의이름
select bookname from book
where bookid =1;

--  (2) 가격이20,000원이상인도서의이름
select bookname from book
where price >= 20000;

--  (3) 박지성의총구매액(박지성의고객번호는1번으로놓고작성)
select sum(saleprice) from orders
where custid=1;

--( 4) 박지성이구매한도서의수(박지성의고객번호는1번으로놓고작성)
select count(*) from orders 
where custid = 1; -- count 안에 컬럼명을 써도되지만 *가 더 안정적일듯





--(5) 박지성이구매한도서의출판사수
select count(distinct(publisher))"출판사의 수"
from book
where bookid in (select bookid
                from orders
                where custid = (select custid
                                        from customer
                                        where name = '박지성'));


--(6) 박지성이구매한도서의이름, 가격, 정가와판매가격의차이
select bookname, price, (price - saleprice)
from book b,orders o
where b.bookid = o.bookid 
      and o.custid = (select custid
                      from customer
                      where name = '박지성');


--(7) 박지성이구매하지않은도서의이름
select distinct(bookname)
from book b,orders o
where b.bookid = o.bookid 
      and o.custid != (select custid
                      from customer
                      where name = '박지성');

--2 마당서점의운영자와경영자가요구하는다음질문에대해SQL 문을작성하시오.
--(1) 마당서점도서의총개수
select count(*) from book;

--(2) 마당서점에도서를출고하는출판사의총개수
select count(distinct(publisher)) from book;

--(3) 모든고객의이름, 주소
select name,address from customer;

--(4) 2014년7월4일~7월7일사이에주문받은도서의주문번호
select orderid from orders
where orderdate between '2014/07/04' and '2014/07/07';

--(5) 2014년7월4일~7월7일사이에주문받은도서를제외한도서의주문번호
select orderid from orders
where orderdate not between '2014/07/04' and '2014/07/07';

--(6) 성이‘김’씨인고객의이름과주소
select name, address from customer
where name like '김%';

--(7) 성이‘김’씨이고이름이‘아’로끝나는고객의이름과주소
select name, address from customer
where name like '김%' and name like '%아';

--(8) 주문하지않은고객의이름(부속질의사용)
select name
from customer
where custid not in (select custid
                     from orders);
                     
--(9) 주문금액의총액과주문의평균금액
select sum(saleprice), avg(saleprice)
from orders;

--(10) 고객의이름과고객별구매액
select c.name, e.price
from customer c inner join(select custid,sum(saleprice) as price
                                     from orders
                                     group by custid) e
on c.custid = e.custid
order by c.custid;

select c.name, sum(o.saleprice) "price"
from customer c, orders o
where c.custid = o.custid
group by c.name
;
--(11) 고객의이름과고객이구매한도서목록
select name, bookname
from customer c cross join orders o cross join book b
where c.custid = o.custid 
   and o.bookid = b.bookid
order by c.custid
;


--(12) 도서의가격(Book 테이블)과판매가격(Orders 테이블)의차이가가장많은주문
--(13) 도서의판매액평균보다자신의구매액평균이더높은고객의이름

--3. 마당서점에서 다음의 심화된 질문에 대해 SQL 문을 작성하시오.
--(1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
--(2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름


