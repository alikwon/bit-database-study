------------------------------------- 
-- 인덱스
-------------------------------------

--검색을 빠르게 하기위해 사용한다
--DML 작업에는 성능저하가 올 수 있다
desc user_ind_columns;

select index_name, table_name, column_name
from user_ind_columns
;

--인덱스 테스트 테이블 생성
drop table emp01;
create table emp01
as
select * from emp;

insert into emp01 select * from emp01; --2배씩 계속 생성됨
select count(*) from emp01;

insert into emp01 (empno,ename) values (2222, 'PARK');
select * from emp01 where ename = 'PARK';

select * from emp where empno=1111;

-- INDEX 생성
-- create index 인덱스이름 on 테이블명( 컬럼이름 )
-- 검색속도가 빨라지고
-- 시스템 부하를 줄여서 전체 성능을 향상시킨다
-- 그러나
-- 생성시 추가적인 공간이 필요하다
-- 인덱스생성하는데 시간이걸린다
-- DML이 자주 일어날 경우 오히려 성능저하된다.
create index emp01_ename_index on emp01 (ename);