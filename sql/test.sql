alter table emp01
modify hiredate default sysdate;

insert into emp01 (empno, ename, job,mgr,hiredate,sal,comm,deptno) 
values (to_number('1111'),'SON','MANAGER',to_number(''),to_date('sysdate','YY/MM/DD'),3000,null,20);
delete from emp01 where empno = 1111;
select * from emp01;
rollback;
commit;

select * from emp01 natural join dept;
delete from dept where deptno = 70;
