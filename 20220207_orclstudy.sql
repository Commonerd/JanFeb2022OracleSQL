create table test1(
name varchar2(20),
age number
);

create table test2(
name varchar2(20),
age number
);

select * from c##scott.temp;


insert into c##scott.temp
values('test1','test2');
commit;

select * from c##scott.temp;
--> ������ �������ϱ�, orclsutdy���� ���̺��� �Ⱥ���


SELECT * FROM USER_SYS_PRIVS;
SELECT * FROM USER_ROLE_PRIVS;
