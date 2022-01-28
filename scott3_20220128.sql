select * from emp;

--사원의 사번, 이름과 상사의 사원번호, 이름을 출력
select *
from emp e, emp m -- 같은 테이블, 서로 다른 이름 지정
where e.mgr = m.empno;

select e.empno 사원번호, e.ename 사원이름, m.empno 상사이름
from emp e, emp m
where e.mgr = m.empno;

--outer join
select *
from emp, dept
where emp.deptno(+) = dept. deptno; --부족한 부분에 +를 붙인다. 
--40번 부서 꺼내오도록 null을 불러와서 끼워버림
--(+)의 의미는 조인할 대상이 없는 애한테 null레코드를 추가하겠다는 의미
-- 그러므로 부족한 애한테 붙여줘야 한다. emp.deptno가 아니라, dept.deptno에 붙이면 안된다.

SELECT *
FROM EMP FULL JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

--1.급여가 2000초과인 사원들의 부서정보, 사원정보를 출력
--(부서번호, 부서명// dept 테이블
--사원번호, 사원이름, 급여) // emp 테이블

select deptno, dname, empno, ename, sal
from emp natural inner join dept
where sal > 2000;
-- 별칭 붙이지 말라고 메시지 나옴. 정답 맞춤 Good~
-- 다른 풀이 방식 
select d.deptno, d.dname, e.empno, e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.sal > 2000;

--2. 각 부서별 부서번호, 부서명, 평균 급여,최대급여, 최소급여 ,사원수 출력
select deptno, dname, trunc(avg(sal)) "평균", max(sal)"최대급여", min(sal) "최소급여", count(*) "사원수"
from emp natural join dept
group by deptno, dname;
--from통해 조인 먼저 하고, group by를 해서 그룹별로 묶어주고
--거의 다 맞고, avg, max 등에 (sal)이 아니라 (deptno)를 엉뚱하게 넣음

--3. 모든 부서정보와 사원정보를  
--부서번호, 사원이름 순으로 정렬시켜 출력(부서번호, 부서명, 사원번호, 사원이름, 직급, 급여)
select e.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e full outer join dept d 
on (e.deptno = d.deptno) 
order by d.deptno, e.empno;
-- 정답~ Good~

--4. 모든 부서정보, 사원정보, 급여 등급, 직속 상관 정보를 
-- 부서번호, 사원번호 순서대로 정렬해서 출력하세요.
--(부서번호, 부서명, 사원번호, 사원명, 급여, 상사번호, 
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
from emp e right outer join dept d--right를 기준으로 조인하겠다. 또는full
on e.deptno = d.deptno
left outer join salgrade s
on e.sal between s.losal and s.hisal
left outer join emp m
on e.mgr = m.empno
order by d.dname, e.empno;

--<4교시>
--'SCOTT'(EMP테이블에 있음)의 부서명(DEPT테이블에 있음)을 출력하세요.
-- 부서번호 구한다음에, DEPT테이블에서 해당 부서의 번호에 맞는 부서명 꺼내오기
select dname
from dept
where deptno = (select deptno
                from emp 
                where ename = 'SCOTT');--서브 쿼리 괄호문 안에 들어가면 ; 세미콜론 떼어낸다.

--Q.'SMITH'와 같은 부서에서 근무하는 사원의 정보 출력
select *
from emp
where deptno = (select deptno
                from emp
                where ename = 'SCOTT')
                and ename <>'SMITH'; -- 스미스 이름은 빼고 싶을 때.
                

--Q2. 'NEW YORK'에서 근무하는 사원들의 이름 출력
select ename
from emp
where deptno = (select deptno
from dept
where loc = 'NEW YORK');

--Q3. 급여를 3000이상 받는 사원이 소속된 부서와 
--동일한 부서에서 근무하는 사원 출력
--(이름, 급여, 부서번호)
select ename, sal, deptno
from emp
where deptno in (select distinct deptno --결과물이 20, 10으로 두줄=>다중행
from emp
where sal >= 3000);

--Q4. 30번 부서 소속 사원 중 급여를 제일 많이 받는 사원보다
--더 많은 급여를 받는 사람의 이름, 급여 출력
select ename, sal from emp where sal > 
(select max(sal) from emp where deptno = 30);

--all 사용. 
select ename, sal from emp where sal > all 
--all은 이퀄스 기능까지 같이 있음. 
--해당 조건식이 모두 참일때만 꺼내오겠다라는 의미.
(select sal from emp where deptno = 30);

--any 사용
select ename, sal from emp where sal > any
--해당 조건식 중에 하나라도 참이면 꺼내오겠다라는 의미.
(select sal from emp where deptno = 30);

--<5교시>
select * from emp where 1 = 0; --false만 만들면 된다.

--exists
select * from emp where exists --서브쿼리에서 가져온 레코드가 하나라도 있으면 '참', 없으면 '거짓'
(select * from emp where deptno = 10);
-- 서브쿼리에 결과가 하나라도 있으면 메인 쿼리 실행 가능
-- 서브쿼리에 결과가 하나라도 없으면 메인 쿼리 실행 불가

--Q1.부서별로 최고 급여와 부서번호 출력. 
select * from emp where (deptno, sal)  --컬럼 여러개니까 괄호.비교할 컬럼이 여러개라면 in으로..
in (select deptno, max(sal) from emp group by deptno);

select deptno, ename
from
(select * from emp where deptno = 10) e10,
 (select * from dept) d
    where e10.deptno = d.deptno;
-- 서브쿼리 두개를 조인해서 테이블로 쓸 수도 있다~

--with
with
e20 as (select * from emp where deptno = 20),
d as (select * from dept)
select e20.deptno, e20.empno, ename, dname, loc
from e20, d
where e20.deptno = d.deptno;

--rownum
select e.*, rownum r --정렬된 상태로 로우넘. 
from
(select * from emp order by sal desc) e
where rownum <=3; 

--연봉 순위 4,5,6등 출력
--select e.*, rownum r
--from (select * from emp order by sal desc) e
--where rownum between >=4 and rownum <= 6; 
--에러가 난다. 
--왜? row넘을 지정한 순간부터는 1부터만 꺼내올 수 있다. 
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

--Q. 전체사원 중
--'ALLEN'과 같은 직책인 사원들의
--사원정보, 부서정보를 출력하세요.
--(직책, 사원번호, 이름, 급여, 부서번호, 부서이름)
select job, empno, ename, sal, deptno, dname
from emp natural inner join dept
where job = (select job from emp where ename = 'ALLEN')
and ename != 'ALLEN';

--Q2. 전체 사원의 평균 급여보다 --> 따로 뽑아야 한다.
-- 높은 급여를 받는 사원들의 정보를 출력하세요.
-- (사원번호, 사원이름, 부서이름, 입사일, 근무지, 급여, 급여등급)
--select empno, ename, dname, hiredate, loc, sal
--from emp natural inner join dept
--where emp.sal>(select avg(count(emp.sal)) from emp g);  
select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
from emp e, dept d, salgrade s 
where e.deptno = d.deptno and e.sal between s.losal and s.hisal
and sal > (select avg(sal)from emp)
order by e.sal desc, e.empno;


--Q3. 10번 부서에서 근무하는 사원 중 30번 부서에는 존재하지 
--않는 직책을 가진 사원들의 정보를 출력하세요
--(사원번호, 사원이름, 직책, 부서번호, 부서명, 근무지)
--select empno, ename, job, deptno, dname, loc
--from emp natural join dept
--where deptno = 10
--having jobdepno = 30 ; 
select empno, ename, job, deptno, dname, loc
from emp natural join dept
where deptno = 10 and job not in 
(select distinct job from emp where deptno = 30);


--Q4. 직책이 SALESMAN인 사람들의
--최고급여보다 높은 급여를 받는
--사원들의 정보를 출력하세요.
--(사원번호, 사원이름, 급여, 급여 등급)
select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and e.sal > (select max(sal) from emp where job = 'SALESMAN');
--90%. max에 sal을 생각못함. 
--다른 풀이 : ALL사용 전부다 큰 애들만 뽑기
select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and e.sal > all
(select distinct sal from emp where job='SALESMAN');