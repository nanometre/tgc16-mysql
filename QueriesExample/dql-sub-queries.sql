-- https://www.mysqltutorial.org/tryit/
-- SUB QUERIES
-- ex:1 find all customers whose credit LIMIT above the average
SELECT * FROM customers WHERE creditLimit > (SELECT avg(creditLimit) FROM customers);

-- ex:2 find all products that have NOT been ordered before
SELECT * FROM products WHERE productCode NOT IN (SELECT DISTINCT(productCode) FROM orderdetails)

-- ex:3 use a subquery to find all customers with no sales rep employee number
SELECT * FROM customers WHERE customerNumber NOT IN (
SELECT customerNumber FROM customers WHERE salesRepEmployeeNumber IS NOT NULL);

-- ex:4 
SELECT employees.employeeNumber, employees.firstName, employees.lastName, SUM(amount) FROM employees JOIN customers
    ON employees.employeeNumber = customers.salesRepEmployeeNumber
    JOIN payments
    ON customers.customerNumber = payments.customerNumber
    GROUP BY employees.employeeNumber, employees.firstName, employees.lastName
    HAVING sum(amount) > (SELECT sum(amount) * 0.1 FROM payments);

-- BONUS: find the best selling product for each year AND month:
    SELECT year(orderDate) AS orderYear, month(orderDate) AS orderMonth, productCode, sum(quantityOrdered) FROM orderdetails 
    JOIN orders ON orderdetails.orderNumber = orders.orderNumber
    GROUP BY productCode, month(orderDate), year(orderDate)
    HAVING productCode = ( SELECT productCode FROM orderdetails 
    JOIN orders ON orderdetails.orderNumber = orders.orderNumber
    WHERE year(orderDate)=orderYear AND month(orderDate)=orderMonth
    GROUP BY productCode
    ORDER BY sum(quantityOrdered) DESC
    LIMIT 1
    )
    ORDER BY year(orderDate), month(orderDate);

-- show all products, and for each product,
-- display the total quantity ordered and
-- and the customer whom ordered the most of that product
SELECT * from
(
  select productCode, sum(quantityOrdered) from orderdetails
	group by productCode
) as t1
JOIN
(
  select productCode as outerProductCode, customerNumber
from orders join orderdetails
 on orders.orderNumber = orderdetails.orderNumber
group by productCode, customerNumber
having (productCode, customerNumber) = (
  
SELECT productCode, customerNumber FROM orders JOIN orderdetails
 on orders.orderNumber = orderdetails.orderNumber
 where productCode=outerProductCode
 group by customerNumber, productCode
 order by sum(quantityOrdered) DESC
 limit 1
 ) 
)
 as t2
 on t1.productCode = t2.outerProductCode

