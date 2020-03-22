--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no AS "employee number", e.last_name AS "last name", e.first_name AS "first name", e.gender, s.salary
FROM employees e
LEFT JOIN salaries s
ON e.emp_no = s.emp_no;

--2. List employees who were hired in 1986.
SELECT emp_no AS "employee number", last_name AS "last name", first_name AS "first name", hire_date AS "hire date"
FROM employees
WHERE extract(year from hire_date) = 1986
--AND hire_date < '1987-01-01';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number,
--last name, first name, and start and end employment dates.
SELECT m.dept_no AS "department number", d.dept_name AS "deparment name", m.emp_no AS "employee number", e.last_name AS "last name", 
e.first_name AS "first name", m.from_date AS "start employment date", m.to_date AS "end employment date"
FROM dept_manager m
LEFT JOIN departments d
ON m.dept_no = d.dept_no
LEFT JOIN employees e
ON m.emp_no = e.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
--Subquery with MAX on "from_date" to show current or latest department by employee
SELECT sq."employee number", sq."last name", sq."first name", sq."from date"
FROM
(SELECT e.emp_no AS "employee number", e.last_name AS "last name", e.first_name AS "first name",
MAX(from_date) AS "from date"
FROM dept_emp de
JOIN departments d
ON de.dept_no = d.dept_no
JOIN employees e
ON e.emp_no = de.emp_no
GROUP BY e.emp_no, e.last_name, e.first_name) sq;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT emp_no AS "employee number", last_name AS "last name", first_name AS "first name", 'Sales' as "department name"
FROM employees
WHERE emp_no IN 
	(SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN
		(SELECT dept_no
		FROM departments 
		WHERE dept_name = 'Sales'));

--or
SELECT e.emp_no AS "employee number", e.last_name AS "last name", e.first_name AS "first name", 
d.dept_name as "department name"
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'

--7. List all employees in the Sales and Development departments, including their employee number, last name, 
--first name, and department name.
SELECT e.emp_no AS "employee number", e.last_name AS "last name", e.first_name AS "first name", 
d.dept_name as "department name"
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales','Development')

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share 
--each last name.
SELECT last_name AS "last name", COUNT(last_name) AS "employees sharing last name"
FROM employees
GROUP BY last_name
ORDER BY "employees sharing last name" DESC
