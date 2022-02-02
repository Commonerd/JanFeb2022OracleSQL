---������1
-- 1 �μ���ȣ�� 10���� �μ��� ��� �� �����ȣ, �̸�, ������ ����϶�.
select empno, ename, sal
from emp
where deptno = 10;

-- 2 �����ȣ�� 7369�� ��� �� �̸�, �Ի���, �μ���ȣ�� ����϶�.
select ename, hiredate, deptno
from emp
where empno =7369;

-- 3 �̸��� ALLEN�� ����� ��� ������ ����϶�.
select *
from emp
where ename = 'ALLEN';

-- 4 �Ի����� 83/01/12�� ����� �̸�, �μ���ȣ, ������ ����϶�.
select ename, deptno, sal
from emp
where hiredate = '83/01/12';

-- 5 ������ MANAGER�� �ƴ� ����� ��� ������ ����϶�.
select *
from emp
where job != 'MANAGER';


-- 6 �Ի����� 81/04/02 ���Ŀ� �Ի��� ����� ������ ����϶�.
select *
from emp
where hiredate > '81/04/02';

-- 7 �޿��� 800 �̻��� ����� �̸�, �޿�, �μ���ȣ�� ����϶�.
select ename, sal, deptno
from emp
where sal >= 800;

-- 8  �����ȣ�� 7654�� 7782 ���� �̿��� ����� ��� ������ ����϶�.
select *
from emp
where empno not between 7654 and 7782;

-- 9 ����� 100% �λ�� �޿��� "���޿�" ������� ����϶�.
--�� ���޿��� 2000������ ������� ����
select sal*2 as "���޿�"
from emp
where sal > 2000;


---������2
-- 1. ��� ����鿡�� �޿��� 20%�� ���ʽ��� �����ϱ�� �Ͽ���. �̸�, �޿�, ���ʽ� �ݾ���  ����϶�.
select ename, sal, sal*0.2 as "���ʽ� �ݾ�"
from emp;
 
-- 2. �޿��� 2,000 �̻��� ��� ����� �޿��� 15%�� ������� ����� �Ͽ���.
-- �̸�, �޿�, ������ �� ����϶�.
select ename, sal, sal*0.15 as "������"
from emp
where sal >= 2000;

-- 3. �μ���ȣ�� 20�� �μ��� �ð��� �ӱ��� ����Ͽ� ����϶�.
-- �� �̴��� �ٹ��ϼ��� 12���̰�, 1�� �ٹ��ð��� 5�ð��̴�.
-- ��¾���� �̸�, �޿�, �ð��� �ӱ��� ����϶�.
select ename �̸�, sal �޿�, round(sal/(12*5)) as "�ð��� �ӱ�"
from emp
where deptno = 20;

-- 4. �Ի����� 81/04/02���� �ʰ� 82/12/09���� ���� ��� ������ ����϶�.
select *
from emp
where hiredate < '82/12/09' and hiredate > ' 81/04/02';

-- 5. �޿��� 1,600���� ũ�� 3,000���� ���� ����� �̸�, ����(����), �޿��� ����϶�.
select ename �̸�, job "����(����)", sal �޿�
from emp
where sal between 1600 and 3000;

-- 6. ������ MANAGER�� SALESMAN�� ����� ��� ������ ����϶�.
-- ��, �μ���ȣ�� ASCENDING SORT  �� �� �޿��� ���� ��� ������ ����϶�.
select *
from emp 
where job = 'MANAGER' or job = 'SALESMAN'
order by deptno asc, sal desc;

-- 7. �μ���ȣ�� 20, 30���� ������ ��� ����� ��� ������ ����϶�.
select *
from emp
where deptno != 20 and deptno != 30;

-- 8. �Ի����� 81�⵵�� ����� ��� ������ ����϶�.
select *
from emp
where to_char(hiredate, 'yy')='81';

-- 9. �̸��� S�� �����ϰ� ������ ���ڰ� T�� ����� ��� ������ ����϶�
-- (��, �̸��� ��ü 5�ڸ��̴�.)
-- **�´� �� ������, �� �ȵǴ��� �𸣰ڴ�??? ���� �ʿ�. => eame like!
select *
from emp
where ename like 'S___T';

--- ������3

-- 1. �Ի����� 81�⵵�� ����� ��� ������ ����϶�.(substr Ȱ��)
select *
from emp
where substr(hiredate, 1, 2) = '81';

-- 2. �̸��� S�� �����ϰ� ������ ���ڰ� T�� ����� ��� ������ ����϶�.(substr Ȱ��)
--  (��, �̸��� ��ü 5�ڸ��̴�.)
select *
from emp 
where substr(ename, 1, 1) = 'S' and substr(ename, 5, 1) = 'T';

-- 3. �̸���(tester@naver.com) ���� �����γ���(naver.com) �����϶�.
select substr('tester@naver.com',8,9) �����γ���
from dual;

-- 4. 'WELCOME TO ORACLEJAVA.'����  ���� '.'�� ������ ��� ���ڸ� �ҹ��ڷ� �����Ͽ� 'e'�� ������  ����϶�.
select length(lower(replace('WELCOME TO ORACLEJAVA.','.'))) 
- length(replace(lower(replace('WELCOME TO ORACLEJAVA.','.')),'e')) as "e�� ����" 
from dual;

-- 5. �Ի��� ���� ���ݱ����� ��¥���� ����϶�. (�Ҽ��� ���� ����)
-- ��¾���� �μ���ȣ, �̸�, �Ի���, ������, �ٹ��ϼ�, �ٹ����, �ٹ�����, �ٹ��ּ��� ����϶�.
select deptno, ename, hiredate, sysdate,
round(sysdate - hiredate) �ٹ��ϼ�,
round((sysdate - hiredate)/365) �ٹ����,
round(months_between(sysdate,hiredate)) �ٹ�����,
round((sysdate - hiredate)/7) �ٹ��ּ�
FROM EMP;


