use project;
describe customers;
describe sales;
-- 1.Which brand is purchased more frequently based on customer gender?
with rank_data as(with grp_data as(
select c.Gender,s.Brand,count(s.Order_id)as purchase_count
from customers as c
inner join sales as s on c.Customer_id=s.Customer_id
group by c.Gender,s.Brand)
select Gender,Brand,purchase_count,rank() over(partition by gender order by purchase_count desc)as ranking from grp_data
)
select* from rank_data where ranking=1;

-- 2.Which age group buys laptops the most?
select c.Age_group,count(Product_name)as lap_count from customers as c
inner join sales as s on c.Customer_id=s.Customer_id
where Product_name like '%laptop%'
group by c.Age_group
order by lap_count desc limit 1;

-- 3.Which customer tier places the most orders?
select c.Customer_tier,count(s.Order_id)as order_count from customers as c
inner join sales as s
on c.Customer_id=s.Customer_id
group by c.Customer_tier
order by order_count desc limit 1 ;

-- 4.Do Gold customers spend more per order than Silver customers?
select c.Customer_tier,round(avg(s.Total_amount),2) as avg_amount from customers as c
inner join sales as s on c.Customer_id=s.Customer_id where c.Customer_tier in('Gold','silver')
group by c.customer_tier;

-- 5.Which customer tier has more customers who make repeat purchases?
with purchase_count as(select c.Customer_Name,c.Customer_id,count(s.Customer_id) as order_count from customers as c
inner join sales as s
on c.Customer_id=s.Customer_id group by c.Customer_id having order_count>1)
select c.customer_tier,count(p.order_count) as repeat_purchase from customers as c
inner join purchase_count as p on c.Customer_id=p.Customer_id group by c.customer_tier 
order by repeat_purchase desc limit 1;

-- 6.Do customers who receive higher discounts place more orders?
with category_cte as(
select c.customer_Name,c.customer_id,count(s.customer_id) as order_count,round(avg(discount_amount),2) as avg_discount,
case 
when avg(s.discount_amount)>(select avg(discount_amount)from sales) then 'higher discount'
else 'lower discount'
end as discount_category
from customers as c inner join sales as s on c.Customer_id=s.Customer_id
group by c.customer_id,c.customer_name
order by avg_discount desc)
select discount_category,avg(order_count)as avg_order from category_cte
group by discount_category order by avg_order desc;

-- 7.For each category, which brand is purchased most frequently?
with brand_count as(
select Category,Brand,count(*)as purchase_count from sales group by Category,Brand)
,rank_cte as(select Category,Brand,rank() over(partition by Category order by purchase_count desc)as ranking from brand_count)
select*from rank_cte where ranking=1;

-- 8.Which product has the highest customer rating?
select Product_Name,avg(Rating)as avg_rating from sales group by Product_Name
order by avg_rating desc limit 1;

-- 9.Which product has the highest discount amount?
select Product_Name,max(Discount_Amount) as highest_discount from sales group by Product_Name 
order by highest_discount desc limit 1;

-- 10.Which date has the highest total sales amount?
select Order_Date,sum(Total_Amount) as sum_of_amount from sales
group by Order_Date order by sum_of_amount desc limit 1;

-- 11.During which time period do customers place orders most frequently?
select hour(Order_Time)as order_hour,count(Customer_id)as order_count from sales group by order_hour
order by order_count desc limit 1;

-- 12.Which payment mode do customers use most frequently?
select Payment_Mode,count(Payment_Mode)as mode_count from sales group by Payment_Mode
order by mode_count desc limit 1;

-- 13.Which payment mode has more cancelled orders?
select Payment_Mode,count(Payment_Mode)as cancellation_c from sales where Order_Status ='cancelled'
group by Payment_Mode order by cancellation_c desc limit 1;

-- 14.Which product category has the highest return rate?
with return_cte as(select category,count(*) as tot_orders,sum(
case
when order_status='returned' then 1
else 0
end)as returned_orders from sales 
group by category)
select category,tot_orders,returned_orders,
round((returned_orders /tot_orders)*100,2) as return_rate from return_cte
order by return_rate desc limit 1;

-- 15.Which product category takes the longest to be delivered?
select category,avg(datediff(delivery_date,order_date)) as avg_delivery_days from sales 
where order_status = 'Delivered'
group by category order by avg_delivery_days desc limit 1;

-- 16.Who is the top-spending customer for each brand?
with cust_rank as(with cust_tot_spend as
(select c.customer_id,c.customer_name,s.brand,sum(s.total_amount)as tot_spend
from customers as c inner join sales as s
on c.customer_id=s.customer_id
group by c.customer_name,c.customer_id,s.brand)
select customer_name,brand,tot_spend,rank() over(partition by brand order by tot_spend desc)as ranking
from cust_tot_spend)
select* from cust_rank where ranking=1;

-- 17.Which age group has the highest average spending per order?
select c.age_group,round(avg(s.total_amount),2)as avg_spent from customers as c
inner join sales as s on c.customer_id=s.customer_id
group by c.age_group order by avg_spent desc limit 1;

-- 18.Which product category has the largest difference between average original price and average selling price?
with avg_cte as
(select category,round(avg(original_price),2) as avg_og_price,round(avg(selling_price),2) as avg_sell_price from sales
group by category)
select category,avg_og_price,avg_sell_price,(avg_og_price-avg_sell_price) as difference from avg_cte
order by difference desc limit 1;

-- 19.Which product category is most popular in each city?
with city_category as
(select c.city,s.category,count(*) as order_c from customers as c
inner join sales as s
on c.customer_id=s.customer_id
group by c.city,s.category),
city_rank as(
select city,category,order_c,
rank() over(partition by city order by order_c desc)
as ranking from city_category)
select*from city_rank where ranking=1;

-- 20.Which products have both high customer ratings and high purchase frequency?
with prod_status as
(select product_name,avg(rating) as avg_rating,count(customer_id) as purchase_c from sales 
group by product_name)
select*from prod_status where avg_rating>(select avg(avg_rating) from prod_status)
and purchase_c>(select avg(purchase_c) from prod_status)
order by avg_rating desc,purchase_c desc;

-- 21.Do expensive products receive more discounts than lower-priced products?
with prod_details as
(select product_name,avg(original_price)as price_avg,avg(discount_amount) as avg_discount
from sales group by product_name),
price_cte as(
select product_name,price_avg,avg_discount,
case
when price_avg>(select avg(price_avg) from prod_details) then 'Expensive'
else 'Low priced'
end as price_category from prod_details)
select price_category,avg(avg_discount) as overall_avg
from price_cte group by price_category;

-- 22.Does delivery time affect customer ratings?
with delivery_time as(
select datediff(delivery_date,order_date)as delivery_days,rating from sales
where order_status='delivered')
,delivery_speed as
(select delivery_days,rating,case
when delivery_days<3 then 'fast'
when delivery_days<6 then 'Medium'
else 'Slow'
end as speed from delivery_time)
select speed,avg(rating)as avg_rating from delivery_speed
group by speed order by avg_rating desc;

-- 23. How is each product performing based on sales, orders, discounts, and customer ratings?
create view product_performance as
(select product_name,brand,category,count(*) as tot_orders,sum(total_amount) as tot_sales,avg(discount_amount) as avg_discount,
avg(rating) as avg_rating from sales
group by product_name,category,brand);

select*from product_performance;