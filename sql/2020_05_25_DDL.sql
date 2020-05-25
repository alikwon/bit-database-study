-- 2020. 05.25


-----------------------------------------
-- DDL
------------------------------------------
--● 테이블 생성
-- 		create table 테이블 이름 
-- 		( 컬럼명1 (공백) 타입(사이즈),  컬럼명2 (공백) 타입(사이즈), ......)

-- ddl_test 라는 이름의 테이블을 생성
-- 컬럼1 : no, 숫자타입, 사이즈 3
-- 컬럼2 : name, 가변문자열, 사이즈 10
-- 컬럼3 : birth , 날짜타입, 기본값 = 현재 날짜 시간

create table ddl_test (
	no number(3),
	name varchar2(10),
	birth date default sysdate
);

desc ddl_test;

insert into ddl_test (no,name) values (1,'scott');

select no, name from ddl_test;

--지금까지 실습에 사용했던 사원 테이블과 유사한 구조의 
--사원번호, 사원이름, 급여 3개의 칼럼으로 구성된 EMP01 테이블을 생성해 봅시다.
CREATE TABLE EMP01(
	EMPNO NUMBER(4),
	ENAME VARCHAR2(20),
	SAL NUMBER(7, 2))
;

desc emp01;

-- 테이블의 복사 : 서브 쿼리 이용
-- 스키마 복사, 행 복사, 제약조건의 복사는 되지 않는다
create table emp02
as
select * from emp
;

select * from tab;
desc emp02;
select * from emp02;

-- emp 테이블의 empno 와 ename 의 컬럼만 복사해서 새로운 테이블 emp03 생성
create table emp03
as
select empno, ename from emp;

select * from emp03;

-- emp 테이블의 10번 부서데이터만 복사해서 새로운 테이블
CREATE TABLE EMP04 
AS
SELECT * FROM EMP WHERE DEPTNO=10;

select * from emp04;

-- emp 테이블의 스키마 구조만 복사해서 생성
create table emp05
as
select * from emp where 1<0;

-- 컬럼의 추가
-- alter table 테이블이름 add(컬럼정의)
-- emp01 테이블에 job 컬럼을 추가하자
alter table emp01 add (JOB varchar2(9));

-- 컬럼의 변경 
-- alter table modify (컬럼 정의)
-- job 컬럼을 최대 30글자까지 정할 수 있께 변경 해보자.
ALTER TABLE EMP01 MODIFY(JOB VARCHAR2(30) not null);
desc emp01;

-- 컬럼의 삭제
-- alter table drop(컬럼명)
ALTER TABLE EMP01 DROP COLUMN sal;
desc emp01;

-- 테이블 객체 삭제
-- drop table (테이블명)
drop table emp01;

-- 테이블 내용 전체 제거
truncate table emp02;

-- 테이블 이름 변경
-- rename 현재 테이블 이름 to 새로운 테이블 이름
rename emp02 to test_emp;
select * from tab;

-- primary 키 제약조건이 지정되어서 추가 안됨
desc dept;
insert into dept values(10, 'test', 'seoul');

--컬럼의 타입을 모두 정의하고, 아래에 제약을 정의하는 방법
--create table emp01(
--	empno number(4) not null
--)
--create table emp01 (
--	empno number(4) primary key,
--	primary key(empno)
--)

--사원 테이블(EMP02)을 사원번호, 사원명, 직급, 부서번호 4개의 칼럼으로 구성하되
--이번에는 사원번호와 사원명에 NOT NULL 조건을 지정하도록 합시다.
create table emp02(
	empno number(4) not null,
	ename varchar2(10) not null,
	job varchar2(10),
	deptno number(2)
);
desc emp02;
insert into emp02 values (null, 'SON', 'MANAGER', 10);
insert into emp02 values (1111, null, 'MANAGER', 10);
insert into emp02 values (1111, 'SON', 'MANAGER', 10);
select * from emp02;


drop table emp03;
create table emp03(
	empno number(4) unique,
	ename varchar2(10) not null,
	job varchar2(10),
	deptno number(2)
);
desc emp03;
insert into emp03 values (1111, 'TEST', 'MANAGER', 20);
insert into emp03 values (1111, 'TEST123', 'MANAGER', 10);
insert into emp03 values (NULL, 'TEST123', 'MANAGER', 10);
select * from emp03;

drop table emp04;
CREATE TABLE EMP04(
	EMPNO NUMBER(4) CONSTRAINT EMP04_EMPNO_UK UNIQUE, 
	ENAME VARCHAR2(10) CONSTRAINT EMP04_ENAME_NN NOT NULL, 
	JOB VARCHAR2(9), 
	DEPTNO NUMBER(2)
);
insert into emp04 values (1111, 'TEST', 'MANAGER', 20);
insert into emp04 values (1111, 'TEST123', 'MANAGER', 10);
insert into emp04 values (NULL, 'TEST123', 'MANAGER', 10);
select * from emp04; 

--사원번호, 사원명, 직급, 부서번호 4개의 칼럼으로 구성된 테이블을 생성하되 
--기본 키 제약 조건을 설정해 봅시다
drop table emp05;
CREATE TABLE EMP05(
	EMPNO NUMBER(4) CONSTRAINT EMP05_EMPNO_PK PRIMARY KEY ,
	ENAME VARCHAR2(10) CONSTRAINT EMP05_ENAME_NN NOT NULL,
	JOB VARCHAR2(9),
	DEPTNO NUMBER(2)
);

--사원번호, 사원명, 직급, 부서번호 4개의 칼럼으로 구성된 테이블을 생성하되 
--기본 키 제약 조건을 설정해 봅시다
-- deptno 외래키로 제약조건 설정
drop table emp06;
CREATE TABLE EMP06(
	EMPNO NUMBER(4) CONSTRAINT EMP06_EMPNO_PK PRIMARY KEY ,
	ENAME VARCHAR2(10) CONSTRAINT EMP06_ENAME_NN NOT NULL,
	JOB VARCHAR2(9),
	DEPTNO NUMBER(2) CONSTRAINT emp06_deptno_fk REFERENCES dept(deptno)
);

insert into emp06 values (1111, 'TEST', 'MANAGER', 20);
insert into emp06 values (1111, 'TEST123', 'MANAGER', 10);
insert into emp06 values (NULL, 'TEST123', 'MANAGER', 10);
insert into emp06 values (2222, 'TEST123', 'MANAGER', 10);
select * from emp06;
desc emp06;

--사원번호, 사원명, 직급, 부서번호, 직급, 성별 6개의 칼럼으로 구성된 테이블을 생성하되
--기본 키 제약 조건, 외래키 제약 조건은 물론 
--CHECK 제약 조건도 설정해 봅시다.
--default 제약 조건으로 birthday sysdate로 입력되도록 처리
CREATE TABLE EMP07(
	EMPNO NUMBER(4) CONSTRAINT EMP07_EMPNO_PK PRIMARY KEY ,
	ENAME VARCHAR2(10) CONSTRAINT EMP07_ENAME_NN NOT NULL,
	JOB VARCHAR2(9) default 'MANAGER',
	DEPTNO NUMBER(2) CONSTRAINT emp07_deptno_fk REFERENCES dept(deptno),
	gender char(1) constraint emp07_gender_ck check (gender = 'M' or gender = 'F'),
	sal number (7,2) constraint emp07_sal_ck check(sal between 500 and 5000),
	birthday date default sysdate
);

insert into emp07 values (1111, 'TEST', NULL, 10, 'F', 600, NULL);
insert into emp07 values (1112, 'TEST', NULL, 10, 'M', 600, NULL);
insert into emp07 (empno, ename, deptno, gender, sal)
				values (1113, 'TEST', 10, 'F', 1600);
select * from emp07;