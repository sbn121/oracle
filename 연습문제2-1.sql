SELECT  first_name||' '||last_name AS name, department_id
FROM    employees
WHERE   employee_id = 200;

SELECT  employee_id, first_name||' '||last_name AS name, salary
FROM    employees
WHERE   salary NOT BETWEEN 3000 AND 15000;

SELECT  employee_id, first_name||' '||last_name AS name, department_id, salary AS "Monthly Salary"
FROM    employees
WHERE   department_id IN (30,60)
ORDER BY 2;

SELECT  employee_id, first_name||' '||last_name AS name, salary, department_id
FROM    employees
WHERE   department_id IN (30,60) AND salary BETWEEN 3000 AND 15000;

SELECT  employee_id, first_name||' '||last_name AS name, job_id
FROM    employees
WHERE   department_id IS NULL;

SELECT  employee_id, first_name||' '||last_name AS name, salary, commission_pct
FROM    employees
WHERE   commission_pct IS NOT NULL
ORDER BY 4 DESC;

SELECT  employee_id, first_name||' '||last_name AS name
FROM    employees
-- WHERE절에 Alias(별칭, 약어) 사용 : X
WHERE   first_name||' '||last_name LIKE '%z%';



