/*
기본적인 데이터 조회 (2)
*/


-- 1) NULL 값

/*
- NULL 값은 0도 아니고 공백도 아닌 알 수 없는 값(Unknown Value)
- 홍길동 몸무게가 NULL, 일지매 몸무게가 NULL이면
  홍길동과 일지매는 몸무게가 0인가?
  홍길동과 일지매 몸무게가 같나? 
- NULL 값과 'NULL'은 완전 다름
- IS NULL, IS NOT NULL을 사용해 NULL 값을 식별할 수 있음
*/

-- 근무 중인 직원 정보 조회 (?)
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date = 'NULL';

-- 근무 중인 직원 정보 조회 (?)
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date = NULL; -- np.nan

-- 근무 중인 직원 정보 조회 (!)
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL;
    
-- 퇴사한 직원 정보 조회
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone, retire_date
	FROM employee
	WHERE retire_date IS NOT NULL;
    
/*
NOT LIKE
NOT BETWEEN
NOT IN
IS NOT NULL
*/


-- 쿼리단에서 데이터의 가공을 다해보자, 다 처리되면 판다스로 주자
-- IFNULL 함수 사용 전
SELECT emp_name, emp_id, eng_name, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL;

-- IFNULL 함수 사용: eng_name 열 값이 NULL이면 (공백 혹은 N/A 혹은 'unkown') 으로 표시
SELECT emp_name, emp_id, IFNULL(eng_name, ''), gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL;

-- IFNULL 함수 결과에 별칭 사용
SELECT emp_name, emp_id, IFNULL(eng_name, '') AS eng_name, gender, dept_id, hire_date
	FROM employee
	WHERE retire_date IS NULL;

/*
참고: DBMS마다 다른 NULL 처리 함수
-- MySQL: IFNULL(), 여기서 ISNULL()은 0 또는 1 반환
-- MSSQL: ISNULL()
-- ORACLE: NVL()
*/

-- IFNULL() 함수보다 더욱 범용적
-- COALESCE() 함수 사용: 나열된 값 중에서 첫 번째 Null이 아닌 값
SELECT emp_name, emp_id, COALESCE(eng_name, '') AS 'nick_name', gender, dept_id, hire_date
	FROM employee
	WHERE retire_date IS NULL;


-- Q) 본부에 속하지 않은 부서 정보 조회



-- Q) 영어 이름이 없는 근무중인 직원 정보 조회




-- 2) 데이터 결합

/*
- CONCAT 함수를 사용해 데이터 결합
- 결합되는 값에 NULL 값이 포함되면 결합 결과가 NULL이 됨
*/

-- 자동 형 변환 (숫자로 결합)
SELECT '10' + '20'; -- 30
SELECT 10 + '20'; -- 30
SELECT 10 + '20AX'; -- 30
SELECT 10 + 'LX20'; -- 10
SELECT 'LX20'+ 10; -- 10

-- 문자열 데이터 결합 (숫자도 문자로 형변환 후 다 붙여버림)
SELECT CONCAT('10', '20');
SELECT CONCAT(10, '20');
SELECT CONCAT(10, 20);
SELECT CONCAT(10, NULL);

-- 열 데이터 결합
SELECT CONCAT(emp_name, '(', emp_id, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- 문자와 숫자 결합
SELECT CONCAT(emp_name, '(', salary, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- 문자와 날짜 결합
SELECT CONCAT(emp_name, '(', hire_date, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- NULL과 결합하면?
SELECT CONCAT(emp_name, '(', eng_name, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- NULL 값 처리 #1
SELECT CONCAT(emp_name, '(', IFNULL(eng_name, ''), ')') AS emp_name, dept_id, gender, 
       hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- NULL 값 처리 #2
SELECT CONCAT(emp_name, IFNULL(CONCAT('(', eng_name, ')'), '')) AS emp_name, dept_id, gender, 
       hire_date, email
	FROM employee
	WHERE retire_date IS NULL;


-- Q) 사원번호와 부서코드를 묶어서(예: S0001(SYS)) 근무중인 직원 정보 조회
SELECT CONCAT(emp_id, '(', dept_id, ')') AS em_id, emp_name, hire_date, email
	FROM employee
    WHERE retire_date IS NULL;
    
    
-- 3) 데이터 정렬
-- 판다스, sort_values()
/*
- ORDER BY 절을 사용해 정렬된 결과를 표시할 수 있음
- 꼭 필요한 경우만 데이터 정렬을 사용(성능 문제 발생 가능)
- ASC: 오름차순  --> 1, 2, 3, 4 / 가, 나, 다, 라 / A, B, C, D
- DESC: 내림차순 --> 4, 3, 2, 1 / 라, 다, 나, 가 / D, C, B, A
- 정렬 방식을 생략하면 ASC가 지정된 것으로 간주됨
- 문자, 날짜, 숫자 모두 정렬 가능
- 복합 정렬은 콤마(,)로 구분해서 정렬 방식을 지정함
*/

-- 이름을 기준으로 오름차순 정렬
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone -- 3)
	FROM employee	-- 1)
	WHERE retire_date IS NULL -- 2)
	ORDER BY emp_name ASC;  -- 4) 이미 다 돌고, 출력할 때만 정렬
	-- 데이터는 1부터 시작
	-- ODER BY 1

-- 이름을 기준으로 내림차순 정렬
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL
	ORDER BY emp_name DESC;

-- 부서코드를 기준으로 오름차순, 이름을 기준으로 내림차순 정렬
SELECT dept_id, emp_name, emp_id, gender, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL
	ORDER BY dept_id ASC, emp_name DESC;
    -- 쿼리에서 콤마(,)는 결계임
    -- ORDER BY dept_id, emp_name DESC;


-- Q) 연봉이 높은 순으로 정렬해서 근무중인 직원 정보 조회
SELECT *
	FROM employee
    WHERE retire_date IS NULL
    ORDER BY salary DESC;
   
-- 입사일을 기준으로 정렬해서 조회 ?? 절대 사용자의 요청을 예측하지 마세요.!
SELECT *
	FROM employee
    WHERE retire_date IS NULL
    ORDER BY hire_date DESC;   
    
-- 4) CASE 문

/*
- 쿼리문 안에서 조건에 따라 다른 값을 표시할 수 있음
*/

-- 직원 정보 조회
SELECT emp_name, emp_id, gender, hire_date, salary
	FROM employee;

-- 성별: M, F --> 남자, 여자
SELECT emp_name, emp_id, 
       CASE WHEN gender = 'M' THEN '남자'
            WHEN gender = 'F' THEN '여자'
            ELSE '' END AS gender, -- ELSE 없으면 NULL
	   hire_date, retire_date, salary
	FROM employee;

-- 근무 상태를 근무, 퇴사로 표시
SELECT emp_name, emp_id, gender, hire_date, salary,
       CASE WHEN retire_date IS NULL THEN '근무'
            ELSE '퇴사' END AS status
	FROM employee;


-- Q) 급여 크기를 상, 중, 하로 구분
SELECT emp_name, emp_id, gender, hire_date, salary,
       CASE WHEN salary >= 7000 THEN '상'
			WHEN salary >= 6000 THEN '중'
            WHEN salary IS NULL THEN NULL
            ELSE '하' END AS status
	FROM employee;
    
-- SYS 부서 전화번호 공백 처리
SELECT emp_name, emp_id, dept_id, gender, hire_date,
		CASE WHEN dept_id = 'SYS' THEN ''
			 ELSE phone END AS phone, salary
	FROM employee;
    


-- 5) IF 함수

/*
- IF(조건, 참일 때 값, 거짓일 때 값)
- 주어진 조건이 참인지 거짓인지에 따라 값을 선택
- 조건 하나에 따른 값 선택의 경우 CASE 문보다 사용이 용이
*/

-- SYS 부서 전화번호 공백 처리
SELECT emp_name, emp_id, dept_id, gender, hire_date,
		IF (dept_id = 'SYS', '', phone) AS phone, salary
	FROM employee;

-- 성별: M, F --> 남자, 여자
SELECT emp_name, emp_id, 
       IF(gender = 'M', '남자', '여자') AS gender, 
	   hire_date, retire_date, salary
	FROM employee;

-- (파생열 추가) 근무 상태를 근무, 퇴사로 표시
SELECT emp_name, emp_id, gender, hire_date, salary,
       IF(retire_date IS NULL,  '근무', '퇴사') AS status
	FROM employee;


-- Q) 급여 크기를 상, 중, 하로 구분 (if문 안쓰는게 좋음요) 


/*
3가지 유형의 SQL문
- DML (data manipulation language) : SELECT, INSERT, UPDATE, DELETE, MERGE
- DDL (data definition language) : CREATE, ALTER, DROP
- DCL (data control권한 language) : GRNAT, REVOKE, DENY
- DDL, DCL은 관리자들이 배우는 것