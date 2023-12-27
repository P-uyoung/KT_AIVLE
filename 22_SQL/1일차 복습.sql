# 쿼리 1
SELECT customer_name,
		CASE WHEN gender = 'F' THEN '여자'
			 WHEN gender = 'F' THEN '여자'
			 ELSE '' END AS gender,
		city,
		YEAR(birth_date) AS birth_year,
        REPEAT('▒', ROUND(point/1000)) AS point
	FROM customer
    WHERE point > 0
    ORDER BY customer_name ASC;
    
# 쿼리 2
SELECT city,
		SUM(IF(gender = 'M', point, 0)) AS M,
		SUM(IF(gender = 'F', point, 0)) AS F,
		SUM(point) AS tot_point
	FROM customer
	WHERE point > 0
	GROUP BY city
	ORDER BY city ASC;

# 쿼리 3
CREATE VIEW 포인트2019
AS  -- 포장지
SELECT gender AS 성별,
		SUM(IF(MONTH(register_date)=1, point, 0)) AS 1월,
        SUM(IF(MONTH(register_date)=2, point, 0)) AS 2월,
        SUM(IF(MONTH(register_date)=3, point, 0)) AS 3월,
        SUM(IF(MONTH(register_date)=4, point, 0)) AS 4월,
        SUM(IF(MONTH(register_date)=5, point, 0)) AS 5월,
        SUM(IF(MONTH(register_date)=6, point, 0)) AS 6월,
        SUM(IF(MONTH(register_date)=7, point, 0)) AS 7월,
        SUM(IF(MONTH(register_date)=8, point, 0)) AS 8월,
        SUM(IF(MONTH(register_date)=9, point, 0)) AS 9월,
        SUM(IF(MONTH(register_date)=10, point, 0)) AS 10월,
        SUM(IF(MONTH(register_date)=11, point, 0)) AS 11월,
        SUM(IF(MONTH(register_date)=12, point, 0)) AS 12월,
		SUM(point) AS 총계
	FROM customer
	WHERE register_date BETWEEN '2018-01-01' AND '2018-12-31'
	GROUP BY gender
	ORDER BY city ASC;
    
SELECT * FROM 포인트2019; -- 확인
/*
VIEW는 데이터를 저장하지 않기 때문에, 최신 데이터를 보여줌. 
즉, DB의 데이터가 바뀌면 바뀐 데이터를 보여준다.!
*/