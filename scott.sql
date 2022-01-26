CREATE TABLE DEPT(
	DEPTNO 		NUMBER(2) ,
	DNAME 		VARCHAR2(14),
	LOC 		VARCHAR2(13) 
	);

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');


CREATE TABLE EMP (
	EMPNO 		NUMBER(4) NOT NULL,
	ENAME 		VARCHAR2(10),
	JOB 		VARCHAR2(9),
	MGR 		NUMBER(4),
	HIREDATE 	DATE,
	SAL 		NUMBER(7, 2),
	COMM 		NUMBER(7, 2),
	DEPTNO 		NUMBER(2)
	);

INSERT INTO EMP VALUES (7369, 'SMITH', 'CLERK', 7902,TO_DATE('1980-12-17', 'YYYY-MM-DD'), 800, NULL, 20);
INSERT INTO EMP VALUES (7499, 'ALLEN', 'SALESMAN', 7698,TO_DATE('1981-02-20', 'YYYY-MM-DD'), 1600, 300, 30);
INSERT INTO EMP VALUES (7521, 'WARD', 'SALESMAN', 7698,TO_DATE('1981-02-22', 'YYYY-MM-DD'), 1250, 500, 30);
INSERT INTO EMP VALUES (7566, 'JONES', 'MANAGER', 7839,TO_DATE('1981-04-02', 'YYYY-MM-DD'), 2975, NULL, 20);
INSERT INTO EMP VALUES (7654, 'MARTIN', 'SALESMAN', 7698,TO_DATE('1981-09-28', 'YYYY-MM-DD'), 1250, 1400, 30);
INSERT INTO EMP VALUES (7698, 'BLAKE', 'MANAGER', 7839,TO_DATE('1981-05-01', 'YYYY-MM-DD'), 2850, NULL, 30);
INSERT INTO EMP VALUES (7782, 'CLARK', 'MANAGER', 7839,TO_DATE('1981-06-09', 'YYYY-MM-DD'), 2450, NULL, 10);
INSERT INTO EMP VALUES (7788, 'SCOTT', 'ANALYST', 7566,TO_DATE('1982-12-09', 'YYYY-MM-DD'), 3000, NULL, 20);
INSERT INTO EMP VALUES (7839, 'KING', 'PRESIDENT', NULL,TO_DATE('1981-11-17', 'YYYY-MM-DD'), 5000, NULL, 10);
INSERT INTO EMP VALUES (7844, 'TURNER', 'SALESMAN', 7698,TO_DATE('1981-09-08', 'YYYY-MM-DD'), 1500, 0, 30);
INSERT INTO EMP VALUES (7876, 'ADAMS', 'CLERK', 7788,TO_DATE('1983-01-12', 'YYYY-MM-DD'), 1100, NULL, 20);
INSERT INTO EMP VALUES (7900, 'JAMES', 'CLERK', 7698,TO_DATE('1981-12-03', 'YYYY-MM-DD'), 950, NULL, 30);
INSERT INTO EMP VALUES (7902, 'FORD', 'ANALYST', 7566,TO_DATE('1981-12-03', 'YYYY-MM-DD'), 3000, NULL, 20);
INSERT INTO EMP VALUES (7934, 'MILLER', 'CLERK', 7782,TO_DATE('1982-01-23', 'YYYY-MM-DD'), 1300, NULL, 10);


CREATE TABLE BONUS(
	ENAME 		VARCHAR2(10),
	JOB 		VARCHAR2(9),
	SAL 		NUMBER,
	COMM 		NUMBER
	);

CREATE TABLE SALGRADE(
	GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER
	);

INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

CREATE TABLE DUMMY (DUMMY NUMBER);

INSERT INTO DUMMY VALUES (0);



alter table dept add constraint pk_dept_deptno primary key(deptno);
alter table emp add constraint pk_emp_empno primary key(empno);
alter table emp add constraint fk_emp_deptno foreign key(deptno) references dept(deptno); 

COMMIT;

select count(*) from emp;

SELECT * FROM EMP;
SELECT EMP NO, ENAME, DEPTNO FROM EMP;
SELECT DISTINCT DEPTNO FROM EMP;
SELECT ALL JOB DEPTNO FROM EMP;
SELECT * FROM DEPT;
SELECT DNAME , LOC FROM DEPT;
-- emp ���̺��� ����� ��ȣ, ����̸�, ������ ����ϼ���.
select EMPNO, ENAME, JOB FROM EMP;
SELECT EMPNO AS "EmployeeNumber", ENAME "��� �̸�", JOB ���� FROM EMP;
-- ȸ�系 ���� �������� ���
SELECT JOB FROM EMP;--�ߺ��� �߻��Ѵ�.
--ȸ�系 ���� �������� ���(�ߺ�����)
--�ߺ��� �����͸� �� ���� ����Ѵ�. 
SELECT DISTINCT JOB FROM EMP;
SELECT DISTINCT JOB, DEPTNO FROM EMP;
--�� Į���� ��ģ ���¿��� �ߺ��� �����Ѵ�. 
-- Į���� �ʹ� ���� �ɸ� ����Ʈ�� �� �ǹ̰� ������ �� ������ �����ؾ� �Ѵ�.

-- ��� �� 10�� �μ� ������ ������ ����ϼ���.
SELECT * FROM EMP WHERE DEPTNO = 10;

--��� �߿��� �޿��� 2000�̸��� �Ǵ� ����� �̸�, �޿��� ����ϼ���
SELECT ENAME, SAL FROM EMP WHERE SAL<2000;

--��� �� �̸��� 'SCOTT'�� ����� ���� ���
SELECT ENAME FROM EMP WHERE ENAME = 'SCOTT';

-- 82�� ���� �Ի��� ����� �̸��� �Ի��� ���
SELECT ENAME, HIREDATE FROM EMP WHERE HIREDATE >= '1982/1/1';
-- ����� �����ȣ, �̸�, �޿��� �����ȣ ������� ����ϼ���.
select empno, ename, sal from emp order by empno asc;
-- ����� �����ȣ, �̸�, �޿��� �޿��� ���� ������� ����ϼ���.
select empno, ename, sal from emp order by sal desc;
-- ����� �����ȣ, �̸�,�μ���ȣ�� �μ���ȣ���, �����ȣ ������� �����ϼ���.
select empno, ename, deptno from emp order by deptno asc, empno asc;
--����� �����ȣ, �̸�, �μ���ȣ�� �μ���ȣ ������������, �����ȣ �������� ������� �����ϼ���.
select empno, ename, deptno from emp order by deptno desc, empno asc;
-- �Ի����� ���� �ֱ��� ��� ������ ���, �̸�, �Ի��� ���
select empno, ename, hiredate from emp order by hiredate desc;

--�μ���ȣ�� 10���̰� ������ MANAGER�� ����� �̸��� �μ���ȣ, ���� ���
SELECT ENAME, DEPTNO, JOB FROM EMP WHERE DEPTNO = 10 AND JOB = 'MANAGER';
--�μ���ȣ�� 10���̰ų� ������ MANAGER�� ��� �̸��� �μ���ȣ, ���� ���
SELECT ENAME, DEPTNO, JOB FROM EMP WHERE DEPTNO = 10 OR JOB = 'MANAGER';
-- �����ȣ�� 7844�̰ų� 7654�̰ų� 7521�� ����� �����ȣ�� �̸� ���
SELECT EMPNO, ENAME FROM EMP WHERE EMPNO=7844 OR EMPNO =7654 OR EMPNO = 7521;
-- �޿��� 1000���� 3000���̿� �ִ� ����� �̸��� �޿� ���
SELECT ENAME, SAL FROM EMP WHERE SAL >= 1000 AND SAL <=3000 ORDER BY SAL;
SELECT EMPNO, ENAME FROM EMP WHERE EMPNO iN(7844,7654,7521);
SELECT ENAME, SAL FROM EMP WHERE SAL BETWEEN 1000 AND 3000;

--1982�⵵�� �Ի��� ����� �̸�, �Ի����� �Ի��� ������ �����ؼ� ����ϼ���.
SELECT ENAME, HIREDATE
FROM EMP 
WHERE HIREDATE BETWEEN '82/1/1' AND '82/12/31'
ORDER BY HIREDATE;

--�̸��� K�� �����ϴ� ����� ���, �̸�
SELECT EMPNO, ENAME FROM EMP WHERE ENAME LIKE 'K%';
--�̸��� N���� ������ ����� ���, �̸�
SELECT EMPNO, ENAME FROM EMP WHERE ENAME LIKE '%N';
-- �̸��� S�� ���� ����� ���, �̸�
SELECT EMPNO, ENAME FROM EMP WHERE ENAME LIKE '%S%';
-- �̸��� A�� ���� ����� ���, �̸�
SELECT EMPNO, ENAME FROM EMP WHERE NOT ENAME LIKE '%A%';
SELECT EMPNO, ENAME FROM EMP WHERE ENAME LIKE 'SCOTT';

--LIKE�� ��ǻ� =�� ����. ��ı�̶�� �̸��� ���� ��� �̾ƿͶ��� �ǹ̴�.
--���ϵ�ī�� X => = (����)
select 100+NULL from dual; -- null

--���� ������ �����ϱ� ���� ���̺�. ����� ���ٸ� �������� ������� �ִ� ���̺�.

--Ŀ�̼��� ���� ���� ����� �����ȣ, �̸�, Ŀ�̼�(comm), �μ���ȣ ���
select empno, ename, comm, deptno from emp where comm is null;

select *from emp;
-- ���� ��簡 ���� ����� �̸��� ����, ����� ���
select ename, job, mgr from emp where mgr is null;

--10�� �μ� ������� �����ȣ, �̸�, �޿�, �μ���ȣ ���
--20�� �μ� ������� �����ȣ, �̸�, �޿�, �μ���ȣ ���
SELECT EMPNO, ENAME, SAL, DEPTNO, JOB FROM EMP WHERE DEPTNO = 10
UNION --�ߺ��� ����. �����ϱ� ������ UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO = 20;

select empno, ename, deptno from emp
minus -- ������ 
select empno, ename, deptno from emp where deptno = 30;

select empno, ename, deptno from emp where job = 'MANAGER'
intersect -- ������
select empno, ename, deptno from emp where deptno = 30;

--����1
select * from emp where ename like '%S';
--����2
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN';
--����3
select empno, ename, sal, deptno from emp where deptno = 20 and sal > 2000
union
select empno, ename, sal, deptno from emp where deptno =30 and sal >2000;
--����4
select * from emp where sal < 2000 or sal >3000;
--����5
select ename, empno, sal, deptno  from emp where ename like '%E%' and deptno = 30
minus
select ename, empno, sal, deptno  from emp where sal between 1000 and 2000;
--����6
select * from emp where comm is null and mgr is not null and job = 'MANAGER' or job = 'CLERK'
minus
select * from emp where ename = '_L';