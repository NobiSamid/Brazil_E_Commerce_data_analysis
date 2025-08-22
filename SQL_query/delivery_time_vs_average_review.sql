--ORDER average delevary time vs average review

SELECT cd.customer_city, ce.product_category_name_english,
       ROUND(AVG(ord.review_score),2) AS avg_review,
	   ROUND(AVG(od.order_delivered_customer_date - od.order_estimated_delivery_date), 2) AS avg_delay
FROM orders_dataset as od
JOIN order_items_dataset as oi ON od.order_id = oi.order_id
JOIN products_dataset as pd ON pd.product_id = oi.product_id
JOIN product_category_name_translation as ce ON pd.product_category_name = ce.product_category_name
JOIN customers_dataset as cd USING(customer_id)
JOIN order_reviews_dataset as ord USING(order_id)
WHERE od.order_status = 'delivered'
GROUP BY cd.customer_city
ORDER BY avg_review DESC, avg_delay DESC;
