-- Create a table which has the employee number, first name, last name
-- , title, from_date, to_date. Filter by people born between 1952 & 1955
-- order by employee number
SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date
	BETWEEN '1952-01-01'
	AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Create a table that has the number of each retiring job title
SELECT COUNT(title) AS retire_count, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY retire_count DESC;

-- Create a table that has employees eligible for a mentorship program
SELECT DISTINCT ON (e.emp_no) 
	e.emp_no, 
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
JOIN dept_emp as de
	ON e.emp_no = de.emp_no
JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01'
					  AND '1965-12-31')
ORDER BY e.emp_no;


SELECT DISTINCT (title), COUNT(title) AS "Eligible Count"
FROM mentorship_eligibility
GROUP BY title
ORDER BY "Eligible Count" DESC;