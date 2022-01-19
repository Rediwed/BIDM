select order_num from Orderitems group by order_num
select top 3 * from Orderitems order by item_price desc

select * from Customers
select * from Customers where cust_email is not null and cust_zip = '44444'


select * from Orderitems where item_price >= 10 and (order_num = '20005' or order_num = '20009') order by prod_id
select * from Orderitems

select *
from Orderitems
WHERE NOT prod_id LIKE '%[0-9]%'

select *
into #tmp
from Orderitems
WHERE NOT prod_id LIKE '%[0-9]%'

select * from #tmp
drop table #tmp

select *
into #tmp
from Patstat
WHERE NOT npl_biblio like '%[0-9]%' AND npl_biblio like '%et al%'

select * from #tmp
WHERE npl_biblio like '% abstract.'

drop table #tmp

select *, (RTrim(cust_address) + ' ' + LTrim(cust_city)) as cust_address_city
from Customers
WHERE cust_contact like 'J%'

select 100*10%10 as Result

select GETDATE() as CurrentDate

select cust_email, (CHARINDEX('@', cust))
from Customers

select cust_email, Right(RTrim(cust_email), (Len(cust_email) - CHARINDEX('@', cust_email))) as Domain
from Customers

select cust_email, replace(Right(RTrim(cust_email), (Len(cust_email) - CHARINDEX('@', cust_email))), 'com', 'org') as Domain_Org
from Customers

select *, Year(order_date) as Jaar, Month(order_date) as Maand, DatePart(qq, order_date) as Kwartaal
from Orders
ORDER BY Jaar, Maand, Kwartaal

select *, Year(order_date) as Jaar, Month(order_date) as Maand, DateName(Month, order_date) as Maandnaam, DatePart(qq, order_date) as Kwartaal
from Orders
ORDER BY Jaar, Maand, Kwartaal

select item_price, round(item_price, 0) as rounded_item_price
from Orderitems

select * from
(select *, dense_rank() over (order by item_price desc) as Rank from Orderitems) A
where a.Rank <= 4

select sum(item_price) as price_total
from Orderitems

select count(a.order_item) from (select order_item from Orderitems group by order_item) A

select SUM(item_price * quantity) as Sum_Revenue, Min(item_price * quantity) as Lowest_Revenue, Max(item_price * quantity) as Highest_Revenue
from Orderitems

select order_num, count(*) as Unique_items
from Orderitems
group by order_num

select prod_id, count(*) as prod_id_count, sum(quantity*item_price) as prod_id_revenue
from Orderitems
group by prod_id
having sum(quantity*item_price) >= 50 and sum(quantity*item_price) <= 150
order by prod_id_revenue asc