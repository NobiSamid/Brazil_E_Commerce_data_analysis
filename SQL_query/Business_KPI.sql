-- E-commerce sales trend analysis or business KPI

SELECT strftime('%Y-%m', order_purchase_timestamp) AS month,
       SUM(payment_value) AS revenue,
       LAG(SUM(payment_value)) OVER (ORDER BY strftime('%Y-%m', order_purchase_timestamp)) AS prev_revenue,
       ROUND(
         (SUM(payment_value) - LAG(SUM(payment_value)) OVER (ORDER BY strftime('%Y-%m', order_purchase_timestamp))) 
         / LAG(SUM(payment_value)) OVER (ORDER BY strftime('%Y-%m', order_purchase_timestamp)) * 100, 2
       ) AS mom_growth
FROM orders_dataset as o
JOIN order_payments_dataset as p USING(order_id)
GROUP BY month
ORDER BY month;