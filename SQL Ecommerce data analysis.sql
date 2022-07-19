SELECT * FROM ecommerce.orders_details;
SELECT * FROM ecommerce.orders_name;

----joining two tables------------

SELECT orders_details.Id, orders_details.Amount, orders_details.Profit, orders_details.Quantity, orders_details.Category, orders_details.Sub_category,
orders_name.Date, orders_name.Customer_Name, orders_name.State, orders_name.City 
from ecommerce.orders_details join ecommerce.orders_name
ON orders_details.Id = orders_name.Id;

SELECT * FROM ecommerce.ecommerce_data;

----Profit per item--------

select Id, Amount, Profit, Quantity, Category, Sub_category, Date, Customer_Name, State, City, Profit/Quantity as Profit_per_Quantity 
from ecommerce.ecommerce_data group by Date;

----Monthly (Time series)- purchases, profits, revenue, Profit per item-------------

select sum(Quantity) as items_sold, sum(Profit) as Profit, sum(Amount) as Revenue, Date, sum(Profit/Quantity) as PPI_Orders 
 from ecommerce.ecommerce_data group by Date;
 
 ----Time series analysis of ITEMS SOLD  ------
 
 select Date, sum(Quantity) as Items_sold from ecommerce.ecommerce_data group by Date;
 
 --------Time series analysis of Profit per category------
 
 select Date, Category, sum(Profit) as Total_Profit from ecommerce.ecommerce_data group by Date, Category;
 
 -----Time series analysis of Revenue per category------
 
 select Date, Category, sum(Amount) as Total_Revenue from ecommerce.ecommerce_data group by Date, Category;
 
 -----Total SOLD OF items for each category------
 select Category, sum(Quantity) as Total_items_sold from ecommerce.ecommerce_data group by Category;
 
 -----Time series analysis of Total SOLD OF items for each category--------
 
 select Date, Category, sum(Quantity) as Total_items_sold from ecommerce.ecommerce_data group by Date, Category;
 
 -----------Total SOLD OF items for each sub-category------
 
 select Sub_category, sum(Quantity) as Total_items_sold from ecommerce.ecommerce_data group by Sub_category;
 
 -----Time series analysis of Total SOLD OF items for each category--------
 
 select Date, Sub_category, sum(Quantity) as Total_items_sold from ecommerce.ecommerce_data group by Date, Sub_category;
 
 ------average PPI for each Category------
 
 select Category, AVG(Profit/Quantity) as Average_PPI from ecommerce.ecommerce_data GROUP BY Category Order by Average_PPI;

----PPI spread for each sub category----

select Profit, Category, Sub_category, (Profit/Quantity) AS PPI from ecommerce.ecommerce_data where Category = 'Clothing' GROUP BY Sub_category order by PPI;
 
 select Profit, Category, Sub_category, (Profit/Quantity) AS PPI from ecommerce.ecommerce_data where Category = 'Electronics' GROUP BY Sub_category order by PPI;
 
 select Profit, Category, Sub_category, (Profit/Quantity) AS PPI from ecommerce.ecommerce_data where Category = 'Furniture' GROUP BY Sub_category order by PPI;
 
 ----Avg PPT for each Sub category------
 
 select Sub_category, AVG(Profit/Quantity) as Average_PPI from ecommerce.ecommerce_data GROUP BY Sub_category Order by Average_PPI desc;

 -----Profitability of items - Categories and Sub categories-----------
 
 select Category, sum(Profit) as Total_profit from ecommerce.ecommerce_data GROUP BY Category Order by Total_profit desc;
 
 select Sub_category, sum(Profit) as Total_profit from ecommerce.ecommerce_data GROUP BY Sub_category Order by Total_profit desc;
 
 -------Most Ranked Item- based on Revenue-----Dense Ranking method----
 
 select Category, Sub_category, sum(Amount) as Revenue, dense_rank() over(partition by Category order by sum(Amount) desc) as Highest_Sales
 from ecommerce.ecommerce_data Group by Sub_category;
 
 ------Most Ranked Item based on Quantity-------Ranking method--
 
 select Category, Sub_category, sum(Quantity) as Items_Sold, rank() over(partition by Category order by sum(Quantity) desc) as Best_seller
 from ecommerce.ecommerce_data Group by Sub_category;
 
 ---------City based Item Sold, Profit, Revenue ------
 
 select City, sum(Amount) as Revenue from ecommerce.ecommerce_data GROUP BY City Order by Revenue desc;
 
 select City, sum(Profit) as Total_profit from ecommerce.ecommerce_data GROUP BY City Order by Total_profit desc;
 
 select City, sum(Quantity) as Item_Sold from ecommerce.ecommerce_data GROUP BY City Order by Item_Sold desc;
 
 ---------Statewise ---Items Sold, Profit, Revenue (In - Demand)------
 
 select State, sum(Quantity) as Items_sold from ecommerce.ecommerce_data GROUP BY State Order by Items_sold desc;
 
 select State, sum(Profit) as Total_Profit from ecommerce.ecommerce_data GROUP BY State Order by Total_Profit desc;
 
 select State, sum(Amount) as Revenue from ecommerce.ecommerce_data GROUP BY State Order by Revenue desc;
 
 ---------Statewise and City wise Most Ranked Item based on Items sold-------Ranking method--------Category wise
 
 select State, City, Category, Sub_category, sum(Quantity) as Items_sold, dense_rank() over(partition by State order by sum(Quantity) desc) as Best_Seller
 from ecommerce.ecommerce_data Group by State, Category;
 
 ---------Statewise and City wise Most Ranked Item based on Items sold-------Ranking method-------Sub Category wise
 
 select State, City, Category, Sub_category, sum(Quantity) as Items_sold, dense_rank() over(partition by State order by sum(Quantity) desc) as Best_seller
 from ecommerce.ecommerce_data Group by State, Sub_category;
 
 ---------Statewise and City wise Most Ranked Item based on Revenue-------Ranking method--------Category wise
 
 select State, City, Category, Sub_category, sum(Amount) as Revenue, dense_rank() over(partition by State order by sum(Amount) desc) as Highest_Sales
 from ecommerce.ecommerce_data Group by State, category;
 
  ---------Statewise and City wise Most Ranked Item based on Revenue-------Ranking method--------Sub category wise
 
 select State, City, Category, Sub_category, sum(Amount) as Revenue, dense_rank() over(partition by State order by sum(Amount) desc) as Highest_Sales
 from ecommerce.ecommerce_data Group by State, Sub_category;
 
 ---------Statewise and City wise Most Ranked Item based on Profit-------Ranking method--------Category wise
 
 select State, City, Category, Sub_category, sum(Profit) as Total_Profit, dense_rank() over(partition by State order by sum(Profit) desc) as Highest_Profit
 from ecommerce.ecommerce_data Group by State, category;
 
  ---------Statewise and City wise Most Ranked Item based on Profit-------Ranking method--------Sub Category wise
 
 select State, City, Category, Sub_category, sum(Profit) as Total_Profit, dense_rank() over(partition by State order by sum(Profit) desc) as Highest_Profit
 from ecommerce.ecommerce_data Group by State, Sub_category;
 
 ----------Sales Target and Actual sales table join------
 
 SELECT ecommerce_data.Amount, ecommerce_data.Profit, sales_target.Category, sales_target.Target, sales_target.Month_order
from ecommerce.ecommerce_data JOIN ecommerce.sales_target
ON ecommerce_data.Date = sales_target.Month_order and ecommerce_data.category = sales_target.category;
 
 ---------Total sales amount and sales target for each caegory---------
 
 select Month_order, Category, Target, sum(Amount) as Sales_Amount, (sum(Amount) - Target) as Difference from ecommerce.target_profit group by Month_order, Category;
 

 
 
 
 
 
 