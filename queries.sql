CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR (40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE Employees (
     emp_no  INT NOT NULL,
	 birth_date DATE NULL,
	 first_name VARCHAR  NOT NULL,
	 last_name VARCHAR NOT NULL,
	 gender    VARCHAR (20) NOT NULL,
	 hire_date DATE NOT NULL,
	 PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
     dept_no VARCHAR (10) NOT NULL,
     emp_no INT NOT NULL,
     from_date DATE NOT NULL,
     to_date DATE NOT NULL,
     FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	 FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	 PRIMARY KEY (emp_no, dept_no)	
);

CREATE TABLE salaries (
      emp_no INT NOT NULL,
      salary INT NOT NULL,
      from_date DATE NOT NULL,
      to_date DATE NOT NULL,
	  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	  PRIMARY KEY (emp_no) 
);


CREATE TABLE titles (
     emp_no INT NOT NULL,
     title VARCHAR(45) NOT NULL,
     from_date DATE NOT NULL,
	 to_date DATE NOT NULL,
	 
);

CREATE TABLE dept_emp (
     emp_no INT NOT NULL,
     dept_no VARCHAR NOT NULL,
     from_date DATE NOT NULL,
     to_date DATE NOT NULL,
	 FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	 FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	 PRIMARY KEY (emp_no, dept_no)
);


SELECT * FROM departments;



--Joining emp_info and title_info
SELECT emp_info.emp_no,
       emp_info.first_name,
	   emp_info.last_name,
	   title_info.title,
	   title_info.from_date,
	   title_info.to_date
FROM emp_info
LEFT JOIN title_info
ON emp_info.emp_no = title_info.emp_no;
	   

--Birthday employees
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	  

SELECT employees.first_name, employees.last_name,employees.emp_no, 
titles.title, titles.from_date, titles.to_date
INTO retirement_titles
FROM employees, titles
WHERE employees.emp_no = titles.emp_no;


--PART 1
Code for use Dictinct with Orderby to remove duplicate rows***

SELECT employees.emp_no,
employees.first_name,
employees.last_name,
titles.title,
titles.from_date,
titles.to_date
INTO retirement_titles
FROM employees 
INNER JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no DESC

-- Use Dictinct with Orderby to remove duplicate rows for part 2/Deliverable 1
SELECT DISTINCT ON (ritirement_titles.emp_no) (ritirement_titles.emp_no)
ritirement_titles.first_name,
ritirement_titles.last_name,
ritirement_titles.title

INTO unique_titles
FROM retirement_titles 
ORDER BY emp_no ASC, to_date DESC;

--
SELECT COUNT(unique_titles.emp_no),unique_titles.title
--INTO retiring_titles
FROM unique_titles 
GROUP BY title 
ORDER BY COUNT(title) DESC;

--Deliverable 
SELECT DISTINCT ON(employees.emp_no)employees.emp_no,
employees.first_name,
employees.last_name,
employees.birth_date,
dept_emp.from_date,
dept_emp.to_date,
titles.title

--DISTINCT ON(emp_no)
--INTO mentor_eligibility
FROM employees 
INNER JOIN dept_emp 
ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN titles 
ON (employees.emp_no = titles.emp_no)
WHERE (e.birth_date BETWEEN '1962-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;