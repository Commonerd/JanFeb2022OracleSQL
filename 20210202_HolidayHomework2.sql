---�� ����4
-- 1. �Ի����� "2022�� 5�� 14��" �� �������� �̸�, �Ի����� ����϶�.
select ename �̸�, to_char(hiredate, 'yyyy"��"mm"��"dd"��"') �Ի���
from emp;

--2. ����� �̸���  �Ի��� �׸��� �Ի����� ��ݱ�,�Ϲݱ�� �����  ����϶�.(decode Ȱ��)
--��¾�� ��   SMITH 80/12/17 �Ϲݱ�
-- **�𸣰ڴ�. ���� �ʿ���!
select ename, hiredate, 
decode(th_char(hiredate, 'mon'), 
'1��', '��ݱ�',
'2��', '��ݱ�',
'3��', '��ݱ�',
'4��', '��ݱ�',
'5��', '��ݱ�',
'6��', '��ݱ�',
'7��', '�Ϲݱ�',
'8��', '�Ϲݱ�',
'9��', '�Ϲݱ�',
'10��', '�Ϲݱ�',
'11��', '�Ϲݱ�',
'12��', '�Ϲݱ�') as �Ի���
from emp;

--3. ����� �̸���  �Ի��� �׸��� �Ի����� ��ݱ�,�Ϲݱ�� �����  ����϶�.(case Ȱ��)
--��¾�� ��   SMITH 80/12/17 �Ϲݱ�
-- **�𸣰ڴ�. ���� �ʿ���!
select ename �̸�, hiredate �Ի���, 
CASE WHEN to_char(hiredate, 'mon')='1��' THEN '��ݱ�'
WHEN to_char(hiredate, 'mon')='2��' THEN '��ݱ�'
WHEN to_char(hiredate, 'mon')='3��' THEN '��ݱ�'
WHEN to_char(hiredate, 'mon')='4��' THEN '��ݱ�'
WHEN to_char(hiredate, 'mon')='5��' THEN '��ݱ�'
WHEN to_char(hiredate, 'mon')='6��' THEN '��ݱ�'
WHEN to_char(hiredate, 'mon')='7��' THEN '�Ϲݱ�'
WHEN to_char(hiredate, 'mon')='8��' THEN '�Ϲݱ�'
WHEN to_char(hiredate, 'mon')='9��' THEN '�Ϲݱ�'
WHEN to_char(hiredate, 'mon')='10��' THEN '�Ϲݱ�'
WHEN to_char(hiredate, 'mon')='11��' THEN '�Ϲݱ�'
WHEN to_char(hiredate, 'mon')='12��' THEN '�Ϲݱ�'
END as �Ի���
FROM EMP;

--4. ȸ�系�� �ּұ޿��� �ִ�޿��� ���̸� ���϶�
select max(sal)-min(sal)
from emp;

--5. DEPT ���̺��� ��� �μ����� ����϶�.
select count(deptno)
from dept;

-- 6. JOB�� �� JOB�� ����� �� �� JOB�� ���� ��� �̸��� ���ڸ���(����)�� ����϶�.
-- �� ������� 3�̻��� ��츸 ����Ѵ�. 
select job, count(*) as �����, sum(length(ename))
from emp
group by job;


---������5
--1. �̸��� "M"�ڰ� �� ������� �̸�,�μ���,�޿��� ���϶� 
select ename, dname, sal
from emp natural inner join dept
where ename like '%M%';

--2. SCOTT�� �޿����� 1000 �� �� �޿����� ���� �޴� ����� �̸�,�޿��� ����϶�.
select ename, sal 
from emp
where  sal < (select sal-1000
from emp
where ename = 'SCOTT');


--3. JOB�� SALESMAN�� ����� �� �ּұ޿��� �޴� �������  �޿��� ���� ����� �̸�, �޿��� ����϶�
select ename, sal
from emp
where sal < (select min(sal) 
from emp 
where job = 'SALESMAN');

--4. WARD�� �Ҽӵ� �μ� ������� ��� �޿����� , �޿��� ���� ����� �̸� ,�޿��� ����϶�.
select ename, sal
from emp
where sal > (select avg(sal) 
from emp 
where deptno = (select deptno 
from emp 
where ename = 'WARD'));

--5. �̸��� "K"�ڰ� ���� ����� �� ���� �޿��� ���� ����� �μ���,����� �̸�, �޿��� ����϶�.
select dname, ename, sal
from emp natural inner join dept
where sal = (select min(sal) from emp where ename like '%K%');



