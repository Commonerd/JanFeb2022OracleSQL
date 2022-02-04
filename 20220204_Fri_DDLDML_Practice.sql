--2교시
create table dept_temp 
as
select * from dept;
select*from dept_temp; -->테이블을 복제해도 제약조건은 복제되지 않는다.

insert into dept_temp (deptno, dname, loc)
values (50, 'DATABASE','SEOUL');

INSERT INTO dept_temp
values(60, 'RandD', 'JEJU');

INSERT INTO dept_temp
values(60, 'RandD'); --> 값의 수가 충분하지 않습니다

INSERT INTO dept_temp
values(60, 'RandD','서울특별시 종로구'); -->열에 대한 값이 너무 큼

INSERT INTO dept_temp
values('7,0', 'RandD','서울특별시 종로구'); -->수치가 부적합합니다. 넘버타입인데, 바차를 넣었구나.

set escape on;
INSERT INTO dept_temp
values(70, 'R\&D','서울'); -- set escape on 하고, 'R\&D'

delete from dept_temp where deptno = 60; -->한 줄 레코드가 통쨰로 지워짐


insert into dept_temp
values(80,'PT',null); --> 널값을 명시하는 방식 **이걸 추천
insert into dept_temp values(90,'marketing',''); -->빈무자열도 null로 인식.
select * from dept_temp;

insert into dept_temp( deptno, dname) -->명시하지 않은 컬럼은 null로 들어간다.
values(11,'management');

--emp 테이블의 스키마만 복사하나 emp_temp 테이블 생성
create table emp_temp
as 
select * from emp where 1=0;
select * from emp_temp;

insert into emp_temp 
values (1000,'홍길동','PRESIDENT',NULL,sysdate,5000,1000,10);
insert into emp_temp 
values (1111,'홍서아','MANAGER',1000,'2022/02/04',4000,NULL,20);
insert into emp_temp 
values (2111,'홍도윤','MANAGER',1000,'2022-02-04',4000,NULL,20);--하이픈 형식도 가능하다.                                 
insert into emp_temp  
values (3111,'홍서준','MANAGER',1000,to_date('04/02/2022','DD/MM/YYYY'),4000,NULL,30);--to_date로 지정해서 쓴다. 어떻게 쓸지 모르므로.
select * from emp_temp; 
delete from emp_temp where ename = '홍길동';

---디폴트에 관하여...
create table tbl_default(
    id varchar2(20) primary key,
    pw varchar2(20) default '1234'
);
insert into tbl_default values('test_id',null);
insert into tbl_default (id) values ('test_id2'); -->pw:1234. 컬럼을 명시하지 않으면 디폴트값.
select * from tbl_default;

--급여 등급이 1급인 사원의 정보를 EMP_TEMP테이블에 저장하라.
--emp_temp에 저장시 grade,losal, hisal을 저장할 칼럼이 없다.
insert into emp_temp
select e.empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and s.grade =1;
select * from emp_temp;

--update 테이블명 set 조건식
select * from dept_temp;
update dept_temp set loc='HOME';
select * from dept_temp;
--40번 부서의 부서명을 'PROJECTTEAM', 근무지를 'JEJU'로 변경
update dept_temp set dname = 'PROJECTTEAM', loc='JEJU'
where deptno = 40;

--emp_temp 테이블의 사원 중 급여가 2500이하인 사원들의 커미션을 50으로 변경하시오.
update emp_temp set comm = 50
where sal <=2500;
update emp_temp set comm = 50 where sal <=2500;
select*from emp_temp;

--4교시
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

--job이 MANAGER인 사원의 정보 삭제
delete from emp_temp where job = 'MANAGER';
select * from emp_temp;

DELETE FROM EMP_TEMP
 WHERE EMPNO IN (SELECT E.EMPNO
                   FROM EMP_TEMP E, SALGRADE S
                  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                    AND S.GRADE = 1
                    AND DEPTNO = 30);
select * from emp_temp;

---문제풀이quiz.1
create table goodsInfo (
num number(3) primary key, --프라이머리키 지정하는 게 좋음. 나는 안했음 실수.
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

commit; --내가 연결 끊어도 계속 저장되었으면 좋겠다면.커밋!
------------------
---문제풀이quiz.2
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

INSERT INTO MEMBERS VALUES(1,'유재석','you','1234',47,'you@naver.com','서울시 서초구 방배2동');
INSERT INTO MEMBERS VALUES(2,'모모','momo','abcd',NULL,'momo@daum.com','경기도 성남시 태평3동');
INSERT INTO MEMBERS VALUES(3,'박길동','park','test01',32,'narae@google.com','인천시 연수구 청학동');
INSERT INTO MEMBERS VALUES(4,'토르','thor','ok005',36,NULL,'서울시 중랑구 상봉동99');
INSERT INTO MEMBERS VALUES(5,'박명수','park2','sky3',49,'great4@apple.com','서울시 마포구 망원동');
INSERT INTO MEMBERS VALUES(6,'유세호','you2','apple',32,'bjae@daum.net','');
INSERT INTO MEMBERS VALUES(7,'스타크','stark','rich',54,'tony@start.com','대전시 유성구 구성동');

select * from MEMBERS;

update members set email = 'thor2@naver.com' where name = '토르';

update members set address = '경기도 용인시 기흥동' where userid = 'you2';

delete from members where no = 7;

update members set age = 21 where userid = 'momo';

select * from members where age between 30 and 39;

select * from members where address like '%서울시%';

select * from members where email like '%daum%';

select name from members order by name asc;

select age, name from members order by age desc, name asc;

commit; -- 커밋을 안하면 임시파일로만 저장되고, 디비에는 반영안되서, 커맨드창에서는 안보임. 

-------TCL
create table dept_tcl
as select * from dept;

select *from dept_tcl;

insert into dept_tcl values(50, 'DB', 'SEOUL');
select * from dept_tcl;
commit; -->이걸 해야 보임.


--40번 부서의 근무지를 JEJU로 변경
UPDATE DEPT_TCL SET LOC = 'JEJU' WHERE DEPTNO=40;
--부서명이 'RESEARCH'인 부서삭제
DELETE FROM DEPT_TCL WHERE DNAME='RESEARCH';
-- SELECT 문 확인
SELECT * FROM DEPT_TCL;
-- 작업 취소
ROLLBACK;
-- 다시 확인
SELECT * FROM DEPT_TCL;

--커밋 안했으니 아직 트랜잭션 수행중
--CMD에서 이거 치면 기다리는 중...
--UPDATE DEPT_TCL SET LOC='BUSAN' WHERE DEPTNO = 20;
--다른 트랜잭션(SQLDV)에서 다루고 있는 테이블은, 이쪽(CMD)에서 접근할 수 없다. 
--SQLDV에서 ROLLBACK하면, CMD에서 "1행이 업데이트 되었습니다."메시지 뜸.
--한 곳에서 트랜잭션 진행중이면, 다른 곳에서 동작안되는...돌고있는 표시. 그것이 '락'이다.
--락이 걸리지 않도록, 항상 트랜잭션을 끝내라.

select * from user_indexes;
select * from user_ind_columns;

select * from emp where empno=7788; --인덱스가 지정되어 있는 컬럼에 대해서, 그 컬럼을 기준으로 검색하는 방법
select * from emp where ename = 'SCOTT'; --인덱스 없음

--인덱스 생성
create index ind_emp_sal
on emp(sal); -- 인덱스 객체가 만들어지고 샐러리가 오름차순으로 정렬이 되어 있다. 
-- 800부터 5000까지. 순서대로 정렬됨. 반 부분을 나눠서 1번 노드로. 또 반 부분을 나눠서 2번 노드로. 1,2 노드를 루트 노드에 저장.
-- 중간값을 기준으로.. 샐러리를 기준으로 해당 레코드가 어디에 있는지 저장하고 있는 인덱스가 따로 생김.
-- emp테이블은 empno에 대한 따로, 샐러리에 대한 인덱스 따로. 
-- emp테이블에 레코드를 새로 추가하면? 인덱스에도 새로 추가된 정보가 들어가야 한다.

select * from emp where sal =3000;
drop index ind_emp_sal; --인덱스 삭제

--8교시 시퀀스
create table dept_seq_test
as select * from dept where 1 = 0;

select * from dept_seq_test;

create sequence seq_deptno
    increment by 10 --안쓰면 기본값 1
    start with 10 --안쓰면 기본값 1
    maxvalue 90
    minvalue 0
    nocycle
    cache 2;
    
    select * from user_sequences;
    
insert into dept_seq_test
values(seq_deptno.nextval,'DATABASE','SEOUL');

select * from dept_seq_test;

select seq_deptno.currval from dual;

alter sequence seq_deptno --시퀀스 변경, 필요한 옵션만 다시 적어주면 된다.
    increment by 3
    maxvalue 99
    cycle;
    
drop sequence seq_deptno; --시퀀스 삭제