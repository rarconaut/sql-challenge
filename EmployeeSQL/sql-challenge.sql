-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Homework 09 SQL-Challenge
-- Create the tables to store employee data from the CSVs
CREATE TABLE "Departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_Emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL,
    CONSTRAINT "pk_Dept_Emp" PRIMARY KEY (
        "emp_no",
		"dept_no"
     )
);

CREATE TABLE "Dept_Manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        "dept_no",
		"emp_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" money   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

-- Adding constraints (foreign keys) for tables
ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");


-- Import CSVs and view the populated tables
select * from "Departments";

select * from "Dept_Emp";

select * from "Dept_Manager";

select * from "Employees";

select * from "Salaries";

select * from "Titles";


-- List the following details of each employee: emp_no, last name, first name, sex, and salary
-- Create 'employee_data' view from query
CREATE VIEW employee_data AS
SELECT E.emp_no, E.last_name, E.first_name, E.sex, S.salary
FROM "Employees" AS E
JOIN "Salaries" AS S
ON (E.emp_no = S.emp_no)
;

SELECT * FROM employee_data
ORDER BY "emp_no";


-- List first name, last name, and hire date for employees hired in 1986
-- Create 'employee_data' view from query
SELECT * FROM "Employees";

CREATE VIEW employee_data_1986 AS
SELECT E.first_name, E.last_name, E.hire_date
FROM "Employees" AS E
WHERE extract(year from hire_date) = 1986;


SELECT * FROM employee_data_1986
ORDER BY "hire_date";


-- List the manager of each dept with: dept_no, dept_name, manager's emp_no, last name, first name.
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


-- List the dept of each employee with: emp_no, last name, first name, dept_name.
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


-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM "Employees"
WHERE first_name = 'Hercules' AND last_name like 'B%'
ORDER BY "last_name";


-- List all employees in the Sales dept, including their emp_no, last name, first name, and dept_name.
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
ORDER BY "emp_no";


-- List all employees in the Sales and Development depts, including emp_no, last name, first name, and dept_name.
CREATE VIEW emp_sales_dev AS
SELECT * FROM emp_sales
WHERE dept_name = 'Sales' or dept_name = 'Development'
ORDER BY "emp_no";

SELECT * FROM emp_sales_dev

-- List the frequency count of employee last names (descending), ie how many employees share each last name.