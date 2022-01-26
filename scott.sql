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
-- emp 테이블에서 사원의 번호, 사원이름, 직급을 출력하세요.
select EMPNO, ENAME, JOB FROM EMP;
SELECT EMPNO AS "EmployeeNumber", ENAME "사원 이름", JOB 직급 FROM EMP;
-- 회사내 직급 종류별로 출력
SELECT JOB FROM EMP;--중복이 발생한다.
--회사내 직급 종류별로 출력(중복제거)
--중복된 데이터를 한 번만 출력한다. 
SELECT DISTINCT JOB FROM EMP;
SELECT DISTINCT JOB, DEPTNO FROM EMP;
--두 칼럼을 합친 상태에서 중복을 제거한다. 
-- 칼럼을 너무 많이 걸면 디스팅트를 쓴 의미가 없어질 수 있으니 유의해야 한다.

-- 사원 중 10번 부서 직원의 정보를 출력하세요.
SELECT * FROM EMP WHERE DEPTNO = 10;

--사원 중에서 급여가 2000미만이 되는 사원의 이름, 급여를 출력하세요
SELECT ENAME, SAL FROM EMP WHERE SAL<2000;

--사원 중 이름이 'SCOTT'인 사원이 정보 출력
SELECT ENAME FROM EMP WHERE ENAME = 'SCOTT';

-- 82년 이후 입사한 사원의 이름과 입사일 출력
SELECT ENAME, HIREDATE FROM EMP WHERE HIREDATE >= '1982/1/1';
-- 사원의 사원번호, 이름, 급여를 사원번호 순서대로 출력하세요.
select empno, ename, sal from emp order by empno asc;
-- 사원의 사원번호, 이름, 급여를 급여가 높은 순서대로 출력하세요.
select empno, ename, sal from emp order by sal desc;
-- 사원의 사원번호, 이름,부서번호를 부서번호대로, 사원번호 순서대로 정렬하세요.
select empno, ename, deptno from emp order by deptno asc, empno asc;
--사원의 사원번호, 이름, 부서번호를 부서번호 내림차순으로, 사원번호 오름차순 순서대로 정렬하세요.
select empno, ename, deptno from emp order by deptno desc, empno asc;
-- 입사일이 가능 최근인 사원 순으로 사번, 이름, 입사일 출력
select empno, ename, hiredate from emp order by hiredate desc;

--부서번호가 10번이고 직급이 MANAGER인 사원의 이름과 부서번호, 직급 출력
SELECT ENAME, DEPTNO, JOB FROM EMP WHERE DEPTNO = 10 AND JOB = 'MANAGER';
--부서번호가 10번이거나 직급이 MANAGER인 사원 이름과 부서번호, 직급 출력
SELECT ENAME, DEPTNO, JOB FROM EMP WHERE DEPTNO = 10 OR JOB = 'MANAGER';
-- 사원번호가 7844이거나 7654이거나 7521인 사원의 사원번호와 이름 출력
SELECT EMPNO, ENAME FROM EMP WHERE EMPNO=7844 OR EMPNO =7654 OR EMPNO = 7521;
-- 급여가 1000에서 3000사이에 있는 사원의 이름과 급여 출력
SELECT ENAME, SAL FROM EMP WHERE SAL >= 1000 AND SAL <=3000 ORDER BY SAL;
SELECT EMPNO, ENAME FROM EMP WHERE EMPNO iN(7844,7654,7521);
SELECT ENAME, SAL FROM EMP WHERE SAL BETWEEN 1000 AND 3000;

--1982년도에 입사한 사원의 이름, 입사일을 입사일 순으로 정렬해서 출력하세요.
SELECT ENAME, HIREDATE
FROM EMP 
WHERE HIREDATE BETWEEN '82/1/1' AND '82/12/31'
ORDER BY HIREDATE;

--이름이 K로 시작하는 사원의 사번, 이름
SELECT EMPNO, ENAME FROM EMP WHERE ENAME LIKE 'K%';
--이름이 N으로 끝나는 사원의 사번, 이름
SELECT EMPNO, ENAME FROM EMP WHERE ENAME LIKE '%N';
-- 이름에 S가 들어가는 사원의 사번, 이름
SELECT EMPNO, ENAME FROM EMP WHERE ENAME LIKE '%S%';
-- 이름에 A가 없는 사원의 사번, 이름
SELECT EMPNO, ENAME FROM EMP WHERE NOT ENAME LIKE '%A%';
SELECT EMPNO, ENAME FROM EMP WHERE ENAME LIKE 'SCOTT';

--LIKE는 사실상 =와 같다. 스캇이라는 이름을 가진 사람 뽑아와라의 의미다.
--와일드카드 X => = (같다)
select 100+NULL from dual; -- null

--가장 데이터 조작하기 위한 테이블. 결과가 한줄만 나오도록 만들어져 있는 테이블.

--커미션을 받지 않은 사원의 사원번호, 이름, 커미션(comm), 부서번호 출력
select empno, ename, comm, deptno from emp where comm is null;

select *from emp;
-- 직속 상사가 없는 사원의 이름과 직급, 상사사번 출력
select ename, job, mgr from emp where mgr is null;

--10번 부서 사원들의 사원번호, 이름, 급여, 부서번호 출력
--20번 부서 사원들의 사원번호, 이름, 급여, 부서번호 출력
SELECT EMPNO, ENAME, SAL, DEPTNO, JOB FROM EMP WHERE DEPTNO = 10
UNION --중복값 제거. 제거하기 싫으면 UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO = 20;

select empno, ename, deptno from emp
minus -- 차집합 
select empno, ename, deptno from emp where deptno = 30;

select empno, ename, deptno from emp where job = 'MANAGER'
intersect -- 교집합
select empno, ename, deptno from emp where deptno = 30;

--문제1
select * from emp where ename like '%S';
--문제2
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN';
--문제3
select empno, ename, sal, deptno from emp where deptno = 20 and sal > 2000
union
select empno, ename, sal, deptno from emp where deptno =30 and sal >2000;
--문제4
select * from emp where sal < 2000 or sal >3000;
--문제5
select ename, empno, sal, deptno  from emp where ename like '%E%' and deptno = 30
minus
select ename, empno, sal, deptno  from emp where sal between 1000 and 2000;
--문제6
select * from emp where comm is null and mgr is not null and job = 'MANAGER' or job = 'CLERK'
minus
select * from emp where ename = '_L';