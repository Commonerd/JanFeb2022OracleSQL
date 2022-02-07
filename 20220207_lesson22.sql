CREATE VIEW vw_emp20 
as (select empno, ename, job, deptno 
    from emp where deptno = 20);
    
select * from user_views; 

select * from vw_emp20;

insert into vw_emp20
values(8000, 'JAVAKIM','SALESMAN',20);
select * from emp;--뷰가 보여지지 않는 부분은 NULL로 나온다.
--뷰가 보여줄 수 있는 부분은 empno, ename, job, deptno 
delete from vw_emp20 where empno = 8000;
select * from emp;

commit;

--부서별 급여 총액, 평균을 구하는 작업(view_sal)
create or replace view view_sal
as (select deptno, sum(sal) as "SalSum" , round(avg(sal)) as "SalAvg"
    from emp group by deptno);
    --> 에러가 난다? select의 sum, avg 부분에  별칭(알리아스) 붙여줘야 함.
    
select * from view_sal;

--사원번호, 사원명, 급여, 부서번호, 부서명, 근무지를 출력하는 view(vw_emp_dept)를 생성하시오.
create or replace view vw_emp_dept
as select empno, ename, sal, deptno, dname, loc
    from emp natural join dept order by empno asc;

select * from vw_emp_dept;
----
create or replace view vw_chk20
as select empno, ename, sal, comm, deptno from emp
    where deptno = 20 with check option;-->deptno 값은 변경할 수 없다. 
    --뷰 생성시 조건으로 지정한 칼럼 값을 변경하지 못하도록 하는 것. 
select * from vw_chk20;

update vw_chk20 set deptno = 10 where sal >=5000;

----
create or replace view vw_read30
as select empno, ename, sal, comm, deptno from emp
where deptno = 30 with read only; --데이터조작어 (DML) 작업 불가
select * from vw_read30;
update vw_read30 set comm = 1000;

---<3교시>
select rownum, e.* from emp e;
select rownum, e.* from emp e order by sal desc;-->로넘버를 쓰는 게 그다지 의미가..
select rownumb, e.* 
from (select *from emp e order by sal desc) e; -->먼저 정렬시키고 가상번호 부여. 얘도 '뷰'다
--셀렉트문이 길다면 with 선언하여 해당별칭으로만 쓰는 방법도 있다.
with e as (select * from emp e order by sal desc)
select rownum, e.* from e where rownum <=3;

--문제풀이
--1. 사원 번호와 사원명과 부서명과 부서의 위치를 출력하는 뷰(VIEW_LOC)를 작성하세요.
create or replace view view_loc
as select empno, ename, dname, loc from emp natural join dept;
select * from view_loc;

--2. 30번 부서 소속 사원의 이름과 입사일과 부서명을 출력하는 뷰(VIEW_DEPT30)를 작성하세요.
create or replace view view_dept30
as 
(select ename, hiredate, dname
from emp natural join dept
where deptno = 30);
select * from view_dept30;

--3. 부서별 최대 급여 정보를 가지는 뷰(VIEW_DEPT_MAXSAL)를 생성하세요.
create or replace view view_dept_maxsal
as (select deptno, max(sal) as "MaxSal"
from emp
group by deptno);
select * from view_dept_maxsal;

--4. 급여를 많이 받는 순서대로 5명만 출력하는 뷰(VIEW_SAL_TOP5)를 작성하세요.
--create or replace view view_sal_top5
--as (select * from emp
--where (select rownumb
--from 
--(select * from emp e order by sal desc) e) <=5);
select rownum, empno, ename
from 
(select *from emp e order by sal desc)
where rownum <=5 ;

--5. 급여를 많이 받는 순서대로 6~10등까지 출력
-- 1. 정렬
-- 2. 가상번호 (별칭) 붙이기
-- 3. 원하는 번호의 레코드 가져오기
select r, empno, ename, sal --rownum을 여기서 붙이면 새롭게 가상번호가 다시 붙음
from (select rownum r, empno, ename, sal --여기서 가상번호 붙이기
from
(select * from emp e order by sal desc))
where r >=6 and r <=10;


--<4-5교시, quiz3. 문제 풀기>
--1
drop table subject purge;
--create table subject (
--    no number(2) primary key,
--    s_num varchar2(2) not null,
--    s_name varchar(30) not null
--    );
    
create table subject (
    no number not null,
    s_num varchar2(2) not null,
    s_name varchar(30) not null,
    unique(no),
    primary key(s_num)
    );
--시퀀스 이용해 레코드 5개 추가 
insert into subject values(1,'01','컴퓨터학과');
insert into subject values(2,'02','교육학과');
insert into subject values(3,'03','신문방송학과');
insert into subject values(4,'04','인터넷비즈니스과');
insert into subject values(5,'05','기술경영과');

--2
drop table student purge;
--create table student(
--  no number(2) primary key,
--  sd_num number(8) not null, 
--  sd_name varchar2(20) not null,
--  sd_id varchar2(10) not null,
--  sd_passwd varchar2(20) not null,
--  s_num varchar2(2) references subject(s_num),
--  --학과 테이블(subject)에 있는 학과번호(s_num)를 학생테이블(student)에 있는 학과번호(s_num)의 참조키로 설정.
--  sd_jumin number(12) not null,
--  sd_hpone varchar2(20) not null,
--  sd_address varchar2(50) not null,
--  sd_email varchar2(30) not null,
--  sd_date date default(sysdate)
--  );
create table student(
  no number not null,
  sd_num number(8) not null, 
  sd_name varchar2(12) not null,
  sd_id varchar2(12) not null,
  sd_passwd varchar2(12) not null,
  s_num varchar2(2) not null,
  sd_date date default(sysdate),
  unique(no),
  primary key(sd_num),
  unique(sd_id),
  foreign key(s_num) references subject(s_num)--학과 테이블(subject)에 있는 학과번호(s_num)를 학생테이블(student)에 있는 학과번호(s_num)의 참조키로 설정.
);  
  
  sd_jumin number(12) not null,
  sd_hpone varchar2(20) not null,
  sd_address varchar2(50) not null,
  sd_email varchar2(30) not null,
  
  );


--3
drop table lesson purge; 
--create table lesson (
--no number(2) primary key,
--l_num varchar(10) not null,
--l_name varchar2(30) not null
--);

create table lesson (
no number not null,
l_num varchar(2) not null,
l_name varchar2(20) not null,
unique(no),
primary key(l_num)
);

insert into lesson values(1,'K','국어');
insert into lesson values(2,'M','수학');
insert into lesson values(3,'E','영어');
insert into lesson values(4,'H','역사');
insert into lesson values(5,'P','프로그래밍');
insert into lesson values(6,'D','데이터베이스');
insert into lesson values(7,'ED','교육학이론');

--4
--create table trainee (
--no number(2) primary key --일련번호, 시퀀스 사용
--sd_num number(8) references student(sd_num)--학번
----수강테이블에는 학번은 반드시 학생테이블에 있는 학번만 입력
--l_num number(2) references subject(--과목번호
----과목번호는 반드시 과목테이블에 있는 과목번호만 입력
--t_section varchar(10) not null --과목구분
--t_date date default(sysdate) --등록일자
drop table trainee purge; 
create table trainee (
no number not null,--일련번호, 시퀀스 사용
sd_num number(8) references student(sd_num),--학번
--수강테이블에는 학번은 반드시 학생테이블에 있는 학번만 입력
l_num number(2) not null,--과목번호
--과목번호는 반드시 과목테이블에 있는 과목번호만 입력
t_section varchar(10) not null check(t_section in('culture','major','minor', --과목구분
t_date date default sysdate, --등록일자
primary key(no),
foreign key(l_num) references lesson(l_num),
foreign key(sd_num) referenes student(sd_num),
);

create sequence seq_subject;
drop sequence seq_subject;
create sequence seq_student;
drop sequence seq_lesson;
create sequence seq_lesson;
create sequence seq_seqtrainee;
drop sequence seq_seqtrainee;

insert into subject values(seq_subject.nextval,'01','컴퓨터학과');
insert into subject values(seq_subject.nextval,'02','교육학과');
insert into subject values(seq_subject.nextval,'03','신문방송학과');
insert into subject values(seq_subject.nextval,'04','인터넷비즈니스과');
insert into subject values(seq_subject.nextval,'05','기술경영과');
select * from subject;

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','김정수', 'javajsp','01');

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','김정수', 'javajsp','01');

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','김정수', 'javajsp','01');

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','김정수', 'javajsp','01');

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','김정수', 'javajsp','01');


insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'K','국어');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'M','수학');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'E','영어');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'H','역사');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'P','프로그래밍');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'D','데이터베이스');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'ED','교육학이론');


insert into trainee(no, sd_num, l_num, t_section;


-----quiz3. 정답
create table subject(
no number not null,
s_num varchar2(2),
s_name varchar2(30) not null,
unique(no),
primary key(s_num)
);

create table student(
no number not null,
sd_num varchar2(8) not null,
sd_name varchar2(12) not null,
sd_id varchar2(12) not null,
s_num varchar2(2) not null,
sd_date date default sysdate,
unique(no),
primary key(sd_num),
unique(sd_id),
foreign key(s_num) REFERENCES subject(s_num)
);

create table lesson(
no number not null,
l_num varchar2(2) not null,
l_name varchar2(20) not null,
unique(no),
primary key(l_num)
);

create table trainee(
   no number not null, 
   sd_num varchar2(8) not null,
   l_num varchar2(2) not null,
   t_section varchar2(20) not null check(t_section in('culture','major','minor')),
   t_date date default sysdate,
   PRIMARY key(no),
   FOREIGN KEY(l_num) REFERENCES lesson(l_num),
   FOREIGN KEY(sd_num) REFERENCES student(sd_num)
);

create sequence seq_subject;
create sequence seq_student;
create sequence seq_lesson;
create sequence seq_trainee;

insert into subject values(seq_subject.nextval, '01','컴퓨터학과');
insert into subject(no, s_num, s_name) values(seq_subject.nextval, '02','교육학과');
insert into subject(no, s_num, s_name) values(seq_subject.nextval, '03','신문방송학과');
insert into subject(no, s_num, s_name) values(seq_subject.nextval, '04','인터넷비즈니스과');
insert into subject(no, s_num, s_name) values(seq_subject.nextval, '05','기술경영과');

select * from subject;

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','김정수', 'javajsp','01');

insert into student(no, sd_num, sd_name, sd_id, s_num) 
values(seq_student.nextval, '95010002','김수현', 'jdbcmania', '01');

insert into student(no, sd_num, sd_name, sd_id, s_num) 
values(seq_student.nextval, '98040001','이지영', 'onji', '04');

insert into student(no, sd_num, sd_name, sd_id, s_num) 
values(seq_student.nextval, '02050001','조수영', 'water', '05');

insert into student(no, sd_num, sd_name, sd_id, s_num) 
values(seq_student.nextval, '94040002','최경란', 'novel', '04');

insert into student(no, sd_num, sd_name, sd_id, s_num) 
values(seq_student.nextval, '08020001','안익태', 'korea', '02');

select * from student;

insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'K','국어');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'M','수학');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'E','영어');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'H','역사');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'P','프로그래밍');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'D','데이터베이스');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'ED','교육학이론');

select * from lesson;

insert into trainee(no, sd_num, l_num, t_section ) 
values(seq_trainee.nextval, '06010001','K', 'culture');
insert into trainee(no, sd_num, l_num, t_section ) 
values(seq_trainee.nextval, '06010001','P', 'major');

select * from trainee;

---동의어SYNONYM
create synonym e for emp; --원래 계정이름.테이블명이지만, 같은 계정안에서라면 계정명 생략
select * from e;--테이블이나 뷰가 이름이 길어서 감추고 싶다면, 동의어 붙여놓고, 그 동의어로 찾는다.
drop synonym e;
select * from e; -->"테이블 또는 뷰가 존재하지 않습니다."

--6교시
create user c##scott identified by tiger 
default tablespace users 
temporary tablespace temp 
profile default;

grant connect, resource to c##scott;
GRANT UNLIMITED TABLESPACE TO c##scott;
alter user c##scott account unlock;

CREATE USER C##ORCLSTUDY
IDENTIFIED BY ORACLE;
--계정만 만들면 안되고, 계정을 만들고 
GRANT CREATE SESSION to c##orclstudy;--권한을 지정해줘야 한다. 
-->> +누르고, 아이디: c##orclstudy ; 비번: ORACLE 지정> 테스트 > 성공. 비밀번호는 대소문자 구분한다.

grant CREATE SESSION to c##orclstudy;
grant RESOURCE, CREATE TABLE to c##orclstudy;
--다양한 권한을 모아둔 것을 '롤'이라고 하는데 그 가운데 리소스를 써본 것.
--cmd쓰는 경우, SHOW USER 시스템 계정. conn system/비번
--시스템 계정으로 접속한 다음에 실행할 것.

grant connect, resource to c##scott; --자원 생성 권한(테이블, 레코드 생성 가능해짐)
GRANT UNLIMITED TABLESPACE TO c##scott;
alter user c##scott account unlock;

revoke resource, create table from c##orclstudy;

--7교시 
-->>시스템계정에서 SCOTT으로 돌아옴
create table temp(
    coll varchar2(20),
    col2 varchar2(20)
);

grant select on temp to c##orclstudy;
grant insert on temp to c##orclstudy;
select * from temp;

revoke select, insert on temp from c##orclstudy;
--> 권한을 뺏었으니까, orclsutdy에서 테이블이 안보임

create role c##rolestudy; --롤삭제: drop role ...
--권한 부여 -- 시스템 권한 : DBA
           -- 객체 권한 : 객체를 소유한 계정
grant connect, resource, create view, create synonym 
to c##rolestudy;

--사용자에게 부여
grant c##rolestudy to c##orclstudy;
-- 해당계정에 롤을 부여해준다. 

drop role c##rolestudy;-->롤 권한 회수


set serveroutput on;

begin 
    DBMS_OUTPUT.PUT_LINE('hello, world!!');
end;
/

--8교시 
DECLARE
    v_empno number(4) := 7788;
    v_ename varchar2(10);
BEGIN
    v_ename := 'SCOTT';
     DBMS_OUTPUT.PUT_LINE('v_empno : ' || v_empno);
     DBMS_OUTPUT.PUT_LINE('v_ename : ' || v_ename); 
END;
/

DECLARE
    v_deptno number(2) default 10;
BEGIN
     --v_deptno := 20; --주석처리하면 위에 디폴트값 10이 저장되고, 주석풀면 20이 저장된다.
     DBMS_OUTPUT.PUT_LINE('v_deptno : '||v_deptno);
END;
/

DECLARE
    v_deptno dept.deptno%type;
BEGIN 
    v_deptno := 50;
    DBMS_OUTPUT.PUT_LINE('v_deptno : ' || v_deptno); 

END;
/
--> 위에 거 안된다. 확인바람.

DECLARE
    v_dept_row dept%rowtype;
BEGIN
    select deptno, dname, loc 
       into v_dept_row 
    from dept where deptno = 40;
    DBMS_OUTPUT.PUT_LINE('부서번호 : '|| v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('부서명 : '|| v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('근무지 : '|| v_dept_row.loc); 
END;
/