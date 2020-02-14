select empno, ename, sal from emp where sal<=1500;
select empno, ename, sal from emp where ename='FORD';
select empno, ename, sal from emp where ename='SCOTT';
select * from emp where hiredate>='1982/01/01';
select * from emp where hiredate between '1987/01/01' and '1987/12/31';
select empno, sal from emp where empno in (7521, 7654, 7844);
select * from emp where empno not in (7521, 7654, 7844);
select * from emp where ename like 'J%';
select * from emp where ename like '%A%';
select * from emp where ename not like '%A%';
select COMM from emp;
select * from emp where comm is null;
select * from emp where comm is not null;
select * from emp where mgr is null;
select * from emp order by sal desc;
select * from emp order by sal;
select * from emp order by hiredate desc;
select * from emp order by sal desc, ename asc;






