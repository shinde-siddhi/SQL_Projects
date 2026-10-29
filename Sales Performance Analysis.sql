-- Step1: Create Database --
Create Database store_management;

-- Database Select
use store_management ;

-- Create Category Table
CREATE TABLE categories(
Category_id INT PRIMARY KEY,
Category_name VARCHAR(50)
);

INSERT INTO categories(Category_id,Category_name) 
VALUES
(1, 'Electronics'),
(2, 'Fashion'),
(3, 'Home & Fashion'),
(4, 'Beauty'),
(5, 'Sports');

SELECT * FROM categories;

-- Customer Table --
CREATE TABLE Customer(
Customer_id INT PRIMARY KEY,
Customer_name VARCHAR(100),
Email VARCHAR(50),
City VARCHAR(50),
State VARCHAR(50),
Signup_Date DATE
);

INSERT INTO Customer(Customer_id,Customer_name,Email,City,State,Signup_Date)
VALUES 
(101, 'Rahul Sharma', 'rahul@gmail.com', 'Delhi', 'Delhi', '2024-01-15'),
(102, 'Priya Verma', 'priya@gmail.com', 'Mumbai', 'Maharashtra', '2024-02-10'),
(103, 'Amit Kumar', 'amit@gmail.com', 'Bangalore', 'Karnataka', '2024-03-05'),
(104, 'Sneha Singh', 'sneha@gmail.com', 'Pune', 'Maharashtra', '2024-03-18'),
(105, 'Rohit Gupta', 'rohit@gmail.com', 'Delhi', 'Delhi', '2024-04-01'),
(106, 'Neha Jain', 'neha@gmail.com', 'Jaipur', 'Rajasthan', '2024-04-22'),
(107, 'Vikas Yadav', 'vikas@gmail.com', 'Lucknow', 'Uttar Pradesh', '2024-05-12'),
(108, 'Anjali Mehta', 'anjali@gmail.com', 'Ahmedabad', 'Gujarat', '2024-06-08'),
(109, 'Karan Patel', 'karan@gmail.com', 'Surat', 'Gujarat', '2024-07-19'),
(110, 'Pooja Agarwal', 'pooja@gmail.com', 'Chandigarh', 'Chandigarh', '2024-08-25');

SELECT * FROM Customer;

-- Product Table
CREATE TABLE Product (
Product_id INT PRIMARY KEY,
Product_name VARCHAR(100),
Category_id INT,
Price DECIMAL(10,2),
Cost DECIMAL(10,2),
FOREIGN KEY (Category_id)
REFERENCES Categories(Category_id)
);

INSERT INTO product
(product_id, product_name, category_id, price, cost)
VALUES
(201, 'Laptop', 1, 65000, 52000),
(202, 'Smartphone', 1, 30000, 24000),
(203, 'Headphones', 1, 3000, 1800),
(204, 'T-Shirt', 2, 1200, 700),
(205, 'Jeans', 2, 2500, 1500),
(206, 'Mixer Grinder', 3, 4500, 3000),
(207, 'Cookware Set', 3, 3500, 2200),
(208, 'Face Cream', 4, 900, 500),
(209, 'Perfume', 4, 2500, 1400),
(210, 'Running Shoes', 5, 4000, 2500);

SELECT * FROM Product;

-- Create Order Table
CREATE TABLE Orders(
Order_id INT PRIMARY KEY,
Customer_id INT,
Order_date DATE,
Order_status VARCHAR(50),
FOREIGN KEY(Customer_id)
REFERENCES Customer(Customer_id)
);

INSERT INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(1001, 101, '2025-01-05', 'Completed'),
(1002, 102, '2025-01-08', 'Completed'),
(1003, 103, '2025-01-12', 'Completed'),
(1004, 101, '2025-01-20', 'Completed'),
(1005, 104, '2025-02-03', 'Completed'),
(1006, 105, '2025-02-10', 'Cancelled'),
(1007, 106, '2025-02-15', 'Completed'),
(1008, 102, '2025-02-21', 'Completed'),
(1009, 107, '2025-03-02', 'Completed'),
(1010, 108, '2025-03-10', 'Completed'),
(1011, 103, '2025-03-18', 'Completed'),
(1012, 109, '2025-03-25', 'Returned'),
(1013, 110, '2025-04-05', 'Completed'),
(1014, 101, '2025-04-12', 'Completed'),
(1015, 104, '2025-04-20', 'Completed');

SELECT * FROM Orders;

CREATE TABLE Order_items(
Order_items_id INT PRIMARY KEY,
Order_id INT,
Product_id INT,
Quantity INT,
Unit_price DECIMAL(10,2),

FOREIGN KEY (Product_id)
REFERENCES Product(Product_id),

FOREIGN KEY (Order_id)
REFERENCES Orders(Order_id)
);

INSERT INTO order_items
(order_items_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 201, 1, 65000),
(2, 1001, 203, 2, 3000),
(3, 1002, 202, 1, 30000),
(4, 1002, 204, 2, 1200),
(5, 1003, 205, 1, 2500),
(6, 1003, 210, 1, 4000),
(7, 1004, 203, 1, 3000),
(8, 1004, 204, 3, 1200),
(9, 1005, 206, 1, 4500),
(10, 1005, 207, 1, 3500),
(11, 1006, 201, 1, 65000),
(12, 1007, 208, 2, 900),
(13, 1007, 209, 1, 2500),
(14, 1008, 202, 1, 30000),
(15, 1008, 203, 1, 3000),
(16, 1009, 210, 2, 4000),
(17, 1010, 207, 1, 3500),
(18, 1011, 201, 1, 65000),
(19, 1011, 203, 1, 3000),
(20, 1012, 209, 2, 2500),
(21, 1013, 204, 2, 1200),
(22, 1013, 205, 1, 2500),
(23, 1014, 202, 1, 30000),
(24, 1014, 209, 1, 2500),
(25, 1015, 206, 1, 4500),
(26, 1015, 210, 1, 4000);

SELECT * FROM Order_items;

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(20),
    payment_status VARCHAR(20),
    amount DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


INSERT INTO payments
(payment_id, order_id, payment_date, payment_method, payment_status, amount)
VALUES
(501, 1001, '2025-01-05', 'UPI', 'Paid', 71000),
(502, 1002, '2025-01-08', 'Card', 'Paid', 32400),
(503, 1003, '2025-01-12', 'UPI', 'Paid', 6500),
(504, 1004, '2025-01-20', 'Card', 'Paid', 6600),
(505, 1005, '2025-02-03', 'COD', 'Paid', 8000),
(506, 1006, '2025-02-10', 'Card', 'Failed', 65000),
(507, 1007, '2025-02-15', 'UPI', 'Paid', 4300),
(508, 1008, '2025-02-21', 'Card', 'Paid', 33000),
(509, 1009, '2025-03-02', 'UPI', 'Paid', 8000),
(510, 1010, '2025-03-10', 'COD', 'Paid', 3500),
(511, 1011, '2025-03-18', 'Card', 'Paid', 68000),
(512, 1012, '2025-03-25', 'UPI', 'Refunded', 5000),
(513, 1013, '2025-04-05', 'UPI', 'Paid', 4900),
(514, 1014, '2025-04-12', 'Card', 'Paid', 32500),
(515, 1015, '2025-04-20', 'COD', 'Paid', 8500);

-- Show company all customer
SELECT * FROM CUSTOMER;

-- Show customer name,city,state
SELECT Customer_name,City,state 
FROM Customer;

-- show customer in which cities
SELECT DISTINCT city 
FROM Customer;

-- Show delhi customers
SELECT * FROM Customer 
WHERE City='Delhi';

-- show the product that price is more than ₹10,000
SELECT * FROM Product 
WHERE price>=10000;

-- show the product that category=electronic price is greater that 20000
SELECT * FROM Product 
WHERE Category_id=1 AND price>2000;

-- Show customer of delhi or mumbai
SELECT * FROM Customer 
WHERE City='Delhi' OR City='Mumbai';

-- Same use for In Operator
SELECT * FROM Customer 
WHERE City In('Delhi','Mumbai');

-- Show the product where price is between 2,0000 to 10,0000;
SELECT Product_name,Price 
FROM Product WHERE Price BETWEEN 2000 AND 10000;

-- Show the customer whose name starts with R;
SELECT Customer_name FROM Customer 
WHERE Customer_name LIKE 'R%';

-- Find the customer whose email is not available;
SELECT * FROM Customer 
WHERE Email is Null;

-- Show the product from Highest Price to lowest Price
SELECT *  FROM Product 
ORDER BY Price desc;

-- Top 5 Expensive Product
SELECT * FROM Product 
ORDER BY Price DESC LIMIT 5;

-- Show Delhi Customer who SignUp 2024;
SELECT * FROM Customer 
WHERE city='Delhi' AND Signup_date 
between '2024-01-01' and '2024-12-31';

-- Complete order from latest order to oldest order 
SELECT * FROM Orders WHERE 
Order_status='Completed' 
ORDER BY Order_date desc;

-- How many are the total customers
SELECT Count(*) AS Total_Customer FROM Customer;

-- Disply the sum with completed order
SELECT Sum(oi.Quantity* oi.Unit_price) 
FROM Orders as o JOIN Order_items as oi on o.Order_id=oi.Order_id   
WHERE Order_status='Completed';

-- Average price of product
SELECT AVG(price) AS Average_Price 
FROM product;

-- Display the cheap product price
SELECT Min(Price) AS Cheap_Product 
FROM Product;

-- Count the Product Category wise
SELECT Category_id, COUNT(*) AS Total_Products FROM Product GROUP BY Category_id;

-- Calculate Category wise total product
SELECT Category_id, sum(price) 
AS Total_Products_value 
FROM Product GROUP BY Category_id;

-- Calculate Category wise product count with category_name
SELECT C.Category_name, COUNT(p.Product_id) As Total_products 
FROM Categories as C Join Product as p  on c.category_id=p.category_id 
GROUP BY C.Category_name;

-- Every customer how much place the orders
SELECT Customer_id, count(*) as Total_orders FROM Orders GROUP BY Customer_id;

-- Show customer with Order
SELECT c.Customer_id,
c.Customer_name,
o.order_id,
o.order_status
FROM Customer c
INNER JOIN Orders o 
ON C.customer_id=o.customer_id;

-- JOIN + WHERE
-- Display only customer whose order Completed
SELECT C.Customer_name,o.order_id,
o.Order_Status from Customer C
INNER JOIN Orders o
ON c.Customer_id= o. Customer_id 
WHERE o.order_status='completed';

-- LEFT JOIN
-- Which customer has not order any product yet
SELECT 
c.Customer_id,
c.Customer_name,
o.order_id
FROM customer c
LEFT JOIN Orders o
ON c.customer_id=o.customer_id;

-- RIGHT JOIN
SELECT 
c.Customer_name,
o.order_id
FROM customer c
RIGHT JOIN Orders o
ON c.customer_id=o.customer_id;

-- Findout the product who never sold
SELECT 
p.Product_id,
p.product_name
FROM product p
LEFT JOIN order_items oi
ON p.product_id=oi.product_id 
WHERE oi.product_id IS NULL;

-- CASE WHEN 
-- Business question: Classify the product based on the product price
SELECT 
  Product_name,
  price,
  CASE
      WHEN price < 2000 THEN 'Budget'
      WHEN price <= 10000 THEN 'Mid Range'
      ELSE 'Premium'
  END AS price_category
FROM product;

-- Business question: Calculate Expensive  Product from average price
SELECT Product_name,price from product 
where price > (select avg(price) from product);

-- Business question: Calculate Expensive Product
SELECT product_name,price from product 
WHERE price= (SELECT MAX(Price) from product);

-- Business question: Find out the product price above average
SELECT product_name,price
FROM product
WHERE price > (select avg(price) from product)
ORDER BY  price asc; 

-- Year() Function
SELECT 
  Order_id,
  Order_date,
  YEAR(order_date) as order_year
FROM orders;

-- MONTH() Fuction
SELECT 
  Order_id,
  Order_date,
  MONTH(order_date) as order_month
FROM orders;

-- Monthly Sales Analysis
SELECT 
   DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
   SUM(oi.quantity * oi.unit_price) AS Total_Sales
FROM orders o
JOIN order_items oi
   ON o.order_id=oi.order_id
WHERE o.order_status='Completed'
GROUP BY DATE_FORMAT(o.order_date,'%Y-%m')
ORDER  BY sales_month;

-- Specific Year Sales
SELECT 
  SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi
   ON o.order_id=oi.order_id
WHERE o.order_status='Completed'
 AND YEAR(o.order_date)=2025;
