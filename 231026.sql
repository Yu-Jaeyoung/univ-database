-- 제품 테이블에서 제조업체별로 제조한 제품의 개수와 가장 비싼 단가를 검색하시오.
SELECT product_name, COUNT(*) AS "제품 수" , max(unit_price) AS "최고가"
  FROM product
 GROUP BY product_name, manufacturer;


-- 제품 테이블에서 제조업체별로 제조한 제품의 개수와 가장 비싼 단가를 검색하시오.
-- 제품을 3개 이상 제조한 
-- HAVING은 GroupBy를 위한 전용 조건
SELECT manufacturer, COUNT(*) AS "제품 수" , max(unit_price) AS "최고가"
  FROM product
 GROUP BY manufacturer
 HAVING COUNT(*) >= 3;


-- 고객 테이블에서 적립금 평균이 1000원 이상인 등급에 대해
-- 등급별 고객수와 적립금 평균을 검색하시오.
SELECT grade, COUNT(*) AS "고객 수", AVG(saved_money) AS "평균적립금"
  FROM customer
 GROUP BY grade
HAVING AVG(saved_money) >= 1000;


-- 주문 테이블에서 각 주문고객이 주문한 제품의 총 주문수량을 주문제품별로 검색하시오.
-- SELECT 옆에 Group By 된 대상을 작성하여 가독성을 높여준다.
SELECT customer_id, product_no, SUM(quantity) AS "총 주문수량"
  FROM porder
 GROUP BY customer_id, product_no;


-- 주문수를 추가하여 가독성 향상 가능
SELECT customer_id, product_no, COUNT(*) AS "주문수", SUM(quantity) AS "총 주문수량"
  FROM porder
 GROUP BY customer_id, product_no;
 

-- 조인(join) 검색
-- banana 고객이 주문한 제품의 이름을 검색하시오.
SELECT product.product_name
  FROM product, porder -- 테이블이 여러개라면, 어떤 테이블이 필요하지?
 WHERE product.product_no = porder.product_no -- 조인 조건, 테이블이 2개 ~ 조인 조건 1개
   AND customer_id = 'banana';
   
   
-- 나이가 30세 이상인 고객이 주문한 제품의 주문제품번호와 주문일자를 검색하시오.
SELECT porder.product_no AS "주문 제품 번호", porder.order_date AS "주문일자"
  FROM customer, porder
 WHERE customer.customer_id = porder.customer_id
   AND age >= 30;

-- 두개의 테이블에서 각 테이블에만 존재하는 attribute의 경우, 구분되어 생략이 가능 
SELECT product_no AS "주문 제품 번호", order_date AS "주문일자"
  FROM customer, porder
 WHERE customer.customer_id = porder.customer_id
   AND age >= 30;


-- 별칭 지정 이전, 가독성이 떨어짐
SELECT customer.customer_id, porder.product_no AS "주문 제품 번호", porder.order_date AS "주문일자"
  FROM customer, porder
 WHERE customer.customer_id = porder.customer_id
   AND age >= 30;

-- 테이블의 별칭 지정, 별칭 규칙이 정해진것은 없음 
SELECT C.customer_id, PO.product_no AS "주문 제품 번호", PO.order_date AS "주문일자"
  FROM customer C, porder PO
 WHERE C.customer_id = PO.customer_id
   AND age >= 30;


-- 고명석 고객이 주문한 제품의 제품명을 검색하시오.
SELECT product_name
  FROM customer C, porder PO, product PR 
 WHERE C.customer_id = PO.customer_id AND PO.product_no = PR.product_no -- 조인 조건
   AND customer_name = '고명석';

-- 셀프 조인(자체 조인) 

ALTER TABLE customer
  ADD recommender VARCHAR(20);

ALTER TABLE customer
  ADD CONSTRAINT chk_recommender
      FOREIGN KEY (recommender) REFERENCES customer(customer_id);

UPDATE customer
   SET recommender = 'orange'
 WHERE customer_id = 'apple';

-- 고객의 이름과 추천 고객 이름을 검색하시오.

SELECT C.customer_name AS "고객 이름", R.customer_name AS "추천 고객 이름"
  FROM customer C, customer R
 WHERE C.recommender = R.customer_id;


-- 이후 실습을 위한 정리
-- 역순으로 진행

ALTER TABLE customer
 DROP CONSTRAINT chk_recommender;
 
ALTER TABLE customer
 DROP COLUMN recommender;


-- INNER JOIN / OUTER JOIN

SELECT C.customer_id, PO.product_no AS "주문 제품 번호", PO.order_date AS "주문일자"
  FROM customer C, porder PO
 WHERE C.customer_id = PO.customer_id -- 조인 조건
   AND age >= 30;

SELECT C.customer_id, PO.product_no AS "주문 제품 번호", PO.order_date AS "주문일자"
  FROM customer C INNER JOIN porder PO ON C.customer_id = PO.customer_id
   AND age >= 30; 


-- 주문한 적이 없는 고객은 출력되지 않음 ~ peach
SELECT C.customer_id, PO.product_no AS "주문 제품 번호", PO.order_date AS "주문일자"
  FROM customer C INNER JOIN porder PO ON C.customer_id = PO.customer_id;


-- OUTER JOIN ~ LEFT or RIGHT 도 가능하지만 수업에서는 RIGHT는 따로 다루지 않음.
SELECT C.customer_id, PO.product_no AS "주문 제품 번호", PO.order_date AS "주문일자"
  FROM customer C LEFT OUTER JOIN porder PO ON C.customer_id = PO.customer_id;


-- 부속 질의문(sub query)
-- 달콤 비스킷을 생산한 제조업체가 만든 제품의 제품명과 단가를 검색하시오.


-- 아래는 절차적으로 실행하는 과정.
-- 1. 달콤 비스킷을 생산한 제조업체를 알아낸다.
SELECT manufacturer
  FROM product
 WHERE product_name = '달콤비스킷';

-- 2. 한밭제과가 제조한 제품의 제품명과 단가를 검색하시오.
SELECT product_name, unit_price
  FROM product
 WHERE manufacturer = '한밭제과';

-- 부속 질의문 완성
-- () 내부에 있는 것을 sub query, 즉 부속 질의라고 부름
-- () 내부의 질의 결과가 여러 개의 값을 반환한다면 `=`를 사용할 수 없음.
-- 즉, () 내부의 질의 결과는 하나의 값을 반환해야함
SELECT product_name, unit_price
  FROM product
 WHERE manufacturer = (SELECT manufacturer
                         FROM product
                        WHERE product_name = '달콤비스킷');

-- banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오.
-- 1. banana 고객이 주문한 제품의 제품번호를 검색하시오.
-- 반환되는 결과의 값이 여러개
SELECT product_no
  FROM porder
 WHERE customer_id = 'banana'; -- 'p06', 'p01', 'p04'
 
-- 2. 해당 제품번호의 제품명과 제조업체를 검색하시오
SELECT product_name AS "제품명", manufacturer AS "제조업체"
  FROM product
 WHERE product_no IN ('p06', 'p01', 'p04');
 
-- 부속 질의문 완성
SELECT product_name AS "제품명", manufacturer AS "제조업체"
  FROM product
 WHERE product_no IN (SELECT product_no
                        FROM porder
                       WHERE customer_id = 'banana');

-- 반대의 경우 / banana 고객이 주문한 제품이 아닌 제품명과 제조업체를 검색하시오.
SELECT product_name AS "제품명", manufacturer AS "제조업체"
  FROM product
 WHERE product_no NOT IN (SELECT product_no
                        FROM porder
                       WHERE customer_id = 'banana');
 

-- 적립금이 가장 많은 고객의 고객이름과 적립금을 검색하시오.
SELECT MAX(saved_money)
  FROM customer; -- 5000


SELECT customer_name
  FROM customer
 WHERE saved_money = (SELECT MAX(saved_money)
                        FROM customer);
 
-- 대한식품이 제조한 모든 제품의 단가보다
-- 비싼 제품의 제품명, 단가, 제조업체를 검색하시오.
-- ALL 키워드 사용

-- 1. 대한식품이 제조한 모든 제품의 단가 검색
SELECT unit_price
  FROM product
 WHERE manufacturer = '대한식품';

-- 2. 아래와 같이 작성하면 한가지 반환값에 대해서만 해결이 가능.
-- 에러
SELECT product_name, unit_price, manufacturer
  FROM product
 WHERE unit_price > (SELECT unit_price
                       FROM product
                      WHERE manufacturer = '대한식품');
                      
-- 다음과 같이 ALL 키워드 사용
SELECT product_name, unit_price, manufacturer
  FROM product
 WHERE unit_price > ALL (SELECT unit_price
                           FROM product
                          WHERE manufacturer = '대한식품');

-- 상관 중첩 질의(correlated nested query)
-- 내부에있는 sub query가 바깥에 있는 정보를 끌어다 사용중임
-- "외부와 내부가 연결 되어있다"
-- 해당 상관 중첩 질의는 외부(바깥)부터 실행하게됨.
-- 기존에는 내부부터 실행되는 구조
-- 내부 구현 순서대로 따라가보면,
-- customer의 customer_name의 처음인 apple을 pick
-- AND에서 apple = apple 로 검색 진행되는 것
-- EXISTS 키워드는 수행한 경우 결과가 있는지 확인하는 것

SELECT customer_name
  FROM customer
 WHERE EXISTS (
    SELECT *
      FROM porder
     WHERE order_date = '22/03/15'
       AND porder.customer_id = customer.customer_id);


-- banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오.
-- 다음과 같이 다양한 방법으로 작성 가능

-- 1.
SELECT PR.product_name, PR.manufacturer
  FROM product PR, porder PO
 WHERE PR.product_no = PO.product_no 
   AND PO.customer_id = 'banana';

-- 2.
SELECT product_name AS "제품명", manufacturer AS "제조업체"
  FROM product
 WHERE product_no IN (SELECT product_no
                        FROM porder
                       WHERE customer_id = 'banana');

-- 3. 
-- 이 방법은 UPDATE 등에 활용 되므로 꼭 기억할 것
SELECT product_name, manufacturer
  FROM product
 WHERE EXISTS (
    SELECT *
      FROM porder
     WHERE product.product_no = porder.product_no
       AND porder.customer_id = 'banana');

-- UNION = 합집합
-- UNION은 DISTINCT가 Default 값
-- 집합 연산은 기본적으로 중복을 제거
-- 고객 테이블에서 나이가 아직 입력되지 않은 고객의 이름을 검색하시오.

SELECT customer_name
  FROM customer
 WHERE age IS NULL
UNION
SELECT customer_name
  FROM customer
 WHERE customer_id LIKE '_____';

-- 중복을 제거하지 X
SELECT customer_name
  FROM customer
 WHERE age IS NULL
UNION ALL
SELECT customer_name
  FROM customer
 WHERE customer_id LIKE '_____';

-- UNION과 UNION ALL은 성능차이가 존재 ALL의 경우가 중복을 제거하므로, 성능이 더 좋음
-- 따라서 이 경우는 값이 절대로 중복되지 않는다는 것을 안다면 사용

-- 삽입
INSERT INTO customer
VALUES ('strawberry', '최유경', 30, 'vip', '공무원', 100);

-- 잘 사용하지 않음
INSERT INTO customer
VALUES ('strawberry2', '최유경', NULL, 'vip', NULL, 100);

-- 가장 많이 사용하는 방법
-- INSERT문에 입력되는 확실한 정보를 보여주는 것
INSERT INTO customer(customer_id, customer_name, grade)
VALUES ('strawberry3', '최유경', 'vip');


-- 수정
-- 제품 테이블에서 제품번호가 'p03'인 제품의 제품명을 '통큰파이'로 수정하시오.
-- 검색을 먼저하는 것이 좋음.

SELECT *
  FROM product
 WHERE product_no = 'p03';

UPDATE product
   SET product_name = '통큰파이' -- 고칠 내용
 WHERE product_no = 'p03';
 
SELECT *
  FROM product;


-- 제품의 단가를 10% 인상하시오.
SELECT * FROM product;

-- WHERE를 작성하지 않으면, 모두를 대상으로 진행
UPDATE product
   SET unit_price = unit_price * 1.1;


-- 정소화 고객이 주문한 제품의 주문 수량을 5개로 지정하시오.
SELECT porder.*
  FROM customer, porder
 WHERE customer.customer_id = porder.customer_id
   AND customer.customer_name = '정소화';

-- 부속 질의 검색
-- = 을 사용하는 것보다 IN을 활용하는 것이 좋음.
-- IN을 활용하면 에러가 발생하지 않음.
SELECT customer_id
  FROM customer
 WHERE customer_name = '정소화';

SELECT *
  FROM porder
 WHERE customer_id IN (SELECT customer_id
                        FROM customer
                       WHERE customer_name = '정소화');

UPDATE porder
   SET quantity = 5
 WHERE customer_id IN (SELECT customer_id
                        FROM customer
                       WHERE customer_name = '정소화');

-- 삭제
-- FROM절에는 한가지가 들어가야함.
-- 조건없이 삭제하는 것은 "매 우" 위험함.
-- 주문일자가 2022년 5월 22일인 주문 내역을 삭제하시오.
-- 주문일자는 2022-05-22로 작성해야지 "다른 도구"에서 에러가 발생하지 않음.
SELECT *
  FROM porder
 WHERE order_date = '22/05/22'; -- 2022-05-22

DELETE 
  FROM porder
 WHERE order_date = '22/05/22'; -- 2022-05-22 

-- 정소화 고객이 주문한 주문내역을 검색하시오.
DELETE
  FROM porder
 WHERE customer_id IN (SELECT customer_id
                        FROM customer
                       WHERE customer_name = '정소화');




SELECT * FROM porder;


