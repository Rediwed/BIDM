-- Chapter 5 (B)
SELECT top 3 *
FROM products
ORDER BY prod_price desc

-- Chapter 6 (C)
SELECT cust_name, cust_id, cust_email, cust_zip
FROM customers
WHERE cust_email is not null AND cust_zip = '44444'

-- Chapter 7 (D)
SELECT *
FROM Orderitems
WHERE order_num NOT IN (20005,20009) AND NOT item_price >= 10
ORDER BY prod_id

-- Chapter 8 (C)
SELECT *
FROM Orderitems
WHERE prod_id NOT like '%[0-9]%'

-- Chapter 8 (D)
SELECT *
INTO #Q8D_2056806
FROM Orderitems
WHERE prod_id NOT like '%[0-9]%'

SELECT *
FROM #Q8D_2056806

Drop table #Q8D_2056806

-- Chapter 9 (C)
SELECT *, (Trim(cust_address) + ' ' + Trim(cust_city)) as cust_address_city
FROM Customers

-- Chapter 10 (C)
SELECT cust_email, Replace(right(Trim(cust_email), len(cust_email) - CHARINDEX('@', cust_email)), 'com', 'org') as cust_Domain
FROM Customers

-- Chapter 10 (G)
SELECT *
FROM (SELECT *, DENSE_RANK() OVER (ORDER BY item_price DESC) AS Ranking FROM Orderitems) A
where a.Ranking <= 4

-- Chapter 11 (B)
SELECT *, quantity * item_price as price_total
FROM Orderitems

-- Chapter 11 (D)
SELECT min(quantity * item_price) AS Min_price, max(quantity * item_price) AS Max_price, sum(quantity * item_price) AS Sum_price
FROM Orderitems

-- Chaptre 12 (C)
SELECT prod_id, sum(quantity) as prod_id_count, sum(quantity * item_price) as order_num_revenue
FROM Orderitems
GROUP BY prod_id

-- Chapter 13 (C)
SELECT cust_name, cust_contact
FROM Customers
Where cust_id in (SELECT cust_id FROM Orders Where order_num in (Select order_num from Orderitems where prod_id NOT in ('TNT2','SLING')))

-- Chapter 13 (D)
SELECT *
FROM Customers
WHERE cust_id not in (SELECT cust_id from Orders)

-- Chapter 13 (G)
Select * from
(SELECT cluster_id, Count(npl_publn_id) as n_pubs
FROM Patstat_golden_set
GROUP BY cluster_id) A
ORDER BY a.n_pubs DESC

-- Chapter 14 (B)
SELECT *
FROM Customers as C, Orders as O
ORDER BY c.cust_id, o.order_num

-- Chapter 14 (C)
SELECT vend_name, prod_name, prod_price
FROM vendors, products
WHERE vendors.vend_id = products.vend_id
ORDER BY vend_name, prod_name;

SELECT vend_name, prod_name, prod_price
FROM vendors as v
JOIN Products as p on v.vend_id = p.vend_id
ORDER BY vend_name, prod_name;

-- Chapter 14 (D)
SELECT *
FROM Customers as c 
JOIN Orders as o on c.cust_id = o.cust_id
JOIN Orderitems as oi on o.order_num = oi.order_num
WHERE cust_name = 'Coyote Inc.'

-- Chapter 15 (B)
SELECT *
FROM Customers as C
LEFT JOIN Orders as o on c.cust_id = o.cust_id

-- Chapter 15 (D)
/

-- Chapter 18 (B)
create table #tmp (order_num int null);
select distinct b.order_num
from customers as a join orders as b on a.cust_id = b.cust_id
join orderitems as c on b.order_num = c.order_num
where cust_city in ('Detroit','Chicago') or item_price > 10;

-- Chapter 18 (D)
INSERT INTO #tmp(order_num)
values (20010);

INSERT INTO #tmp(order_num)
values (20011);
INSERT INTO #tmp(order_num)
values (20012);
INSERT INTO #tmp(order_num)
values (20013);

SELECT *
INTO #Tmp2
FROM #tmp

select * from #Tmp2

INSERT INTO #tmp2(order_num)
values (null);
INSERT INTO #tmp2(order_num)
values (null);
INSERT INTO #tmp2(order_num)
values (null);

-- Chapter 19 (D)
SELECT *
INTO #Orderitems
FROM Orderitems

UPDATE #Orderitems SET quantity = quantity * 10
WHERE quantity > 1

UPDATE #Orderitems SET quantity = quantity * 5
WHERE quantity = 1

SELECT * from #Orderitems

drop TABLE #Orderitems

-- Chapter 19 (E)
SELECT *
INTO Customers_2056806
From Customers

UPDATE Customers_2056806 SET cust_email = REPLACE(cust_email,'com','org')
WHERE cust_id in (select cust_id from Orders WHERE order_num NOT IN (20005, 20009))

select cust_id from Orders WHERE order_num NOT IN (20005, 20009)
Select * from Customers_2056806