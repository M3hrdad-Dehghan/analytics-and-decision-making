-- Find the name of departments where a manager has never worked in there.
SELECT 
    dm.emp_no, d.dept_name
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    dm.dept_no <> d.dept_no
ORDER BY dm.emp_no , d.dept_no;


-- Combine Employee Career Events Into a Single Analytical Dataset Showing which Dates, Employee Changed Title and Department
SELECT 
    *
FROM
    (SELECT 
        emp_no, from_date, 'TITLE_CHANGE' AS event_type
    FROM
        titles UNION ALL SELECT 
        emp_no, from_date, 'DEPT_CHANGE' AS event_type
    FROM
        dept_emp) AS my_tabel
ORDER BY emp_no;


-- How many salary contract signed by female employees have been valueud above the all-time average contract salary value of the company?
CREATE VIEW my_view AS

WITH avg_salary AS (
SELECT avg(salary) AS 'average_salary'
FROM salaries
)

SELECT 
    e.gender,
    s.emp_no,
    s.salary,
    avs.average_salary,
    CASE
        WHEN s.salary > avs.average_salary THEN 1
        ELSE 0
    END AS 'f_above_avegare_salary'
FROM
    employees e
        JOIN
    salaries s ON s.emp_no = e.emp_no AND e.gender = 'F'
        CROSS JOIN
    avg_salary avs;


-- The HR analytics team would like to identify employees within a specific demographic group who are earning above the company’s average salary
DROP PROCEDURE IF EXISTS hr_application;

DELIMITER $$
	CREATE PROCEDURE hr_application(IN p_gender TEXT , IN p_yearbirth INTEGER)
    
    BEGIN
		WITH average_salary AS (
		SELECT AVG(salary) AS 'average_salary'
		FROM salaries)

		SELECT E.gender, E.birth_date, S.salary, ROUND(AVGS.average_salary,0) AS 'average_salary'
		FROM employees E
		JOIN salaries S ON S.emp_no = E.emp_no CROSS JOIN average_salary AVGS 
		WHERE 
			(S.salary > ROUND(AVGS.average_salary,0)) AND
            (E.gender = p_gender) AND
            (YEAR(E.birth_date) = p_yearbirth);
	END $$
DELIMITER ;



-- How has an employee’s salary changed over time compared to their previous compensation level?
SET @employment_number = 15645;

SELECT 
    S.emp_no,    E.first_name,    E.last_name,    E.gender,    S.salary,    S.from_date,    S.to_date,
    LAG(S.salary) OVER W AS 'previous_salary',
    LEAD(S.salary) OVER W AS 'next_salary',
    S.salary - LAG(S.salary) OVER W AS 'change_salary'
FROM
    salaries S
        JOIN
    employees E ON E.emp_no = S.emp_no
WHERE S.emp_no = @employment_number
WINDOW W AS (PARTITION BY S.emp_no)
ORDER BY S.emp_no , S.from_date ASC
