--missing delivery dates
SELECT COUNT(*) AS missing_delivery
FROM orders_dataset
WHERE order_delivered_customer_date IS NULL;
