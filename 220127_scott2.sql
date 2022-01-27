--1교시
select comm from emp order by comm; --null뒤
select comm from emp order by comm desc; --null앞
select LPAD('DATABASE',20,' '), RPAD('DATABASE',20,' ') from dual;--전체 20자리 중에, 8자리를 채우고, 나머지를 지정문자로 채움.
select RPAD(substr(ename,1,2),length(ename), '*') 이름 from emp;

SELECT 
TRIM(LEADING FROM '  ABCD  ') LT,
LENGTH(TRIM(LEADING FROM '  ABCD  '))LT_LEN,
TRIM(TRAILING FROM '  ABCD  ') RT,
LENGTH(TRIM(TRAILING FROM '  ABCD  ')) RT_LEN,
TRIM(BOTH FROM '  ABCD  ') BOTH1,
LENGTH(TRIM(BOTH FROM '  ABCD  ')) BOTH1,
TRIM('  ABCD  ') BOTHT2, --이게 제일 중요
LENGTH(TRIM('  ABCD  ')) BOTHLEN2 FROM DUAL;

--2교시
--round(대상, [표시할 자리수])
select
ROUND(35.125, 1), -- 35.1
ROUND(35.125, 2), -- 35.13
ROUND(35.125), -- 35 (소수점 없으면 1의 자리부터 표시)
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
sysdate 오늘, 
sysdate - 1 어제, 
sysdate +1 내일 
from dual;

select (sysdate - hiredate) as "근무 일수" from emp;

--입사일로부터 40주년이 되는 날짜를 출력하세요
select empno, ename, hiredate, ADD_MONTHS(hiredate,480) "10year" 
from emp;

--입사일로부터 몇 개월이 지났는지
select sysdate, hiredate, MONTHS_BETWEEN(SYSDATE,hiredate)
from emp;

--현재로부터 오는 지정된 요일의 날짜 
alter session set NLS_LANGUAGE = AMERICAN;
select sysdate, next_day(sysdate, 'friday') from dual;

alter session set NLS_LANGUAGE = KOREAN;
select sysdate, next_day(sysdate, 6) from dual;

select sysdate, last_day(sysdate) from dual;

--3교시
select hiredate, round(hiredate,'MONTH') from emp where deptno = 10;
select hiredate, trunc(hiredate,'MONTH') from emp where deptno = 10;
--입사일을 출력하되 요일까지 출력
select TO_CHAR(hiredate, 'yyyy/MON/dd DY') --hiredate를 지정한 패턴 문자로 출력
from emp where deptno = 10;

select sysdate, to_char(sysdate,'YYYY/MM/DD, HH24:MI:SS') from dual;
--숫자를 문자열로 바꿔주는 패턴
select ename, sal, to_char(sal,'L999,999') from emp where deptno = 10;
--L:로컬 그 지역의 화폐 
select ename, sal, to_char(sal,'$999,999') from emp where deptno = 10;

select '10,000'+'20,000' from dual; -- 에러
--문자열을 숫자로 바꿀 떄 to_number를 씁니다.
select TO_NUMBER('10,000','99,999')+TO_NUMBER('20,000','99,999') 
from dual;

-- 19821209에 입사한 사원의 정보출력
select empno, ename, hiredate
from emp
where hiredate = to_date(19821209,'yyyymmdd'); 

-- 올해 며칠이 지났는지 날짜계산
select round(sysdate - to_date('2022/01/01','yyyy/mm/dd'))
from dual;

-- 올해 며칠이 지났는지 날짜계산 - 오늘 포함하고 싶지 않다면 trunc
select trunc(sysdate - to_date('2022/01/01','yyyy/mm/dd'))
from dual;

--연봉 구하기 SAL*12+comm
select empno, ename, sal*12+comm 연봉, sal*12*12+NVL(comm,0) 연봉2 from emp;
select empno, enaeme, NVL2(comm, sal*12+comm, sal*12) 연봉
from emp;

--4교시
--모든 사원은 자신의 상관이 있다.
--그러나 emp테이블에 유일하게 상관없는 레코드가 있는데,
-- 그 사원의 mgr 칼럼 값은 null이다.
--상관이 없는 사원만 출력하되, 
--mgr 칼럼 값 null 대신 CEO로 출력해보자.
select empno, ename, NVL(to_char(mgr),'CEO') --mgr이 넘버타입, ceo는 문자열 varchar2타입
--NVL함수 사용시 주의할 점: 안의 두 요소가 타입이 같아야 한다.
from emp 
where mgr is null;

--NVL2를 활용한 문제풀이
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

--직급에 따라 급여를 인상하도록 하자. 
--(사원번호, 사원명, 직급, 급여, 인상된 급여9upsal))
--직급이 'ANAlYST'인 사원은 5%, 'SALESMAN'인 사원은 10%, 
--'MANAGER'인 사원은 15%, 'CLERK'인 사원은 20%인 인상한다.
select empno, ename, job, sal, 
case when job = 'ANALYST' THEN SAL *1.05
WHEN JOB = 'SALESMAN' THEN SAL *1.1
WHEN JOB = 'MANAGER' THEN SAL*1.15
WHEN JOB = 'CLERK' THEN SAL*1.2
end
as "upsal"
from emp;

--5교시
select to_char(sum(sal),'$999,999') as total from emp;
select round(avg(sal)) as average from emp;
select min(sal) 최저급여, max(sal) 최대급여 from emp;
--전체 레코드의 수는 count(*)
select count(*) from emp;

--모든 직원의 커미션 합. 
select sum(comm) from emp;--널을 제외하고 계산
select avg(comm) from emp;--널을 제외하고 계산
select count(comm) from emp;--널을 제외하고 카운트

select sum(sal), sal from emp; -- 에러. sum(sal)은 1줄, sal은 14줄
select deptno, sum(sal), round(avg(sal))
from emp
group by deptno;

--부서별로 사원 수와 커미션 받는 사원 수 출력
--select count(*)
--from emp
--group by deptno;
--select count(*)
--from emp
--where comm is not null;
select deptno, count(*), count(comm) from emp group by deptno;

--부서별로 가장 최근에 입사한 사원의 입사일 출력
--select hiredate
--from emp
--where min(sysdate-hiredate)
--group by deptno;
select deptno, max(hiredate) from emp group by deptno;

--그룹 여러 개 지정
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
WHERE SAL >= 2000 --whre절에서 그룹함수 절을 쓰면 안된다.
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
           LISTAGG(ENAME, ', ') --가로로 나열할 컬럼 이름, 구분자
           WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
      FROM EMP
    GROUP BY DEPTNO;
    
    SELECT ENAME 
     , SAL 
     , RANK() OVER (ORDER BY SAL DESC) AS "RANK" 
     , DENSE_RANK() OVER (ORDER BY SAL DESC) AS "DENSE_RANK" 
  FROM EMP 
 ORDER BY SAL DESC;
 
 
--7교시
--P.212-213,2,3,4
--2. 같은 직책의 사원이 3명 이상인 직책과 인원수 출력
-- select job, count(job)>=3 from emp group by job;
select count(*) 인원수, job 직책 from emp group by job having count(*) >=3;

--3. 입사년도를 기준으로 부서별로 몇명 입사했는지 출력
--select the_char(hiredate,'yyyy') as "HIRE_YEAR",deptno, count(hiredate)
--from emp
--group by the_char(hiredate,'yyyy');
select to_char(hiredate,'yyyy') as "HIRE_YEAR", deptno, count(*) 인원수
from emp
group by to_char(hiredate,'yyyy'), deptno;

--4. 추가수당을 받는 사원과 받지 않는 사원 수 출력
select nvl2(comm, 'O', 'X') comm, count(*) 인원수
from emp
group by nvl2(comm, 'O', 'X');

--조인
select * from emp, dept order by empno; --한 사람에 대해 부서가 10,20,30,40 다 들어감
--이렇게 조인을 하면 안된다. 테이블명만 나열하면 안된다.
--WHERE 절을 활용하여 조인의 조건을 걸어줘야 한다. 

--Equip join : 컬럼의 값이 같은 경우 조인한다.
select * from emp, dept where emp.deptno = dept.deptno; 
--컬럼명이 같은 경우, 반드시 테이블명.컬럼명 이렇게 해줘야 한다.
--컬럼명이 다르면 안해줘도 된다.
--셀렉트절 where절 테이블명 적어줌. emp.deptno, ename, dname
select * from emp e, dept d where e.deptno = d.deptno
-- from절에서 테이블 별칭을 정해준다 > where절에서 별칭으로 써준다.
select * from dept;

select * from salgrade;
select * from emp; --위의 테이블과 공통의 열이 없다. sal에 관련된 비슷한 것만 있을 뿐(hisal, losal)

select e.empno, e.ename, s.grade  --컬럼 앞에 테이블 별칭 적어주면 구분이 쉬워져서 좋은 코드가 된다. 
from emp e, salgrade s 
where e.sal between s.losal and s.hisal and e.deptno=10;

--8교시
--20번 부서 사원의 사번, 이름, 부서명을 출력
select e.empno, e.ename, d.dname, d.deptno
from emp e, dept d
where e.deptno = d.deptno and e.deptno=20;
-- where안에서 조건이 두개 이상이면 and로 연결한다.
-- 아래는 위와 같은 결과물이지만, inner조인으로 표현.
select e.empno, e.ename, d.dname, d.deptno
from emp e inner join dept d  --이너 조인 표시
on e.deptno = d.deptno where empno=7788; --조인 조건, --뒤에 where절 가능

select *
from emp e inner join dept d
using (deptno) where empno = 7788;--뒤에 where절 가능

select *
from emp e NATURAL JOIN dept d where empno=7788;--뒤에 where절 가능