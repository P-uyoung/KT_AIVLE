/*
실습 - 기본적인 데이터 조회
*/

-- 데이터베이스 연결
USE MyShop2019;


-- Q01) customer 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
SELECT *
FROM customer;

-- Q02) employee 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
SELECT *
FROM employee;

-- Q03) product 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
SELECT *
FROM product;

-- Q04) order_header 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
SELECT *
FROM order_header;

-- Q05) order_detail 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
SELECT *
FROM order_detail;

-- Q06) 이름이 '홍길동'인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
	FROM customer
    WHERE customer_name = '홍길동';

-- Q07) '울산' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
	FROM customer
    WHERE city = '울산';

-- Q08) 포인트가 500,000 이상인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
	FROM customer
    WHERE point >= 500000;

-- Q09) 이름에 공백이 들어간 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
	FROM customer
    WHERE customer_name LIKE '% %';

-- Q10) 전화번호가 010으로 시작하지 않는 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
	FROM customer
    WHERE phone NOT LIKE '010-%';
 
-- Q11) 포인트가 400,000 이상인 '서울' 지역 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
	FROM customer
    WHERE point >= 400000 AND city = '서울';

-- Q12) '강릉' 또는 '원주' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
	FROM customer
	WHERE city in ('강릉', '원주'); 

-- Q13) 1990년에 출생한 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
--      단, CASE 문을 사용해 성별은 '남자', '여자'로 표시되게 하세요.
SELECT customer_name, customer_id,
		CASE WHEN gender = 'F' THEN '여자'
			 WHEN gender = 'M' THEN '남자'
			 END  gender, city, phone, point
	FROM customer
    WHERE birth_date BETWEEN '1990-01-01' AND '1990-12-31';

-- Q14) 1990년에 출생한 '대구' 또는 '경주' 지역 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
	FROM customer
    WHERE birth_date BETWEEN '1990-01-01' AND '1990-12-31'
		AND city in ('대구', '경주');

-- Q15) 근무중인 남자 직원의 이름, 사원번호, 성별, 전화번호, 입사일을 조회하세요.
 

-- Q16) 다음과 같이 조건에 따른 고객 등급이 표시되게 조회하세요.
--      단, 포인트가 0이거나 NULL이면 고객 등급이 NULL이 되게 하세요.
/*
1,000,000 이상 --> 'Platinum'
  600,000 이상 --> 'Gold'
  300,000 이상 --> 'Silver'
  100,000 이상 --> 'Bronze'
        0 초과 --> 'Family'
*/


-- 정리
SELECT CONCAT(customer_name, '(', customer_id, ')') AS name,
        IF(gender = 'M', '남', '여') AS gender,
        phone,
        city,
        birth_date,
        CASE WHEN point >= 1000000 THEN 'Platinum'
			WHEN point >= 600000 THEN 'Gold'
            WHEN point >= 300000 THEN 'Silver'
            WHEN point >= 100000 THEN 'Bronze'
            WHEN point > 0 THEN 'Family'
            ELSE NULL END level
	FROM customer
    WHERE city in ('서울', '부산', '대구') AND point > 0
    ORDER BY customer_name ASC;
    
