/* 1.write a SQL query to find the salesperson and customer who reside in the same city.
Return Salesman, cust_name and city*/
SELECT s.name,cust_name,s.city
FROM salesman s
INNER JOIN customer c 
ON c.city = s.city

/*2. write a SQL query to find those orders where the order amount exists between 500
and 2000. Return ord_no, purch_amt, cust_name, city*/
SELECT ord_no, purch_amt, cust_name, city
FROM customer
INNER JOIN orders 
ON orders.customer_id = customer.customer_id 
WHERE purch_amt BETWEEN 500 AND 2000

/*3. write a SQL query to find the salesperson(s) and the customer(s) he represents.
Return Customer Name, city, Salesman, commission*/
SELECT cust_name, s.city, s.name, commission
FROM salesman s
INNER JOIN customer c
ON c.salesman_id = s.salesman_id


/*4. write a SQL query to find salespeople who received commissions of more than 12
percent from the company. Return Customer Name, customer city, Salesman,
commission.*/
SELECT cust_name, c.city, s.name, s.commission
FROM customer c
INNER JOIN salesman s
ON c.salesman_id = s.salesman_id
where s.commission>.12

/*5. write a SQL query to locate those salespeople who do not live in the same city where
their customers live and have received a commission of more than 12% from the
company. Return Customer Name, customer city, Salesman, salesman city,
commission*/
SELECT cust_name,c.city'customer_city', s.name,s.city 'salesman_city', s.commission
FROM customer c  
INNER JOIN salesman s  
ON s.salesman_id=c.salesman_id 
WHERE s.commission>.12 
AND c.city<>s.city;

/*6. write a SQL query to find the details of an order. Return ord_no, ord_date,
purch_amt, Customer Name, grade, Salesman, commission*/
SELECT ord_no,ord_date, purch_amt, c.cust_name, c.grade, s.name, s.commission
FROM customer c  
INNER JOIN salesman s  
ON c.salesman_id=s.salesman_id 
INNER JOIN orders o 
ON c.customer_id=o.customer_id 

/*7. Write a SQL statement to join the tables salesman, customer and orders so that the
same column of each table appears once and only the relational rows are returned.*/
SELECT c.customer_id,s.salesman_id,ord_no, purch_amt, ord_date, c.cust_name, c.city "CCity", c.grade, s.city as "SCity",commission
FROM orders o
INNER JOIN customer c
ON c.customer_id = o.customer_id
INNER JOIN salesman s
ON s.salesman_id = c.salesman_id

/*8. write a SQL query to display the customer name, customer city, grade, salesman,
salesman city. The results should be sorted by ascending customer_id.*/
SELECT s.salesman_id,c.salesman_id,c.customer_id,c.cust_name, c.city "customer-city", c.grade, s.name "Salesman", s.city "salesman-city"
FROM customer c
LEFT JOIN salesman s
ON c.salesman_id = s.salesman_id
ORDER BY c.customer_id

/*9. write a SQL query to find those customers with a grade less than 300. Return
cust_name, customer city, grade, Salesman, salesmancity. The result should be
ordered by ascending customer_id.*/
SELECT cust_name, c.city "customer-city", grade, s.name "Salesman", s.city "salesman-city"
FROM customer c
INNER JOIN salesman s
ON s.salesman_id = c.salesman_id
where c.grade<300
order by c.customer_id

/*10. Write a SQL statement to make a report with customer name, city, order number,
order date, and order amount in ascending order according to the order date to
determine whether any of the existing customers have placed an order or not*/
SELECT cust_name, c.city, ord_no, o.ord_date, purch_amt 
FROM customer c
INNER JOIN orders o
ON o.customer_id = c.customer_id
ORDER BY o.ord_date

/*11. Write a SQL statement to generate a report with customer name, city, order number,
order date, order amount, salesperson name, and commission to determine if any of
the existing customers have not placed orders or if they have placed orders through
their salesman or by themselves*/
SELECT c.cust_name,c.city, o.ord_no,
o.ord_date,o.purch_amt, 
s.name,s.commission 
FROM customer c 
LEFT JOIN orders o
ON c.customer_id=o.customer_id 
LEFT OUTER JOIN salesman s 
ON s.salesman_id=o.salesman_id;

/*12. Write a SQL statement to generate a list in ascending order of salespersons who
work either for one or more customers or have not yet joined any of the customers*/
SELECT distinct s.name "sales person"
FROM salesman s 
LEFT JOIN customer c
on c.salesman_id = s.salesman_id
ORDER BY s.name

/*13. write a SQL query to list all salespersons along with customer name, city, grade,
order number, date, and amount.*/
SELECT s.name "salesperson", c.cust_name, c.city, c.grade, o.ord_no, o.ord_date,o.purch_amt
FROM salesman s
LEFT JOIN customer c
ON c.salesman_id = s.salesman_id
INNER JOIN orders o
ON o.customer_id = c.customer_id

/*14. Write a SQL statement to make a list for the salesmen who either work for one or
more customers or yet to join any of the customers. The customer may have placed,
either one or more orders on or above order amount 2000 and must have a grade, or
he may not have placed any order to the associated supplier.*/
SELECT c.cust_name,c.city,c.grade, 
s.name AS "Salesman", 
o.ord_no, o.ord_date, o.purch_amt 
FROM salesman s 
LEFT JOIN customer c
ON c.salesman_id=s.salesman_id 
LEFT JOIN orders o 
ON o.customer_id=c.customer_id 
WHERE o.purch_amt>=2000 
AND c.grade IS NOT NULL;

/*16. Write a SQL statement to generate a report with the customer name, city, order no.
order date, purchase amount for only those customers on the list who must have a
grade and placed one or more orders or which order(s) have been placed by the
customer who neither is on the list nor has a grade.*/
SELECT * 
FROM customer c
INNER JOIN orders o
ON o.customer_id = c.customer_id
where c.grade IS NOT NULL

/*17. Write a SQL query to combine each row of the salesman table with each row of the
customer table*/
SELECT *
FROM salesman
CROSS JOIN customer

/*18. Write a SQL statement to create a Cartesian product between salesperson and
customer, i.e. each salesperson will appear for all customers and vice versa for that
salesperson who belongs to that city*/
SELECT *
FROM salesman s
CROSS JOIN customer c
where s.city = c.city

/*19. Write a SQL statement to create a Cartesian product between salesperson and
customer, i.e. each salesperson will appear for every customer and vice versa for
those salesmen who belong to a city and customers who require a grade*/
SELECT *
FROM salesman s
CROSS JOIN customer c
where s.city IS NOT NULL
AND c.grade IS NOT NULL

/*20. Write a SQL statement to make a Cartesian product between salesman and
customer i.e. each salesman will appear for all customers and vice versa for those
salesmen who must belong to a city which is not the same as his customer and the
customers should have their own grade*/
SELECT *
FROM salesman s
CROSS JOIN customer c
where s.city IS NOT NULL
AND c.grade IS NOT NULL
AND s.city <> c.city

SELECT * FROM salesman
SELECT * FROM customer
SELECT * FROM orders