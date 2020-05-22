-- 2020. 05. 20 

--숫자 함수
-- MOD : 입력받은 수를 나는 나머지반환
select mod(10,3)
from dual;

-- ABS : 절대값
select abs(-100)
from dual;

-- power : m의 n승
select power(2,10)
from dual; -- 2의 10승

-- TRUNC : 특정 자리수 밑으로 버림
-- '-1' = 일의 자리, '0' = 소수점 X , '1' = 소수점 첫째자리
select trunc(1282.23,0)  
from dual;

-- ROUND : 특정 자리수에서 반올림
-- '-1' = 일의 자리, '0' = 소수점 X , '1' = 소수점 첫째자리
select round(1281.23, -2)
from dual;


--날짜
select sysdate, to_char(sysdate, 'YYYY.MM.DD')
from dual;

select ename, hiredate, to_char(hiredate, 'YYYY.MM.DD')
from emp;

select to_char(98712346,'L999,999,999,999')
from dual;

select sal,nvl(comm,0), to_char(sal*1000, 'L999,999,999'),
to_char(sal*1000*12+nvl(comm,0), 'L999,999,999') as income from emp
order by income desc;



--DECODE : if switch 문과 유사
select ename, deptno,
decode(deptno, 
            10, 'ACCOUNTING', 
            20, 'RESEARCH', 
            30, 'SALES', 
            40, 'OPERATIONS' )
as dname
from emp;


select ename, deptno,
case 
    when deptno=10 then 'ACCOUNTING'
    when deptno=20 then 'RESEARCH'
    when deptno=30 then 'SALES'
    when deptno=40 then 'OPERATIONS'
    else 'no name'
end as deptname
from emp
order by deptname, ename;


-----------------------------------
-- 그룹 함수 (집합함수)
-----------------------------------
-- sum, avg, count, max, min

-- sum(컬럼이름) : 해당 컬럼의 데이터들의 함 반환
-- Ex : 매월 지급되는 급여들의 총 합
select to_char(sum(sal)*1000,'L999,999,999') as totalsal
from emp;
select sum(comm) from emp; -- null은 제외하고 계산됨

-- AVG(컬럼명) : 해당컬럼의 데이터들의 평균값을 반환
select avg(sal) from emp;
select avg(comm) from emp;

-- MAX(컬럼명) : 최대값  (MIN : 최소값)
select max(sal),min(sal)
from emp;


-- 부서별 평균 급여가 2000 이상인(HAVING)
-- 부서번호와 부서별 평균 급여를 출력
select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >=2000
;

--직급별 지표출력
select job, count(*) as "직급별인원",
            sum(sal) as "직급별 월 총 급여",
            round(avg(sal)) as "직급별 월 평균 급여",
            nvl(sum(comm),0) as "부서별 수령 커미션의 총 합",
            max(sal) as "직급별 최고 급여 금액"
from emp
group by job
having count(*) > 1 --직급별 인원이 2개 이상인 직급
;