select * from emp;

--����� ���, �̸��� ����� �����ȣ, �̸��� ���
select *
from emp e, emp m -- ���� ���̺�, ���� �ٸ� �̸� ����
where e.mgr = m.empno;

select e.empno �����ȣ, e.ename ����̸�, m.empno ����̸�
from emp e, emp m
where e.mgr = m.empno;

--outer join
select *
from emp, dept
where emp.deptno(+) = dept. deptno; --������ �κп� +�� ���δ�. 
--40�� �μ� ���������� null�� �ҷ��ͼ� ��������
--(+)�� �ǹ̴� ������ ����� ���� ������ null���ڵ带 �߰��ϰڴٴ� �ǹ�
-- �׷��Ƿ� ������ ������ �ٿ���� �Ѵ�. emp.deptno�� �ƴ϶�, dept.deptno�� ���̸� �ȵȴ�.

SELECT *
FROM EMP FULL JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

--1.�޿��� 2000�ʰ��� ������� �μ�����, ��������� ���
--(�μ���ȣ, �μ���// dept ���̺�
--�����ȣ, ����̸�, �޿�) // emp ���̺�

select deptno, dname, empno, ename, sal
from emp natural inner join dept
where sal > 2000;
-- ��Ī ������ ����� �޽��� ����. ���� ���� Good~
-- �ٸ� Ǯ�� ��� 
select d.deptno, d.dname, e.empno, e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.sal > 2000;

--2. �� �μ��� �μ���ȣ, �μ���, ��� �޿�,�ִ�޿�, �ּұ޿� ,����� ���
select deptno, dname, trunc(avg(sal)) "���", max(sal)"�ִ�޿�", min(sal) "�ּұ޿�", count(*) "�����"
from emp natural join dept
group by deptno, dname;
--from���� ���� ���� �ϰ�, group by�� �ؼ� �׷캰�� �����ְ�
--���� �� �°�, avg, max � (sal)�� �ƴ϶� (deptno)�� �����ϰ� ����

--3. ��� �μ������� ���������  
--�μ���ȣ, ����̸� ������ ���Ľ��� ���(�μ���ȣ, �μ���, �����ȣ, ����̸�, ����, �޿�)
select e.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e full outer join dept d 
on (e.deptno = d.deptno) 
order by d.deptno, e.empno;
-- ����~ Good~

--4. ��� �μ�����, �������, �޿� ���, ���� ��� ������ 
-- �μ���ȣ, �����ȣ ������� �����ؼ� ����ϼ���.
--(�μ���ȣ, �μ���, �����ȣ, �����, �޿�, ����ȣ, 
select e.deptno, d.dname, e.empno, e.ename, e.sal, e.mgr
from emp e full outer join dept d on (e.deptno = d.deptno)
order by d.deptno, e.empno;

select d.deptno, e.ename, e.sal, s.grade, m.ename
from emp e, dept d, salgrade s, emp m
where e.deptno(+) = d.deptno
and e.sal between s.losal(+) and s.hisal(+)
and e.mgr = m.empno(+)
order by d.dname, e.empno;

select d.deptno, e.ename, e.sal, s.grade, m.ename
from emp e right outer join dept d--right�� �������� �����ϰڴ�. �Ǵ�full
on e.deptno = d.deptno
left outer join salgrade s
on e.sal between s.losal and s.hisal
left outer join emp m
on e.mgr = m.empno
order by d.dname, e.empno;

--<4����>
--'SCOTT'(EMP���̺� ����)�� �μ���(DEPT���̺� ����)�� ����ϼ���.
-- �μ���ȣ ���Ѵ�����, DEPT���̺��� �ش� �μ��� ��ȣ�� �´� �μ��� ��������
select dname
from dept
where deptno = (select deptno
                from emp 
                where ename = 'SCOTT');--���� ���� ��ȣ�� �ȿ� ���� ; �����ݷ� �����.

--Q.'SMITH'�� ���� �μ����� �ٹ��ϴ� ����� ���� ���
select *
from emp
where deptno = (select deptno
                from emp
                where ename = 'SCOTT')
                and ename <>'SMITH'; -- ���̽� �̸��� ���� ���� ��.
                

--Q2. 'NEW YORK'���� �ٹ��ϴ� ������� �̸� ���
select ename
from emp
where deptno = (select deptno
from dept
where loc = 'NEW YORK');

--Q3. �޿��� 3000�̻� �޴� ����� �Ҽӵ� �μ��� 
--������ �μ����� �ٹ��ϴ� ��� ���
--(�̸�, �޿�, �μ���ȣ)
select ename, sal, deptno
from emp
where deptno in (select distinct deptno --������� 20, 10���� ����=>������
from emp
where sal >= 3000);

--Q4. 30�� �μ� �Ҽ� ��� �� �޿��� ���� ���� �޴� �������
--�� ���� �޿��� �޴� ����� �̸�, �޿� ���
select ename, sal from emp where sal > 
(select max(sal) from emp where deptno = 30);

--all ���. 
select ename, sal from emp where sal > all 
--all�� ������ ��ɱ��� ���� ����. 
--�ش� ���ǽ��� ��� ���϶��� �������ڴٶ�� �ǹ�.
(select sal from emp where deptno = 30);

--any ���
select ename, sal from emp where sal > any
--�ش� ���ǽ� �߿� �ϳ��� ���̸� �������ڴٶ�� �ǹ�.
(select sal from emp where deptno = 30);

--<5����>
select * from emp where 1 = 0; --false�� ����� �ȴ�.

--exists
select * from emp where exists --������������ ������ ���ڵ尡 �ϳ��� ������ '��', ������ '����'
(select * from emp where deptno = 10);
-- ���������� ����� �ϳ��� ������ ���� ���� ���� ����
-- ���������� ����� �ϳ��� ������ ���� ���� ���� �Ұ�

--Q1.�μ����� �ְ� �޿��� �μ���ȣ ���. 
select * from emp where (deptno, sal)  --�÷� �������ϱ� ��ȣ.���� �÷��� ��������� in����..
in (select deptno, max(sal) from emp group by deptno);

select deptno, ename
from
(select * from emp where deptno = 10) e10,
 (select * from dept) d
    where e10.deptno = d.deptno;
-- �������� �ΰ��� �����ؼ� ���̺�� �� ���� �ִ�~

--with
with
e20 as (select * from emp where deptno = 20),
d as (select * from dept)
select e20.deptno, e20.empno, ename, dname, loc
from e20, d
where e20.deptno = d.deptno;

--rownum
select e.*, rownum r --���ĵ� ���·� �ο��. 
from
(select * from emp order by sal desc) e
where rownum <=3; 

--���� ���� 4,5,6�� ���
--select e.*, rownum r
--from (select * from emp order by sal desc) e
--where rownum between >=4 and rownum <= 6; 
--������ ����. 
--��? row���� ������ �������ʹ� 1���͸� ������ �� �ִ�. 
select empno, ename, sal, r
from 
(select e.*, rownum r
from
(select * from emp order by sal desc) e)
where r >= 4 and r <= 6;


select empno, ename, job, sal, 
(select grade 
from salgrade s 
where e.sal between s.losal and s.hisal) grade,
(select dname from dept d where e.deptno = d.deptno) dname
from emp e;

--Q. ��ü��� ��
--'ALLEN'�� ���� ��å�� �������
--�������, �μ������� ����ϼ���.
--(��å, �����ȣ, �̸�, �޿�, �μ���ȣ, �μ��̸�)
select job, empno, ename, sal, deptno, dname
from emp natural inner join dept
where job = (select job from emp where ename = 'ALLEN')
and ename != 'ALLEN';

--Q2. ��ü ����� ��� �޿����� --> ���� �̾ƾ� �Ѵ�.
-- ���� �޿��� �޴� ������� ������ ����ϼ���.
-- (�����ȣ, ����̸�, �μ��̸�, �Ի���, �ٹ���, �޿�, �޿����)
--select empno, ename, dname, hiredate, loc, sal
--from emp natural inner join dept
--where emp.sal>(select avg(count(emp.sal)) from emp g);  
select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
from emp e, dept d, salgrade s 
where e.deptno = d.deptno and e.sal between s.losal and s.hisal
and sal > (select avg(sal)from emp)
order by e.sal desc, e.empno;


--Q3. 10�� �μ����� �ٹ��ϴ� ��� �� 30�� �μ����� �������� 
--�ʴ� ��å�� ���� ������� ������ ����ϼ���
--(�����ȣ, ����̸�, ��å, �μ���ȣ, �μ���, �ٹ���)
--select empno, ename, job, deptno, dname, loc
--from emp natural join dept
--where deptno = 10
--having jobdepno = 30 ; 
select empno, ename, job, deptno, dname, loc
from emp natural join dept
where deptno = 10 and job not in 
(select distinct job from emp where deptno = 30);


--Q4. ��å�� SALESMAN�� �������
--�ְ�޿����� ���� �޿��� �޴�
--������� ������ ����ϼ���.
--(�����ȣ, ����̸�, �޿�, �޿� ���)
select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and e.sal > (select max(sal) from emp where job = 'SALESMAN');
--90%. max�� sal�� ��������. 
--�ٸ� Ǯ�� : ALL��� ���δ� ū �ֵ鸸 �̱�
select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and e.sal > all
(select distinct sal from emp where job='SALESMAN');