--1. 모든 도서의 이름과 가격을 검색하시오
select bookname, price
from book;

--2. 모든 도서의 이름과 가격을 검색하시오
select bookname, price
from book;

--3. 모든 도서의 도서번호,  도서이름, 출판사, 가격을 검색하시오
select bookid, bookname, publisher, price
from book;

--4. 도서 테이블에 있는 모든 출판사를 검색하시오.(중복 제거)
select distinct publisher
from book;

--5. 가격이 20,000원 미만인 도서를 검색하시오.
select bookname
from book
where price <20000;

--6. 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
select bookname
from book
where price between 10000 and 20000;

--7. 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오.
select bookname
from book
where publisher = '굿스포츠' or publisher = '대한미디어';

--8.‘축구의 역사’를 출간한 출판사를 검색하시오.
select publisher
from book
where bookname = '축구의 역사';

--9. 도서이름에 ‘축구’가 포함된 출판사를 검색하시오.
select publisher
from book
where bookname like '%축구%';

--10. 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
select bookname
from book
where bookname like '_구%';

--11. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
select bookname
from book
where price between 10000 and 20000;

--12. 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오.
select bookname
from book
where publisher = '굿스포츠' or publisher = '대한미디어';

--13. 도서를 이름순으로 검색하시오.
select bookname
from book
order by bookname;

--14. 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
select price, bookname
from book
order by price, bookname;

--15. 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 검색하시오 
select price, publisher, bookname
from book
order by price desc, publisher asc;

--16. 고객이 주문한 도서의 총 판매액을 구하시오.
select sum(saleprice)총판매액
from orders;

--** 모르겠음.17. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의  총 수량을 구하시오.  단, 두 권 이상 구매한 고객만 구한다.
select custid, count(*) as 도서수량
from orders
where saleprice >= 8000
group by custid
having count(*) >= 2;

--18. 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
select *
from customer c inner join orders o
on c.custid = o.custid;

--19. 고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬하여 보이시오.
select *
from customer natural join orders
order by custid;

--20. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
select name, saleprice
from customer natural join orders;

--21. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
select custid, sum(saleprice)
from customer natural join orders 
group by custid
order by custid;

--22. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오
select name, bookname
from customer natural join orders natural join book
order by name;

--23. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오
select name, bookname
from customer natural join orders natural join book
order by name;

--24. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
select name, price
from customer natural join orders natural join book
where price > 20000;

--**모르겠음25. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오
SELECT Customer.name, saleprice
FROM Customer LEFT OUTER JOIN Orders 
ON Customer.custid =Orders.custid;	

select c.name, o.saleprice
from customer c full outer join orders o 
on c.custid = o.custid;

--26. 가장 비싼 도서의 이름을 보이시오.
select bookname
from book
where price = (select max(price) from book);

--27. 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
select distinct name
from customer natural join book natural join orders;

--28. 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
select name 
from customer natural join orders natural join book
where publisher = '대한미디어';

--29. 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 보이시오.
select replace(bookname,'야구','농구')
from book
where bookname like '%야구%';

--30. 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수를 확인하시오
select bookname, length(bookname)
from book
where publisher = '굿스포츠';

--** 못풀었음. 31. 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.(한국인은 성이 제일 첫번째 글자이다.)
select substr(name, 1, 1) 성, count(*) 인원
from customer
group by substr(name, 1, 1);

--32. 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오
select orderid, orderdate, orderdate+10 확정일자
from orders;

--**문제 이상. 33. 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. (단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시)
select orderid 주문번호, to_char(orderdate,'yyyy-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
from customer natural join orders natural join book
where orderdate = '2014/07/07';

--34. 이름, 전화번호가 포함된 고객목록을 보이시오.단, 전화번호가 없는 고객은 ‘연락처없음’ 으로 표시한다.
select name, nvl(phone, '연락처없음')
from customer;
