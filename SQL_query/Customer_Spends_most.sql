--CUSTOMER unique id that speds most

SELECT cd.customer_unique_id, 
       SUM(op.payment_value) AS total_spend
FROM customers_dataset as cd
JOIN orders_dataset as od 
    ON cd.customer_id = od.customer_id
JOIN order_payments_dataset as op 
    ON od.order_id = op.order_id
GROUP BY cd.customer_unique_id
HAVING SUM(op.payment_value) > (
    SELECT AVG(total_spend)
    FROM (
        SELECT c2.customer_unique_id,
               SUM(p2.payment_value) AS total_spend
        FROM customers_dataset as c2
        JOIN orders_dataset as o2 
            ON c2.customer_id = o2.customer_id
        JOIN order_payments_dataset p2 
            ON o2.order_id = p2.order_id
        GROUP BY c2.customer_unique_id
    ) sub
)ORDER BY total_spend DESC
LIMIT 20;
