SELECT *
  FROM customer;

-- 데이터베이스 프로그래밍

-- 결과 집합, result set
-- rs.next(); -- true, false

-- 진행 순서
-- 하나씩 순차적으로 검색하는 것이 아님
-- 자체적으로 "색인"을 활용하여 검색의 효율성을 자동으로 높임
-- 1. 오류 검사
-- 2. 실행 계획 (execution plan)

-- DBMS는 아래 3가지 수행 경우를 다르다고 판단 (사실 크게 다르지 않음)
SELECT *
  FROM customer
 WHERE customer_id = 'banana';
 
 
SELECT *
  FROM customer
 WHERE customer_id = 'apple';


SELECT *
  FROM customer
 WHERE customer_id = 'strawberry';
 

-- 다음과 같은 기능을 제공
SELECT *
  FROM customer
 WHERE customer_id = ?;


UPDATE customer
   SET age = ?, grade = ?, saved_money = ?
 WHERE customer_id = ?