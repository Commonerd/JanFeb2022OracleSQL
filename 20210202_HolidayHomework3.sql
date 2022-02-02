--1. ��� ������ �̸��� ������ �˻��Ͻÿ�
select bookname, price
from book;

--2. ��� ������ �̸��� ������ �˻��Ͻÿ�
select bookname, price
from book;

--3. ��� ������ ������ȣ,  �����̸�, ���ǻ�, ������ �˻��Ͻÿ�
select bookid, bookname, publisher, price
from book;

--4. ���� ���̺� �ִ� ��� ���ǻ縦 �˻��Ͻÿ�.(�ߺ� ����)
select distinct publisher
from book;

--5. ������ 20,000�� �̸��� ������ �˻��Ͻÿ�.
select bookname
from book
where price <20000;

--6. ������ 10,000�� �̻� 20,000 ������ ������ �˻��Ͻÿ�.
select bookname
from book
where price between 10000 and 20000;

--7. ���ǻ簡 ���½������� Ȥ�� �����ѹ̵��� ������ �˻��Ͻÿ�.
select bookname
from book
where publisher = '�½�����' or publisher = '���ѹ̵��';

--8.���౸�� ���硯�� �Ⱓ�� ���ǻ縦 �˻��Ͻÿ�.
select publisher
from book
where bookname = '�౸�� ����';

--9. �����̸��� ���౸���� ���Ե� ���ǻ縦 �˻��Ͻÿ�.
select publisher
from book
where bookname like '%�౸%';

--10. �����̸��� ���� �� ��° ��ġ�� ��������� ���ڿ��� ���� ������ �˻��Ͻÿ�.
select bookname
from book
where bookname like '_��%';

--11. �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
select bookname
from book
where price between 10000 and 20000;

--12. ���ǻ簡 ���½������� Ȥ�� �����ѹ̵��� ������ �˻��Ͻÿ�.
select bookname
from book
where publisher = '�½�����' or publisher = '���ѹ̵��';

--13. ������ �̸������� �˻��Ͻÿ�.
select bookname
from book
order by bookname;

--14. ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�.
select price, bookname
from book
order by price, bookname;

--15. ������ ������ ������������ �˻��Ͻÿ�. ���� ������ ���ٸ� ���ǻ��� ������������ �˻��Ͻÿ� 
select price, publisher, bookname
from book
order by price desc, publisher asc;

--16. ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
select sum(saleprice)���Ǹž�
from orders;

--** �𸣰���.17. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������  �� ������ ���Ͻÿ�.  ��, �� �� �̻� ������ ���� ���Ѵ�.
select custid, count(*) as ��������
from orders
where saleprice >= 8000
group by custid
having count(*) >= 2;

--18. ���� ���� �ֹ��� ���� �����͸� ��� ���̽ÿ�.
select *
from customer c inner join orders o
on c.custid = o.custid;

--19. ���� ���� �ֹ��� ���� �����͸� ����ȣ ������ �����Ͽ� ���̽ÿ�.
select *
from customer natural join orders
order by custid;

--20. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
select name, saleprice
from customer natural join orders;

--21. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
select custid, sum(saleprice)
from customer natural join orders 
group by custid
order by custid;

--22. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�
select name, bookname
from customer natural join orders natural join book
order by name;

--23. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�
select name, bookname
from customer natural join orders natural join book
order by name;

--24. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
select name, price
from customer natural join orders natural join book
where price > 20000;

--**�𸣰���25. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�
SELECT Customer.name, saleprice
FROM Customer LEFT OUTER JOIN Orders 
ON Customer.custid =Orders.custid;	

select c.name, o.saleprice
from customer c full outer join orders o 
on c.custid = o.custid;

--26. ���� ��� ������ �̸��� ���̽ÿ�.
select bookname
from book
where price = (select max(price) from book);

--27. ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
select distinct name
from customer natural join book natural join orders;

--28. ���ѹ̵��� ������ ������ ������ ���� �̸��� ���̽ÿ�.
select name 
from customer natural join orders natural join book
where publisher = '���ѹ̵��';

--29. �������� �߱��� ���Ե� ������ �󱸷� ������ �� ���� ����� ���̽ÿ�.
select replace(bookname,'�߱�','��')
from book
where bookname like '%�߱�%';

--30. �½��������� ������ ������ ����� ������ ���� ���� Ȯ���Ͻÿ�
select bookname, length(bookname)
from book
where publisher = '�½�����';

--** ��Ǯ����. 31. �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.(�ѱ����� ���� ���� ù��° �����̴�.)
select substr(name, 1, 1) ��, count(*) �ο�
from customer
group by substr(name, 1, 1);

--32. �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�
select orderid, orderdate, orderdate+10 Ȯ������
from orders;

--**���� �̻�. 33. 2014�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. (�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ��)
select orderid �ֹ���ȣ, to_char(orderdate,'yyyy-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
from customer natural join orders natural join book
where orderdate = '2014/07/07';

--34. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�.��, ��ȭ��ȣ�� ���� ���� ������ó������ ���� ǥ���Ѵ�.
select name, nvl(phone, '����ó����')
from customer;
