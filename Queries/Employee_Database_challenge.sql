-- Retrieving relevant data needed to start analysis of 'Operation Silver Tsunami':
SELECT * FROM employees;
SELECT * FROM titles;

DROP TABLE retirement_titles;

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t ON(e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no DESC;

SELECT * FROM retirement_titles;


-- Distinct with Orderby to remove duplicate rows:
DROP TABLE unique_titles;

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01') 
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_titles;


-- Most recent titles:
DROP TABLE retiring_titles;

SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles;


-- Determine eligibility for mentorship:
DROP TABLE mentorship_eligibility;

SELECT DISTINCT ON (emp.emp_no) emp.emp_no, emp.first_name, emp.last_name, emp.birth_date, de.from_date, de.to_date, ti.title
INTO mentorship_eligibility
FROM employees AS emp
LEFT JOIN dept_emp AS de
ON (emp.emp_no = de.emp_no)
LEFT JOIN titles AS ti
ON (emp.emp_no = ti.emp_no)
WHERE (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp.emp_no;

SELECT * FROM mentorship_eligibility;