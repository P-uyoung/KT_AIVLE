/*
데이터 집계 (2)
*/


-- 데이터베이스 연결
USE hrdb2019;

/*
[ 순위 함수 ] 
- RANK() : 1, 2, 2, 4, ..
- DENSE_RANK() : 1, 2, 2, 3, ..
- ROW_NUMBER() : 1, 2, 3, 4, ...
- NTILE(n) : 1, 1, 1, 2, 2, 2, 3, 3, 3 (n조각으로 나눈다)
*/


-- 1) RANK: 1, 2, 2, 4

-- 전체 순위 조회
SELECT emp_id, emp_name, dept_id, gender, phone, salary,
       RANK() OVER(ORDER BY salary DESC) AS rnk
   FROM employee
   WHERE retire_date IS NULL;

-- 입사일 기준 조회
SELECT emp_name, emp_id, gender, phone, hire_date,
	   RANK() OVER(ORDER BY hire_date ASC) AS rnk
	FROM employee
	WHERE retire_date IS NULL
    ORDER BY emp_name ASC;
   
-- 남녀별 순위 조회
SELECT emp_id, emp_name, dept_id, gender, phone, salary,
       RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rnk
   FROM employee
   WHERE retire_date IS NULL;

SELECT emp_id, emp_name, dept_id, gender, phone, salary,
       RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rnk1,
       RANK() OVER(ORDER BY salary DESC) AS rnk2
   FROM employee
   WHERE retire_date IS NULL
   ORDER BY rnk2 DESC;

-- Q) 남녀별 1등 조회
-- 서브쿼리: FROM 절에 올때는 별칭이 꼭 필요함.
SELECT *
	FROM(
		SELECT emp_id, emp_name, dept_id, gender, phone, salary,
				RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rnk
		   FROM employee
		   WHERE retire_date IS NULL
	) AS T
    WHERE rnk = 1;

   
   
-- 2) DENSE_RANK: 1, 2, 2, 3

-- 전체 순위 조회
SELECT emp_id, emp_name, dept_id, gender, phone, salary, 
	   DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
   FROM employee
   WHERE retire_date IS NULL;

-- 남녀별 순위 조회
SELECT emp_id, emp_name, dept_id, gender, phone, salary, 
	   DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rnk
   FROM employee
   WHERE retire_date IS NULL;


-- 3) ROW_NUMBER: 1, 2, 3, 4
-- 페이징 넘버링을 하기위해 함.

-- 번호 붙여 조회
SELECT ROW_NUMBER() OVER(ORDER BY emp_id ASC) AS num,
       emp_id, emp_name, dept_id, gender, phone, salary
   FROM employee
   WHERE retire_date IS NULL;
   
SELECT * 
	FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY emp_id ASC) AS num,
				emp_id, emp_name, dept_id, gender, phone, salary
		FROM employee
		WHERE retire_date IS NULL
	) AS T
WHERE num BETWEEN 6 AND 10;

-- 남녀별 번호 붙여 조회
SELECT ROW_NUMBER() OVER(PARTITION BY gender ORDER BY emp_id ASC) AS num,
	   emp_id, emp_name, dept_id, gender, phone, salary
   FROM employee
   WHERE retire_date IS NULL;


-- Q) 남녀 1번부터 3번까지 조회



-- 4) NTILE: 1, 1, 1, 2, 2, 2, 3, 3, 3

-- 급여 순으로 3등분 (16개이면 5,5,5)
SELECT emp_id, emp_name, dept_id, gender, phone, salary,
	   NTILE(3) OVER(ORDER BY salary DESC) AS grp
   FROM employee
   WHERE retire_date IS NULL;

-- 남녀별 급여순으로 3등분
SELECT emp_id, emp_name, dept_id, gender, phone, salary,
	   NTILE(3) OVER(PARTITION BY gender ORDER BY salary DESC) AS grp
   FROM employee
   WHERE retire_date IS NULL;
   
-- 급여순으로 3등분 (상,중,하 로)
SELECT emp_id, emp_name, dept_id, gender, phone, salary,
	   ELT(NTILE(3) OVER(PARTITION BY gender ORDER BY salary DESC), '상', '중','하') AS grp
   FROM employee
   WHERE retire_date IS NULL;
