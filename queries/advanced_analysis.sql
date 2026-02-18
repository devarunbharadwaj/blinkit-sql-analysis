/* ============================================================
   ADVANCED BUSINESS INSIGHTS
   Blinkit SQL Analysis – PostgreSQL
   Author: Devarun Bharadwaj
============================================================ */


/* ============================================================
   1️⃣ CUSTOMER SEGMENTATION (Based on Total Spend)
============================================================ */

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
        total_spent,
        CASE
            WHEN total_spent >= 8000 THEN 'High Value'
            WHEN total_spent BETWEEN 4000 AND 7999 THEN 'Mid Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_spend
)

SELECT 
    customer_segment,
    COUNT(*) AS customer_count
FROM customer_segments
GROUP BY customer_segment
ORDER BY customer_count DESC;



/* ============================================================
   2️⃣ MONTHLY REVENUE TREND
============================================================ */

SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(order_total) AS monthly_revenue,
    COUNT(order_id) AS monthly_orders
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;



/* ============================================================
   3️⃣ DELAYED ORDERS BREAKDOWN
============================================================ */

SELECT 
    reasons_if_delayed,
    COUNT(*) AS delay_count
FROM delivery
WHERE delivery_status <> 'On Time'
GROUP BY reasons_if_delayed
ORDER BY delay_count DESC;



/* ============================================================
   4️⃣ CATEGORY REVENUE ANALYSIS
============================================================ */

SELECT 
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
JOIN products p 
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;



/* ============================================================
   5️⃣ SENTIMENT vs DELIVERY STATUS
============================================================ */

SELECT 
    d.delivery_status,
    f.sentiment,
    COUNT(*) AS feedback_count
FROM feedback f
JOIN delivery d 
    ON f.order_id = d.order_id
GROUP BY d.delivery_status, f.sentiment
ORDER BY d.delivery_status, feedback_count DESC;
