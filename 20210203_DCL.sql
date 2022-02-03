--사원번호, 사원명, 급여 3개의 컬럼으로 구성된 emp01테이블 생성하세요.
create table emp01 (
empno number,
ename varchar2(30),
sal number(8,2)
);

drop table emp01; --휴지통에 삭제(복구가능)
drop table emp01 purge; --완전삭제(복구불가)

--전체 
create table emp02 
as 
select * from emp; 
select * from emp02; 

--특정 레코드만
create table emp03
as
select * from emp where deptno = 30;
select *from emp03;

--틀만 뽑아오기
create table emp04
as
select * from emp where 1 = 0;
select * from emp04;

--해당 컬럼만
create table emp05
as
select empno, ename, deptno from emp;
select * from emp05; 

-- 
desc emp01;

alter table emp01 add(job varchar2(10));
alter table emp01 modify(job varchar(30));

---3교시
alter table emp01 rename column empno to empnum;
desc emp01;

alter table emp01 drop column job;

--emp 01 -> emp 06
rename emp01 to emp06;
desc emp06;

select count(*) from emp02;
truncate table emp02; --컬럼은 남기고, 레코드 전부삭제
select count(*) from emp02; 

--4교시
drop table emp01 purge;
--테이블 복제하면 제약조건은 복제가 안된다.
create table emp01(
empno number(4) not null,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2)
); 
DESC emp01;
insert into emp01 values(7499,'ALLEN','SALESMAN',30);--빈문자열도 null로 인식한다.
--insert는 중복가능. 그래서 2번 실행하면 2개 입력됨. 
select * from emp01;

drop table emp02;
create table emp02(
empno number(4)unique,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2)
); 
insert into emp02 values(7499,'ALLEN','SALESMAN',30);--빈문자열도 null로 인식한다.
--insert는 중복가능. 그러나 empno가 unique 조건이 걸려서 안됨.
insert into emp02 values(7499, 'JONES', 'SALESMAN',30);
insert into emp02 values(7499, 'JONES', 'SALESMAN',20);
insert into emp02 values(NULL, 'JONES', 'SALESMAN',20);
insert into emp02 values(NULL, 'JONES', 'SALESMAN',20);
select * from emp02;

--제약조건을 확인하는 두 가지 딕셔너리1
select * from USER_CONS_COLUMNS
where table_name='EMP02';
--제약조건을 확인하는 두 가지 딕셔너리2
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP02';

create table table_NN2(
    login_id varchar2(20) constraint TBLNN2_id_nn NOT NULL, 
    login_pw varchar2(20) constraint TBLNN2_pw_nn NOT NULL,
    tel varchar2(20) 
    );
    
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS WHERE TABLE_NAME='TABLE_NN2';

--이미 만들어진 테이블에서 tel에 제약조건 주고 싶다면?
alter table table_NN2 modify (tel not null);

alter table table_NN2 drop constraint TBLNN2_id_nn;
desc table_NN2;

drop table emp04;
create table emp04(
    empno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
    );
insert into emp04 values(7499,'ALLEN','SALESMAN',30);
insert into emp04 values(7499,'ALLEN','SALESMAN',30); -- 중복 X
insert into emp04 values('','ALLEN','SALESMAN',30); -- null X