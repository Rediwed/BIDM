
-- Queries lab 0

--Chapter 1-3

--A
--Done

--B
sp_tables

--C
sp_who
sp_who "active"

--Chapter 4
--A.B DONE

--C

SELECT DISTINCT order_num
FROM orderitems

--D
SELECT TOP(2) *
FROM orderitems

--OF

SELECT order_num
FROM orderitems



--Chapter 5
--A Done

--B

SELECT TOP 3 *
FROM orderitems
ORDER BY item_price DESC



--Chapter 6

--A Done

--B
SELECT *
FROM customers 
WHERE cust_id BETWEEN 10002 AND 10004

--C
SELECT *
FROM customers
WHERE cust_email IS NOT NULL AND cust_zip = '44444' 

--Chapter 7

--A Done
--B
SELECT *
FROM orderitems
WHERE item_price >= 10 and (order_num = '20005' or order_num = '20009') 
ORDER by prod_id
--C



SELECT *
FROM orderitems
WHERE order_num IN (20005,20009) AND item_price >=10
ORDER BY prod_id

--D
SELECT *
FROM orderitems
WHERE order_num NOT IN (20005,20009) AND NOT item_price >=10

-- Queries lab 1

--Chapter 8
--A Done

--B
SELECT *
FROM orderitems
WHERE prod_id LIKE '%[0-9]%'

--C

SELECT order_item, prod_id
FROM orderitems
WHERE NOT prod_id LIKE '%[0-9]%'

--D
SELECT order_item, prod_id
INTO #2064050tmp
FROM orderitems

drop table #2064050tmp

--E

SELECT *
INTO #tmp
FROM Patstat
WHERE NOT npl_biblio like '%[0-9]%' AND npl_biblio like '%et al%'


SELECT * 
FROM #tmp
WHERE npl_biblio like '% abstract.'

drop table #tmp

--Chapter 9

--A Done

--B
SELECT *, RTRIM(cust_address) + '('+ RTrim(cust_city) +')' AS Cust_city_adress
FROM customers

--C

SELECT *, RTrim(cust_address) + ' ' + LTrim(cust_city) as cust_address_city
FROM Customers
WHERE cust_contact like 'J%'

--D
SELECT 100*10 AS result

--E
SELECT getdate() AS Currentdata

--Chapter 10

--A Done

--B
SELECT cust_email, Right(RTrim(cust_email), (Len(cust_email) - CHARINDEX('@', cust_email))) as Domain
FROM Customers

--C
SELECT cust_email, replace(Right(RTrim(cust_email), (Len(cust_email) - CHARINDEX('@', cust_email))), 'com', 'org')  as Domain_org
FROM Customers

--D

SELECT *, Year(order_date) as Jaar, Month(order_date) as Maand, DatePart(qq, order_date) as Kwartaal
FROM Orders
ORDER BY Jaar, Maand, Kwartaal

--E
SELECT *, Year(order_date) as Jaar, Month(order_date) as Maand, DateName(Month, order_date) as Maandnaam, DatePart(qq, order_date) as Kwartaal
from Orders
ORDER BY Jaar, Maand, Kwartaal 

--F

select item_price, round(item_price, 0) as rounded_item_price
from Orderitems

--G

select * from
(select *, dense_rank() over (order by item_price desc) as Rank from Orderitems) A
where a.Rank <= 4

--Chapter 11
--A Done

--B

SELECT sum(item_price) AS price_total
FROM orderitems

--C
select order_num, count(*) as Unique_items
from Orderitems
group by order_num


--D
SELECT SUM(item_price * quantity) as Sum_Revenue, Min(item_price * quantity) as Lowest_Revenue, Max(item_price * quantity) as Highest_Revenue
FROM Orderitems

--Chapter 12
--A Done

--B
SELECT order_num,COUNT(*) AS order_num_count, SUM(quantity*order_item) AS order_num_revenue
FROM orderitems
group by order_num
HAVING order_num_revenue >100
ORDER BY prod_id ASC


--C
SELECT prod_id, count(*) as prod_id_count, sum(quantity*item_price) as prod_id_revenue
FROM Orderitems
GROUP BY prod_id
HAVING sum(quantity*item_price) >= 50 and sum(quantity*item_price) <= 150
ORDER BY prod_id_revenue DESC

--Chapter 13

--A DONE
--B 
select * from orders
select * from Orderitems

select cust_name, cust_contact, cust_id
from customers
WHERE NOT cust_id IN (select cust_id
from Orders 
WHERE order_num IN (select order_num from orderitems where prod_id = 'TNT2' or prod_id = 'SLING'))

--C
select count(*), c.cust_name
from orders as a
join orderitems as b on a.order_num = b.order_num
join customers as c on a.cust_id = c.cust_id
group by c.cust_name

--D
select *
from Customers 
where cust_id not in (select cust_id from orders)

--E 
select *
from Customers 
where not exists (select * from orders where customers.cust_id = orders.cust_id)

--F 
select cust_name, cust_id
from Customers 
where not exists (select *
                from Orders
                WHERE DATEDIFF(month, order_date, '2005-09-01') = 0)

--G
select top(1) cluster_id, count(cluster_id) as num_publications
from Patstat_golden_set
group by cluster_id
order by num_publications desc

--Chapter 14
--A Done

--B 
select *
from customers as c, orders as b
order by c.cust_id, b.order_num

--C
SELECT vend_name, prod_name, prod_price
FROM vendors as a
join Products as b on a.vend_id = b.vend_id
ORDER BY vend_name, prod_name;

--D
select c.cust_name, b.prod_id, b.order_num
from orders as a
join orderitems as b on a.order_num = b.order_num
join customers as c on a.cust_id = c.cust_id
where c.cust_name = 'Coyote Inc.'
group by c.cust_name, b.prod_id, b.order_num
order by prod_id

-- Chapter 15
--A Done

--B
-- KAN OOK MET LEFT JOIN

select *  
from orders as a
join orderitems as b on a.order_num = b.order_num
right join customers as c on a.cust_id = c.cust_id

--C
select c.*, b.*
from customers as a
full join orders as b on a.cust_id = b.cust_id
full join orderitems as c on b.order_num = c.order_num

--D
select *
from orderitems as c
join orderitems as b on c.item_price = b.item_price
	and b.order_num < c.order_num
	and b.prod_id > c.prod_id;

select *
from orderitems as o1 join orderitems as o2 on o1.item_price = o2.item_price
	and o1.order_num < o2.order_num
	and o1.prod_id > o2.prod_id;

--Chapter 16 -- Even overslaan

--Chapter 18

--A done

--B 
drop table #tmp
create table #tmp (order_num int null);
insert into #tmp
select distinct b.order_num
From customers as a
join orders as b on a.cust_id = b.cust_id
join orderitems as c on b.order_num = c.order_num
where cust_city in ('Detroit','Chicago') or item_price > 10;

--C

insert into #tmp(order_num)
VALUES ('20010');

insert into #tmp(order_num)
VALUES ('20011');

insert into #tmp(order_num)
VALUES ('20012');

insert into #tmp(order_num)
VALUES ('20013');

--D
select * 
into #tmp2
from #tmp

insert into #tmp2
VALUES (NULL);

insert into #tmp2
VALUES (NULL);

insert into #tmp2
VALUES (NULL);

select *
from #tmp2

--Chapter 19

drop table #tmp2
--A Done
--B

delete from #tmp2
where order_num is NULL or order_num >= 20010

select *
from #tmp

--C
delete from #tmp

drop table #tmp2

--D  

select *
from #orderitems
into #orderitems from orderitems

update #orderitems set item_price = 10 * item_price 
WHERE quantity > 1
update #orderitems set item_price = 5 * item_price 
WHERE quantity = 1



--E
