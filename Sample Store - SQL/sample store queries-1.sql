/***************************/
-- Before running these queries, make sure to download related DB 
/**************************/

USE sql_store;

-- Return all products from sql_store database
-- name, unit price, create a new column called 'new price' (unit price * 1.1)
SELECT 
	name, 
    unit_price,
    unit_price * 1.1 AS new_price
FROM products;

-- Get the orders placed in 2019 - COME BACK TO THIS OR DELETE
-- WHERE clause
SELECT *
FROM orders
WHERE order_date >= '2019-01-01';

-- From order_items table, get the items for 
-- order #6 where the total price is greater than 30
-- AND Operator
SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30;

-- Return products with
-- quantity in stock equal to 49, 38, 72
-- IN Operator
SELECT * 
FROM products 
WHERE quantity_in_stock IN (49, 38, 72);

-- Return customers born between 1/1/1990 and 1/1/2000 
-- BETWEEN clause
SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

-- Get the customers whose
-- address contain TRAIL or AVENUE
-- LIKE clause
SELECT * 
FROM customers
WHERE address LIKE '%trail%' OR address LIKE '%avenue%';
-- phone numbers do not end with 9
SELECT *
FROM customers
WHERE phone NOT LIKE '%9';

-- Use regexp to get the customers whose
-- first names are ELKA or AMBUR
SELECT *
FROM customers 
WHERE first_name REGEXP 'ELKA|AMBUR';
-- last name end with EY or ON
SELECT *
FROM customers
WHERE last_name REGEXP 'ey$|on$';
-- last names start with MY or contains SE
SELECT *
FROM customers 
WHERE last_name REGEXP '^my|se';
-- last names contain B followed by R or U
SELECT *
FROM customers 
WHERE last_name REGEXP 'b[r|u]';

-- Get the orders that are not shipped yet
SELECT *
FROM orders 
WHERE shipped_date IS NULL;

-- Select all orders with id = 2, sort by total price
SELECT 
	*,
    quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC

    