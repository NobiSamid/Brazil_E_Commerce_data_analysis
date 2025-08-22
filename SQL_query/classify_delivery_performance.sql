--Classify delivery performance.

SELECT order_id,
       CASE
         WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'On Time'
         WHEN order_delivered_customer_date IS NULL THEN 'Pending'
         ELSE 'Late'
       END AS delivery_status,
       CASE
         WHEN review_score >= 4 THEN 'Happy'
         WHEN review_score = 3 THEN 'Neutral'
         ELSE 'Unhappy'
       END AS customer_sentiment
FROM orders_dataset as od
LEFT JOIN order_reviews_dataset as ord USING(order_id)
ORDER BY delivery_status, customer_sentiment;
