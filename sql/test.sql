alter table emp01
modify hiredate default sysdate;

insert into emp01 (empno, ename, job,mgr,hiredate,sal,comm,deptno) 
values (to_number('1111'),'SON','MANAGER',to_number(''),to_date('19881115','YY/MM/DD'),3000,null,20);
delete from emp01 where empno = 1111;
select * from emp01;
rollback;
commit;
--2.
insert into dept(deptno,dname,loc) values(50,'DESIGN','SEOUL');
--3.
update dept
set dname = 'GAME', loc = 'JEJU'
where deptno = 50;
--4.
delete from dept
where deptno = 50;
--5.
select * from tab;
--6.
desc emp;
--7.
select * from user_constraints;


-- 1.
create index emp_index on emp (ename);
--2.
create view emp_view
as
select *
from emp natural join dept;
--3.
update emp01
set deptno = (
	select deptno
	from emp01
	where ename = 'SCOTT')
;

rollback;
select * from emp_view;
select * from emp01;
delete from dept where deptno = 70;
