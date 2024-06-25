CREATE DATABASE WINAIM_DB;
CREATE SCHEMA ASSESSMENT;
USE WINAIM_DB;
USE ASSESSMENT;


-- Create the departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Create the employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id)SNIPPING REFERENCES departments(department_id)
);


-- Create the salaries table
CREATE TABLE salaries (
    employee_id INT,
    salary DECIMAL(10, 2),
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


-- INSERT DUMMY DATA TO THE ABOVE TABLES

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'Sales'),
(5, 'Finance');

INSERT INTO employees (employee_id, first_name, last_name, department_id, hire_date) VALUES
(1, 'John', 'Doe', 2, '2023-01-15'),
(2, 'Jane', 'Smith', 1, '2022-03-22'),
(3, 'Alice', 'Johnson', 3, '2021-07-11'),
(4, 'Bob', 'Brown', 4, '2020-11-30'),
(5, 'Charlie', 'Davis', 5, '2019-05-25');

INSERT INTO salaries (employee_id, salary, from_date, to_date) VALUES
(1, 75000.00, '2023-01-15', '2024-01-14'),
(2, 65000.00, '2022-03-22', '2023-03-21'),
(3, 70000.00, '2021-07-11', '2022-07-10'),
(4, 80000.00, '2020-11-30', '2021-11-29'),
(5, 90000.00, '2019-05-25', '2020-05-24');


-- 1. Query to Find All Employees Who Have Been Hired in the Last Year

SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE YEAR(hire_date) = YEAR(CURDATE()) - 1
  AND MONTH(hire_date) BETWEEN 1 AND 12;


-- 2. Query to Calculate the Total Salary Expenditure for Each Department

SELECT d.department_name, SUM(s.salary) AS total_salary_expenditure
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;


-- 3. Query to Find the Top 5 Highest-Paid Employees Along with Their Department Names

SELECT e.employee_id, e.first_name, e.last_name, d.department_name, s.salary
FROM employees e
JOIN (
    SELECT employee_id, MAX(salary) AS salary
    FROM salaries
    GROUP BY employee_id
) s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id
ORDER BY s.salary DESC
LIMIT 5;
