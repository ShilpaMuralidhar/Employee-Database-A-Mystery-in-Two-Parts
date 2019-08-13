DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE departments(
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL,
	PRIMARY KEY (dept_no)
);


CREATE TABLE dept_emp(
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR NOT NULL,
	emp_no INTEGER NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM employees;
CREATE TABLE employees(
	emp_no INTEGER NOT NULL,
	birth_date VARCHAR NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no) 
);

CREATE TABLE salaries(
	emp_no INTEGER NOT NULL,
	salary VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles(
	emp_no INTEGER NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--1. List the following details of each employee: employee number, last name, 
--first name, gender, and salary.
SELECT e.emp_no, e.first_name, e.last_name, e.gender
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no = s.emp_no;

--2.List employees who were hired in 1986.
SELECT * 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3. List the manager of each department with the following 
--information: department number, department name, the 
--manager's employee number, last name, first name, and start and 
--end employment dates.
SELECT dm.dept_no, dm.emp_no, dm.from_date, dm.to_date,
e.emp_no, e.first_name, e.last_name, d.dept_no, d.dept_name 
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

--4.List the department of each employee with the 
--following information: employee number, last name, 
--first name, and department name.
SELECT de.emp_no, de.dept_no, d.dept_no, d.dept_name, 
e.emp_no, e.first_name, e.last_name
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e ON de.emp_no = e.emp_no;

--5.List all employees whose first name is "Hercules" 
--and last names begin with "B."
SELECT first_name, last_name 
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6.List all employees in the Sales department, 
--including their employee number, last name, 
--first name, and department name.

SELECT d.dept_no, d.dept_name, de.emp_no, de.dept_no, 
e.emp_no, e.first_name, e.last_name
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e ON de.emp_no = e.emp_no
WHERE dept_name LIKE 'Sales';

--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and 
--department name.

SELECT d.dept_no, d.dept_name, de.emp_no, de.dept_no, 
e.emp_no, e.first_name, e.last_name
FROM departments d 
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e ON de.emp_no = e.emp_no
WHERE dept_name LIKE 'Sales'
OR dept_name LIKE 'Development';

--8. In descending order, list the frequency count of employee 
--last names, i.e., how many employees share each last name.
SELECT last_name, COUNT (*)  AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;












