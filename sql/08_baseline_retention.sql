/* Calculates the baseline repeat purchase rate across the platform to establish a control metric for retention comparisons. */
WITH customer_cte AS(
    SELECT c.customer_unique_id, COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)
SELECT ROUND(AVG(CASE
                WHEN order_count > 1 THEN 1.0
                ELSE 0.0
            END) * 100, 2) AS pct_unique_more_order
FROM customer_cte