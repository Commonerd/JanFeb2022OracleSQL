set serveroutput on;

begin 
DBMS_OUT.PUT_LINE('hello, world!!');
end;
/

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

--예제1. 홀짝 구하기
DECLARE
    v_num number := 8;
BEGIN
    if mod(v_num, 2) = 1 then
    DBMS_OUTPUT.PUT_LINE(v_num||'은 홀수입니다.');
    else
    DBMS_OUTPUT.PUT_LINE(v_num||'은 짝수입니다.');
    end if;
END;
/

--예제2. 학점구하기
DECLARE
   V_SCORE NUMBER := 87;
BEGIN
   IF V_SCORE >= 90 THEN
      DBMS_OUTPUT.PUT_LINE('A학점');
   ELSIF V_SCORE >= 80 THEN
      DBMS_OUTPUT.PUT_LINE('B학점');
   ELSIF V_SCORE >= 70 THEN
      DBMS_OUTPUT.PUT_LINE('C학점');
   ELSIF V_SCORE >= 60 THEN
      DBMS_OUTPUT.PUT_LINE('D학점');
   ELSE
      DBMS_OUTPUT.PUT_LINE('F학점');
   END IF;
END;
/

--2교시 예제1.
DECLARE 
    v_cnt number := 1;
    v_str varchar2(10);
BEGIN
    loop
        v_str := v_str||'*';
        v_cnt := v_cnt + 1;
        DBMS_OUTPUT.PUT_LINE(v_str);
        exit when v_cnt >5; 
    end loop;    
END;
/

DECLARE 
    v_cnt number := 1;
    v_str varchar2(10) := null;
BEGIN
    while v_cnt <=5 loop
        v_str := v_str||'*';
        DBMS_OUTPUT.PUT_LINE(v_str);
        v_cnt := v_cnt + 1; 
        
    end loop;    
END;
/

BEGIN 
    for i in 0..4 loop --시작값과 마지막값은 숫자로. 
    DBMS_OUTPUT.PUT_LINE(i);
    end loop;
END;
/

BEGIN 
    for i in REVERSE 0..4 loop --시작값과 마지막값은 숫자로. 
    DBMS_OUTPUT.PUT_LINE(i);
    end loop;
END;
/

DECLARE
VDEPT DEPT%ROWTYPE; 
BEGIN
DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명'); 
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------'); 
-- 변수 CNT는 1부터 1씩 증가하다가 4에 도달하면 반복문에서 벗어난다.
FOR CNT IN 1..4 LOOP
SELECT * INTO VDEPT FROM DEPT WHERE DEPTNO=10*CNT;
DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME  || ' / ' || VDEPT.LOC); 
END LOOP; END;
/

DECLARE
    type rec_dept is record(
    dname dept.dname%type,
    loc dept.loc%type
    ); --위에서 타입을 먼저 선언(rec_dept는 괄호 안에와 같다)하고,
    --아래(dept_r rec_dept)에 넣은 것임
    dept_r rec_dept; --변수명(dept_r)  타입(rec_dept)
BEGIN
    dept_r.dname :='DATABASE';
    dept_r.loc := 'SEOUL';
    DBMS_OUTPUT.PUT_LINE(dept_r.dname);
    DBMS_OUTPUT.PUT_LINE(dept_r.loc);
END;
/

create table dept_record
as select * from dept;

select * from dept_record;

DECLARE
    type rec_dept is record(
    dname dept.dname%type,
    loc dept.loc%type
    ); --위에서 타입을 먼저 선언(rec_dept는 괄호 안에와 같다)하고,
    --아래(dept_r rec_dept)에 넣은 것임
    dept_r rec_dept; --변수명(dept_r)  타입(rec_dept)
BEGIN
    select dname, loc into dept_r from dept_record where deptno = 10;
    DBMS_OUTPUT.PUT_LINE(dept_r.dname);
    DBMS_OUTPUT.PUT_LINE(dept_r.loc);
END;
/

--
DECLARE
    type rec_dept is record(
    deptno number(2) := 99,
    dname dept.dname%type,
    loc dept.loc%type
    ); --위에서 타입을 먼저 선언(rec_dept는 괄호 안에와 같다)하고,
    --아래(dept_r rec_dept)에 넣은 것임
    dept_r rec_dept; --변수명(dept_r)  타입(rec_dept)
BEGIN
    dept_r.dname := '개발1';
    dept_r.loc := '제주';
    insert into dept_record values dept_r;
END;
/
select * from dept_record;

--3교시
DECLARE
    type rec_dept is record(
    deptno number(2) := 99,
    dname dept.dname%type,
    loc dept.loc%type
    ); --위에서 타입을 먼저 선언(rec_dept는 괄호 안에와 같다)하고,
    --아래(dept_r rec_dept)에 넣은 것임
    dept_r rec_dept; --변수명(dept_r)  타입(rec_dept)
BEGIN
    dept_r.deptno := 50;
    dept_r.dname := 'DB관리';
    dept_r.loc := '전주';
    update dept_record set row = dept_r --row = dept_r
    -- 원래대로라면  deptno = dept_r.deptno, ..이렇게 다 써줘야 함.
    where deptno = 99;
END;
/
select * from dept_record;


-- 중첩레코드
DECLARE
   TYPE REC_DEPT IS RECORD(
      deptno DEPT.DEPTNO%TYPE,
      dname DEPT.DNAME%TYPE,
      loc DEPT.LOC%TYPE
   );
   TYPE REC_EMP IS RECORD(
      empno EMP.EMPNO%TYPE,
      ename EMP.ENAME%TYPE,
      dinfo REC_DEPT
   );
   emp_rec REC_EMP;
BEGIN
   SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
     INTO emp_rec.empno, emp_rec.ename,
          emp_rec.dinfo.deptno,
          emp_rec.dinfo.dname,
          emp_rec.dinfo.loc
     FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
 AND E.EMPNO = 7788;

   DBMS_OUTPUT.PUT_LINE('EMPNO : ' || emp_rec.empno);
   DBMS_OUTPUT.PUT_LINE('ENAME : ' || emp_rec.ename);
   DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || emp_rec.dinfo.deptno);
   DBMS_OUTPUT.PUT_LINE('DNAME : ' || emp_rec.dinfo.dname);
   DBMS_OUTPUT.PUT_LINE('LOC : ' || emp_rec.dinfo.loc);
END;
/

--컬렉션
--TYPE 연관배열명(1) IS TABLE OF 자료형 [NOT NULL](2)
--INDEX BY 인덱스형(3)
DECLARE 
    TYPE itab_ex is table of varchar2(20)
    index by PLS_INTEGER;
    
    text_arr itab_ex;--변수선언
BEGIN
    text_arr(1) := 'first';
    text_arr(2) := 'second';
    text_arr(3) := 'third';
    text_arr(4) := 'fourth';
    
    for i in 1..4 loop
    DBMS_OUTPUT.PUT_LINE(text_arr(i));
    end loop;
END;
/

--

DECLARE
   TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
      INDEX BY PLS_INTEGER;

   dept_arr ITAB_DEPT;
   idx PLS_INTEGER := 0;

BEGIN
   FOR i IN(SELECT * FROM DEPT) LOOP
      idx := idx + 1;
      dept_arr(idx).deptno := i.DEPTNO;
      dept_arr(idx).dname := i.DNAME;
      dept_arr(idx).loc := i.LOC;

      DBMS_OUTPUT.PUT_LINE(
      dept_arr(idx).deptno || ' : ' ||
      dept_arr(idx).dname || ' : ' ||
      dept_arr(idx).loc);
   END LOOP;
END;
/

--
DECLARE
   TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
      INDEX BY PLS_INTEGER;

   text_arr ITAB_EX;

BEGIN
   text_arr(1) := '1st data';
   text_arr(2) := '2nd data';
   text_arr(3) := '3rd data';
   text_arr(50) := '50th data'; 
    --인덱스에 4번부터 49번까지가 있을 것 같지만, 없네?
    text_arr(4) := '4th data';
   DBMS_OUTPUT.PUT_LINE('text_arr.COUNT : ' || text_arr.COUNT);
   DBMS_OUTPUT.PUT_LINE('text_arr.FIRST : ' || text_arr.FIRST); --첫번째 인덱스넘버 1
   DBMS_OUTPUT.PUT_LINE('text_arr.LAST : ' || text_arr.LAST);-- 마지막 인덱스넘버 50
   
   DBMS_OUTPUT.PUT_LINE('text_arr.PRIOR(50) : ' || text_arr.PRIOR(50));--50번 인덱스 앞에 있는 것 = 3
   DBMS_OUTPUT.PUT_LINE('text_arr.NEXT(50) : ' || text_arr.NEXT(50));--50번 인덱스 다음에는? 없음
   --DBMS_OUTPUT.PUT_LINE('text_arr.NEXT(49) : ' || text_arr(49));--49번 인덱스 없음
   
END;
/

--4교시 <커서>
DECLARE
   -- 커서 데이터를 입력할 변수 선언
   V_DEPT_ROW DEPT%ROWTYPE; --한줄씩 처리하도록

   -- 명시적 커서 선언(Declaration)
   CURSOR c1 IS
      SELECT DEPTNO, DNAME, LOC
        FROM DEPT;

BEGIN
   -- 커서 열기(Open)
   OPEN c1;

   LOOP
      -- 커서로부터 읽어온 데이터 사용(Fetch)
      FETCH c1 INTO V_DEPT_ROW;

      -- 커서의 모든 행을 읽어오기 위해 %NOTFOUND 속성 지정
      EXIT WHEN c1%NOTFOUND;--더이상 읽어올 데이터를 찾지 못하면 EXIT.

      
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
                        || ', DNAME : ' || V_DEPT_ROW.DNAME
                        || ', LOC : ' || V_DEPT_ROW.LOC);
   END LOOP;

   -- 커서 닫기(Close)
   CLOSE c1;

END;
/

DECLARE
    CURSOR C1 IS
    SELECT * FROM EMP;
    
BEGIN
--자동으로 OPEN FETCH를 하고 싶다면, FOR문을 쓴다.
    FOR C1_REC IN C1 LOOP
    DBMS_OUTPUT.PUT_LINE(C1_REC.EMPNO || C1_REC.ENAME);
    END LOOP;
    
END;
/

DECLARE
v_wrong number;
BEGIN
select dname into v_wrong from dept where deptno = 10;
DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');
--에러 발생. dname은 바차2, v_wrong은 넘버타입. 타입이 다른 것에 넣었기 때문에 오류.
EXCEPTION
    when VALUE_ERROR then 
    DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생');
END;
/

DECLARE
    v_wrong number;
    number_format EXCEPTION;
    PRAGMA EXCEPTION_INIT(number_format, -6502);--예외에 대해서 초기화(INIT)

BEGIN
select dname into v_wrong from dept where deptno = 10;
DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');
--에러 발생. dname은 바차2, v_wrong은 넘버타입. 타입이 다른 것에 넣었기 때문에 오류.
EXCEPTION
    when VALUE_ERROR then 
    DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생');
END;
/

DECLARE
   v_wrong NUMBER;
BEGIN
   SELECT DNAME INTO v_wrong
     FROM DEPT
    WHERE DEPTNO = 10;

   DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생');
      DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/

--<5교시>
set serveroutput on;
create or replace procedure pro_noparam
is 
    v_empno number(4) := 7788;
    v_ename varchar2(10);
begin
    v_ename := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('v_empno : '||v_empno);
    DBMS_OUTPUT.PUT_LINE('v_ename : '||v_ename);
END;
/
execute pro_noparam; 
exec pro_noparam;

BEGIN
    pro_noparam;
END;
/

SELECT *
  FROM USER_SOURCE
 WHERE NAME = 'PRO_NOPARAM';
 
--숫자를 4개 입력받아서 쓰는 프로시저
create or replace procedure pro_param_in
(   pl in number, 
    p2 number,
    p3 number :=3,
    p4 number default 4
)
is
begin
    DBMS_OUTPUT.PUT_LINE('pl : '||pl);
    DBMS_OUTPUT.PUT_LINE('p2 : '||p2);
    DBMS_OUTPUT.PUT_LINE('p3 : '||p3);
    DBMS_OUTPUT.PUT_LINE('p4 : '||p4);
end;
/
execute pro_param_in(1,2,9,8);
EXECUTE pro_param_in(1,2);--매개변수 개수와 값의 개수가 달라도 잘 실행된다.
--EXECUTE pro_param_in(1);
--ORA-06550: 줄 1, 열74:PLS-00306: 'PRO_PARAM_IN' 호출 시 인수의 갯수나 유형이 잘못되었습니다
--줄1은 프로시저의 첫 번째 값을 의미함. 
execute pro_param_in(p2 => 30, p1 => 40); --파라미터값을 명시해서 사용할 수도 있다.

-- 사원번호 입력 시, 사원의 정보 출력
--레코드 1줄만 뽑아오기
create or replace procedure empinfo
(  v_empno in emp.empno%type)
is
    v_emp emp%rowtype; --한줄 통째로 저장
begin
   select * into v_emp from emp where empno = v_empno;
   DBMS_OUTPUT.PUT_LINE('사원번호 : '||v_emp.empno);
   DBMS_OUTPUT.PUT_LINE('사원이름 : '||v_emp.ename);
   DBMS_OUTPUT.PUT_LINE('사원직책 : '||v_emp.job);
   DBMS_OUTPUT.PUT_LINE('사원부서 : '||v_emp.deptno);
EXCEPTION WHEN NO_DATA_FOUND then
    DBMS_OUTPUT.PUT_LINE(v_empno ||' : 해당 사원 없음');
end;
/
execute empinfo(7788);
execute empinfo(7777);

--부서번호를 입력시 해당 부서의 사원번호와 이름을 출력
--레코드가 여러줄이 출력됨=> CURSOR 사용
create or replace procedure deptinfo
(v_deptno in emp.deptno%type)   
is
    v_emp emp%rowtype; --한줄 통째로 저장
    cursor c1
        is select * from emp where deptno = v_deptno;
begin 
   DBMS_OUTPUT.PUT_LINE('사원번호 / 사원명');
   DBMS_OUTPUT.PUT_LINE('-------------------');
   for v_emp in c1 loop
    DBMS_OUTPUT.PUT_LINE(v_emp.empno ||' / '|| v_emp.ename);
   end loop;
end;
/
exec deptinfo(10);
exec deptinfo(20);
exec deptinfo(30);
exec deptinfo(40);

--6교시 예제2.OUT모드
CREATE OR REPLACE PROCEDURE pro_param_out
(
   in_empno IN EMP.EMPNO%TYPE,
   out_ename OUT EMP.ENAME%TYPE, 
   --여기서 out은 출력이 아니라, 변수에 저장된 것을,
   --다른 변수에 저장(반환)하는 용도
   out_sal OUT EMP.SAL%TYPE
)
IS

BEGIN
   SELECT ENAME, SAL INTO out_ename, out_sal
     FROM EMP
    WHERE EMPNO = in_empno;
END pro_param_out;
/


DECLARE
   v_ename EMP.ENAME%TYPE;
   v_sal EMP.SAL%TYPE;
BEGIN
   pro_param_out(7788, v_ename, v_sal);
   DBMS_OUTPUT.PUT_LINE('ENAME : ' || v_ename);
   DBMS_OUTPUT.PUT_LINE('SAL : ' || v_sal);
END;
/

--예제3.INOUT모드
CREATE OR REPLACE PROCEDURE pro_param_inout
(
   inout_no IN OUT NUMBER
)
IS

BEGIN
   inout_no := inout_no * 2;
END pro_param_inout;
/
DECLARE
   no NUMBER;
BEGIN
   no := 5;
   pro_param_inout(no);
   DBMS_OUTPUT.PUT_LINE('no : ' || no);
END;
/

--함수
create or replace function func_tax
(
    pay number
)
return number
is
    tax number := 0.05;
begin
    return round((pay * tax));
end;
/

DECLARE
   aftertax NUMBER;
BEGIN
   aftertax := func_aftertax(3000);
   DBMS_OUTPUT.PUT_LINE('after-tax income : ' || aftertax);
END;
/

CREATE OR REPLACE FUNCTION func_aftertax(
   sal IN NUMBER
)
RETURN NUMBER
IS
   tax NUMBER := 0.05;
BEGIN
   RETURN (ROUND(sal - (sal * tax)));
END func_aftertax;
/

DECLARE
   tax NUMBER;
BEGIN
   tax := func_tax(3000);
   DBMS_OUTPUT.PUT_LINE('tax : ' || tax);
END;
/
--함수의 장점은 SELECT문에서도 쓸 수 있다는 점이다.
select func_tax(3000) from dual;
select empno, ename, sal, func_tax(sal) from emp;

--7교시
-- 부서번호를 입력하면 부서의 이름을 반환하는 함수 생성(func01)
CREATE OR REPLACE FUNCTION func01
(v_deptno emp.deptno%type) -- 매개변수 받는 부분.
return varchar2
is
    v_dname dept.dname%type; --매개변수가 아니기 때문에 위에 안씀.
begin
    select dname into v_dname from dept where deptno = v_deptno;
    return v_dname;
end;
/
select empno, ename, func01(deptno) dept_name from emp;
--함수를 쓰면 이왕이면 별칭을 붙이는 편이 깔끔하다.


--패키지
CREATE OR REPLACE PACKAGE pkg_example
IS
   spec_no NUMBER := 10;
   FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER;
   PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
   PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE);
END;
/

CREATE OR REPLACE PACKAGE BODY pkg_example
IS
   body_no NUMBER := 10;

   FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER
      IS
         tax NUMBER := 0.05;
      BEGIN
         RETURN (ROUND(sal - (sal * tax)));
   END func_aftertax;
PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE)
      IS
         out_ename EMP.ENAME%TYPE;
         out_sal EMP.SAL%TYPE;
      BEGIN
         SELECT ENAME, SAL INTO out_ename, out_sal
           FROM EMP
          WHERE EMPNO = in_empno;

         DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
         DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
   END pro_emp;
PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE)
   IS
      out_dname DEPT.DNAME%TYPE;
      out_loc DEPT.LOC%TYPE;
   BEGIN
      SELECT DNAME, LOC INTO out_dname, out_loc
        FROM DEPT
       WHERE DEPTNO = in_deptno;

      DBMS_OUTPUT.PUT_LINE('DNAME : ' || out_dname);
      DBMS_OUTPUT.PUT_LINE('LOC : ' || out_loc);
   END pro_dept;
END;
/

--트리거
DROP TABLE EMP01 PURGE;
create table emp01(
empno number(4) primary key,
ename varchar2(20),
job varchar2(20)
);
create or replace trigger trg01
after insert on emp01 --인서트문이 실행된 다음에 다음의 작업 실행하세요라는 의미
begin
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
end;
/
insert into emp01 values(1, 'JAVAKIM', '프로그래머');

create table sal01(
salno number(4) primary key,
sal number(7,2),
empno number(4) references emp01(empno)
);
create sequence seq_sal01;
create or replace trigger trg02
after insert on emp01
for each row --변경된 줄마다 처리하기 위함
begin
    insert into sal01 values(seq_sal01.nextval, 100, :new.empno); --넥스트밸류
--지금 인서트된 사원. 'new'로 참조된다. 올드나 뉴가 나오면 for each row와 같이 다녀야 한다.
--새로 추가된 값에서 empno값을 꺼내오겠다는 의미.(:new.empno)
end;
/

insert into emp01 values (2, 'oraclekim','디자이너');

select * from emp01; 
select * from sal01;

insert into emp01 values(3,'sunkim','개발자');
-- 여기까지 뭐가 문제 있는데(sal 100에서 안 늘어남...오류찾기)

create or replace trigger trg03
after delete on emp01
for each row
begin 
    delete from sal01 where empno = :old.empno;
end;
/
select * from emp01;
select * from sal01;
delete from emp01 where empno = 2;




----정답본
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(20),
    job varchar2(20)
);    
create or replace trigger trg01
after insert on emp01
begin
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
end;    
/
insert into emp01 values(1, 'JAVAKIM','프로그래머');
create table sal01(
salno number(4) primary key,
sal number(7,2),
empno number(4) references emp01(empno)
);

create sequence seq_sal01;
create or replace trigger trg02
after insert on emp01
for each row
begin
    insert into sal01 values(seq_sal01.nextval, 100, :new.empno); 
end;
/
insert into emp01 values (2,'oraclekim','디자이너');

select * from emp01;
select * from sal01;

insert into emp01 values (3,'sunkim','개발자');

select * from emp01;
select * from sal01;

create or replace trigger trg03
after delete on emp01
for each row
begin
    delete from sal01 where empno = :old.empno;
end;
/

delete from emp01 where empno = 2;
select * from emp01;
select * from sal01;


--8교시 물류프로그램 트리거 연습
--trigger 연습--
--1. product 테이블을 생성. 
 CREATE TABLE product(
 code CHAR(6) PRIMARY KEY,
 name VARCHAR2(12) NOT NULL,
 company  VARCHAR2(12),
 price number,
 quantity number DEFAULT 0
 );
 drop table warehousing;
--2. warehousing 테이블을 생성
 CREATE TABLE warehousing(
 no number PRIMARY KEY,
 code  CHAR(6) REFERENCES product(code),
 w_date date DEFAULT sysdate,
 w_quantity number,
 unit_cost number,
 w_price number
 );
 
--3. product테이블의 w_quantity 컬럼을 통해서 실질적인 트리거의 적용 예를 살펴보도록 하겠다. 우선 product 테이블에 다음과 같은 샘플 데이터를 입력해 보자.
INSERT INTO product(code, name, company, price) VALUES('A00001','세탁기', 'LG', 500); 
INSERT INTO product(code, name, company, price) VALUES('A00002','컴퓨터', 'LG', 700);
INSERT INTO product(code, name, company, price) VALUES('A00003','냉장고', '삼성', 600);

--4. warehousing 테이블에 product이 입력되면 warehousing 수량을 product 테이블의 quantity에 추가하는 트리거 작성
-- warehousing 트리거 
drop trigger trg_01;
 CREATE TRIGGER TRG_01
 AFTER INSERT ON warehousing
 FOR EACH ROW
 BEGIN
 UPDATE product
 SET quantity = quantity + :NEW.w_quantity
 WHERE code = :NEW.code;
 END;
/

--5. 트리거를 실행시킨 후 warehousing 테이블에 행을 추가한다. warehousing 테이블에는 물론 product 테이블의 quantity이 변경됨을 확인할 수 있다. 
 INSERT INTO warehousing(no,code,w_quantity,unit_cost,w_price) 
 VALUES(1, 'A00001', 5, 320, 1600);
 SELECT * FROM warehousing;
 SELECT * FROM product;
 
--6. warehousing 테이블에 product이 입력되면 자동으로 product 테이블의 quantity이 증가하게 된다. warehousing 테이블에 또 다른 product을 입력한다. 
 INSERT INTO warehousing(no, code, w_quantity, unit_cost, w_price) 
 VALUES(2, 'A00002', 10, 680, 6800);
 SELECT * FROM warehousing;
 SELECT * FROM product;
 INSERT INTO warehousing(no, code, w_quantity, unit_cost, w_price) 
 VALUES(3, 'A00003', 10, 220, 2200);
 SELECT * FROM warehousing;
 SELECT * FROM product;
 
--<실습하기> 갱신 트리거 작성하기
--이미 warehousing된 product에 대해서 warehousing 수량이 변경되면 product 테이블의 w_quantity 역시 변경되어야 한다. 이를 위한 갱신 트리거 작성해 보자. 
-- 갱신 트리거
drop trigger trg02;
 CREATE TRIGGER TRG02
 AFTER UPDATE ON warehousing
 FOR EACH ROW
 BEGIN
 UPDATE product
 SET quantity = quantity + (-:old.w_quantity+:new.w_quantity) 
 WHERE code = :new.code;
 END;
 /

--2. warehousing 번호 3번은 냉장고가 warehousing된 정보를 기록한 것으로서 warehousing 번호 3번의 w_quantity을 8로 변경하였더니 냉장고의 quantity 역시 8로 변경되었다.
  UPDATE warehousing SET w_quantity=8, w_price=2200
 WHERE no=3;
 SELECT * FROM warehousing ORDER BY no;
 
--<실습하기> 삭제 트리거 작성하기
--warehousing 테이블에서 warehousing되었던 상황이 삭제되면 product 테이블에 w_quantity에서 삭제된 w_quantity 만큼을 빼는 삭제 트리거 작성해 보자. 
--삭제트리거
drop trigger trg03;
 CREATE TRIGGER TRG03
 AFTER DELETE ON warehousing
 FOR EACH ROW
 BEGIN
 UPDATE product
 SET quantity = quantity - :old.w_quantity WHERE code = :old.code;
 END;
/
 
--2. 입고번호 3번은 냉장고가 입고된 정보를 기록한 것으로서 입고번호가 3번인 행을 삭제하였더니 냉장고의 수량 역시 0으로 변경되었다. 
 DELETE from warehousing WHERE no = 3;
 SELECT * FROM warehousing ORDER BY no;
 SELECT * FROM product;