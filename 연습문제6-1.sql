select employee_id, first_name, department_id, salary
from    employees
where   salary =( select min(salary) from employees);

select  e.employee_id, e.first_name, d.department_id, j.job_id
from    employees e, departments d, jobs j
WHERE   e.department_id = d.department_id
AND     e.job_id = j.job_id
AND     d.department_name = 'Marketing';

select  employee_id, first_name, hire_date
from    employees
where   hire_date < (select hire_date from employees where manager_id is null)
order by 3;


-- 서브쿼리는 WHERE 절에 가장 많이 사용한다!