/***************************/
-- Before running these queries, make sure to download related DB 
/**************************/

USE sql_store;

-- JOIN order_items and products tables
SELECT 
	order_id,
    oi.product_id,
    quantity,
    oi.unit_price
FROM order_items oi
JOIN products p 
ON oi.product_id = p.product_id;

USE sql_hr;

-- Return employee and their manager
SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
JOIN employees m
ON e.reports_to = m.employee_id;

-- Create a query that returns the client, payment information, and payment method
-- JOINing multiple tables
USE sql_invoicing;

SELECT 
	c.name,
    p.date,
    p.invoice_id,
    p.amount,
    pm.name
FROM clients c
JOIN payments p
	ON c.client_id = p.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;
    
-- JOIN products table with order_items table
-- How many times is each product ordered
-- use an outer join to include all products whether they have been ordered or not
USE sql_store;

SELECT 
	p.product_id,
    p.name,
    oi.quantity
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id;
    
-- Write a query that produces the following
-- order_date, order_id, first_name, shipper, status
-- using outer joins across multiple tables
USE sql_store;

SELECT 
	o.order_id,
    o.order_date,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
-- Simplify code USING keyword
-- Return the payment date, client, amount and payment method
USE sql_invoicing;

SELECT 
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;

-- Using cross join, return all of the products and shippers
USE sql_store;

SELECT 
	p.name AS product,
    sh.name AS shipper
FROM products p
CROSS JOIN shippers sh
ORDER BY shipper;

-- Write a UNION query that combines multiple select statements
-- Based on points, what group does each customers fit in?
-- < 2000 - bronze
-- 2000 - 3000 - silver
-- > 3000 - gold
USE sql_store;

SELECT 
	customer_id,
    first_name,
    points,
    'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    'Gold' AS type
FROM customers
WHERE points > 3000
ORDER BY first_name;
	


    


