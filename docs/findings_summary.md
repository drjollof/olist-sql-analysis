# Delivery Performance and Retention Impact

## Business Problem
Olist experiences inconsistencies in delivery performance across regions. This analysis identifies the worst-performing delivery routes, pinpoints bottleneck sources, and quantifies the impact of delays on review scores and repeat purchase rates.

## Approach
The 9-table schema was analyzed using SQL to track seller-side versus carrier-side delays, segment review scores by delivery speed, and track customer retention through cohort analysis based on initial delivery experience.

## Findings
*   **Problematic Routes:** The routes from Maranhão to São Paulo (`MA to SP`) and Rio de Janeiro to Ceará (`RJ to CE`) have the highest delay rates, with 24.41% and 23.73% of packages arriving late, respectively.
*   **Satisfaction Impact:** The bottom 10% of underperforming sellers average a review score of 3.63, compared to the platform average of 4.09.
*   **Root Bottleneck:** Timestamp analysis indicates logistics carriers are the primary bottleneck for delayed orders. For delayed packages originating from Rio de Janeiro (`RJ`), sellers average 4.8 days to dispatch, whereas carriers average 25.6 days for final delivery.
*   **Retention Damage:** Olist's baseline repeat purchase rate is 3.12%. Customers whose first order is delivered late show a lower retention rate of 2.57% (a ~19% relative drop) compared to 3.17% for those with on-time first deliveries.

## Recommendations
*   **Carrier Renegotiation:** Carrier delays significantly outweigh seller dispatch delays on the worst-performing routes. Olist should review SLAs with current logistics partners or evaluate alternative regional carriers for these specific routes.
*   **Adjust Estimated Delivery Dates:** Increase the estimated delivery dates presented at checkout for high-risk routes to set accurate expectations and mitigate the late delivery rate.
*   **Retention Incentives:** Implement targeted retention campaigns, such as automated discount codes, specifically for customers whose first order is delivered late, to address the drop in repeat purchase probability.
