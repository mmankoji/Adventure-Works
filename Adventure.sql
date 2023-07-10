use adventure;

# 1. Calculation of KPI's 
select round(sum(salesamount),2) as TtlSales, round(sum(TotalProductCost),2) as TtlCost, sum(orderQuantity) as TtlQuantity, count(distinct salesordernumber) as TtlOrders, 
round((sum(salesamount)-sum(TotalProductCost)),2) as Profit
from
(select * from factintsalesnew
union
select * from factinternetsalesold) as Total;

create view TotalKPI as 
select round(sum(salesamount),2) as TtlSales, round(sum(TotalProductCost),2) as TtlCost, sum(orderQuantity) as TtlQuantity, count(distinct salesordernumber) as TtlOrders, 
round((sum(salesamount)-sum(TotalProductCost)),2) as Profit
from
(select * from factintsalesnew
union
select * from factinternetsalesold) as Total;

select * from TotalKPI;         -- calculation of KPI's 

# 2. Calculation of Yearwise KPI's 
select year(OrderDateKey) as Year, round(sum(salesamount),2) as TtlSales, round(sum(TotalProductCost),2) as TtlCost, sum(orderQuantity) as TtlQuantity, count(distinct salesordernumber) as TtlOrders, 
round((sum(salesamount)-sum(TotalProductCost)),2) as Profit
from
(select * from factintsalesnew
union
select * from factinternetsalesold) as Total
group by 1;

create view YearwiseKPI as 
select year(OrderDateKey) as Year, round(sum(salesamount),2) as TtlSales, round(sum(TotalProductCost),2) as TtlCost, sum(orderQuantity) as TtlQuantity, count(distinct salesordernumber) as TtlOrders, 
round((sum(salesamount)-sum(TotalProductCost)),2) as Profit
from
(select * from factintsalesnew
union
select * from factinternetsalesold) as Total
group by 1;

select * from YearwiseKPI;   -- Yearwise KPI's 

# 3.  Countrywise sales and Profit
select * from dimsalesterritory;
select * from factinternetsalesold;

SELECT
  d.SalesTerritoryCountry AS country,
  round(SUM(salesAmount), 2) AS TotalSales,
  ROUND(SUM(salesAmount) - SUM(TotalProductCost), 2) AS profit
FROM
  (SELECT * FROM factintsalesnew
   UNION
   SELECT * FROM factinternetsalesold) AS f
LEFT JOIN dimsalesterritory AS d ON 
f.SalesTerritoryKey = d.SalesTerritoryKey
GROUP BY 1;

create view countrywisedetails as
SELECT
  d.SalesTerritoryCountry AS country,
  round(SUM(salesAmount), 2) AS TotalSales,
  ROUND(SUM(salesAmount) - SUM(TotalProductCost), 2) AS profit
FROM
  (SELECT * FROM factintsalesnew
   UNION
   SELECT * FROM factinternetsalesold) AS f
LEFT JOIN dimsalesterritory AS d ON 
f.SalesTerritoryKey = d.SalesTerritoryKey
GROUP BY 1;

select * from countrywisedetails;         -- countrywise Sales & profit


select * from dimproduct;
select * from dimproductsubcategory;
SELECT * FROM factinternetsalesold;
select * from dimproductcategory;

# 4. Productwise Sales & orders Quantity
select dm.EnglishProductSubcategoryName as SubCategory, 
round(sum(salesamount), 2) as TotalSales, 
sum(orderquantity) as TotalOrdersQty
from
(select * from factintsalesnew
union
select * from factinternetsalesold) as F
left join dimproduct as d on
d.ProductKey = f.ProductKey
left join dimproductsubcategory as dm on 
dm.ProductSubcategoryKey = d.ProductSubcategoryKey
group by 1
order by 2 desc;

SELECT * FROM factinternetsalesold;

# Monthwise Sales, ProductionCost and Profit
select year(orderdatekey) as Year, month(orderdatekey) as Month, round(sum(salesAmount), 2) as TotalSales, round(sum(TotalProductCost), 2) as ProductionCost, 
round(sum(salesamount-TotalProductCost), 2) as Profit
from
(select * from factintsalesnew
union
select * from factinternetsalesold) as F
group by 1, 2
order by 1 asc;

# Display the product name and list price of all products from the Products table

select * from dimproduct;
SELECT * FROM factinternetsalesold;

select EnglishProductName, round(listprice, 2) as Price from dimproduct
group by 2
order by 2 desc
limit 10;

# Find the total sales amount for each product category.
select EnglishProductName as ProductName, round(sum(salesamount), 2) as TotalSales
from
(select * from factintsalesnew
union
select * from factinternetsalesold) as F
left join dimproduct as d on
f.ProductKey = d.ProductKey
group by 1
order by 2 desc;

# Display the order number, order date, and shipping address for all orders placed by a specific customer (you can choose a customer ID)

select * from dimcustomer;
SELECT * FROM factinternetsalesold;

select d.CustomerKey, count(SalesOrderNumber), round(sum(salesamount), 2) as TotalSales, OrderDateKey, AddressLine1
from
(select * from factintsalesnew
union
select * from factinternetsalesold) as F
left join dimcustomer as d on
f.CustomerKey = d.CustomerKey
group by 1
order by 3 desc
limit 20;

# Retrieve the product name, standard cost, and list price for all products that have a profit margin greater than 30%.

select * from dimproduct;
SELECT * FROM factinternetsalesold;

select EnglishProductName, ProductStandardCost, ListPrice, round((SalesAmount-TotalProductCost), 2) as profit
from
(select * from factintsalesnew
union
select * from factinternetsalesold) as F
left join dimproduct as d on
d.ProductKey = f.ProductKey;









