/* Identifies critical failure paths in the logistics network by joining order, product, seller, customer, and review data to find geographic routes with high delay rates and poor review scores. */
SELECT s.seller_state || ' to ' || c.customer_state AS delivery_route ,
ROUND(AVG(order_reviews.review_score), 2) AS avg_review_score,
ROUND(AVG(CASE 
       WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1.0 
       ELSE 0.0 
    END) * 100, 2) AS pct_late
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items ON order_items.order_id = o.order_id
JOIN sellers s ON s.seller_id = order_items.seller_id
JOIN order_reviews ON order_reviews.order_id = o.order_id
GROUP BY s.seller_state, c.customer_state
HAVING COUNT(o.order_id) > 50
ORDER BY pct_late DESC