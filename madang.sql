create table Book(
    bookid NUMBER(2) PRIMARY KEY,
    bookname VARCHAR2(40),
    publisher VARCHAR2(40),
    price NUMBER(8)
);

CREATE TABLE  Customer (
  custid      NUMBER(2) PRIMARY KEY,  
  name        VARCHAR2(40),
  address     VARCHAR2(50),
  phone       VARCHAR2(20)
);


CREATE TABLE Orders (
  orderid NUMBER(2) PRIMARY KEY,
  custid  NUMBER(2) REFERENCES Customer(custid),
  bookid  NUMBER(2) REFERENCES Book(bookid),
  saleprice NUMBER(8) ,
  orderdate DATE
);


-- Book, Customer, Orders 데이터 생성
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

-- 주문(Orders) 테이블의 책값은 할인 판매를 가정함
INSERT INTO Orders VALUES (1, 1, 1, 6000, TO_DATE('2014-07-01','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, TO_DATE('2014-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, TO_DATE('2014-07-03','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, TO_DATE('2014-07-04','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, TO_DATE('2014-07-05','yyyy-mm-dd'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, TO_DATE('2014-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, TO_DATE( '2014-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, TO_DATE('2014-07-08','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, TO_DATE('2014-07-09','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, TO_DATE('2014-07-10','yyyy-mm-dd'));

COMMIT;

-- Select / From
select bookname, price from Book;
select * from Book;
select distinct publisher from Book;

-- Where
select * from Book where price < 20000;
select * from Book where price between 10000 and 20000;
select * from Book where publisher in ('굿스포츠','대한미디어');
select * from Book where publisher not in ('굿스포츠','대한미디어');
select bookname, publisher from Book where bookname like '축구의 역사';
select bookname, publisher from Book where bookname like '%축구%';
select * from Book where bookname like '_구%'; -- 왼쪽 두번째 위치에 '구'
select * from Book where bookname like '%축구%' and price >= 20000;
select * from Book where publisher='굿스포츠' or publisher='대한미디어';

-- Order By (오름차순이 default)
select * from Book order by bookname;
select * from Book order by price, bookname; -- 가격->이름순
select * from Book order by price desc, publisher asc;

-- 집계함수
select sum(saleprice) from Orders;
select sum(saleprice) AS 총매출 from Orders;
select sum(saleprice) as 총매출 from orders where custid=2;
select sum(saleprice) as Total,
       avg(saleprice) as Average,
       min(saleprice) as Minimum,
       max(saleprice) as Max
          from orders;
select count(*) from orders; -- 도서판매건수

-- Group By: 어느 고객이 얼마나 주문했는지
select custid, count(*) as 도서수량, sum(saleprice) as 총액
       from orders
       group by custid;
     -- custid는 여러 행인데 sum()은 값이 하나. 매칭이 안 된다. group by로 묶어줘야 한다.
select custid, sum(saleprice) from orders;
select count(*) as 도서수량 from orders
       where saleprice >= 8000
       group by custid
       having count(*) >= 2;

-- 연습문제
select bookname from Book where bookid = 1;
select bookname from Book where price >= 20000;
select sum(saleprice) from Orders
       where custid = 1;
select count(*) from Orders
       where custid = 1;
select count(*) as 도서수량 from Book;
select count(distinct publisher) from Book;
select name, address from customer;
select orderid from orders where orderdate in ('14/07/04', '14/07/07');
select orderid from orders where orderdate not in ('14/07/04', '14/07/07');
select name, address from customer where name like '김%';
select name, address from customer where name like '김%아';

-- 내용삽입
insert into Book(bookid,bookname,price,publisher) Values(11,'축구이야기',8000,'AAAA');

-- 조인: 필요한 두 개의 테이블을 합친다.
select * from customer, orders;
select * from customer, orders where customer.custid = orders.custid; -- 진짜 박지성이 주문한 내역만 보여준다.
select * from customer, orders where customer.custid = orders.custid order by customer.custid;-- 고객번호 순서대로 보여준다.
select name, saleprice from customer, orders where customer.custid = orders.custid;
select customer.name, sum(saleprice) from customer, orders where customer.custid = orders.custid group by customer.name;
select customer.name, book.bookname from customer, orders, book
        where customer.custid = orders.custid and orders.bookid = book.bookid
        order by customer.name;
select customer.name, book.bookname from customer, orders, book
        where book.price = 20000 and customer.custid = orders.custid
             and orders.bookid = book.bookid;
select customer.name, orders.saleprice from customer, orders, book
        where customer.custid = orders.custid and orders.bookid = book.bookid;
select customer.name, saleprice -- 외부조인(outerjoin)
    from customer, orders where customer.custid=orders.custid(+);
select customer.name, saleprice
    from customer left outer join orders on customer.custid = orders.custid;

-- Oracle 중첩질의문제
-- (5)박지성이 구매한 도서의 출판사 수
select customer.name 이름, count(distinct publisher) 출판사수 from book, customer, orders
       where orders.custid = customer.custid and book.bookid = orders.bookid
             and customer.name = '박지성'
       group by customer.name;
-- (6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격 차이
select book.bookname, book.price, book.price-orders.saleprice
       from customer, orders, book
       where orders.custid=customer.custid and book.bookid=orders.bookid
             and customer.name = '박지성';
-- (7) 박지성이 구매하지 않은 도서의 이름*******
select bookname from book
       where bookid not in (select bookid from orders
                            where custid = (select custid from customer
                                            where name='박지성'));
-- (8)주문하지 않은 고객의 이름(부속질의사용)
-- (9) 주문금액의 총액과 주문의 평균금액
-- (10) 고객의 이름과 고객별 구매액
-- (11) 고객의 이름과 고객이 구매한 도서목록
-- (12) 도서의 가격과 판매가격의 차이가 가장 많은 주문
-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름

select * from customer;
select * from orders;
select * from book;

select b1.bookname from Book b1 where b1.price > (select avg(b2.price) from Book b2 where b2.publisher=b1.publisher);
-- 마당서점의 고객별 판매액(결과는 고객이름과 고객별 판매액 출력)

select custid, sum(saleprice) "합계"
from Orders od group by custid;

--
select cs.custid, cs.name, od.orderid
from Customer cs, Orders od
where cs.custid <= 2 and cs.custid = od.custid;

select cs.custid, cs.name, od.orderid
from (select *
     from customer cs
     where cs.custid <=2) cs, orders od
where cs.custid = od.custid;

-- 각 고객의 평균 주문금액 --
select orderid, custid, saleprice
from Orders od
where saleprice > (select avg(saleprice) --오른쪽에 단일행,단일열로 된 스칼라값이 와야 한다.
                    from orders so  -- 여기까지만 쓰면 전체 주문금액 평균보다 큰 것
                    where od.custid=so.custid);  -- group by를 쓰면?.. where절 자체가 for문이 들어감

