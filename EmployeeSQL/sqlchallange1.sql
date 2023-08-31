create table sqlchallange1.titles (
	title_id VARCHAR(10) primary key,
	title VARCHAR(100) not null
);

create table sqlchallange1.departments (
	dept_no VARCHAR (20) primary key,
	dept_name VARCHAR (40) not null
);

create table sqlchallange1.employees (
	emp_no INT primary key,
	emp_title_id VARCHAR (20),
	birth_date DATE,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	sex CHAR(1),
	hire_date DATE,
	foreign key (emp_title_id) references sqlchallange1.titles(title_id)
);

create table salaries (
	emp_no INT primary key,
	salary INT,
	foreign key (emp_no) references employees(emp_no)
);

create table dept_manager (
	dept_no VARCHAR(20),
	emp_no INT,
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no)
);

create table sqlchallange1.dept_emp( 
	emp_no INT,
	dept_no VARCHAR (20),
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments (dept_no)
);

-- List the employee number, last name, first name, sex, and salary of each employee.

select 
	e.emp_no,
	e.last_name,
	e.first_name,
	e.sex,
	s.salary
from
	sqlchallange1.employees AS e
join
	salaries as s on e.emp_no = s.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT
    first_name,
    last_name,
    hire_date
FROM
    sqlchallange1.employees
WHERE
    extract(year from hire_date) = 1986;
   
-- List the manager of each department along with their department number, department name, employee number, last name, and first name
   
 select 
 	dm.dept_no,
 	d.dept_name,
 	dm.emp_no,
 	e.last_name,
 	e.first_name
 from
 	sqlchallange1.dept_manager as dm
 join
 	sqlchallange1.departments as d on dm.dept_no = d.dept_no
 join
 	sqlchallange1.employees as e on dm.emp_no = e.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

 select 
 	de.emp_no,
 	e.last_name,
 	e.first_name,
 	d.dept_no,
 	d.dept_name
 from
 	sqlchallange1.dept_emp as de
 join
 	sqlchallange1.employees as e on de.emp_no = e.emp_no
 join
 	sqlchallange1.departments as d on de.dept_no = d.dept_no;
 
 -- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select
 	first_name,
 	last_name,
 	sex
from 
 sqlchallange1.employees
 where
  first_name = 'Hercules'
  and last_name like 'B%';
 
 -- List each employee in the Sales department, including their employee number, last name, and first name
 select 
 	e.emp_no,
 	e.last_name,
 	e.first_name
 from
 	sqlchallange1.employees as e
 join
 	sqlchallange1.dept_emp as de on e.emp_no = de.emp_no
 join
 	sqlchallange1.departments as d on de.dept_no = d.dept_no
 where
 	d.dept_name = 'Sales';
 
 -- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
 select 
 	e.emp_no,
 	e.last_name,
 	e.first_name,
 	d.dept_name
 from
 	sqlchallange1.employees as e
 join
 	sqlchallange1.dept_emp as de on e.emp_no = de.emp_no
 join
 	sqlchallange1.departments as d on de.dept_no = d.dept_no 
 where
 	d.dept_name in ('Sales', 'Development');
 
-- Frequency counts of shared last name
 
 select
 	last_name,
 	count(*) as frequency
 from
 sqlchallange1.employees
 group by
 	last_name
 order by
 	frequency desc;
 
 
 