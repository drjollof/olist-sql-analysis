/* Measures the impact of initial delivery performance on long-term retention by calculating repeat purchase rates specifically segmented by the delivery status of a customer's first order. */
WITH window_cte AS(
    SELECT ROW_NUMBER() OVER(PARTITION BY c.customer_unique_id ORDER BY o.order_purchase_timestamp ASC) AS order_sequence,
    COUNT(o.order_id) OVER(PARTITION BY c.customer_unique_id) AS total_orders,
    o.order_delivered_customer_date, o.order_estimated_delivery_date
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
)

SELECT CASE 
                WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Late First Order'
                ELSE 'On-Time First Order' 
           END  AS delivery_category,
           
           ROUND(AVG(CASE
                 WHEN total_orders > 1 THEN 1.0 
                 ELSE 0.0 
           END) * 100 ,2) AS repeat_rate
           
FROM window_cte
WHERE order_sequence = 1
GROUP BY delivery_category