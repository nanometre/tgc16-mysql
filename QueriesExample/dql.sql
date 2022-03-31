-- https://www.mysqltutorial.org/tryit/
-- select all columns
select * from employees;

-- display only certain columns
select firstName, lastName, email from employees;

-- select all job titles but remove duplicates
select distinct(jobTitle) from employees;

-- select columns and rename them at the same time
select firstName as "First Name",
  lastName as "Last Name",
  email as "Email" from employees;

-- use `where` to filter rows:
-- select all employees from officeCode 1
select * from employees where officeCode=1;

-- display the first name, last name and email from employees
-- working in officeCode 1
select firstName, lastName, email from employees where officeCode=1;

-- we can use `like` for string comparsion
select * from employees where jobTitle like "Sales Rep";

-- find all employees whose job title begins with "sales"
select * from employees where jobTitle like "Sales%";

-- find all employees whose job title end with "sales"
select * from employees where jobTitle like "%Sales";

-- find all employees whose job title has the sales anywhere
select * from employees where jobTitle like "%Sales%";

-- find all products whose name begins with 1969
SELECT * FROM products where productName like "1969%";

-- find all products whose name contains "Davidson" anywhere
SELECT * FROM products where productName LIKE "%Davidson%";

-- show all sales rep from office code = 1
SELECT * FROM employees where officeCode = 1 and jobTitle = "Sales Rep";

-- show all employees from office code 1 or 2
SELECT * FROM employees where officeCode = 1 or officeCode=2;

-- show all sales rep from office code 1 and 2
SELECT * FROM employees where (officeCode = 1 or officeCode=2) 
              and jobTitle="Sales Rep";

-- show all customers from USA in the state of NV who has
-- credit limit greater than 5000
SELECT * FROM customers where state="NV" 
      and country="USA" 
	  and creditLimit > 5000;

-- JOINS
-- display the first and last name of all employees along with their office address
select lastName, firstName, city, addressLine1, addressLine2 from employees JOIN offices
 ON employees.officeCode = offices.officeCode;

 -- display the first, last name, city, country and officecode
 -- NOTE: because there are two officeCode columns, we have to use the table
 -- name to specify which table to use
 SELECT firstName, lastName, city, country, employees.officeCode FROM
employees JOIN offices on employees.officeCode = offices.officeCode;

--- same as above, but only from USA and order by the first name in ASCENDING order
select firstName, lastName, city, country, employees.officeCode from employees JOIN offices
 ON employees.officeCode = offices.officeCode
 WHERE country="USA"
 ORDER BY firstName;

-- count how many customers have sales rep
-- due to inner join, for a row in the left hand table to appear in the joined table,
-- it must have a corresponding row in the right hand table
select count(*) from customers join employees 
	ON customers.salesRepEmployeeNumber = employees.employeeNumber
    
-- show all customers with their sales rep, even for customers with no sales rep
select * from customers left join employees 
	ON customers.salesRepEmployeeNumber = employees.employeeNumber;