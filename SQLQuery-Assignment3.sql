CREATE DATABASE Assignment3

USE Assignment3

CREATE TABLE department (
  dept_id int PRIMARY KEY IDENTITY(1,1),
  dept_name varchar(10) NOT NULL
)

CREATE TABLE employee (
  emp_id int PRIMARY KEY IDENTITY(1,1),
  dept_id int,
  mngr_id int NOT NULL,
  emp_name varchar(10) NOT NULL,
  salary decimal(8,2) NOT NULL,
  FOREIGN KEY(dept_id) REFERENCES department(dept_id)
)

INSERT INTO department (dept_name) VALUES
('Sale'),
('Market'),
('Bank'),
('HR'),
('Developer'),
('Management'),
('Business'),
('Hospital'),
('Production');


INSERT INTO employee (dept_id, mngr_id, emp_name,salary) VALUES
(1, 21, 'Mahesh', 31000),
(1, 22, 'Ramesh', 34000),
(1, 23, 'Paresh', 38000),
(1, 24, 'Jayesh', 39000),
(1, 25, 'Vihesh', 37000),
(1, 26, 'Karan', 30000),
(2, 27, 'Raj', 33000),
(2, 28, 'Rajan', 39000),
(2, 29, 'viren', 44000),
(2, 30, 'yash', 47000),
(2, 31, 'harsh', 49000),
(3, 32, 'Bhavan', 20000),
(3, 33, 'Bhavan', 27000),
(3, 34, 'Rimesh', 29000),
(3, 35, 'Kalpeesh', 28000),
(7, 36, 'Sahil', 50000),
(7, 37, 'Sohel', 52000),
(7, 38, 'Vansh', 54000),
(5, 39, 'Dhruv', 65000),
(5, 40, 'Dhruv', 65000),
(5, 41, 'Smith', 68000),
(5, 42, 'Chirag', 60000),
(5, 43, 'Parthiv', 61000),
(5, 44, 'Parth', 67000),
(4, 45, 'Haresh', 44000),
(4, 46, 'Harsh', 49000),
(6, 47, 'kirth', 31000),
(6, 48, 'kipt', 38000),
(6, 49, 'kir', 35000),
(6, 50, 'kinit', 36000),
(8, 51, 'vraj', 33000),
(8, 52, 'vnay', 39000);

/*1. write a SQL query to find Employees who have the biggest salary in their Department*/
SELECT dept_id,emp_name,salary 
FROM employee
where dept_id+''+salary 
IN(SELECT dept_id+''+max(salary)
FROM employee
GROUP BY dept_id)


/*2. write a SQL query to find Departments that have less than 3 people in it*/
SELECT dept_name, count(d.dept_id)
FROM department d
INNER JOIN employee e
on e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING count(d.dept_id)<3

/*3. write a SQL query to find All Department along with the number of people there*/
SELECT dept_name, count(d.dept_id)
FROM department d
INNER JOIN employee e
on e.dept_id = d.dept_id
GROUP BY d.dept_name

/*4. write a SQL query to find All Department along with the total salary there*/
SELECT dept_name, sum(salary)
FROM department d
INNER JOIN employee e
on e.dept_id = d.dept_id
GROUP BY d.dept_name

SELECT * FROM employee

SELECT * FROM department

select sysdatetimeoffset()
select GETUTCDATE()