



/*union*/

SELECT product_id, product_name  from production.products
UNION
SELECT customer_id, first_name from sales.customers
where first_name is NULl
order by product_id;


/*case statement */
SELECT order_id, order_date, 
case
     WHEN order_date > '2017-01-03' THEN 'new'
     when order_date between '2018-01-03' and '2018-05-06' THEN 'newest'
     ELSE 'old'
END     
from sales.orders;


SELECT order_date, order_status,
CASE
    WHEN order_date = '2016-01-16' then order_status +1
    else order_status+2
END    as new_status
 FROM sales.orders
JOIN sales.staffs
    ON sales.orders.store_id = sales.staffs.store_id



/*having clause */

SELECT   store_id ,COUNT(store_id) from sales.staffs
GROUP BY store_id
having COUNT(store_id) > 1
ORDER BY store_id DESC


/* updating, deleting */
SELECT * FROM production.brands

UPDATE production.brands
set brand_name = 'uk'
WHERE brand_id = 2

DELETE from production.brands
WHERE brand_id = 3 


/* aliasing */
SELECT first_name + ' ' + last_name as fullname from [sales].[staffs]


SELECT demo. staff_id, stores.city from [sales].[staffs] as demo
join [sales].stores as stores
 on demo.store_id = stores.store_id

/* partition by */

SELECT first_name, last_name, active, COUNT(active) OVER (partition by active) 
from sales.staffs
join sales.stores
on sales.staffs.store_id = sales.stores.store_id


/*CTE  */

WITH CTE_stores as
(SELECT first_name, last_name, active, COUNT(active) OVER (partition by active) 
from [sales].[staffs]
join [sales].[stores]
    on [sales].[staffs].store_id = [sales].[stores].store_id
)


/*temporary tables*/

CREATE TABLE #temp_sales (
    SalesID int,
    city VARCHAR(100),
    zipsod int
)


insert into #temp_sales VALUES('2', 'city', '0071')
SELECT * from #temp_sales

INSERT into #temp_sales
SELECT * FROM sales.stores


/* temp table 2*/
DROP TABLE if EXISTS #temptable2
CREATE TABLE #temptable2 (
    brendid int,
    brend_name VARCHAR(255)
)

insert into #temptable2 
SELECT brand_id,   AVG(brand_id) FROM production.brands
GROUP by brand_id

SELECT * From #temptable2

/* -- string functions */
DROP TABLE if exists employeeErrors 

CREATE TABLE employeeErrors (
    employee_id VARCHAR(50),
    firstname VARCHAR(50),
    lastname VARCHAR(50)
)

insert into employeeErrors VALUES
(' 100', 'jimbo','halbert'),('101 ', 'pamela', 'beasely'),('105', 'toby', 'flenderson - fired')

SELECT * FROM employeeErrors

-- using trim, ltrim, rtrim
SELECT employee_id, TRIM(employee_id) as idtrim FROM employeeErrors
SELECT employee_id, LTRIM(employee_id) as idtrim FROM employeeErrors
SELECT employee_id, RTRIM(employee_id) as idtrim FROM employeeErrors



-- using replace
SELECT lastname, REPLACE(lastname, '- fired','') FROM employeeErrors

--using substring

SELECT *
from employeeErrors err
join production.categories cat 
    on substring(err.employee_id, 3,1) = cat.category_id


--using UPPER and lower

SELECT firstname, LOWER(firstname)
 FROM employeeErrors
 --all characters in lower latters

SELECT firstname, UPPER(firstname)
 FROM employeeErrors


/* stored procedures */

CREATE PROCEDURE test
as
SELECT * FROM production.categories

exec test



create PROCEDURE temp_empl
AS
CREATE TABLE #temp_employee (
    employee_id VARCHAR(50),
    firstname VARCHAR(50),
    lastname VARCHAR(50)
)

insert into #temp_employee VALUES
(' 100', 'jimbo','halbert'),('101 ', 'pamela', 'beasely'),('105', 'toby', 'flenderson - fired')

SELECT *
from #temp_employee

exec temp_empl @jobtitle = 'salesman'



/*-- subqueryies */

SELECT * 
From sales.staffs


SELECT staff_id, active, (select AVG(active) from sales.staffs) as avg
From sales.staffs



-- subqueries in select

SELECT product_id, list_price, (select AVG(list_price) from production.products)
from production.products

-- subqueries with partition by
SELECT product_id, list_price,  AVG(list_price) over () as avg
from production.products


-- subqueries with group by doesnt work
SELECT product_id, list_price,  AVG(list_price) as avg
from production.products
group by product_id, list_price
ORDER by 1, 2

-- subqueries in from(it's better to use temp tables)
SELECT a.[avg], a.product_id
from (SELECT product_id, list_price,  AVG(list_price) over () as avg
from production.products) a

-- subqueries in where
SELECT product_id, list_price
from production.products
WHERE category_id in (select category_id from production.categories where category_id > 3)



