-- https://www.mysqltutorial.org/tryit/
-- AGGREGATES
-- find the average credit limit among customers
SELECT AVG(creditLimit) FROM customers;

-- count how many rows are there in the customers table
-- i.e. how many customers there are
SELECT count(*) FROM customers;

-- max and min
SELECT min(creditLimit) FROM customers
    WHERE creditLimit > 0;

-- select by date
SELECT * FROM payments where paymentDate > "2004-04-01"
SELECT * FROM payments where paymentDate >= "2004-04-01" AND paymentDate <= "2005-05-01";

-- extract out the day, month and year component of a date
SELECT YEAR(paymentDate), MONTH(paymentDate), DAY(paymentDate), amount FROM payments;

-- find the total amount paid out in the month of June across all yeears
SELECT sum(amount) from payments where month(paymentDate) = 6;

-- GROUP BY and AGGREGATES
-- CAN ONLY SELECT WHAT WE GROUP BY
SELECT officeCode, count(*) FROM employees  
    GROUP BY officeCode

-- show how many customers there are per country
SELECT country, count(*) FROM customers
    GROUP BY country

-- show the average credit limit per country
SELECT country, avg(creditLimit) FROM customers GROUP BY country

-- show the average credit limit and number of customers per country
SELECT country, avg(creditLimit), count(*) FROM customers GROUP BY country

-- ORDER OF OPERATION
-- FROM JOIN > WHERE > GROUP BY > SELECT > HAVING > ORDER BY > LIMIT

-- JOIN happens before GROUP BY, this means that GROUP BY affects the joined table
-- WHERE happens after JOIN but before GROUP BY 
-- HAVING is tagged to GROUP BY to filter the GROUP BY table

SELECT employees.officeCode, addressLine1, addressLine2, count(*) as "EmployeeCount"
    FROM employees JOIN offices
    ON employees.officeCode = offices.officeCode
    WHERE country="USA"
    GROUP BY officeCode, addressLine1, addressLine2
    HAVING EmployeeCount > 4

SELECT COUNT(*), products.productCode, productName, productLine 
    FROM orderdetails JOIN products
    ON products.productCode = orderdetails.productCode
    WHERE productLine LIKE "classic cars"
    GROUP BY productCode, productName
    HAVING COUNT(*) >= 28
    ORDER BY COUNT(*) DESC
    LIMIT 10