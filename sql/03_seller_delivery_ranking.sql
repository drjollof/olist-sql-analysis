/* Ranks sellers by their late delivery rates to isolate underperforming vendors contributing to logistical delays. Filters for minimum order volumes to ensure statistical significance. */
WITH delay_cte AS
(
SELECT order_items.seller_id, ROUND(AVG(EXTRACT(EPOCH FROM o.order_delivered_customer_date) - EXTRACT(EPOCH FROM o.order_purchase_timestamp)) / 86400, 2) AS avg_delivery_time,
ROUND(AVG(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1.0
 ELSE 0.0 END) * 100, 2) AS pct_late
FROM orders o
JOIN order_items ON order_items.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY order_items.seller_id
HAVING COUNT(o.order_id) > 10
), ntile_cte AS (
SELECT * , NTILE(10) OVER(ORDER BY pct_late DESC) AS decile
FROM delay_cte
)

SELECT * FROM ntile_cte 
WHERE decile = 1

