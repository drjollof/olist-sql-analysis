/* Calculates the average time elapsed between a customer's first and second purchase, segmented by whether the initial delivery was completed on time or delayed. */
WITH window_cte AS(
    SELECT ROW_NUMBER() OVER(PARTITION BY c.customer_unique_id ORDER BY o.order_purchase_timestamp ASC) AS order_sequence,
    COUNT(o.order_id) OVER(PARTITION BY c.customer_unique_id) AS total_orders,
    c.customer_unique_id, o.order_delivered_customer_date, o.order_estimated_delivery_date, o.order_purchase_timestamp
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
)

SELECT 
CASE 
    WHEN first_order.order_delivered_customer_date > first_order.order_estimated_delivery_date THEN 'Late First Order'
    ELSE 'On-Time First Order' 
END  AS delivery_category,
ROUND(AVG(EXTRACT(EPOCH FROM second_order.order_purchase_timestamp) - EXTRACT(EPOCH FROM first_order.order_purchase_timestamp)) / 86400, 2) AS avg_days_to_repeat

FROM window_cte AS first_order
JOIN window_cte AS second_order 
  ON first_order.customer_unique_id = second_order.customer_unique_id 
  AND first_order.order_sequence = 1 
  AND second_order.order_sequence = 2
GROUP BY delivery_category