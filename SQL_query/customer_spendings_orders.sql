--CUSTOMer analysis

WITH customer_orders AS (
  SELECT c.customer_unique_id,
         COUNT(o.order_id) AS total_orders,
         SUM(p.payment_value) AS total_spend
  FROM customers_dataset as c
  JOIN orders_dataset as o 
    ON c.customer_id = o.customer_id
  JOIN order_payments_dataset as p 
    ON o.order_id = p.order_id
  GROUP BY c.customer_unique_id
)
SELECT customer_unique_id,
       total_orders,
       total_spend,
       CASE
         WHEN total_orders = 1 THEN 'New'
         WHEN total_orders BETWEEN 2 AND 5 THEN 'Repeat'
         ELSE 'Loyal'
       END AS segment
FROM customer_orders
ORDER BY total_spend DESC;
