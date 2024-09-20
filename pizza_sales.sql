/*
Create database pizza_sales;
use pizza_sales;
SELECT * FROM pizza_sales.mytable;

# TOTAL NUMBER OF ORDERS
SELECT COUNT(ORDER_ID) AS TOTAL_ORDERS FROM pizza_sales.mytable;

# Total Revenue Generated
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales.mytable;

# Most expensive pizza
SELECT unit_price, pizza_size,
pizza_category, pizza_name
FROM pizza_sales.mytable
ORDER BY unit_price DESC
LIMIT 1;

# Most common pizza ordered 
SELECT p.pizza_name, COUNT(o.order_id) AS order_count
FROM pizza_sales.mytable o
JOIN pizza_sales.mytable p ON o.pizza_id = p.pizza_id
GROUP BY p.pizza_name
ORDER BY order_count DESC;

 # Most common pizza size ordered 
SELECT p.pizza_size, COUNT(o.order_id) AS order_count
FROM pizza_sales.mytable o
JOIN pizza_sales.mytable p ON o.pizza_id = p.pizza_id
GROUP BY p.pizza_size
ORDER BY order_count DESC;

# Join the necessary tables to find the total quantity of each pizza category ordered
SELECT p.pizza_category, SUM(o.quantity) AS total_quantity
FROM pizza_sales.mytable o
JOIN pizza_sales.mytable p ON o.pizza_id = p.pizza_id
GROUP BY p.pizza_category
ORDER BY total_quantity DESC;

# Determine the distribution of orders by hour of the day
SELECT HOUR(order_time) AS order_hour,
COUNT(*) AS order_count
FROM pizza_sales.mytable
GROUP BY order_hour
ORDER BY order_hour;

#Join relevant tables to find the category-wise distribution of pizzas
SELECT p.pizza_category,
COUNT(o.order_id) AS order_count
FROM pizza_sales.mytable o
JOIN pizza_sales.mytable p ON
o.pizza_id = p.pizza_id
GROUP BY p.pizza_category
ORDER BY order_count DESC;

# Determine the top 5 most ordered pizza types based on revenue.
SELECT p.pizza_name, SUM(o.quantity * p.unit_price)
AS total_revenue
FROM pizza_sales.mytable o
JOIN pizza_sales.mytable p ON
o.pizza_id = p.pizza_id
GROUP BY p.pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

# Determine the top 3 most ordered pizza types based on revenue for each pizza category
SELECT pizza_category, pizza_category,
Round(SUM(quantity * unit_price)) AS total_revenue
FROM pizza_sales.mytable
GROUP BY pizza_category, pizza_category
ORDER BY pizza_category, total_revenue DESC
LIMIT 3;

# Analyze the cumulative revenue generated over time
SELECT order_date,
    ROUND(SUM(quantity * unit_price)) AS daily_revenue,
    ROUND(SUM(SUM(quantity * unit_price)) OVER (ORDER BY order_date), 3) AS cumulative_revenue
FROM 
    pizza_sales.mytable
GROUP BY 
    order_date
ORDER BY 
    order_date;

# Calculate the percentage contribution of each pizza type to total revenue
WITH total_revenue AS (
SELECT SUM(quantity * unit_price) AS total_revenue_value
    FROM pizza_sales.mytable
),
category_revenue AS (
    SELECT 
        pizza_category,
        Round(SUM(quantity * unit_price)) AS pizza_category_revenue
    FROM 
        pizza_sales.mytable
    GROUP BY 
        pizza_category
)
SELECT 
    cr.pizza_category,
    cr.pizza_category_revenue,
    ROUND((cr.pizza_category_revenue / tr.total_revenue_value) * 100, 2) AS percentage_contribution
FROM 
    category_revenue cr, 
    total_revenue tr
ORDER BY 
    percentage_contribution DESC;

*/