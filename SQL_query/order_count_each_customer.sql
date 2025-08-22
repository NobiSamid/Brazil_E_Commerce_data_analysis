-- Order count for each unique customer

SELECT customer_unique_id, 
       GROUP_CONCAT(customer_id) AS customers,
       COUNT(*) AS total_count
FROM customers_dataset
GROUP BY customer_unique_id
ORDER BY total_count DESC;
