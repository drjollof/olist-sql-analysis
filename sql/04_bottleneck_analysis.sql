/* Isolates delivery delays by attributing processing time to either the seller (dispatch delay) or the carrier (transit delay) to identify the primary logistical bottleneck. */
SELECT s.seller_state, ROUND(AVG(EXTRACT(EPOCH FROM o.order_delivered_carrier_date) -  EXTRACT(EPOCH FROM o.order_purchase_timestamp)) / 86400, 2) AS seller_delay,
ROUND(AVG(EXTRACT(EPOCH FROM o.order_delivered_customer_date) - EXTRACT(EPOCH FROM o.order_delivered_carrier_date)) / 86400, 2) AS logistics_delay
FROM orders o
JOIN order_items ON order_items.order_id = o.order_id
JOIN sellers s ON s.seller_id = order_items.seller_id
WHERE o.order_status = 'delivered' AND o.order_delivered_customer_date > o.order_estimated_delivery_date
GROUP BY s.seller_state