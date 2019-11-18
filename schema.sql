-- Creating tables for PH-Employees
Create TABLE departments(
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY(dept_no),
	UNIQUE(dept_name)
);
CREATE TABLE employees(
	emp_no INT NOT NULL,
	birthdate DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY(emp_no)
);

CREATE TABLE dept_manager(
dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY(emp_no,dept_no)
);

CREATE TABLE salaries(
emp_no INT NOT NULL,
salary INT NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
PRIMARY KEY(emp_no)
);

CREATE TABLE titles(
emp_no INT NOT NULL,
dept_no VARCHAR NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
PRIMARY KEY(emp_no)
);
SELECT * FROM departments;

SELECT *FROM employees;
-- Retirement eligibility
SELECT first_name,last_name
FROM employees
WHERE (birthdate BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Retirement eligibility
SELECT COUNT(first_name)
FROM employees
WHERE (birthdate BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--SELECT MODIFY
SELECT first_name,last_name
INTO retirement_info
FROM employees
WHERE (birthdate BETWEEN '1952-01-01' AND '1955-12-31')
AND(hire_date BETWEEN '1985-01-01' AND '1988-12-31')

SELECT * FROM retirement_info;
SELECT *FROM employees;
DROP TABLE dept_emp;

--Table Create for dept_emp
CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY(emp_no,dept_no));
	
SELECT *FROM dept_emp;
-- Retirement eligibility
SELECT first_name,last_name
FROM employees
WHERE (birthdate BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Retirement eligibility
SELECT COUNT(first_name)
FROM employees
WHERE (birthdate BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--SELECT MODIFY
SELECT first_name,last_name
INTO retirement_info
FROM employees
WHERE (birthdate BETWEEN '1952-01-01' AND '1955-12-31')
AND(hire_date BETWEEN '1985-01-01' AND '1988-12-31')


SELECT first_name,last_name,title
FROM employees as e
LEFT JOIN titles as t ON e.emp_no=t.emp_no

DROP TABLE retirement_info;
-- Create new table for retiring employees
SELECT emp_no,first_name,last_name
INTO retirement_info
FROM employees
WHERE(birthdate BETWEEN '1952-01-01' AND '1955-12-31')
AND(hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;



--Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no=dept_emp.emp_no;

--Enable shotened nickname
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

SELECT *FROM dept_emp;
SELECT *FROM dept_manager;
--joining departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no=dm.dept_no;
-- Left join for retirement_info and dept_emp
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no=de.emp_no
WHERE de.to_date=('9999-01-01');

SELECT * FROM current_emp;

--Employee count by department number
SELECT COUNT(ce.emp_no),de.dept_no
INTO department_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no=de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--Salary table List 1
SELECT * FROM salaries
ORDER BY to_date DESC;



SELECT e.emp_no,
	e.first_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no=s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no=de.emp_no)
WHERE(e.birthdate BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND(de.to_date='9999-01-01');
--List of managers per department List 2
SELECT dm.dept_no,
	   d.dept_name,
	   dm.emp_no,
	   ce.last_name,
	   ce.first_name,
	   dm.from_date,
	   dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON(dm.dept_no=d.dept_no)
	INNER JOIN current_emp AS ce
		ON(dm.emp_no=ce.emp_no);
SELECT * FROM manager_info;

--Department Retirees List 3
SELECT d.dept_name,
	ce.first_name,
	ce.last_name,
	de.emp_no
INTO dept_info
	FROM current_emp as ce
	INNER JOIN dept_emp as de
	ON(ce.emp_no=de.emp_no)
	INNER JOIN departments AS d
	ON(de.dept_no=d.dept_no);
	
SELECT * FROM dept_info;
--Create query list for Sales department
SELECT *
FROM dept_info
WHERE dept_name IN('Sales');
--Create query list for Development department
SELECT *
FROM dept_info
WHERE dept_name IN('Sales','Development');

SELECT * FROM titles;
--Module Challenge Part 1


DROP TABLE titles;
--recreate titles table

CREATE TABLE titles(
		emp_no INT NOT NULL,
		title VARCHAR NOT NULL,
		from_date DATE NOT NULL,
		to_date DATE NOT NULL,
		FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
	 	);

SELECT * FROM salaries;
SELECT * FROM titles;
SELECT * FROM employees;
DROP TABLE employees_salary;
--part_1 table 
SELECT e.first_name,
	e.last_name,
	ti.emp_no,
	ti.title,
	ti.from_date,
	s.salary
INTO employees_salary --export as name of Part_1.csv
	FROM titles as ti
	RIGHT JOIN employees as e
	ON(ti.emp_no=e.emp_no)
	RIGHT JOIN salaries as s
	ON(ti.emp_no=s.salary);
	

SELECT * FROM employees_salary;

--Part 1.2
--count the row for each duplicate name
SELECT
	first_name,
	last_name,
	count(*)
FROM employees_salary
GROUP BY
	first_name,
	last_name
HAVING count(*) >1;
--produce the row table for duplicate 
SELECT * FROM
	(SELECT*,count(*)
	OVER
	 (PARTITION BY
	 	first_name,
	 	last_name)
	 AS count FROM employees_salary
		) tableWithCount
	WHERE tableWithCount.count>1;
SELECT * FROM employees_salary;

DROP TABLE EMP_TITLE;

--Combine the duplicate row
SELECT 
first_name,
last_name,
salary,
from_date,
title
INTO EMP_TITLE
FROM employees_salary
GROUP BY
	first_name,
	last_name,
	salary,
	from_date,
	title
ORDER BY
	from_date DESC;
	
SELECT * FROM EMP_TITLE;
	
	
--DELETETING THE NULL values
DELETE FROM EMP_TITLE
WHERE first_name is NULL;

SELECT * FROM EMP_TITLE;

SELECT COUNT(emp.title),emp.title
INTO title_count
FROM EMP_TITLE as emp
GROUP BY emp.title;


SELECT * FROM title_count;

SELECT  tc.count,
		emp.first_name,
		emp.last_name,
		emp.salary,
		emp.from_date,
		emp.title
		INTO emp_title_count
		FROM EMP_TITLE as emp
		LEFT JOIN title_count as tc
		ON(emp.title=tc.title)
		ORDER BY emp.from_date DESC;

--Part 3 Who's Ready for a Mentor?

SELECT ep.emp_no,
		ep.first_name,
		ep.last_name,
		ep.birthdate,
		ti.title,
		ti.from_date,
		ti.to_date
		INTO mentor_ready --export as par_3
		FROM employees as ep
		INNER JOIN titles as ti
		ON(ep.emp_no = ti.emp_no)
		WHERE (ep.birthdate BETWEEN '1965-01-01'AND '1965-12-31')
		AND(ti.to_date='9999-01-01');
	
	