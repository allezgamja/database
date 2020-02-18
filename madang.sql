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


-- Book, Customer, Orders ������ ����
INSERT INTO Book VALUES(1, '�౸�� ����', '�½�����', 7000);
INSERT INTO Book VALUES(2, '�౸�ƴ� ����', '������', 13000);
INSERT INTO Book VALUES(3, '�౸�� ����', '���ѹ̵��', 22000);
INSERT INTO Book VALUES(4, '���� ���̺�', '���ѹ̵��', 35000);
INSERT INTO Book VALUES(5, '�ǰ� ����', '�½�����', 8000);
INSERT INTO Book VALUES(6, '���� �ܰ躰���', '�½�����', 6000);
INSERT INTO Book VALUES(7, '�߱��� �߾�', '�̻�̵��', 20000);
INSERT INTO Book VALUES(8, '�߱��� ��Ź��', '�̻�̵��', 13000);
INSERT INTO Book VALUES(9, '�ø��� �̾߱�', '�Ｚ��', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '������', '���� ��ü��Ÿ', '000-5000-0001');
INSERT INTO Customer VALUES (2, '�迬��', '���ѹα� ����', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '��̶�', '���ѹα� ������', '000-7000-0001');
INSERT INTO Customer VALUES (4, '�߽ż�', '�̱� Ŭ������', '000-8000-0001');
INSERT INTO Customer VALUES (5, '�ڼ���', '���ѹα� ����',  NULL);

-- �ֹ�(Orders) ���̺��� å���� ���� �ǸŸ� ������
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
select * from Book where publisher in ('�½�����','���ѹ̵��');
select * from Book where publisher not in ('�½�����','���ѹ̵��');
select bookname, publisher from Book where bookname like '�౸�� ����';
select bookname, publisher from Book where bookname like '%�౸%';
select * from Book where bookname like '_��%'; -- ���� �ι�° ��ġ�� '��'
select * from Book where bookname like '%�౸%' and price >= 20000;
select * from Book where publisher='�½�����' or publisher='���ѹ̵��';

-- Order By (���������� default)
select * from Book order by bookname;
select * from Book order by price, bookname; -- ����->�̸���
select * from Book order by price desc, publisher asc;

-- �����Լ�
select sum(saleprice) from Orders;
select sum(saleprice) AS �Ѹ��� from Orders;
select sum(saleprice) as �Ѹ��� from orders where custid=2;
select sum(saleprice) as Total,
       avg(saleprice) as Average,
       min(saleprice) as Minimum,
       max(saleprice) as Max
          from orders;
select count(*) from orders; -- �����ǸŰǼ�

-- Group By: ��� ���� �󸶳� �ֹ��ߴ���
select custid, count(*) as ��������, sum(saleprice) as �Ѿ�
       from orders
       group by custid;
     -- custid�� ���� ���ε� sum()�� ���� �ϳ�. ��Ī�� �� �ȴ�. group by�� ������� �Ѵ�.
select custid, sum(saleprice) from orders;
select count(*) as �������� from orders
       where saleprice >= 8000
       group by custid
       having count(*) >= 2;

-- ��������
select bookname from Book where bookid = 1;
select bookname from Book where price >= 20000;
select sum(saleprice) from Orders
       where custid = 1;
select count(*) from Orders
       where custid = 1;
select count(*) as �������� from Book;
select count(distinct publisher) from Book;
select name, address from customer;
select orderid from orders where orderdate in ('14/07/04', '14/07/07');
select orderid from orders where orderdate not in ('14/07/04', '14/07/07');
select name, address from customer where name like '��%';
select name, address from customer where name like '��%��';

-- �������
insert into Book(bookid,bookname,price,publisher) Values(11,'�౸�̾߱�',8000,'AAAA');

-- ����: �ʿ��� �� ���� ���̺��� ��ģ��.
select * from customer, orders;
select * from customer, orders where customer.custid = orders.custid; -- ��¥ �������� �ֹ��� ������ �����ش�.
select * from customer, orders where customer.custid = orders.custid order by customer.custid;-- ����ȣ ������� �����ش�.
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
select customer.name, saleprice -- �ܺ�����(outerjoin)
    from customer, orders where customer.custid=orders.custid(+);
select customer.name, saleprice
    from customer left outer join orders on customer.custid = orders.custid;

-- Oracle ��ø���ǹ���
-- (5)�������� ������ ������ ���ǻ� ��
select customer.name �̸�, count(distinct publisher) ���ǻ�� from book, customer, orders
       where orders.custid = customer.custid and book.bookid = orders.bookid
             and customer.name = '������'
       group by customer.name;
-- (6) �������� ������ ������ �̸�, ����, ������ �ǸŰ��� ����
select book.bookname, book.price, book.price-orders.saleprice
       from customer, orders, book
       where orders.custid=customer.custid and book.bookid=orders.bookid
             and customer.name = '������';
-- (7) �������� �������� ���� ������ �̸�*******
select bookname from book
       where bookid not in (select bookid from orders
                            where custid = (select custid from customer
                                            where name='������'));
-- (8)�ֹ����� ���� ���� �̸�(�μ����ǻ��)
-- (9) �ֹ��ݾ��� �Ѿװ� �ֹ��� ��ձݾ�
-- (10) ���� �̸��� ���� ���ž�
-- (11) ���� �̸��� ���� ������ �������
-- (12) ������ ���ݰ� �ǸŰ����� ���̰� ���� ���� �ֹ�
-- (13) ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�

select * from customer;
select * from orders;
select * from book;

select b1.bookname from Book b1 where b1.price > (select avg(b2.price) from Book b2 where b2.publisher=b1.publisher);
-- ���缭���� ���� �Ǹž�(����� ���̸��� ���� �Ǹž� ���)

select custid, sum(saleprice) "�հ�"
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

-- �� ���� ��� �ֹ��ݾ� --
select orderid, custid, saleprice
from Orders od
where saleprice > (select avg(saleprice) --�����ʿ� ������,���Ͽ��� �� ��Į���� �;� �Ѵ�.
                    from orders so  -- ��������� ���� ��ü �ֹ��ݾ� ��պ��� ū ��
                    where od.custid=so.custid);  -- group by�� ����?.. where�� ��ü�� for���� ��

