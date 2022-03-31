-- https://www.mysqltutorial.org/tryit/
-- 1 - Find all the offices and display only their city, phone and country
SELECT city, phone, country FROM offices;

-- 2 - Find all rows in the orders table that mentions FedEx in the comments.
SELECT * FROM orders WHERE comments LIKE '%fedex%';

-- 3 - Show the contact first name and contact last name of all customers in descending order by the customer's name
SELECT contactFirstName, contactLastName FROM customers ORDER BY contactFirstName DESC;

-- 4 - Find all sales rep who are in office code 1, 2 or 3 and their first name or last name contains the substring 'son'
SELECT * FROM employees 
	WHERE jobTitle="Sales Rep" 
	AND (officeCode="1" OR officeCode="2" OR officeCode="3")
	AND (firstName LIKE "%son%" OR lastName LIKE "%son%");

-- 4 alternate solution
SELECT * FROM employees
	WHERE officeCode(1,2,3)
	AND (firstName LIKE '%son%' OR lastName LIKE "%son%")
	AND jobTitle="Sales Rep";

-- 5 - Display all the orders bought by the customer with the customer number 124, along with the customer name, the contact's first name and contact's last name.
SELECT orders.*, customerName, contactFirstName, contactLastName FROM orders 
	JOIN customers ON orders.customerNumber = customers.customerNumber
	WHERE orders.customerNumber = "124";

-- 6 - Show the name of the product, together with the order details,  for each order line from the orderdetails table
SELECT orderdetails.* productName FROM orderdetails 
    JOIN products ON orderdetails.productCode = products.productCode;

-- **FOR Q5 & Q6**
-- WHEN JOINING TABLE, DO <SMALL TABLE> JOIN <LARGE TABLE>. THIS WAY IS MORE EFFICIENT

-- 7 - Display all the payments made by each company from the USA. 
SELECT customers.customerNumber, customerName, country, payments.* 
	FROM customers JOIN payments 
	ON customers.customerNumber = payments.customerNumber
	WHERE country = "USA"

-- 8 - Show how many employees are there for each state in the USA		
SELECT COUNT(*), state 
	FROM offices JOIN employees 
	ON offices.officeCode = employees.officeCode
	WHERE country = "USA"
	GROUP BY state

-- 9 - From the payments table, display the average amount spent by each customer. Display the name of the customer as well.
SELECT customerName, AVG(amount) 
	FROM customers JOIN payments
	ON customers.customerNumber = payments.customerNumber
	GROUP BY customers.customerNumber
	ORDER BY AVG(amount) DESC

-- 10 - From the payments table, display the average amount spent by each customer but only if the customer has spent a minimum of 10,000 dollars.
SELECT customerName, AVG(amount) 
	FROM customers JOIN payments
	ON customers.customerNumber = payments.customerNumber
	GROUP BY customers.customerNumber
	HAVING SUM(amount) >= 10000
	ORDER BY AVG(amount)

-- 11  - For each product, display how many times it was ordered, and display the results with the most orders first and only show the top ten.
SELECT products.productCode, productName, SUM(quantityOrdered)
	FROM products JOIN orderdetails
	ON products.productCode = orderdetails.productCode
	GROUP BY products.productCode
	ORDER BY SUM(quantityOrdered) DESC
	LIMIT 10

-- 12 - Display all orders made between Jan 2003 and Dec 2003
SELECT * 
	FROM orders
	WHERE orderDate >= "2003-01-01" AND orderDate <= "2003-12-31"

-- 12 ALTERNATE ANSWER
SELECT * 
	FROM orders 
	WHERE orderDate 
	BETWEEN "2003-01-01" AND "2003-12-31"


-- 13 - Display all the number of orders made, per month, between Jan 2003 and Dec 2003
SELECT MONTH(orderDate), COUNT(*) 
	FROM orders
	WHERE orderDate >= "2003-01-01" AND orderDate <= "2003-12-31"
	GROUP BY MONTH(orderDate)
-- 13A ALTERNATE ANSWER
SELECT MONTH(orderDate), COUNT(*) FROM orders JOIN orderdetails
 ON orders.orderNumber = orderdetails.orderNumber
 WHERE YEAR(orderDate) = 2003
 GROUP BY MONTH(orderDate)

-- Q13B ALTERNATE ANSWER
SELECT YEAR(orderDate), MONTH(orderDate), COUNT(*) FROM orders JOIN orderdetails
 ON orders.orderNumber = orderdetails.orderNumber
 WHERE YEAR(orderDate) >= 2003 AND YEAR(orderDate) <=2004
 GROUP BY YEAR(orderDate), MONTH(orderDate)
