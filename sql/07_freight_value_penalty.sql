/* Evaluates customer sensitivity to shipping costs by comparing review scores for delayed orders split by high versus low freight value tiers. */
WITH freight_cte AS (
    SELECT 
        o.order_id, 
        order_reviews.review_score,
        NTILE(2) OVER(ORDER BY order_items.freight_value DESC) as freight_tier
    FROM orders o
    JOIN order_items ON order_items.order_id = o.order_id
    JOIN order_reviews ON order_reviews.order_id = o.order_id
    WHERE o.order_delivered_customer_date > o.order_estimated_delivery_date
)
SELECT 
    CASE 
        WHEN freight_tier = 1 THEN 'High Freight' 
        ELSE 'Low Freight' 
    END AS freight_group, 
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM freight_cte
GROUP BY freight_tier;
