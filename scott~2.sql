--1. 사원 이름이 s로 끝나는 사원 데이터를 모두 출력
select * 
from emp 
where ename like'%S';

--2. 30번 부서에서 근무 사원 중 
--직책이 SALESMAN인 사원의 번호,이름,직책,급여,부서번호 출력
select empno, ename, job, sal, deptno 
from emp 
where deptno = 30 and job = 'SALEMAN';

--3. 20번, 30번 부서에서 근무하고 있느 ㄴ사원 중 급여가 200초과인 사원의
-- 번호, 이름, 급여 부서번호 출력하세요.
select empno, ename, sal, deptno 
from emp
where deptno = 20 and sal>2000
union
select empno, ename, sal, deptno 
from emp
where deptno = 30 and sal>2000;
--짧은 버전. in을 이용해서 20 또는 30을 맞춰줌
select empno, ename, sal, deptno
from emp
where deptno in(20,30) and sal>2000;

--4. 급여가 2000이상 3000이하의 범위 이하의 값 가진 사원 데이터 모두 출력
select *
from emp
where not sal between 2000 and 3000;
--또는
select *
from emp
where sal < 2000 or sal >3000;

--5. 사원 이름에 E가 포함되어 있는 30번 부서 사원 중 급여가 1000~2000 사이가
--아닌 사원의 번호, 이름, 급여, 부서번호를 출력하세요
select empno, ename, sal, deptno
from emp
where ename like '%E%' 
AND deptno = 30
and sal not between 1000 and 2000; 

--6. 커미션이 존재하지 않고, 상급자가 있고,
--직책이 'MANAGER', 'CLERK'인 
--사원의 정보 모두 출력
select*
from emp
where comm is null
and mgr is not null
and job in ('MANAGER','CLERK');