/* Calculates average delivery transit times and late delivery percentages aggregated by customer state to identify regional performance baselines. */
SELECT  ROUND(AVG(EXTRACT(EPOCH FROM o.order_delivered_customer_date) - EXTRACT(EPOCH FROM o.order_purchase_timestamp)) / 86400, 2) AS avg_delivery_time,
 c.customer_state, ROUND(AVG(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1.0
 ELSE 0.0 END) * 100, 2) AS pct_late
FROM customers c
JOIN orders o
 ON c.customer_id = o.customer_id 
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
 