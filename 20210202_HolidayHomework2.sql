---설 선물4
-- 1. 입사일을 "2022년 5월 14일" 의 형식으로 이름, 입사일을 출력하라.
select ename 이름, to_char(hiredate, 'yyyy"년"mm"월"dd"일"') 입사일
from emp;

--2. 사원의 이름과  입사일 그리고 입사일을 상반기,하반기로 나누어서  출력하라.(decode 활용)
--출력양식 예   SMITH 80/12/17 하반기
-- **모르겠다. 질문 필요함!
select ename, hiredate, 
decode(th_char(hiredate, 'mon'), 
'1월', '상반기',
'2월', '상반기',
'3월', '상반기',
'4월', '상반기',
'5월', '상반기',
'6월', '상반기',
'7월', '하반기',
'8월', '하반기',
'9월', '하반기',
'10월', '하반기',
'11월', '하반기',
'12월', '하반기') as 입사일
from emp;

--3. 사원의 이름과  입사일 그리고 입사일을 상반기,하반기로 나누어서  출력하라.(case 활용)
--출력양식 예   SMITH 80/12/17 하반기
-- **모르겠다. 질문 필요함!
select ename 이름, hiredate 입사일, 
CASE WHEN to_char(hiredate, 'mon')='1월' THEN '상반기'
WHEN to_char(hiredate, 'mon')='2월' THEN '상반기'
WHEN to_char(hiredate, 'mon')='3월' THEN '상반기'
WHEN to_char(hiredate, 'mon')='4월' THEN '상반기'
WHEN to_char(hiredate, 'mon')='5월' THEN '상반기'
WHEN to_char(hiredate, 'mon')='6월' THEN '상반기'
WHEN to_char(hiredate, 'mon')='7월' THEN '하반기'
WHEN to_char(hiredate, 'mon')='8월' THEN '하반기'
WHEN to_char(hiredate, 'mon')='9월' THEN '하반기'
WHEN to_char(hiredate, 'mon')='10월' THEN '하반기'
WHEN to_char(hiredate, 'mon')='11월' THEN '하반기'
WHEN to_char(hiredate, 'mon')='12월' THEN '하반기'
END as 입사일
FROM EMP;

--4. 회사내의 최소급여와 최대급여의 차이를 구하라
select max(sal)-min(sal)
from emp;

--5. DEPT 테이블의 모든 부서수를 출력하라.
select count(deptno)
from dept;

-- 6. JOB과 그 JOB별 사원수 및 그 JOB에 속한 사원 이름의 총자리수(길이)를 출력하라.
-- 단 사원수가 3이상인 경우만 출력한다. 
select job, count(*) as 사원수, sum(length(ename))
from emp
group by job;


---설선물5
--1. 이름에 "M"자가 들어간 사원들의 이름,부서명,급여를 구하라 
select ename, dname, sal
from emp natural inner join dept
where ename like '%M%';

--2. SCOTT의 급여에서 1000 을 뺀 급여보다 적게 받는 사원의 이름,급여를 출력하라.
select ename, sal 
from emp
where  sal < (select sal-1000
from emp
where ename = 'SCOTT');


--3. JOB이 SALESMAN인 사원들 중 최소급여를 받는 사원보다  급여가 적은 사원의 이름, 급여를 출력하라
select ename, sal
from emp
where sal < (select min(sal) 
from emp 
where job = 'SALESMAN');

--4. WARD가 소속된 부서 사원들의 평균 급여보다 , 급여가 높은 사원의 이름 ,급여를 출력하라.
select ename, sal
from emp
where sal > (select avg(sal) 
from emp 
where deptno = (select deptno 
from emp 
where ename = 'WARD'));

--5. 이름에 "K"자가 들어가는 사원들 중 가장 급여가 적은 사원의 부서명,사원의 이름, 급여를 출력하라.
select dname, ename, sal
from emp natural inner join dept
where sal = (select min(sal) from emp where ename like '%K%');



