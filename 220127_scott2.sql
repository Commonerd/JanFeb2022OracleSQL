--1����
select comm from emp order by comm; --null��
select comm from emp order by comm desc; --null��
select LPAD('DATABASE',20,' '), RPAD('DATABASE',20,' ') from dual;--��ü 20�ڸ� �߿�, 8�ڸ��� ä���, �������� �������ڷ� ä��.
select RPAD(substr(ename,1,2),length(ename), '*') �̸� from emp;

SELECT 
TRIM(LEADING FROM '  ABCD  ') LT,
LENGTH(TRIM(LEADING FROM '  ABCD  '))LT_LEN,
TRIM(TRAILING FROM '  ABCD  ') RT,
LENGTH(TRIM(TRAILING FROM '  ABCD  ')) RT_LEN,
TRIM(BOTH FROM '  ABCD  ') BOTH1,
LENGTH(TRIM(BOTH FROM '  ABCD  ')) BOTH1,
TRIM('  ABCD  ') BOTHT2, --�̰� ���� �߿�
LENGTH(TRIM('  ABCD  ')) BOTHLEN2 FROM DUAL;

--2����
--round(���, [ǥ���� �ڸ���])
select
ROUND(35.125, 1), -- 35.1
ROUND(35.125, 2), -- 35.13
ROUND(35.125), -- 35 (�Ҽ��� ������ 1�� �ڸ����� ǥ��)
ROUND(35.12, -1), -- 40
ROUND(135.12,-2) -- 100
from dual;

select 
trunc(12.345,2), --12.34
trunc(12.345,0), -- 12
trunc(12.345),--12
trunc(12.345,-1) --10
from dual;

select
MOD(34,2),
MOD(34,5),
MOD(34,7)
from dual;

select 
sysdate ����, 
sysdate - 1 ����, 
sysdate +1 ���� 
from dual;

select (sysdate - hiredate) as "�ٹ� �ϼ�" from emp;

--�Ի��Ϸκ��� 40�ֳ��� �Ǵ� ��¥�� ����ϼ���
select empno, ename, hiredate, ADD_MONTHS(hiredate,480) "10year" 
from emp;

--�Ի��Ϸκ��� �� ������ ��������
select sysdate, hiredate, MONTHS_BETWEEN(SYSDATE,hiredate)
from emp;

--����κ��� ���� ������ ������ ��¥ 
alter session set NLS_LANGUAGE = AMERICAN;
select sysdate, next_day(sysdate, 'friday') from dual;

alter session set NLS_LANGUAGE = KOREAN;
select sysdate, next_day(sysdate, 6) from dual;

select sysdate, last_day(sysdate) from dual;

--3����
select hiredate, round(hiredate,'MONTH') from emp where deptno = 10;
select hiredate, trunc(hiredate,'MONTH') from emp where deptno = 10;
--�Ի����� ����ϵ� ���ϱ��� ���
select TO_CHAR(hiredate, 'yyyy/MON/dd DY') --hiredate�� ������ ���� ���ڷ� ���
from emp where deptno = 10;

select sysdate, to_char(sysdate,'YYYY/MM/DD, HH24:MI:SS') from dual;
--���ڸ� ���ڿ��� �ٲ��ִ� ����
select ename, sal, to_char(sal,'L999,999') from emp where deptno = 10;
--L:���� �� ������ ȭ�� 
select ename, sal, to_char(sal,'$999,999') from emp where deptno = 10;

select '10,000'+'20,000' from dual; -- ����
--���ڿ��� ���ڷ� �ٲ� �� to_number�� ���ϴ�.
select TO_NUMBER('10,000','99,999')+TO_NUMBER('20,000','99,999') 
from dual;

-- 19821209�� �Ի��� ����� �������
select empno, ename, hiredate
from emp
where hiredate = to_date(19821209,'yyyymmdd'); 

-- ���� ��ĥ�� �������� ��¥���
select round(sysdate - to_date('2022/01/01','yyyy/mm/dd'))
from dual;

-- ���� ��ĥ�� �������� ��¥��� - ���� �����ϰ� ���� �ʴٸ� trunc
select trunc(sysdate - to_date('2022/01/01','yyyy/mm/dd'))
from dual;

--���� ���ϱ� SAL*12+comm
select empno, ename, sal*12+comm ����, sal*12*12+NVL(comm,0) ����2 from emp;
select empno, enaeme, NVL2(comm, sal*12+comm, sal*12) ����
from emp;

--4����
--��� ����� �ڽ��� ����� �ִ�.
--�׷��� emp���̺� �����ϰ� ������� ���ڵ尡 �ִµ�,
-- �� ����� mgr Į�� ���� null�̴�.
--����� ���� ����� ����ϵ�, 
--mgr Į�� �� null ��� CEO�� ����غ���.
select empno, ename, NVL(to_char(mgr),'CEO') --mgr�� �ѹ�Ÿ��, ceo�� ���ڿ� varchar2Ÿ��
--NVL�Լ� ���� ������ ��: ���� �� ��Ұ� Ÿ���� ���ƾ� �Ѵ�.
from emp 
where mgr is null;

--NVL2�� Ȱ���� ����Ǯ��
select empno, ename, NVL2(mgr,to_char(mgr),'CEO')
from emp
where mgr is null;

select deptno, decode(deptno, 10, 'ACCOUNTING',
20, 'RESEARCH',
30, 'SALSE',
40, 'OPERATIONS') as dname
from emp;

select ename, deptno, CASE WHEN DEPTNO=10 THEN 'ACCOUNTING'
WHEN DEPTNO=20 THEN 'RESEARCH'
WHEN DEPTNO=30 THEN  'SALSE'
WHEN DEPTNO=40 THEN 'OPERATIONS'
END
FROM EMP;

--���޿� ���� �޿��� �λ��ϵ��� ����. 
--(�����ȣ, �����, ����, �޿�, �λ�� �޿�9upsal))
--������ 'ANAlYST'�� ����� 5%, 'SALESMAN'�� ����� 10%, 
--'MANAGER'�� ����� 15%, 'CLERK'�� ����� 20%�� �λ��Ѵ�.
select empno, ename, job, sal, 
case when job = 'ANALYST' THEN SAL *1.05
WHEN JOB = 'SALESMAN' THEN SAL *1.1
WHEN JOB = 'MANAGER' THEN SAL*1.15
WHEN JOB = 'CLERK' THEN SAL*1.2
end
as "upsal"
from emp;

--5����
select to_char(sum(sal),'$999,999') as total from emp;
select round(avg(sal)) as average from emp;
select min(sal) �����޿�, max(sal) �ִ�޿� from emp;
--��ü ���ڵ��� ���� count(*)
select count(*) from emp;

--��� ������ Ŀ�̼� ��. 
select sum(comm) from emp;--���� �����ϰ� ���
select avg(comm) from emp;--���� �����ϰ� ���
select count(comm) from emp;--���� �����ϰ� ī��Ʈ

select sum(sal), sal from emp; -- ����. sum(sal)�� 1��, sal�� 14��
select deptno, sum(sal), round(avg(sal))
from emp
group by deptno;

--�μ����� ��� ���� Ŀ�̼� �޴� ��� �� ���
--select count(*)
--from emp
--group by deptno;
--select count(*)
--from emp
--where comm is not null;
select deptno, count(*), count(comm) from emp group by deptno;

--�μ����� ���� �ֱٿ� �Ի��� ����� �Ի��� ���
--select hiredate
--from emp
--where min(sysdate-hiredate)
--group by deptno;
select deptno, max(hiredate) from emp group by deptno;

--�׷� ���� �� ����
select deptno, job, avg(sal)
from emp
group by deptno, job
order by deptno, job;

select deptno, job, avg(sal)
from emp
group by deptno, job
having avg(sal) >= 2000
order by deptno, job;


select deptno, job, avg(sal)
from emp
group by deptno, job
having deptno = 20
order by deptno, job;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL >= 2000 --whre������ �׷��Լ� ���� ���� �ȵȴ�.
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

    SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY CUBE(DEPTNO, JOB)
    ORDER BY DEPTNO, JOB;
    
    SELECT DEPTNO, ENAME
    FROM EMP
    GROUP BY DEPTNO, ENAME;
    
    SELECT DEPTNO,
           LISTAGG(ENAME, ', ') --���η� ������ �÷� �̸�, ������
           WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
      FROM EMP
    GROUP BY DEPTNO;
    
    SELECT ENAME 
     , SAL 
     , RANK() OVER (ORDER BY SAL DESC) AS "RANK" 
     , DENSE_RANK() OVER (ORDER BY SAL DESC) AS "DENSE_RANK" 
  FROM EMP 
 ORDER BY SAL DESC;
 
 
--7����
--P.212-213,2,3,4
--2. ���� ��å�� ����� 3�� �̻��� ��å�� �ο��� ���
-- select job, count(job)>=3 from emp group by job;
select count(*) �ο���, job ��å from emp group by job having count(*) >=3;

--3. �Ի�⵵�� �������� �μ����� ��� �Ի��ߴ��� ���
--select the_char(hiredate,'yyyy') as "HIRE_YEAR",deptno, count(hiredate)
--from emp
--group by the_char(hiredate,'yyyy');
select to_char(hiredate,'yyyy') as "HIRE_YEAR", deptno, count(*) �ο���
from emp
group by to_char(hiredate,'yyyy'), deptno;

--4. �߰������� �޴� ����� ���� �ʴ� ��� �� ���
select nvl2(comm, 'O', 'X') comm, count(*) �ο���
from emp
group by nvl2(comm, 'O', 'X');

--����
select * from emp, dept order by empno; --�� ����� ���� �μ��� 10,20,30,40 �� ��
--�̷��� ������ �ϸ� �ȵȴ�. ���̺�� �����ϸ� �ȵȴ�.
--WHERE ���� Ȱ���Ͽ� ������ ������ �ɾ���� �Ѵ�. 

--Equip join : �÷��� ���� ���� ��� �����Ѵ�.
select * from emp, dept where emp.deptno = dept.deptno; 
--�÷����� ���� ���, �ݵ�� ���̺��.�÷��� �̷��� ����� �Ѵ�.
--�÷����� �ٸ��� �����൵ �ȴ�.
--����Ʈ�� where�� ���̺�� ������. emp.deptno, ename, dname
select * from emp e, dept d where e.deptno = d.deptno
-- from������ ���̺� ��Ī�� �����ش� > where������ ��Ī���� ���ش�.
select * from dept;

select * from salgrade;
select * from emp; --���� ���̺�� ������ ���� ����. sal�� ���õ� ����� �͸� ���� ��(hisal, losal)

select e.empno, e.ename, s.grade  --�÷� �տ� ���̺� ��Ī �����ָ� ������ �������� ���� �ڵ尡 �ȴ�. 
from emp e, salgrade s 
where e.sal between s.losal and s.hisal and e.deptno=10;

--8����
--20�� �μ� ����� ���, �̸�, �μ����� ���
select e.empno, e.ename, d.dname, d.deptno
from emp e, dept d
where e.deptno = d.deptno and e.deptno=20;
-- where�ȿ��� ������ �ΰ� �̻��̸� and�� �����Ѵ�.
-- �Ʒ��� ���� ���� �����������, inner�������� ǥ��.
select e.empno, e.ename, d.dname, d.deptno
from emp e inner join dept d  --�̳� ���� ǥ��
on e.deptno = d.deptno where empno=7788; --���� ����, --�ڿ� where�� ����

select *
from emp e inner join dept d
using (deptno) where empno = 7788;--�ڿ� where�� ����

select *
from emp e NATURAL JOIN dept d where empno=7788;--�ڿ� where�� ����