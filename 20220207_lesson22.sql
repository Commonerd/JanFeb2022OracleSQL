CREATE VIEW vw_emp20 
as (select empno, ename, job, deptno 
    from emp where deptno = 20);
    
select * from user_views; 

select * from vw_emp20;

insert into vw_emp20
values(8000, 'JAVAKIM','SALESMAN',20);
select * from emp;--�䰡 �������� �ʴ� �κ��� NULL�� ���´�.
--�䰡 ������ �� �ִ� �κ��� empno, ename, job, deptno 
delete from vw_emp20 where empno = 8000;
select * from emp;

commit;

--�μ��� �޿� �Ѿ�, ����� ���ϴ� �۾�(view_sal)
create or replace view view_sal
as (select deptno, sum(sal) as "SalSum" , round(avg(sal)) as "SalAvg"
    from emp group by deptno);
    --> ������ ����? select�� sum, avg �κп�  ��Ī(�˸��ƽ�) �ٿ���� ��.
    
select * from view_sal;

--�����ȣ, �����, �޿�, �μ���ȣ, �μ���, �ٹ����� ����ϴ� view(vw_emp_dept)�� �����Ͻÿ�.
create or replace view vw_emp_dept
as select empno, ename, sal, deptno, dname, loc
    from emp natural join dept order by empno asc;

select * from vw_emp_dept;
----
create or replace view vw_chk20
as select empno, ename, sal, comm, deptno from emp
    where deptno = 20 with check option;-->deptno ���� ������ �� ����. 
    --�� ������ �������� ������ Į�� ���� �������� ���ϵ��� �ϴ� ��. 
select * from vw_chk20;

update vw_chk20 set deptno = 10 where sal >=5000;

----
create or replace view vw_read30
as select empno, ename, sal, comm, deptno from emp
where deptno = 30 with read only; --���������۾� (DML) �۾� �Ұ�
select * from vw_read30;
update vw_read30 set comm = 1000;

---<3����>
select rownum, e.* from emp e;
select rownum, e.* from emp e order by sal desc;-->�γѹ��� ���� �� �״��� �ǹ̰�..
select rownumb, e.* 
from (select *from emp e order by sal desc) e; -->���� ���Ľ�Ű�� �����ȣ �ο�. �굵 '��'��
--����Ʈ���� ��ٸ� with �����Ͽ� �ش纰Ī���θ� ���� ����� �ִ�.
with e as (select * from emp e order by sal desc)
select rownum, e.* from e where rownum <=3;

--����Ǯ��
--1. ��� ��ȣ�� ������ �μ���� �μ��� ��ġ�� ����ϴ� ��(VIEW_LOC)�� �ۼ��ϼ���.
create or replace view view_loc
as select empno, ename, dname, loc from emp natural join dept;
select * from view_loc;

--2. 30�� �μ� �Ҽ� ����� �̸��� �Ի��ϰ� �μ����� ����ϴ� ��(VIEW_DEPT30)�� �ۼ��ϼ���.
create or replace view view_dept30
as 
(select ename, hiredate, dname
from emp natural join dept
where deptno = 30);
select * from view_dept30;

--3. �μ��� �ִ� �޿� ������ ������ ��(VIEW_DEPT_MAXSAL)�� �����ϼ���.
create or replace view view_dept_maxsal
as (select deptno, max(sal) as "MaxSal"
from emp
group by deptno);
select * from view_dept_maxsal;

--4. �޿��� ���� �޴� ������� 5�� ����ϴ� ��(VIEW_SAL_TOP5)�� �ۼ��ϼ���.
--create or replace view view_sal_top5
--as (select * from emp
--where (select rownumb
--from 
--(select * from emp e order by sal desc) e) <=5);
select rownum, empno, ename
from 
(select *from emp e order by sal desc)
where rownum <=5 ;

--5. �޿��� ���� �޴� ������� 6~10����� ���
-- 1. ����
-- 2. �����ȣ (��Ī) ���̱�
-- 3. ���ϴ� ��ȣ�� ���ڵ� ��������
select r, empno, ename, sal --rownum�� ���⼭ ���̸� ���Ӱ� �����ȣ�� �ٽ� ����
from (select rownum r, empno, ename, sal --���⼭ �����ȣ ���̱�
from
(select * from emp e order by sal desc))
where r >=6 and r <=10;


--<4-5����, quiz3. ���� Ǯ��>
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
--������ �̿��� ���ڵ� 5�� �߰� 
insert into subject values(1,'01','��ǻ���а�');
insert into subject values(2,'02','�����а�');
insert into subject values(3,'03','�Ź�����а�');
insert into subject values(4,'04','���ͳݺ���Ͻ���');
insert into subject values(5,'05','����濵��');

--2
drop table student purge;
--create table student(
--  no number(2) primary key,
--  sd_num number(8) not null, 
--  sd_name varchar2(20) not null,
--  sd_id varchar2(10) not null,
--  sd_passwd varchar2(20) not null,
--  s_num varchar2(2) references subject(s_num),
--  --�а� ���̺�(subject)�� �ִ� �а���ȣ(s_num)�� �л����̺�(student)�� �ִ� �а���ȣ(s_num)�� ����Ű�� ����.
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
  foreign key(s_num) references subject(s_num)--�а� ���̺�(subject)�� �ִ� �а���ȣ(s_num)�� �л����̺�(student)�� �ִ� �а���ȣ(s_num)�� ����Ű�� ����.
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

insert into lesson values(1,'K','����');
insert into lesson values(2,'M','����');
insert into lesson values(3,'E','����');
insert into lesson values(4,'H','����');
insert into lesson values(5,'P','���α׷���');
insert into lesson values(6,'D','�����ͺ��̽�');
insert into lesson values(7,'ED','�������̷�');

--4
--create table trainee (
--no number(2) primary key --�Ϸù�ȣ, ������ ���
--sd_num number(8) references student(sd_num)--�й�
----�������̺��� �й��� �ݵ�� �л����̺� �ִ� �й��� �Է�
--l_num number(2) references subject(--�����ȣ
----�����ȣ�� �ݵ�� �������̺� �ִ� �����ȣ�� �Է�
--t_section varchar(10) not null --���񱸺�
--t_date date default(sysdate) --�������
drop table trainee purge; 
create table trainee (
no number not null,--�Ϸù�ȣ, ������ ���
sd_num number(8) references student(sd_num),--�й�
--�������̺��� �й��� �ݵ�� �л����̺� �ִ� �й��� �Է�
l_num number(2) not null,--�����ȣ
--�����ȣ�� �ݵ�� �������̺� �ִ� �����ȣ�� �Է�
t_section varchar(10) not null check(t_section in('culture','major','minor', --���񱸺�
t_date date default sysdate, --�������
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

insert into subject values(seq_subject.nextval,'01','��ǻ���а�');
insert into subject values(seq_subject.nextval,'02','�����а�');
insert into subject values(seq_subject.nextval,'03','�Ź�����а�');
insert into subject values(seq_subject.nextval,'04','���ͳݺ���Ͻ���');
insert into subject values(seq_subject.nextval,'05','����濵��');
select * from subject;

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','������', 'javajsp','01');

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','������', 'javajsp','01');

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','������', 'javajsp','01');

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','������', 'javajsp','01');

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','������', 'javajsp','01');


insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'K','����');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'M','����');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'E','����');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'H','����');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'P','���α׷���');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'D','�����ͺ��̽�');
insert into lesson(no, l_num, l_name) values(seq_lesson.nextval,'ED','�������̷�');


insert into trainee(no, sd_num, l_num, t_section;


-----quiz3. ����
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

insert into subject values(seq_subject.nextval, '01','��ǻ���а�');
insert into subject(no, s_num, s_name) values(seq_subject.nextval, '02','�����а�');
insert into subject(no, s_num, s_name) values(seq_subject.nextval, '03','�Ź�����а�');
insert into subject(no, s_num, s_name) values(seq_subject.nextval, '04','���ͳݺ���Ͻ���');
insert into subject(no, s_num, s_name) values(seq_subject.nextval, '05','����濵��');

select * from subject;

insert into student(no, sd_num, sd_name, sd_id, s_num)
values (seq_student.nextval, '06010001','������', 'javajsp','01');

insert into student(no, sd_num, sd_name, sd_id, s_num) 
values(seq_student.nextval, '95010002','�����', 'jdbcmania', '01');

insert into student(no, sd_num, sd_name, sd_id, s_num) 
values(seq_student.nextval, '98040001','������', 'onji', '04');

insert into student(no, sd_num, sd_name, sd_id, s_num) 
values(seq_student.nextval, '02050001','������', 'water', '05');

insert into student(no, sd_num, sd_name, sd_id, s_num) 
values(seq_student.nextval, '94040002','�ְ��', 'novel', '04');

insert into student(no, sd_num, sd_name, sd_id, s_num) 
values(seq_student.nextval, '08020001','������', 'korea', '02');

select * from student;

insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'K','����');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'M','����');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'E','����');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'H','����');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'P','���α׷���');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'D','�����ͺ��̽�');
insert into lesson(no, l_num, l_name ) values(seq_lesson.nextval, 'ED','�������̷�');

select * from lesson;

insert into trainee(no, sd_num, l_num, t_section ) 
values(seq_trainee.nextval, '06010001','K', 'culture');
insert into trainee(no, sd_num, l_num, t_section ) 
values(seq_trainee.nextval, '06010001','P', 'major');

select * from trainee;

---���Ǿ�SYNONYM
create synonym e for emp; --���� �����̸�.���̺��������, ���� �����ȿ������ ������ ����
select * from e;--���̺��̳� �䰡 �̸��� �� ���߰� �ʹٸ�, ���Ǿ� �ٿ�����, �� ���Ǿ�� ã�´�.
drop synonym e;
select * from e; -->"���̺� �Ǵ� �䰡 �������� �ʽ��ϴ�."

--6����
create user c##scott identified by tiger 
default tablespace users 
temporary tablespace temp 
profile default;

grant connect, resource to c##scott;
GRANT UNLIMITED TABLESPACE TO c##scott;
alter user c##scott account unlock;

CREATE USER C##ORCLSTUDY
IDENTIFIED BY ORACLE;
--������ ����� �ȵǰ�, ������ ����� 
GRANT CREATE SESSION to c##orclstudy;--������ ��������� �Ѵ�. 
-->> +������, ���̵�: c##orclstudy ; ���: ORACLE ����> �׽�Ʈ > ����. ��й�ȣ�� ��ҹ��� �����Ѵ�.

grant CREATE SESSION to c##orclstudy;
grant RESOURCE, CREATE TABLE to c##orclstudy;
--�پ��� ������ ��Ƶ� ���� '��'�̶�� �ϴµ� �� ��� ���ҽ��� �ẻ ��.
--cmd���� ���, SHOW USER �ý��� ����. conn system/���
--�ý��� �������� ������ ������ ������ ��.

grant connect, resource to c##scott; --�ڿ� ���� ����(���̺�, ���ڵ� ���� ��������)
GRANT UNLIMITED TABLESPACE TO c##scott;
alter user c##scott account unlock;

revoke resource, create table from c##orclstudy;

--7���� 
-->>�ý��۰������� SCOTT���� ���ƿ�
create table temp(
    coll varchar2(20),
    col2 varchar2(20)
);

grant select on temp to c##orclstudy;
grant insert on temp to c##orclstudy;
select * from temp;

revoke select, insert on temp from c##orclstudy;
--> ������ �������ϱ�, orclsutdy���� ���̺��� �Ⱥ���

create role c##rolestudy; --�ѻ���: drop role ...
--���� �ο� -- �ý��� ���� : DBA
           -- ��ü ���� : ��ü�� ������ ����
grant connect, resource, create view, create synonym 
to c##rolestudy;

--����ڿ��� �ο�
grant c##rolestudy to c##orclstudy;
-- �ش������ ���� �ο����ش�. 

drop role c##rolestudy;-->�� ���� ȸ��


set serveroutput on;

begin 
    DBMS_OUTPUT.PUT_LINE('hello, world!!');
end;
/

--8���� 
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
     --v_deptno := 20; --�ּ�ó���ϸ� ���� ����Ʈ�� 10�� ����ǰ�, �ּ�Ǯ�� 20�� ����ȴ�.
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
--> ���� �� �ȵȴ�. Ȯ�ιٶ�.

DECLARE
    v_dept_row dept%rowtype;
BEGIN
    select deptno, dname, loc 
       into v_dept_row 
    from dept where deptno = 40;
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : '|| v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '|| v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('�ٹ��� : '|| v_dept_row.loc); 
END;
/