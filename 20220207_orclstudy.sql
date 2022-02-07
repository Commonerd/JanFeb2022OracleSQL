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
--> 권한을 뺏었으니까, orclsutdy에서 테이블이 안보임


SELECT * FROM USER_SYS_PRIVS;
SELECT * FROM USER_ROLE_PRIVS;
