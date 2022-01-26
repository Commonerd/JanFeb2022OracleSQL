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

select 'DataBase', LOWER('DataBase') from dual;
--테이블 안에 원본데이터는 변경되지 않는다.
--사원테이블에서 부서번호가 10번인 사원명을 모두 소문자로 변환
select ename, LOWER(ename)
from emp
where deptno = 10;
--대문자로 변환
select 'DataBase', UPPER('DataBase') from dual;

--직급이 'manager'인 사원을 검색
select ename, job from emp where UPPER(job) = UPPER('manager');

select INITCAP('DATA BASE PROGRAM') from dual;

--이름이 'Smith'인 사람의 정보 출력 
select * from emp where INITCAP(ename) = 'Smith';
select * from emp where ename = UPPER('Smith');

--이름에 a가 있는 사원의 정보 출력
select * from emp where upper(ename) like upper('%a%');
select concat('Data', 'Base') from dual;--mySQL에서 많이 쓴다.
select 'Data'||'Base' from dual; 
-- ||는 문자열 두 개를 더해준다.이걸 많이 쓴다. 
select ename||'의 사원번호는 '|| empno||'입니다.' from emp;

select length('data'), length('데이터') from dual;
select 'DataBase', substr('DataBase',1,4), substr('DataBase',5),--지정안하면 끝까지잘라옴
substr('DataBase',-1,1),substr('DataBase',-4,4) from dual;

select ename, hiredate, substr(hiredate,1,2) year from emp where substr(hiredate,1,2) = 81;
-- 이름이 k로 끝나는 직원의 정보 출력(like쓰지 말고 substr사용)
select * from emp where substr(ename,-1,1) = UPPER('k');
select instr('DataBase','D') from dual; --1
select instr('DataBase','a') from dual; --2
select instr('DataBase','a',3) from dual; --4 (3번 인덱스부터 찾아주세요)
select instr('DataBase','z') from dual; -- 0. 해당글자 없음.

--이름의 두 번째 자리에 'A'가 있는 사원의 이름 출력(instr)
select ename from emp where instr(ename,'A',2) = 2;

select '010-1111-2222', replace('010-1111-2222','-',' ') 
, replace('010-1111-2222','-')
from dual;
