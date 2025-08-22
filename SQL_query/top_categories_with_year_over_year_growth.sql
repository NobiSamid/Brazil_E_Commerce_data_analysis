---“Top categories with highest year-over-year growth.”

WITH sales_by_year AS (
  SELECT pct.product_category_name_english AS category,
         strftime('%Y', o.order_purchase_timestamp) AS year,
         SUM(oi.price) AS revenue
  FROM order_items_dataset oi
  JOIN products_dataset p USING(product_id)
  JOIN product_category_name_translation pct USING(product_category_name)
  JOIN orders_dataset o USING(order_id)
  WHERE o.order_status = 'delivered'
  GROUP BY pct.product_category_name_english, year
)
SELECT category,
       year,
       revenue,
       ROUND(
         (revenue - LAG(revenue) OVER(PARTITION BY category ORDER BY year)) 
         / LAG(revenue) OVER(PARTITION BY category ORDER BY year) * 100, 2
       ) AS yoy_growth
FROM sales_by_year
ORDER BY revenue DESC, category ASC, year DESC;
