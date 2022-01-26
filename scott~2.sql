--1. ��� �̸��� s�� ������ ��� �����͸� ��� ���
select * 
from emp 
where ename like'%S';

--2. 30�� �μ����� �ٹ� ��� �� 
--��å�� SALESMAN�� ����� ��ȣ,�̸�,��å,�޿�,�μ���ȣ ���
select empno, ename, job, sal, deptno 
from emp 
where deptno = 30 and job = 'SALEMAN';

--3. 20��, 30�� �μ����� �ٹ��ϰ� �ִ� ����� �� �޿��� 200�ʰ��� �����
-- ��ȣ, �̸�, �޿� �μ���ȣ ����ϼ���.
select empno, ename, sal, deptno 
from emp
where deptno = 20 and sal>2000
union
select empno, ename, sal, deptno 
from emp
where deptno = 30 and sal>2000;
--ª�� ����. in�� �̿��ؼ� 20 �Ǵ� 30�� ������
select empno, ename, sal, deptno
from emp
where deptno in(20,30) and sal>2000;

--4. �޿��� 2000�̻� 3000������ ���� ������ �� ���� ��� ������ ��� ���
select *
from emp
where not sal between 2000 and 3000;
--�Ǵ�
select *
from emp
where sal < 2000 or sal >3000;

--5. ��� �̸��� E�� ���ԵǾ� �ִ� 30�� �μ� ��� �� �޿��� 1000~2000 ���̰�
--�ƴ� ����� ��ȣ, �̸�, �޿�, �μ���ȣ�� ����ϼ���
select empno, ename, sal, deptno
from emp
where ename like '%E%' 
AND deptno = 30
and sal not between 1000 and 2000; 

--6. Ŀ�̼��� �������� �ʰ�, ����ڰ� �ְ�,
--��å�� 'MANAGER', 'CLERK'�� 
--����� ���� ��� ���
select*
from emp
where comm is null
and mgr is not null
and job in ('MANAGER','CLERK');