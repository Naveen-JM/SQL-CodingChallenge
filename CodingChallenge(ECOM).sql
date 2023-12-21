Create Database ECommerce;
Use ECommerce;
-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    FirstName VARCHAR(255),
	LastName Varchar(255),
    email VARCHAR(255),
    address VARCHAR(255)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(255),
	description TEXT,
    price DECIMAL(10, 2),
    stockQuantity INT
);

-- Cart Table
CREATE TABLE cart (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order_Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
	Total_amount DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO products (product_id, name, description, price, stockQuantity)
VALUES
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

-- Inserting sample data into the customers table

INSERT INTO customers (customer_id, FirstName,LastName, email, address)
VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '123 Main St, City'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
(3, 'Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
(5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District'),
(6, 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
(7, 'Michael',' Davis', 'michael@example.com', '890 Maple St '),
(8, 'Emma',' Wilson', 'emma@example.com', '321 Redwood St, Country'),
(9, 'William',' Taylor', 'william@example.com', '432 Spruce St, Province'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory');

-- Inserting sample data into the orders table

INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES
(1, 1, '2023-01-05', 1200.00 ),
(2, 2, '2023-02-10', 900.00),
(3, 3, '2023-03-15', 300.00),
(4, 4, '2023-04-20', 150.00),
(5, 5, '2023-05-25', 1800.00),
(6, 6, '2023-06-30', 400.00),
(7, 7, '2023-07-05', 700.00),
(8, 8, '2023-08-10', 160.00),
(9, 9, '2023-09-15', 140.00),
(10, 10, '2023-10-20', 1400.00);

-- Inserting sample data into the order_items table

INSERT INTO order_items (order_item_id, order_id, product_id, quantity)
VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 5, 2),
(5, 4, 4, 4),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 5, 2, 2),
(9, 6, 10, 2),
(10, 6, 9, 3);

INSERT INTO cart (cart_id, customer_id, product_id, quantity)
VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);

--Q1)
UPDATE products
SET price = 800
WHERE product_id = 7;

--Q2)
DELETE FROM cart
WHERE customer_id = 1;

--Q3)
SELECT *
FROM products
WHERE price < 100;

--Q4)
SELECT *
FROM products
WHERE stockQuantity > 5;

--Q5)
SELECT *
FROM orders
WHERE total_amount BETWEEN 500 AND 1000;

--Q6)
SELECT *
FROM products
WHERE name LIKE '%r';

--Q7)
SELECT *
FROM cart
WHERE customer_id = 5;

--Q8)
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023;

--Q9)
SELECT category, MIN(stockQuantity) AS min_stock
FROM products
GROUP BY category;

--Q10)
SELECT c.customer_id, c.FirstName, SUM(o.total_amount) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.FirstName;

--Q11)
SELECT
    c.customer_id,
    c.FirstName AS customer_name,
    AVG(o.total_amount) AS average_order_amount
FROM
    customers c
JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.FirstName;

	--Q12)
-- Count the number of orders placed by each customer
SELECT
c.customer_id,
c.FirstName AS customer_name,
COUNT(o.order_id) AS order_count
FROM
customers c
JOIN
orders o ON c.customer_id = o.customer_id
GROUP BY
c.customer_id, c.FirstName;

--Q13)
SELECT
    c.customer_id,
    c.FirstName AS customer_name,
    MAX(o.total_amount) AS max_order_amount
FROM
    customers c
JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.FirstName;

--Q14)
SELECT
    c.customer_id,
    c.FirstName AS customer_name
FROM
    customers c
JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.FirstName
HAVING
    SUM(o.total_amount) > 1000;

	--Q15)
SELECT *FROM products
WHERE product_id NOT IN (SELECT product_id FROM cart);
   --Q16)
SELECT *FROM customers
WHERE customer_id NOT IN (
SELECT customer_id
FROM orders
);
  --Q17)

 --Q18)
 SELECT *FROM products
WHERE stockQuantity <= 5;

--Q19)
SELECT *FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders WHERE total_amount > 1000);
