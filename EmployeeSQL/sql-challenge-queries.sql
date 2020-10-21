-- View the populated tables
select * from "Departments";

select * from "Dept_Emp";

select * from "Dept_Manager";

select * from "Employees";

select * from "Salaries";

select * from "Titles";

-- Homework 9 SQL-Challenge Queries
-- List the following details of each employee: emp_no, last_name, first_name, sex, and salary
-- Create 'employee_data' view from query
CREATE VIEW employee_data AS
SELECT E.emp_no, E.last_name, E.first_name, E.sex, S.salary
FROM "Employees" AS E
JOIN "Salaries" AS S
ON (E.emp_no = S.emp_no)
;

SELECT * FROM employee_data
ORDER BY "emp_no";


-- List first_name, last_name, and hire date for employees hired in 1986
-- Create 'employee_data' view from query
SELECT * FROM "Employees";

CREATE VIEW employee_data_1986 AS
SELECT E.first_name, E.last_name, E.hire_date
FROM "Employees" AS E
WHERE extract(year from hire_date) = 1986
;


SELECT * FROM employee_data_1986
ORDER BY "hire_date";


-- List the manager of each dept with: dept_no, dept_name, manager's emp_no, last_name, first_name.
CREATE VIEW manager_data AS
SELECT DM.dept_no, D.dept_name, E.emp_no, E.last_name, E.first_name
FROM "Employees" AS E
JOIN "Dept_Manager" AS DM
ON (E.emp_no = DM.emp_no)
  JOIN "Departments" AS D
  ON (DM.dept_no = D.dept_no)
;

SELECT * FROM manager_data
ORDER BY "dept_no";


-- List the dept of each employee with: emp_no, last_name, first_name, dept_name.
CREATE VIEW emp_dept AS
SELECT E.emp_no, E.last_name, E.first_name, D.dept_name
FROM "Employees" AS E
JOIN "Dept_Emp" AS DE
ON (E.emp_no = DE.emp_no)
  JOIN "Departments" AS D
  ON (DE.dept_no = D.dept_no)
;

SELECT * FROM emp_dept
ORDER BY "emp_no";


-- List first_name, last_name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM "Employees"
WHERE first_name = 'Hercules' AND last_name like 'B%'
ORDER BY "last_name"
;


-- List all employees in the Sales dept, including their emp_no, last_name, first_name, and dept_name.
CREATE VIEW emp_sales AS
SELECT E.emp_no, E.last_name, E.first_name, D.dept_name
FROM "Employees" AS E
JOIN "Dept_Emp" AS DE
ON (E.emp_no = DE.emp_no)
  JOIN "Departments" AS D
  ON (DE.dept_no = D.dept_no)
;

SELECT * FROM emp_sales
WHERE dept_name = 'Sales'
ORDER BY "emp_no"
;


-- List all employees in the Sales and Development depts, including emp_no, last_name, first_name, and dept_name.
CREATE VIEW emp_sales_dev AS
SELECT * FROM emp_sales
WHERE dept_name = 'Sales' OR dept_name = 'Development'
ORDER BY "emp_no"
;

SELECT * FROM emp_sales_dev;

-- List the frequency count of employee last names (descending), ie how many employees share each last name.
SELECT last_name, COUNT(last_name) FROM "Employees"
GROUP BY "last_name"
ORDER BY "count" DESC
;

-- Verify the count
select * from "Employees"
where "last_name" = 'Baba'
;