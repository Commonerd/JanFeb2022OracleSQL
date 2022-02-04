--2����
create table dept_temp 
as
select * from dept;
select*from dept_temp; -->���̺��� �����ص� ���������� �������� �ʴ´�.

insert into dept_temp (deptno, dname, loc)
values (50, 'DATABASE','SEOUL');

INSERT INTO dept_temp
values(60, 'RandD', 'JEJU');

INSERT INTO dept_temp
values(60, 'RandD'); --> ���� ���� ������� �ʽ��ϴ�

INSERT INTO dept_temp
values(60, 'RandD','����Ư���� ���α�'); -->���� ���� ���� �ʹ� ŭ

INSERT INTO dept_temp
values('7,0', 'RandD','����Ư���� ���α�'); -->��ġ�� �������մϴ�. �ѹ�Ÿ���ε�, ������ �־�����.

set escape on;
INSERT INTO dept_temp
values(70, 'R\&D','����'); -- set escape on �ϰ�, 'R\&D'

delete from dept_temp where deptno = 60; -->�� �� ���ڵ尡 �뤊�� ������


insert into dept_temp
values(80,'PT',null); --> �ΰ��� ����ϴ� ��� **�̰� ��õ
insert into dept_temp values(90,'marketing',''); -->���ڿ��� null�� �ν�.
select * from dept_temp;

insert into dept_temp( deptno, dname) -->������� ���� �÷��� null�� ����.
values(11,'management');

--emp ���̺��� ��Ű���� �����ϳ� emp_temp ���̺� ����
create table emp_temp
as 
select * from emp where 1=0;
select * from emp_temp;

insert into emp_temp 
values (1000,'ȫ�浿','PRESIDENT',NULL,sysdate,5000,1000,10);
insert into emp_temp 
values (1111,'ȫ����','MANAGER',1000,'2022/02/04',4000,NULL,20);
insert into emp_temp 
values (2111,'ȫ����','MANAGER',1000,'2022-02-04',4000,NULL,20);--������ ���ĵ� �����ϴ�.                                 
insert into emp_temp  
values (3111,'ȫ����','MANAGER',1000,to_date('04/02/2022','DD/MM/YYYY'),4000,NULL,30);--to_date�� �����ؼ� ����. ��� ���� �𸣹Ƿ�.
select * from emp_temp; 
delete from emp_temp where ename = 'ȫ�浿';

---����Ʈ�� ���Ͽ�...
create table tbl_default(
    id varchar2(20) primary key,
    pw varchar2(20) default '1234'
);
insert into tbl_default values('test_id',null);
insert into tbl_default (id) values ('test_id2'); -->pw:1234. �÷��� ������� ������ ����Ʈ��.
select * from tbl_default;

--�޿� ����� 1���� ����� ������ EMP_TEMP���̺� �����϶�.
--emp_temp�� ����� grade,losal, hisal�� ������ Į���� ����.
insert into emp_temp
select e.empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and s.grade =1;
select * from emp_temp;

--update ���̺�� set ���ǽ�
select * from dept_temp;
update dept_temp set loc='HOME';
select * from dept_temp;
--40�� �μ��� �μ����� 'PROJECTTEAM', �ٹ����� 'JEJU'�� ����
update dept_temp set dname = 'PROJECTTEAM', loc='JEJU'
where deptno = 40;

--emp_temp ���̺��� ��� �� �޿��� 2500������ ������� Ŀ�̼��� 50���� �����Ͻÿ�.
update emp_temp set comm = 50
where sal <=2500;
update emp_temp set comm = 50 where sal <=2500;
select*from emp_temp;

--4����
UPDATE DEPT_TEMP
   SET (DNAME, LOC) = (SELECT DNAME, LOC
                         FROM DEPT
                        WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;
 
 UPDATE DEPT_TEMP
   SET DNAME = (SELECT DNAME
                  FROM DEPT
                 WHERE DEPTNO = 40),
       LOC = (SELECT LOC
                FROM DEPT
               WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;
 
COMMIT;
delete from emp_temp;
select * from emp_temp;
rollback;

--job�� MANAGER�� ����� ���� ����
delete from emp_temp where job = 'MANAGER';
select * from emp_temp;

DELETE FROM EMP_TEMP
 WHERE EMPNO IN (SELECT E.EMPNO
                   FROM EMP_TEMP E, SALGRADE S
                  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                    AND S.GRADE = 1
                    AND DEPTNO = 30);
select * from emp_temp;

---����Ǯ��quiz.1
create table goodsInfo (
num number(3) primary key, --�����̸Ӹ�Ű �����ϴ� �� ����. ���� ������ �Ǽ�.
code varchar2(7),
name varchar2(30),
price number(10),
maker varchar2(20)
);

insert into goodsinfo VALUES(1,'A001','DIGITALTV',520000,'JEIL');
insert into goodsinfo VALUES(2,'A002','DVD',240000,'JEIL');
insert into goodsinfo VALUES(3,'U101C','DSLR',830000,'WOOSU');
insert into goodsinfo VALUES(4,'U405D','ELECTRONIC DICTIONARY',160000,'WOOSU');
insert into goodsinfo VALUES(5,'H704','MICROWAVE OVEN',90000,'HANA');
insert into goodsinfo VALUES(6,'A001','REFRIGERATOR',150000,'WOOSU');
insert into goodsinfo VALUES(7,'M021R','AIR CONDITIONER',170000,'WOOSU');
insert into goodsinfo VALUES(8,'ZT809','AIR CONDITIONER',140000,'JEIL');
SELECT * FROM GOODSINFO;

UPDATE GOODSINFO SET NAME = 'GAS RANGE' WHERE CODE='H704';
SELECT * FROM GOODSINFO;

DELETE FROM GOODSINFO WHERE MAKER = 'WOOSU';
SELECT * FROM GOODSINFO;'

commit; --���� ���� ��� ��� ����Ǿ����� ���ڴٸ�.Ŀ��!
------------------
---����Ǯ��quiz.2
drop table MEMBERS purge;
CREATE TABLE MEMBERS (
NO NUMBER(3) primary key,
NAME VARCHAR2(10) not null,
USERID VARCHAR2(15) not null unique,
PASSWORD VARCHAR2(15),
AGE NUMBER(3),
EMAIL VARCHAR2(30),
ADDRESS VARCHAR2(100)
);

INSERT INTO MEMBERS VALUES(1,'���缮','you','1234',47,'you@naver.com','����� ���ʱ� ���2��');
INSERT INTO MEMBERS VALUES(2,'���','momo','abcd',NULL,'momo@daum.com','��⵵ ������ ����3��');
INSERT INTO MEMBERS VALUES(3,'�ڱ浿','park','test01',32,'narae@google.com','��õ�� ������ û�е�');
INSERT INTO MEMBERS VALUES(4,'�丣','thor','ok005',36,NULL,'����� �߶��� �����99');
INSERT INTO MEMBERS VALUES(5,'�ڸ��','park2','sky3',49,'great4@apple.com','����� ������ ������');
INSERT INTO MEMBERS VALUES(6,'����ȣ','you2','apple',32,'bjae@daum.net','');
INSERT INTO MEMBERS VALUES(7,'��Ÿũ','stark','rich',54,'tony@start.com','������ ������ ������');

select * from MEMBERS;

update members set email = 'thor2@naver.com' where name = '�丣';

update members set address = '��⵵ ���ν� ���ﵿ' where userid = 'you2';

delete from members where no = 7;

update members set age = 21 where userid = 'momo';

select * from members where age between 30 and 39;

select * from members where address like '%�����%';

select * from members where email like '%daum%';

select name from members order by name asc;

select age, name from members order by age desc, name asc;

commit; -- Ŀ���� ���ϸ� �ӽ����Ϸθ� ����ǰ�, ��񿡴� �ݿ��ȵǼ�, Ŀ�ǵ�â������ �Ⱥ���. 

-------TCL
create table dept_tcl
as select * from dept;

select *from dept_tcl;

insert into dept_tcl values(50, 'DB', 'SEOUL');
select * from dept_tcl;
commit; -->�̰� �ؾ� ����.


--40�� �μ��� �ٹ����� JEJU�� ����
UPDATE DEPT_TCL SET LOC = 'JEJU' WHERE DEPTNO=40;
--�μ����� 'RESEARCH'�� �μ�����
DELETE FROM DEPT_TCL WHERE DNAME='RESEARCH';
-- SELECT �� Ȯ��
SELECT * FROM DEPT_TCL;
-- �۾� ���
ROLLBACK;
-- �ٽ� Ȯ��
SELECT * FROM DEPT_TCL;

--Ŀ�� �������� ���� Ʈ����� ������
--CMD���� �̰� ġ�� ��ٸ��� ��...
--UPDATE DEPT_TCL SET LOC='BUSAN' WHERE DEPTNO = 20;
--�ٸ� Ʈ�����(SQLDV)���� �ٷ�� �ִ� ���̺���, ����(CMD)���� ������ �� ����. 
--SQLDV���� ROLLBACK�ϸ�, CMD���� "1���� ������Ʈ �Ǿ����ϴ�."�޽��� ��.
--�� ������ Ʈ����� �������̸�, �ٸ� ������ ���۾ȵǴ�...�����ִ� ǥ��. �װ��� '��'�̴�.
--���� �ɸ��� �ʵ���, �׻� Ʈ������� ������.

select * from user_indexes;
select * from user_ind_columns;

select * from emp where empno=7788; --�ε����� �����Ǿ� �ִ� �÷��� ���ؼ�, �� �÷��� �������� �˻��ϴ� ���
select * from emp where ename = 'SCOTT'; --�ε��� ����

--�ε��� ����
create index ind_emp_sal
on emp(sal); -- �ε��� ��ü�� ��������� �������� ������������ ������ �Ǿ� �ִ�. 
-- 800���� 5000����. ������� ���ĵ�. �� �κ��� ������ 1�� ����. �� �� �κ��� ������ 2�� ����. 1,2 ��带 ��Ʈ ��忡 ����.
-- �߰����� ��������.. �������� �������� �ش� ���ڵ尡 ��� �ִ��� �����ϰ� �ִ� �ε����� ���� ����.
-- emp���̺��� empno�� ���� ����, �������� ���� �ε��� ����. 
-- emp���̺� ���ڵ带 ���� �߰��ϸ�? �ε������� ���� �߰��� ������ ���� �Ѵ�.

select * from emp where sal =3000;
drop index ind_emp_sal; --�ε��� ����

--8���� ������
create table dept_seq_test
as select * from dept where 1 = 0;

select * from dept_seq_test;

create sequence seq_deptno
    increment by 10 --�Ⱦ��� �⺻�� 1
    start with 10 --�Ⱦ��� �⺻�� 1
    maxvalue 90
    minvalue 0
    nocycle
    cache 2;
    
    select * from user_sequences;
    
insert into dept_seq_test
values(seq_deptno.nextval,'DATABASE','SEOUL');

select * from dept_seq_test;

select seq_deptno.currval from dual;

alter sequence seq_deptno --������ ����, �ʿ��� �ɼǸ� �ٽ� �����ָ� �ȴ�.
    increment by 3
    maxvalue 99
    cycle;
    
drop sequence seq_deptno; --������ ����