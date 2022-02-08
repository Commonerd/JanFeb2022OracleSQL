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
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : '|| v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '|| v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('�ٹ��� : '|| v_dept_row.loc); 
END;
/

--����1. Ȧ¦ ���ϱ�
DECLARE
    v_num number := 8;
BEGIN
    if mod(v_num, 2) = 1 then
    DBMS_OUTPUT.PUT_LINE(v_num||'�� Ȧ���Դϴ�.');
    else
    DBMS_OUTPUT.PUT_LINE(v_num||'�� ¦���Դϴ�.');
    end if;
END;
/

--����2. �������ϱ�
DECLARE
   V_SCORE NUMBER := 87;
BEGIN
   IF V_SCORE >= 90 THEN
      DBMS_OUTPUT.PUT_LINE('A����');
   ELSIF V_SCORE >= 80 THEN
      DBMS_OUTPUT.PUT_LINE('B����');
   ELSIF V_SCORE >= 70 THEN
      DBMS_OUTPUT.PUT_LINE('C����');
   ELSIF V_SCORE >= 60 THEN
      DBMS_OUTPUT.PUT_LINE('D����');
   ELSE
      DBMS_OUTPUT.PUT_LINE('F����');
   END IF;
END;
/

--2���� ����1.
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
    for i in 0..4 loop --���۰��� ���������� ���ڷ�. 
    DBMS_OUTPUT.PUT_LINE(i);
    end loop;
END;
/

BEGIN 
    for i in REVERSE 0..4 loop --���۰��� ���������� ���ڷ�. 
    DBMS_OUTPUT.PUT_LINE(i);
    end loop;
END;
/

DECLARE
VDEPT DEPT%ROWTYPE; 
BEGIN
DBMS_OUTPUT.PUT_LINE('�μ���ȣ / �μ��� / ������'); 
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------'); 
-- ���� CNT�� 1���� 1�� �����ϴٰ� 4�� �����ϸ� �ݺ������� �����.
FOR CNT IN 1..4 LOOP
SELECT * INTO VDEPT FROM DEPT WHERE DEPTNO=10*CNT;
DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME  || ' / ' || VDEPT.LOC); 
END LOOP; END;
/

DECLARE
    type rec_dept is record(
    dname dept.dname%type,
    loc dept.loc%type
    ); --������ Ÿ���� ���� ����(rec_dept�� ��ȣ �ȿ��� ����)�ϰ�,
    --�Ʒ�(dept_r rec_dept)�� ���� ����
    dept_r rec_dept; --������(dept_r)  Ÿ��(rec_dept)
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
    ); --������ Ÿ���� ���� ����(rec_dept�� ��ȣ �ȿ��� ����)�ϰ�,
    --�Ʒ�(dept_r rec_dept)�� ���� ����
    dept_r rec_dept; --������(dept_r)  Ÿ��(rec_dept)
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
    ); --������ Ÿ���� ���� ����(rec_dept�� ��ȣ �ȿ��� ����)�ϰ�,
    --�Ʒ�(dept_r rec_dept)�� ���� ����
    dept_r rec_dept; --������(dept_r)  Ÿ��(rec_dept)
BEGIN
    dept_r.dname := '����1';
    dept_r.loc := '����';
    insert into dept_record values dept_r;
END;
/
select * from dept_record;

--3����
DECLARE
    type rec_dept is record(
    deptno number(2) := 99,
    dname dept.dname%type,
    loc dept.loc%type
    ); --������ Ÿ���� ���� ����(rec_dept�� ��ȣ �ȿ��� ����)�ϰ�,
    --�Ʒ�(dept_r rec_dept)�� ���� ����
    dept_r rec_dept; --������(dept_r)  Ÿ��(rec_dept)
BEGIN
    dept_r.deptno := 50;
    dept_r.dname := 'DB����';
    dept_r.loc := '����';
    update dept_record set row = dept_r --row = dept_r
    -- ������ζ��  deptno = dept_r.deptno, ..�̷��� �� ����� ��.
    where deptno = 99;
END;
/
select * from dept_record;


-- ��ø���ڵ�
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

--�÷���
--TYPE �����迭��(1) IS TABLE OF �ڷ��� [NOT NULL](2)
--INDEX BY �ε�����(3)
DECLARE 
    TYPE itab_ex is table of varchar2(20)
    index by PLS_INTEGER;
    
    text_arr itab_ex;--��������
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
    --�ε����� 4������ 49�������� ���� �� ������, ����?
    text_arr(4) := '4th data';
   DBMS_OUTPUT.PUT_LINE('text_arr.COUNT : ' || text_arr.COUNT);
   DBMS_OUTPUT.PUT_LINE('text_arr.FIRST : ' || text_arr.FIRST); --ù��° �ε����ѹ� 1
   DBMS_OUTPUT.PUT_LINE('text_arr.LAST : ' || text_arr.LAST);-- ������ �ε����ѹ� 50
   
   DBMS_OUTPUT.PUT_LINE('text_arr.PRIOR(50) : ' || text_arr.PRIOR(50));--50�� �ε��� �տ� �ִ� �� = 3
   DBMS_OUTPUT.PUT_LINE('text_arr.NEXT(50) : ' || text_arr.NEXT(50));--50�� �ε��� ��������? ����
   --DBMS_OUTPUT.PUT_LINE('text_arr.NEXT(49) : ' || text_arr(49));--49�� �ε��� ����
   
END;
/

--4���� <Ŀ��>
DECLARE
   -- Ŀ�� �����͸� �Է��� ���� ����
   V_DEPT_ROW DEPT%ROWTYPE; --���پ� ó���ϵ���

   -- ����� Ŀ�� ����(Declaration)
   CURSOR c1 IS
      SELECT DEPTNO, DNAME, LOC
        FROM DEPT;

BEGIN
   -- Ŀ�� ����(Open)
   OPEN c1;

   LOOP
      -- Ŀ���κ��� �о�� ������ ���(Fetch)
      FETCH c1 INTO V_DEPT_ROW;

      -- Ŀ���� ��� ���� �о���� ���� %NOTFOUND �Ӽ� ����
      EXIT WHEN c1%NOTFOUND;--���̻� �о�� �����͸� ã�� ���ϸ� EXIT.

      
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
                        || ', DNAME : ' || V_DEPT_ROW.DNAME
                        || ', LOC : ' || V_DEPT_ROW.LOC);
   END LOOP;

   -- Ŀ�� �ݱ�(Close)
   CLOSE c1;

END;
/

DECLARE
    CURSOR C1 IS
    SELECT * FROM EMP;
    
BEGIN
--�ڵ����� OPEN FETCH�� �ϰ� �ʹٸ�, FOR���� ����.
    FOR C1_REC IN C1 LOOP
    DBMS_OUTPUT.PUT_LINE(C1_REC.EMPNO || C1_REC.ENAME);
    END LOOP;
    
END;
/

DECLARE
v_wrong number;
BEGIN
select dname into v_wrong from dept where deptno = 10;
DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�');
--���� �߻�. dname�� ����2, v_wrong�� �ѹ�Ÿ��. Ÿ���� �ٸ� �Ϳ� �־��� ������ ����.
EXCEPTION
    when VALUE_ERROR then 
    DBMS_OUTPUT.PUT_LINE('���� ó�� : ��ġ �Ǵ� �� ���� �߻�');
END;
/

DECLARE
    v_wrong number;
    number_format EXCEPTION;
    PRAGMA EXCEPTION_INIT(number_format, -6502);--���ܿ� ���ؼ� �ʱ�ȭ(INIT)

BEGIN
select dname into v_wrong from dept where deptno = 10;
DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�');
--���� �߻�. dname�� ����2, v_wrong�� �ѹ�Ÿ��. Ÿ���� �ٸ� �Ϳ� �־��� ������ ����.
EXCEPTION
    when VALUE_ERROR then 
    DBMS_OUTPUT.PUT_LINE('���� ó�� : ��ġ �Ǵ� �� ���� �߻�');
END;
/

DECLARE
   v_wrong NUMBER;
BEGIN
   SELECT DNAME INTO v_wrong
     FROM DEPT
    WHERE DEPTNO = 10;

   DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�');

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('���� ó�� : ���� ���� �� ���� �߻�');
      DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/

--<5����>
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
 
--���ڸ� 4�� �Է¹޾Ƽ� ���� ���ν���
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
EXECUTE pro_param_in(1,2);--�Ű����� ������ ���� ������ �޶� �� ����ȴ�.
--EXECUTE pro_param_in(1);
--ORA-06550: �� 1, ��74:PLS-00306: 'PRO_PARAM_IN' ȣ�� �� �μ��� ������ ������ �߸��Ǿ����ϴ�
--��1�� ���ν����� ù ��° ���� �ǹ���. 
execute pro_param_in(p2 => 30, p1 => 40); --�Ķ���Ͱ��� ����ؼ� ����� ���� �ִ�.

-- �����ȣ �Է� ��, ����� ���� ���
--���ڵ� 1�ٸ� �̾ƿ���
create or replace procedure empinfo
(  v_empno in emp.empno%type)
is
    v_emp emp%rowtype; --���� ��°�� ����
begin
   select * into v_emp from emp where empno = v_empno;
   DBMS_OUTPUT.PUT_LINE('�����ȣ : '||v_emp.empno);
   DBMS_OUTPUT.PUT_LINE('����̸� : '||v_emp.ename);
   DBMS_OUTPUT.PUT_LINE('�����å : '||v_emp.job);
   DBMS_OUTPUT.PUT_LINE('����μ� : '||v_emp.deptno);
EXCEPTION WHEN NO_DATA_FOUND then
    DBMS_OUTPUT.PUT_LINE(v_empno ||' : �ش� ��� ����');
end;
/
execute empinfo(7788);
execute empinfo(7777);

--�μ���ȣ�� �Է½� �ش� �μ��� �����ȣ�� �̸��� ���
--���ڵ尡 �������� ��µ�=> CURSOR ���
create or replace procedure deptinfo
(v_deptno in emp.deptno%type)   
is
    v_emp emp%rowtype; --���� ��°�� ����
    cursor c1
        is select * from emp where deptno = v_deptno;
begin 
   DBMS_OUTPUT.PUT_LINE('�����ȣ / �����');
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

--6���� ����2.OUT���
CREATE OR REPLACE PROCEDURE pro_param_out
(
   in_empno IN EMP.EMPNO%TYPE,
   out_ename OUT EMP.ENAME%TYPE, 
   --���⼭ out�� ����� �ƴ϶�, ������ ����� ����,
   --�ٸ� ������ ����(��ȯ)�ϴ� �뵵
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

--����3.INOUT���
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

--�Լ�
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
--�Լ��� ������ SELECT�������� �� �� �ִٴ� ���̴�.
select func_tax(3000) from dual;
select empno, ename, sal, func_tax(sal) from emp;

--7����
-- �μ���ȣ�� �Է��ϸ� �μ��� �̸��� ��ȯ�ϴ� �Լ� ����(func01)
CREATE OR REPLACE FUNCTION func01
(v_deptno emp.deptno%type) -- �Ű����� �޴� �κ�.
return varchar2
is
    v_dname dept.dname%type; --�Ű������� �ƴϱ� ������ ���� �Ⱦ�.
begin
    select dname into v_dname from dept where deptno = v_deptno;
    return v_dname;
end;
/
select empno, ename, func01(deptno) dept_name from emp;
--�Լ��� ���� �̿��̸� ��Ī�� ���̴� ���� ����ϴ�.


--��Ű��
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

--Ʈ����
DROP TABLE EMP01 PURGE;
create table emp01(
empno number(4) primary key,
ename varchar2(20),
job varchar2(20)
);
create or replace trigger trg01
after insert on emp01 --�μ�Ʈ���� ����� ������ ������ �۾� �����ϼ����� �ǹ�
begin
    DBMS_OUTPUT.PUT_LINE('���Ի���� �Ի��߽��ϴ�.');
end;
/
insert into emp01 values(1, 'JAVAKIM', '���α׷���');

create table sal01(
salno number(4) primary key,
sal number(7,2),
empno number(4) references emp01(empno)
);
create sequence seq_sal01;
create or replace trigger trg02
after insert on emp01
for each row --����� �ٸ��� ó���ϱ� ����
begin
    insert into sal01 values(seq_sal01.nextval, 100, :new.empno); --�ؽ�Ʈ���
--���� �μ�Ʈ�� ���. 'new'�� �����ȴ�. �õ峪 ���� ������ for each row�� ���� �ٳ�� �Ѵ�.
--���� �߰��� ������ empno���� �������ڴٴ� �ǹ�.(:new.empno)
end;
/

insert into emp01 values (2, 'oraclekim','�����̳�');

select * from emp01; 
select * from sal01;

insert into emp01 values(3,'sunkim','������');
-- ������� ���� ���� �ִµ�(sal 100���� �� �þ...����ã��)

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




----���亻
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(20),
    job varchar2(20)
);    
create or replace trigger trg01
after insert on emp01
begin
    DBMS_OUTPUT.PUT_LINE('���Ի���� �Ի��߽��ϴ�.');
end;    
/
insert into emp01 values(1, 'JAVAKIM','���α׷���');
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
insert into emp01 values (2,'oraclekim','�����̳�');

select * from emp01;
select * from sal01;

insert into emp01 values (3,'sunkim','������');

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


--8���� �������α׷� Ʈ���� ����
--trigger ����--
--1. product ���̺��� ����. 
 CREATE TABLE product(
 code CHAR(6) PRIMARY KEY,
 name VARCHAR2(12) NOT NULL,
 company  VARCHAR2(12),
 price number,
 quantity number DEFAULT 0
 );
 drop table warehousing;
--2. warehousing ���̺��� ����
 CREATE TABLE warehousing(
 no number PRIMARY KEY,
 code  CHAR(6) REFERENCES product(code),
 w_date date DEFAULT sysdate,
 w_quantity number,
 unit_cost number,
 w_price number
 );
 
--3. product���̺��� w_quantity �÷��� ���ؼ� �������� Ʈ������ ���� ���� ���캸���� �ϰڴ�. �켱 product ���̺� ������ ���� ���� �����͸� �Է��� ����.
INSERT INTO product(code, name, company, price) VALUES('A00001','��Ź��', 'LG', 500); 
INSERT INTO product(code, name, company, price) VALUES('A00002','��ǻ��', 'LG', 700);
INSERT INTO product(code, name, company, price) VALUES('A00003','�����', '�Ｚ', 600);

--4. warehousing ���̺� product�� �ԷµǸ� warehousing ������ product ���̺��� quantity�� �߰��ϴ� Ʈ���� �ۼ�
-- warehousing Ʈ���� 
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

--5. Ʈ���Ÿ� �����Ų �� warehousing ���̺� ���� �߰��Ѵ�. warehousing ���̺��� ���� product ���̺��� quantity�� ������� Ȯ���� �� �ִ�. 
 INSERT INTO warehousing(no,code,w_quantity,unit_cost,w_price) 
 VALUES(1, 'A00001', 5, 320, 1600);
 SELECT * FROM warehousing;
 SELECT * FROM product;
 
--6. warehousing ���̺� product�� �ԷµǸ� �ڵ����� product ���̺��� quantity�� �����ϰ� �ȴ�. warehousing ���̺� �� �ٸ� product�� �Է��Ѵ�. 
 INSERT INTO warehousing(no, code, w_quantity, unit_cost, w_price) 
 VALUES(2, 'A00002', 10, 680, 6800);
 SELECT * FROM warehousing;
 SELECT * FROM product;
 INSERT INTO warehousing(no, code, w_quantity, unit_cost, w_price) 
 VALUES(3, 'A00003', 10, 220, 2200);
 SELECT * FROM warehousing;
 SELECT * FROM product;
 
--<�ǽ��ϱ�> ���� Ʈ���� �ۼ��ϱ�
--�̹� warehousing�� product�� ���ؼ� warehousing ������ ����Ǹ� product ���̺��� w_quantity ���� ����Ǿ�� �Ѵ�. �̸� ���� ���� Ʈ���� �ۼ��� ����. 
-- ���� Ʈ����
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

--2. warehousing ��ȣ 3���� ����� warehousing�� ������ ����� �����μ� warehousing ��ȣ 3���� w_quantity�� 8�� �����Ͽ����� ������� quantity ���� 8�� ����Ǿ���.
  UPDATE warehousing SET w_quantity=8, w_price=2200
 WHERE no=3;
 SELECT * FROM warehousing ORDER BY no;
 
--<�ǽ��ϱ�> ���� Ʈ���� �ۼ��ϱ�
--warehousing ���̺��� warehousing�Ǿ��� ��Ȳ�� �����Ǹ� product ���̺� w_quantity���� ������ w_quantity ��ŭ�� ���� ���� Ʈ���� �ۼ��� ����. 
--����Ʈ����
drop trigger trg03;
 CREATE TRIGGER TRG03
 AFTER DELETE ON warehousing
 FOR EACH ROW
 BEGIN
 UPDATE product
 SET quantity = quantity - :old.w_quantity WHERE code = :old.code;
 END;
/
 
--2. �԰��ȣ 3���� ����� �԰�� ������ ����� �����μ� �԰��ȣ�� 3���� ���� �����Ͽ����� ������� ���� ���� 0���� ����Ǿ���. 
 DELETE from warehousing WHERE no = 3;
 SELECT * FROM warehousing ORDER BY no;
 SELECT * FROM product;