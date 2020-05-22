--BETWEEN AND 연산자
select *
from emp
--where hiredate>'1980/01/01'; --80년1월1일 이후 입사자
--where hiredate >= '1987/01/01' and hiredate <= '1987/12/31'; -- 1987년 입사자 리스트 출력
where hiredate between '1981/01/01' and '1981-12-31';       -- 1981년 입사자 출력

--or연산을 간소화 하는 IN연산자
--컬럼 이름 IN(데이터1, 데이터2, 데이터3,...)
--컬럼 = 데이터1 or 컬럼 = 데이터2 or 컬럼 = 데이터3 or .....
select *
from emp
where comm in(300,500,1400);


-- 패턴검색 : like 연산자
-- 컬럼 이름 like 패턴
-- % (와일드 카드) = 0개 이상 문자열이 가능하다
--  'S%' : S로 시작하는 문자열
select * from emp 
where ename like 'S%'; -- 이름이 S로 시작하는 사원

--  '%S' : S로 끝나는 문자열
select * from emp 
where ename like '%S'; -- 이름이 S로 끝나는 사원

--  '%S%' : S를 포함하는 문자열
select * from emp 
where ename like '%AR%'; -- 이름에 AR을 포함하는 사원

-- _ = 1개의 자리수에 어떠한 문자가 와도 가능하다
SELECT * FROM EMP
WHERE ENAME LIKE '_A%'; -- 두번째 글자 A

SELECT * FROM EMP
WHERE ENAME LIKE '__A%'; -- 세번째 글자 A

SELECT * FROM EMP
WHERE ENAME LIKE '%L__'; -- 끝에서 세번째 글자 L

--null 값을 확인하기 위한 연산자 : is null, is not null
--컬럼명 is null : 컬럼값이 null인경우 true
select ename, comm
from emp
where comm is null;

select *
from emp
-- order by sal desc;
-- order by hiredate asc;
-- order by comm; -- null 값 정렬
order by deptno desc, ename asc; -- 부서 정렬하는데 이름도 같이정렬