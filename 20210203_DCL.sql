--�����ȣ, �����, �޿� 3���� �÷����� ������ emp01���̺� �����ϼ���.
create table emp01 (
empno number,
ename varchar2(30),
sal number(8,2)
);

drop table emp01; --�����뿡 ����(��������)
drop table emp01 purge; --��������(�����Ұ�)

--��ü 
create table emp02 
as 
select * from emp; 
select * from emp02; 

--Ư�� ���ڵ常
create table emp03
as
select * from emp where deptno = 30;
select *from emp03;

--Ʋ�� �̾ƿ���
create table emp04
as
select * from emp where 1 = 0;
select * from emp04;

--�ش� �÷���
create table emp05
as
select empno, ename, deptno from emp;
select * from emp05; 

-- 
desc emp01;

alter table emp01 add(job varchar2(10));
alter table emp01 modify(job varchar(30));

---3����
alter table emp01 rename column empno to empnum;
desc emp01;

alter table emp01 drop column job;

--emp 01 -> emp 06
rename emp01 to emp06;
desc emp06;

select count(*) from emp02;
truncate table emp02; --�÷��� �����, ���ڵ� ���λ���
select count(*) from emp02; 

--4����
drop table emp01 purge;
--���̺� �����ϸ� ���������� ������ �ȵȴ�.
create table emp01(
empno number(4) not null,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2)
); 
DESC emp01;
insert into emp01 values(7499,'ALLEN','SALESMAN',30);--���ڿ��� null�� �ν��Ѵ�.
--insert�� �ߺ�����. �׷��� 2�� �����ϸ� 2�� �Էµ�. 
select * from emp01;

drop table emp02;
create table emp02(
empno number(4)unique,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2)
); 
insert into emp02 values(7499,'ALLEN','SALESMAN',30);--���ڿ��� null�� �ν��Ѵ�.
--insert�� �ߺ�����. �׷��� empno�� unique ������ �ɷ��� �ȵ�.
insert into emp02 values(7499, 'JONES', 'SALESMAN',30);
insert into emp02 values(7499, 'JONES', 'SALESMAN',20);
insert into emp02 values(NULL, 'JONES', 'SALESMAN',20);
insert into emp02 values(NULL, 'JONES', 'SALESMAN',20);
select * from emp02;

--���������� Ȯ���ϴ� �� ���� ��ųʸ�1
select * from USER_CONS_COLUMNS
where table_name='EMP02';
--���������� Ȯ���ϴ� �� ���� ��ųʸ�2
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP02';

create table table_NN2(
    login_id varchar2(20) constraint TBLNN2_id_nn NOT NULL, 
    login_pw varchar2(20) constraint TBLNN2_pw_nn NOT NULL,
    tel varchar2(20) 
    );
    
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS WHERE TABLE_NAME='TABLE_NN2';

--�̹� ������� ���̺��� tel�� �������� �ְ� �ʹٸ�?
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
insert into emp04 values(7499,'ALLEN','SALESMAN',30); -- �ߺ� X
insert into emp04 values('','ALLEN','SALESMAN',30); -- null X