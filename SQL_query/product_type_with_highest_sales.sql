--Product category that get ordered from highest to lowest

SELECT pc.product_category_name_english,
       ROUND(SUM(oi.price),2) AS total_sales,
       COUNT(DISTINCT od.order_id) AS order_count
FROM order_items_dataset as oi
JOIN products_dataset as pd USING(product_id)
JOIN orders_dataset as od USING(order_id)
JOIN product_category_name_translation as pc ON pc.product_category_name = pd.product_category_name
WHERE od.order_status = 'delivered'
GROUP BY pc.product_category_name_english
ORDER BY total_sales DESC
;
