/* Segments delivery speeds into distinct temporal tiers (Early, 1-3 Days Late, 4+ Days Late) to quantify the precise impact of delivery latency on customer review scores. */
SELECT 
CASE 
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN
        CASE 
            WHEN ((EXTRACT(EPOCH FROM o.order_delivered_customer_date) - EXTRACT(EPOCH FROM o.order_estimated_delivery_date)) / 86400) > 3 THEN '4+ Days Late'
            ELSE '1-3 Days Late'
        END
ELSE  'Early'
END AS delivery_speed, ROUND(AVG(order_reviews.review_score), 2) AS avg_review_score
FROM orders o
JOIN order_reviews ON order_reviews.order_id = o.order_id
GROUP BY delivery_speed

