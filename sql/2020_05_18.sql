-- 2020.05.18

select * from emp;

select * from dept;

-- 로그인한 계정이 소유한 테이블 확인
SELECT * from tab;


-- emp : 사원 정보
-- dept : 부서 정보
-- bonus : 임시 테이블
-- salgrade : 급여 테이블

-- 테이블의 구조 확인 : desc 테이블 이름
desc emp;
desc dept;
desc salgrade;

-- 데이터 검색 질의

select ename, sal, deptno, empno -- 컬럼이름들을 나열
from emp -- 테이블 이름
;

select * from dept; -- 전체출력

select deptno from dept; -- deptno만 출력


-- select 의 결과는 새로운 테이블이다
-- 컬럼의 산술연산이 가능하다. +, -, *, /, mod
select * from emp;
select sal + comm from emp;
select sal, sal + comm from emp;
-- +
select ename, sal, sal+500 from emp;
-- -
select ename, sal, sal-100 from emp;
-- *
select ename, sal, sal*1.08 from emp;
-- /
select ename, sal, sal/2 from emp;

--null 값의 확인
select empno, job, sal, comm, SAL*12, SAL*12+COMM
from emp;

-- nvl(컬럼 명, 기본값) : null 값 치환 함수
-- 기본값은 컬럼 도메인의 자료형과 같아야한다.
-- as : 컬럼 이름대신 별칭 출력
select ename, job, sal, nvl(comm, 0), sal*12, sal*12+nvl(comm,0) as TOTAL
from emp;

-- 데이터베이스의 문자열 표현 --> 작은따옴표를 사용
-- '문자열'
-- 문자열을 붙여서 출력하는 연산 --> ||
select ename || ' is a ' || job
from emp;

-- distinct : 중복되는 데이터를 한번씩만 출력
select deptno from emp;
select distinct deptno from emp;

-- order by : 정렬
select deptno, job from emp order by deptno;
select distinct deptno, job from emp order by deptno;