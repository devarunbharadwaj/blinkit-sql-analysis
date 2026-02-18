/* ============================================================
   BLINKIT SQL BUSINESS ANALYSIS
   Author: Devarun Bharadwaj
   Database: PostgreSQL
   Description: Core business insights for quick-commerce data
============================================================ */


/* 1️⃣ Basic Dataset Overview */

-- Total customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Total products
SELECT COUNT(*) AS total_products
FROM products;

-- Total orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Total order items
SELECT COUNT(*) AS total_order_items
FROM order_items;

-- Total deliveries
SELECT COUNT(*) AS total_deliveries
FROM delivery;

-- Total feedback entries
SELECT COUNT(*) AS total_feedback_entries
FROM feedback;



/* 2️⃣ Revenue Analysis */

-- Total revenue generated
SELECT SUM(order_total) AS total_revenue
FROM orders;

-- Average order value
SELECT AVG(order_total) AS avg_order_value
FROM orders;

-- Top 10 customers by spending
SELECT 
    customer_id,
    SUM(order_total) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;



/* 3️⃣ Customer Order Frequency Distribution */

SELECT 
    order_count,
    COUNT(*) AS number_of_customers
FROM (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) sub
GROUP BY order_count
ORDER BY order_count;



/* 4️⃣ Monthly Revenue & Order Trend */

SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(order_total) AS monthly_revenue,
    COUNT(order_id) AS monthly_orders
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;



/* 5️⃣ Product Category Performance */

SELECT 
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
JOIN products p 
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;



/* 6️⃣ Top Selling Products */

SELECT 
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p 
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 10;



/* 7️⃣ Delivery Performance Analysis */

-- Delivery status breakdown
SELECT 
    delivery_status,
    COUNT(*) AS count
FROM delivery
GROUP BY delivery_status
ORDER BY count DESC;

-- Delay reason analysis (excluding on-time deliveries)
SELECT 
    reasons_if_delayed,
    COUNT(*) AS delay_count
FROM delivery
WHERE delivery_status <> 'On Time'
GROUP BY reasons_if_delayed
ORDER BY delay_count DESC;

-- Average distance for delayed orders
SELECT 
    AVG(distance_km) AS avg_distance_delayed
FROM delivery
WHERE delivery_status <> 'On Time';

-- Average distance for on-time deliveries
SELECT 
    AVG(distance_km) AS avg_distance_on_time
FROM delivery
WHERE delivery_status = 'On Time';



/* 8️⃣ Customer Feedback Sentiment Analysis */

-- Sentiment distribution
SELECT 
    sentiment,
    COUNT(*) AS count
FROM feedback
GROUP BY sentiment
ORDER BY count DESC;

-- Sentiment vs Delivery Status
SELECT 
    d.delivery_status,
    f.sentiment,
    COUNT(*) AS count
FROM feedback f
JOIN delivery d 
    ON f.order_id = d.order_id
GROUP BY d.delivery_status, f.sentiment
ORDER BY d.delivery_status;



/* 9️⃣ Delayed Orders by Customer Segment */

WITH customer_spend AS (
    SELECT 
        customer_id,
        SUM(order_total) AS total_spent
    FROM orders
    GROUP BY customer_id
),

customer_segments AS (
    SELECT 
        customer_id,
        CASE
            WHEN total_spent >= 8000 THEN 'High Value'
            WHEN total_spent BETWEEN 4000 AND 7999 THEN 'Mid Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_spend
)

SELECT 
    cs.customer_segment,
    COUNT(*) AS delayed_orders
FROM customer_segments cs
JOIN orders o 
    ON cs.customer_id = o.customer_id
JOIN delivery d 
    ON o.order_id = d.order_id
WHERE d.delivery_status <> 'On Time'
GROUP BY cs.customer_segment
ORDER BY delayed_orders DESC;

