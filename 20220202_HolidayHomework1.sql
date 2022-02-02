---선선물1
-- 1 부서번호가 10번인 부서의 사원 중 사원번호, 이름, 월급을 출력하라.
select empno, ename, sal
from emp
where deptno = 10;

-- 2 사원번호가 7369인 사원 중 이름, 입사일, 부서번호를 출력하라.
select ename, hiredate, deptno
from emp
where empno =7369;

-- 3 이름이 ALLEN인 사원의 모든 정보를 출력하라.
select *
from emp
where ename = 'ALLEN';

-- 4 입사일이 83/01/12인 사원의 이름, 부서번호, 월급을 출력하라.
select ename, deptno, sal
from emp
where hiredate = '83/01/12';

-- 5 직업이 MANAGER가 아닌 사원의 모든 정보를 출력하라.
select *
from emp
where job != 'MANAGER';


-- 6 입사일이 81/04/02 이후에 입사한 사원의 정보를 출력하라.
select *
from emp
where hiredate > '81/04/02';

-- 7 급여가 800 이상인 사원의 이름, 급여, 부서번호를 출력하라.
select ename, sal, deptno
from emp
where sal >= 800;

-- 8  사원번호가 7654와 7782 사이 이외의 사원의 모든 정보를 출력하라.
select *
from emp
where empno not between 7654 and 7782;

-- 9 사원의 100% 인상된 급여를 "새급여" 헤딩으로 출력하라.
--단 구급여가 2000이하인 사원으로 제한
select sal*2 as "새급여"
from emp
where sal > 2000;


---설선물2
-- 1. 모든 사원들에게 급여의 20%를 보너스로 지불하기로 하였다. 이름, 급여, 보너스 금액을  출력하라.
select ename, sal, sal*0.2 as "보너스 금액"
from emp;
 
-- 2. 급여가 2,000 이상인 모든 사원은 급여의 15%를 경조비로 내기로 하였다.
-- 이름, 급여, 경조비 를 출력하라.
select ename, sal, sal*0.15 as "경조비"
from emp
where sal >= 2000;

-- 3. 부서번호가 20인 부서의 시간당 임금을 계산하여 출력하라.
-- 단 이달의 근무일수가 12일이고, 1일 근무시간은 5시간이다.
-- 출력양식은 이름, 급여, 시간당 임금을 출력하라.
select ename 이름, sal 급여, round(sal/(12*5)) as "시간당 임금"
from emp
where deptno = 20;

-- 4. 입사일이 81/04/02보다 늦고 82/12/09보다 빠른 모든 정보를 출력하라.
select *
from emp
where hiredate < '82/12/09' and hiredate > ' 81/04/02';

-- 5. 급여가 1,600보다 크고 3,000보다 작은 사원의 이름, 직업(업무), 급여를 출력하라.
select ename 이름, job "직업(업무)", sal 급여
from emp
where sal between 1600 and 3000;

-- 6. 직업이 MANAGER와 SALESMAN인 사원의 모든 정보를 출력하라.
-- 단, 부서번호로 ASCENDING SORT  한 후 급여가 많은 사원 순으로 출력하라.
select *
from emp 
where job = 'MANAGER' or job = 'SALESMAN'
order by deptno asc, sal desc;

-- 7. 부서번호가 20, 30번을 제외한 모든 사원의 모든 정보를 출력하라.
select *
from emp
where deptno != 20 and deptno != 30;

-- 8. 입사일이 81년도인 사원의 모든 정보를 출력하라.
select *
from emp
where to_char(hiredate, 'yy')='81';

-- 9. 이름이 S로 시작하고 마지막 글자가 T인 사원의 모든 정보를 출력하라
-- (단, 이름은 전체 5자리이다.)
-- **맞는 것 같은데, 왜 안되는지 모르겠다??? 질문 필요. => eame like!
select *
from emp
where ename like 'S___T';

--- 설선물3

-- 1. 입사일이 81년도인 사원의 모든 정보를 출력하라.(substr 활용)
select *
from emp
where substr(hiredate, 1, 2) = '81';

-- 2. 이름이 S로 시작하고 마지막 글자가 T인 사원의 모든 정보를 출력하라.(substr 활용)
--  (단, 이름은 전체 5자리이다.)
select *
from emp 
where substr(ename, 1, 1) = 'S' and substr(ename, 5, 1) = 'T';

-- 3. 이메일(tester@naver.com) 에서 도메인네임(naver.com) 추출하라.
select substr('tester@naver.com',8,9) 도메인네임
from dual;

-- 4. 'WELCOME TO ORACLEJAVA.'에서  온점 '.'을 삭제후 모든 문자를 소문자로 변경하여 'e'의 개수를  출력하라.
select length(lower(replace('WELCOME TO ORACLEJAVA.','.'))) 
- length(replace(lower(replace('WELCOME TO ORACLEJAVA.','.')),'e')) as "e의 개수" 
from dual;

-- 5. 입사일 부터 지금까지의 날짜수를 출력하라. (소수점 이하 절삭)
-- 출력양식은 부서번호, 이름, 입사일, 현재일, 근무일수, 근무년수, 근무월수, 근무주수를 출력하라.
select deptno, ename, hiredate, sysdate,
round(sysdate - hiredate) 근무일수,
round((sysdate - hiredate)/365) 근무년수,
round(months_between(sysdate,hiredate)) 근무월수,
round((sysdate - hiredate)/7) 근무주수
FROM EMP;


