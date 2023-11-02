-- 고객 아이디 속성이 기본키 / 기본키는 NOT NULL
-- 고객 이름과 등급은 반드시 값이 있어야함
-- 적립금 속성은 값을 입력하지 않으면 0이 기본으로 입력

CREATE TABLE customer1 (
    customer_id     VARCHAR2(20) NOT NULL,
    customer_name   VARCHAR2(20) NOT NULL,
    age             NUMBER,
    grade           VARCHAR2(20) NOT NULL,
    job_title       VARCHAR2(20),
    saved_money     NUMBER DEFAULT 0,
    PRIMARY KEY     ( customer_id )
);


-- 제품 테이블(relation)건
-- 제품 테이블의 속성(attribute)은 제품번호, 제품명, 재고량, 단가, 제조업체로 구성
-- 기본키는 제품번호 속성(attribute)
-- 제약 조건 : 재고량은 0 이상 10,000 이하를 유지

CREATE TABLE product1(
    product_no      VARCHAR2(20) NOT NULL,
    product_name    VARCHAR2(20) NOT NULL,
    stock           NUMBER       NOT NULL,
    unit_price      NUMBER       NOT NULL,
    manufacturer    VARCHAR2(20) NOT NULL,
    PRIMARY KEY     ( product_no ),
    CHECK           ( stock >=0 AND stock <= 10000)
);


-- 주문 테이블
-- 주문 테이블은 주문번호, 주문고객, 주문제품, 수량, 배송지, 주문일자로 구성
-- 주문 번호 속성(attribute)이 기본 키
-- 주문 고객 속성은 고객 테이블의 고객 아이디를 참조하는 외래키
-- 주문 제품 속성은 제품 테이블의 제품번호를 참조하는 외래키

CREATE TABLE porder1(
    order_no        VARCHAR2(20) NOT NULL,
    customer_id     VARCHAR2(20) NOT NULL,
    product_no      VARCHAR2(20) NOT NULL,
    quantity        NUMBER       NOT NULL,
    destination     VARCHAR2(35) NOT NULL,
    order_date      DATE         NOT NULL,
    PRIMARY KEY     ( order_no ),
    FOREIGN KEY     ( customer_id ) REFERENCES customer1 ( customer_id ),
    FOREIGN KEY     ( product_no )  REFERENCES product1  ( product_no )
);


-- 배송 업체 테이블
-- 업체번호/company_no, 업체명/company_name 주소/address, 전화번호/telephone 속성으로 구성
-- 업체번호/company_no 속성이 기본키

CREATE TABLE shipping_company1(
    company_no      VARCHAR2(5)     NOT NULL,
    company_name    VARCHAR2(2)     NOT NULL,
    address         VARCHAR2(100)   NOT NULL,
    telephone       NUMBER          NOT NULL,
    PRIMARY KEY     ( company_no )
);


SELECT *
  FROM customer1;

-- 속성 추가
-- 고객 테이블에 가입 날짜를 추가
ALTER TABLE customer1 ADD join_date DATE;


-- 속성 삭제
-- 고객 테이블의 가입 날짜 속성을 삭제
ALTER TABLE customer1 DROP COLUMN join_date;


-- 제약 조건 추가
-- 고객 테이블에 20세이상의 고객만 가입할 수 있다는 데이터 무결성 제약 조건을 추가
ALTER TABLE customer1 ADD CONSTRAINT chk_age CHECK (age >= 20);


-- 기존 제약 조건 삭제
-- 고객 테이블에 20세 이상의 고객만 가입할 수 있다는 데이터 무결성 제약 조건을 삭제
ALTER TABLE customer1 DROP CONSTRAINT chk_age;


-- 테이블 삭제
-- 참조하는 테이블을 먼저 삭제
-- 삭제는 생성의 역순으로 진행
-- 배송업체 테이블을 삭제
DROP TABLE shipping_company1;

DROP TABLE porder1;

DROP TABLE product1;

DROP TABLE customer1;


-- 테이블 생성 확인
SELECT *
  FROM customer1;

SELECT *
  FROM product1;

SELECT *
  FROM porder1;


-- -------------------------------------------------------------------------------------
-- --------------------------------- 예제 데이터 생성 ----------------------------------
-- -------------------------------------------------------------------------------------

INSERT INTO customer1 (customer_id, customer_name, age, grade, job_title, saved_money)
VALUES ('apple', '정소화', 20, 'gold', '학생', 1000);
INSERT INTO customer1 (customer_id, customer_name, age, grade, job_title, saved_money)
VALUES ('banana', '김선우', 25, 'vip', '간호사', 2500);
INSERT INTO customer1 (customer_id, customer_name, age, grade, job_title, saved_money)
VALUES ('carrot', '고명석', 28, 'gold', '교사', 4500);
INSERT INTO customer1 (customer_id, customer_name, age, grade, job_title, saved_money)
VALUES ('orange', '김용욱', 22, 'silver', '학생', 0);
INSERT INTO customer1 (customer_id, customer_name, age, grade, job_title, saved_money)
VALUES ('melon', '성원용', 35, 'gold', '회사원', 5000);
INSERT INTO customer1 (customer_id, customer_name, age, grade, job_title, saved_money)
VALUES ('peach', '오형준', NULL, 'silver', '의사', 300);
INSERT INTO customer1 (customer_id, customer_name, age, grade, job_title, saved_money)
VALUES ('pear', '채광주', 31, 'silver', '회사원', 500);

INSERT INTO product1 (product_no, product_name, stock, unit_price, manufacturer)
VALUES ('p01', '그냥만두', 5000, 4500, '대한식품');
INSERT INTO product1 (product_no, product_name, stock, unit_price, manufacturer)
VALUES ('p02', '매운쫄면', 2500, 5500, '민국푸드');
INSERT INTO product1 (product_no, product_name, stock, unit_price, manufacturer)
VALUES ('p03', '쿵떡파이', 3600, 2600, '한밭제과');
INSERT INTO product1 (product_no, product_name, stock, unit_price, manufacturer)
VALUES ('p04', '맛난초콜릿', 1250, 2500, '한밭제과');
INSERT INTO product1 (product_no, product_name, stock, unit_price, manufacturer)
VALUES ('p05', '얼큰라면', 2200, 1200, '대한식품');
INSERT INTO product1 (product_no, product_name, stock, unit_price, manufacturer)
VALUES ('p06', '통통우동', 1000, 1550, '민국푸드');
INSERT INTO product1 (product_no, product_name, stock, unit_price, manufacturer)
VALUES ('p07', '달콤비스킷', 1650, 1500, '한밭제과');

INSERT INTO porder1 (order_no, customer_id, product_no, quantity, destination, order_date)
VALUES ('o01', 'apple', 'p03', 10, '서울시 마포구', TO_DATE('20220101','YYYYMMDD'));
INSERT INTO porder1 (order_no, customer_id, product_no, quantity, destination, order_date)
VALUES ('o02', 'melon', 'p01', 5, '인천시 계양구', '2022-01-10');
INSERT INTO porder1 (order_no, customer_id, product_no, quantity, destination, order_date)
VALUES ('o03', 'banana', 'p06', 45, '경기도 부천시', '2022-01-11');
INSERT INTO porder1 (order_no, customer_id, product_no, quantity, destination, order_date)
VALUES ('o04', 'carrot', 'p02', 8, '부산시 금정구', '2022-02-01');
INSERT INTO porder1 (order_no, customer_id, product_no, quantity, destination, order_date)
VALUES ('o05', 'melon', 'p06', 36, '경기도 용인시', '2022-02-20');
INSERT INTO porder1 (order_no, customer_id, product_no, quantity, destination, order_date)
VALUES ('o06', 'banana', 'p01', 19, '충청북도 보은군', '2022-03-02');
INSERT INTO porder1 (order_no, customer_id, product_no, quantity, destination, order_date)
VALUES ('o07', 'apple', 'p03', 22, '서울시 영등포구', '22/03/15');
INSERT INTO porder1 (order_no, customer_id, product_no, quantity, destination, order_date)
VALUES ('o08', 'pear', 'p02', 50, '강원도 춘천시', '22/04/10');
INSERT INTO porder1 (order_no, customer_id, product_no, quantity, destination, order_date)
VALUES ('o09', 'banana', 'p04', 15, '전라남도 목포시', '22/04/11');
INSERT INTO porder1 (order_no, customer_id, product_no, quantity, destination, order_date)
VALUES ('o10', 'carrot', 'p03', 20, '경기도 안양시', '22/05/22');

--INSERT INTO porder
--VALUES ('o01', 'apple', 'p03', 10, '서울시 마포구', TO_DATE('20220101', 'YYYYMMDD'));
--INSERT INTO porder
--VALUES ('o02', 'melon', 'p01', 5, '인천시 계양구', TO_DATE('20220110', 'YYYYMMDD'));
--INSERT INTO porder
--VALUES ('o03', 'banana', 'p06', 45, '경기도 부천시', TO_DATE('20220111', 'YYYYMMDD'));
--INSERT INTO porder
--VALUES ('o04', 'carrot', 'p02', 8, '부산시 금정구', TO_DATE('20220201', 'YYYYMMDD'));
--INSERT INTO porder
--VALUES ('o05', 'melon', 'p06', 36, '경기도 용인시', TO_DATE('20220220', 'YYYYMMDD'));
--INSERT INTO porder
--VALUES ('o06', 'banana', 'p01', 19, '충청북도 보은군', TO_DATE('20220302', 'YYYYMMDD'));
--INSERT INTO porder
--VALUES ('o07', 'apple', 'p03', 22, '서울시 영등포구', TO_DATE('20220315', 'YYYYMMDD'));
--INSERT INTO porder
--VALUES ('o08', 'pear', 'p02', 50, '강원도 춘천시', TO_DATE('20220410', 'YYYYMMDD'));
--INSERT INTO porder
--VALUES ('o09', 'banana', 'p04', 15, '전라남도 목포시', TO_DATE('20220411', 'YYYYMMDD'));
--INSERT INTO porder
--VALUES ('o10', 'carrot', 'p03', 20, '경기도 안양시', TO_DATE('20220522', 'YYYYMMDD'));

COMMIT;

SELECT *
  FROM customer1;
  
SELECT *
  FROM product1;
  
SELECT *
  FROM porder1;


-- 데이터 검색 SELECT

-- 기본 검색
-- 고객 테이블에서 고객 아이디, 고객 이름, 등급 속성을 검색
SELECT customer_id, customer_name, grade
  FROM customer1;


-- 고객 테이블에서 모든 속성을 검색
SELECT *
  FROM customer1;


-- 제품 테이블에서 제조 업체를 검색
SELECT manufacturer
  FROM product1;


-- 제품 테이블에서 제조 업체를 검색하되, ALL 키워드를 사용
-- 결과 테이블에서 제조업체가 중복됨
-- ALL은 생략 가능
SELECT ALL manufacturer
  FROM product1;


-- 제품 테이블에서 제조업체 속성 중복 없이 검색
-- 중복 없이 검색은 DISTINCT 사용
-- 성능이 떨어질 수 있으므로 목적이 있는 경우 사용
SELECT DISTINCT manufacturer
  FROM product1;
  
  
-- 제품 테이블에서 제품명과 단가를 검색하되, 단가를 가격이라는 새 이름으로 출력
-- 큰 따옴표로 묶어주는 것이 띄어쓰기가 포함된 문장에 좋음
SELECT product_name AS "제품명", unit_price AS "가격"
  FROM product1;


-- AS 키워드는 생략 가능
SELECT product_name 제품명, unit_price 가격
  FROM product1;
  
  
-- 제품 테이블에서 제품명과 단가 속성을 검색
-- 단가에 500원을 더해 "조정 단가"라는 새이름으로 출력
SELECT product_name AS "제품명", unit_price + 500 AS "조정 단가"
  FROM product1;
  

-- 조건 검색
-- 한밭 제과가 제조한 제품의 제품명, 재고량, 단가를 검색
SELECT product_name AS "제품명", stock AS "재고량", unit_price AS "단가"
  FROM product1
 WHERE manufacturer = '한밭제과';


-- apple 고객이 15개 이상 주문한 주문 제품, 수량, 주문일자를 검색
SELECT product_no AS "주문 제품", quantity AS "수량", order_date AS "주문일자"
  FROM porder1
 WHERE quantity >= 15 AND customer_id = 'apple';
  
  
-- apple 고객이 주문했거나, 15개 이상 주문된 주문 제품, 수량, 주문 일자를 검색
SELECT product_no AS "주문 제품", quantity AS "수량", order_date AS "주문 일자"
  FROM porder1
 WHERE customer_id = 'apple'
    OR quantity >= 15;


-- apple 고객이 아닌 고객이 15개 이상 주문한 주문 제품, 수량, 주문 일자를 검색
SELECT customer_id, product_no, quantity, order_date
  FROM porder1
 WHERE NOT customer_id = 'apple'
   AND quantity >= 15;

SELECT customer_id, product_no, quantity, order_date
  FROM porder1
 WHERE customer_id != 'apple'
   AND quantity >= 15;  
  
  
-- 단가가 2000원 이상이면서 3000원 이하인 제품의 제품명, 단가, 제조업체를 검색
SELECT product_name, unit_price, manufacturer
  FROM product1
 WHERE unit_price >= 2000
   AND unit_price <= 3000;

SELECT product_name, unit_price, manufacturer
  FROM product1
 WHERE unit_price BETWEEN 2000 AND 3000;


-- LIKE를 이용한 검색
-- 김선우 고객에 대한 고객명, 나이, 등급, 적립금을 검색
SELECT customer_name, age, grade, saved_money
  FROM customer1
 WHERE customer_name = '김선우';


-- 성이 김씨인 고객의 고객이름, 나이, 등급, 적립금을 검색
SELECT customer_name, age, grade, saved_money
  FROM customer1
 WHERE customer_name LIKE '김%';
 

-- 고객아이디가 5자인 고객의 고객아이디, 고객 이름, 등급을 검색
SELECT customer_id, customer_name, grade
  FROM customer1
 WHERE customer_id LIKE '_____';


INSERT INTO customer1 (customer_id, customer_name, age, grade, job_title, saved_money)
VALUES ('test', '김군', 20, 'silver', 'tester', 10);

INSERT INTO customer1 (customer_id, customer_name, age, grade, job_title, saved_money)
VALUES ('test2', '최군', 20, 'silver', 'tester', 10);


-- 김씨 성을 가진 고객 중 이름이 2글자인 고객명, 나이, 등급, 적립금을 검색
SELECT customer_name, age, grade, saved_money
  FROM customer1
 WHERE customer_name LIKE '김_';

DELETE 
  FROM customer1
 WHERE customer_name = '김군' OR customer_name = '최군';


-- NULL을 이용한 검색
-- 나이가 입력되지 않은 고객의 고객 이름을 검색
SELECT customer_name
  FROM customer1
 WHERE age IS NULL;
 

-- 나이가 입력된 고객의 고객 이름을 검색
SELECT customer_name
  FROM customer1
 WHERE age IS NOT NULL;


-- 정렬 검색
-- 기본적인 검색은 동일
-- 이름, 등급, 나이를 검색
SELECT customer_name AS 이름, grade AS 등급, age AS 나이
  FROM customer1;
  

-- 고객이름, 등급, 나이를 검색하되, 나이를 기준으로 내림차순으로 정렬
SELECT customer_name, grade, age
  FROM customer1
 ORDER BY age DESC;


-- 고객이름, 등급, 나이를 검색해되, 나이를 기준으로 오름차순으로 정렬
SELECT customer_name, grade, age
  FROM customer1
 ORDER BY age ASC;


-- 수량이 10개 이상인 주문의 고객아이디, 제품번호, 수량, 주문일자를 검색
SELECT customer_id, product_no, quantity, order_date
  FROM porder1
 WHERE quantity >= 10;


-- 수량이 10개 이상인 주문의 고객아이디, 제품번호, 수량, 주문일자를 검색
-- 제품번호를 기준으로 정렬
SELECT customer_id, product_no, quantity, order_date
  FROM porder1
 WHERE quantity >=10
 ORDER BY product_no ASC;


-- 수량이 10개 이상인 주문의 고객아이디, 제품번호, 수량, 주문일자를 검색
-- 제품번호를 기준으로 정렬
-- 수량을 기준으로 내림차순 정렬
SELECT customer_id, product_no, quantity, order_date
  FROM porder1
 WHERE quantity >= 10
 ORDER BY product_no ASC, quantity DESC;


-- 집계 함수 / aggregate function

-- 제품 테이블에서 모든 제품의 단가를 검색
SELECT *
  FROM product1;
  
  
-- 제품 테이블에서 모든 제품의 평균 단가를 검색
SELECT AVG (unit_price)
  FROM product1;
  

-- 한밭제과에서 제조한 제품의 재고량을 검색
SELECT stock
  FROM product1
 WHERE manufacturer = '한밭제과';


-- 한밭제과에서 제조한 제품의 재고량 합계를 검색
SELECT SUM (stock) AS "재고량"
  FROM product1
 WHERE manufacturer = '한밭제과';


-- COUNT 사용하기
-- 고객 테이블에 고객이 몇 명 등록되어 있는지 검색
-- 고객아이디 속성 이용
SELECT COUNT (customer_id) AS "고객수"
  FROM customer1;
  

-- 나이 속성 이용
-- 집계 함수에서 NULL은 COUNT 대상이 아님
SELECT COUNT (age) AS "고객수"
  FROM customer1;


-- * 이용
SELECT COUNT (*) AS "고객수"
  FROM customer1;


-- 전체 DB를 보는 것으로 오래걸리나? 싶지만,
-- 알아서 효율적으로 검색 진행 -> 더 좋은 선택
SELECT COUNT(*) AS "고객수"
  FROM customer1;


-- 제조 업체 이름을 검색
SELECT manufacturer
  FROM product1;
  
-- 제조 업체 수를 검색
SELECT COUNT (manufacturer)
  FROM product1;


-- 제조 업체 수를 검색 (중복 제거)
SELECT COUNT (DISTINCT manufacturer)
  FROM product1;


-- 고객들의 평균 나이와, 가장 어린 나이, 가장 많은 나이를 검색
SELECT AVG (age), MIN (age), MAX (age)
  FROM customer1;


-- 주문 테이블에서 주문 수량의 합계를 검색
SELECT SUM (quantity)
  FROM porder1;


-- 그룹별 검색
-- 주문 테이블에서 주문 제품별 주문 수량의 합계를 검색
SELECT product_no, SUM (quantity)
  FROM porder1
 GROUP BY product_no;


-- 제품 테이블에서 제조업체별로 제조한 제품의 개수와 가장 비싼 단가를 검색
SELECT manufacturer, COUNT (product_name), MAX (unit_price)
  FROM product1
 GROUP BY manufacturer;
 

-- 제조업체별로 제조한 제품의 개수와 가장 단가가 높은 제품의 단가를 검색하시오.
-- 단, 제품을 3개 이상 제조한 제조업체만
-- HAVING은 GroupBy를 위한 전용 조건
SELECT manufacturer, COUNT (product_name), MAX (unit_price)
  FROM product1
 GROUP BY manufacturer
 HAVING COUNT(*) >= 3;


-- 고객 테이블에서 적립금 평균이 1000원 이상인 등급에 대해
-- 등급별 고객수와 적립금 평균을 검색
SELECT grade, COUNT(*), AVG(saved_money)
  FROM customer1
 GROUP BY grade
 HAVING AVG(saved_money) >= 1000;


-- 주문 테이블에서 각 주문고객이 주문한 제품의 총 주문수량을 주문제품별로 검색하시오.
-- SELECT 옆에 Group By 된 대상을 작성하여 가독성을 높여준다.
SELECT customer_id, product_no, SUM(quantity)
  FROM porder1
 GROUP BY customer_id, product_no;


-- 주문 테이블에서 각 주문고객이 주문한 제품의 총 주문수량을 주문제품별로 검색하시오.
-- 주문수를 추가하여 가독성 향상 가능
SELECT customer_id, product_no, SUM (quantity) AS "총 주문수량", COUNT(*) AS "주문수"
  FROM porder1
 GROUP BY customer_id, product_no;
 

-- 조인(join) 검색
-- banana 고객이 주문한 제품의 이름을 검색
SELECT product1.product_name
  FROM porder1, product1
 WHERE customer_id = 'banana'
   AND porder1.product_no = product1.product_no;


-- 나이가 30세 이상인 고객이 주문한 제품의 주문제품번호와 주문일자를 검색
SELECT porder1.product_no, porder1.order_date
  FROM customer1, porder1
 WHERE customer1.customer_id = porder1.customer_id
   AND customer1.age >= 30;


-- 나이가 30세 이상인 고객이 주문한 제품의 주문제품번호와 주문일자를 검색
-- 두개의 테이블에서 각 테이블에만 존재하는 attribute의 경우, 구분되어 생략이 가능
SELECT product_no, order_date
  FROM customer1, porder1
 WHERE customer1.customer_id = porder1.customer_id
   AND customer1.age >= 30;


-- 나이가 30세 이상인 고객이 주문한 제품의 주문제품번호와 주문일자를 검색
-- 테이블의 별칭 지정, 졀칭 규칙이 정해진것은 없음
SELECT B.product_no, B.order_date
  FROM customer1 A, porder1 B
 WHERE A.customer_id = B.customer_id
   AND A.age >= 30;


-- 고명석 고객이 주문한 제품의 제품명을 검색하시오.
SELECT C.product_name
  FROM customer1 A, porder1 B, product1 C
 WHERE A.customer_id = B.customer_id
   AND B.product_no = C.product_no
   AND A.customer_name = '고명석';


-- 셀프 조인(자체 조인)

ALTER TABLE customer1
  ADD recommender VARCHAR2(20);

ALTER TABLE customer1
  ADD CONSTRAINT chk_recommender
      FOREIGN KEY  ( recommender ) REFERENCES customer ( customer_id );

UPDATE customer1
   SET recommender = 'orange'
 WHERE customer_id = 'apple';

SELECT *
  FROM customer1;

-- 고객의 이름과 추천 고객 이름을 검색
SELECT A.customer_name, B.customer_name
  FROM customer1 A, customer1 B
 WHERE A.recommender = B.customer_id;


-- 역순으로 정리
ALTER TABLE customer1
 DROP CONSTRAINT chk_recommender;
 
ALTER TABLE  customer1
 DROP COLUMN recommender;


-- INNER JOIN / OUTER JOIN

-- 나이가 30세 이상인 고객이 주문한 제품의 주문제품과 주문일자를 검색
SELECT B.product_no, B.order_date
  FROM customer1 A, porder1 B
 WHERE A.customer_id = B.customer_id
   AND A.age >= 30;


-- 나이가 30세 이상인 고객이 주문한 제품의 주문제품과 주문일자를 검색
SELECT B.product_no, B.order_date
  FROM customer1 A INNER JOIN porder1 B ON A.customer_id = B.customer_id
 WHERE A.age >= 30;
 

-- 주문한 적이 없는 고객은 출력되지 않음
SELECT A.customer_id, B.product_no, B.order_date
  FROM customer1 A INNER JOIN porder1 B ON A.customer_id = B
  .customer_id;


-- OUTER JOIN ~ LEFT or RIGHT 도 가능
SELECT A.customer_id, B.product_no, B.order_date
  FROM customer1 A LEFT OUTER JOIN porder1 B ON A.customer_id = B.customer_id;

SELECT A.customer_id, B.product_no, B.order_date
  FROM customer1 A RIGHT OUTER JOIN porder1 B ON A.customer_id = B.customer_id;


-- 부속 질의문(sub query)
-- 달콤 비스킷을 생산한 제조업체가 만든 제품의 제품명과 단가를 검색하시오.


-- 아래는 절차적으로 실행하는 과정.
-- 1. 달콤비스킷을 생산한 제조업체를 검색
SELECT manufacturer
  FROM product1
 WHERE product_name = '달콤비스킷';


-- 2. 한밭제과가 제조한 제품의 제품명과 단가를 검색
SELECT product_name, unit_price
  FROM product1
 WHERE manufacturer = '한밭제과';


-- 부속 질의문 완성
SELECT product_name, unit_price
  FROM product1
 WHERE manufacturer = (SELECT manufacturer
                         FROM product1
                        WHERE product_name = '달콤비스킷');


-- banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오.
SELECT product_name, manufacturer
  FROM product1
 WHERE product_no IN (SELECT product_no
                        FROM porder1
                       WHERE customer_id = 'banana');


-- banana 고객이 주문한 제품이 아닌 제품명과 제조업체를 검색하시오.
SELECT product_name, manufacturer
  FROM product1
 WHERE product_no NOT IN (SELECT product_no
                        FROM porder1
                       WHERE customer_id = 'banana');


-- 적립금이 가장 많은 고객의 고객이름과 적립금을 검색
SELECT customer_name, saved_money
  FROM customer1
 WHERE saved_money = (SELECT MAX(saved_money)
                        FROM customer1);
                        
                        
-- 대한식품이 제조한 모든 제품의 단가보다
-- 비싼 제품의 제품명, 단가, 제조업체를 검색하시오.
-- ALL 키워드 사용

SELECT product_name, stock, manufacturer
  FROM product1
 WHERE unit_price > ALL (SELECT unit_price
                           FROM product1
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

-- 2022년 3월 15일에 제품을 주문한 고객의 고객이름을 검색
SELECT customer_name
  FROM customer1
 WHERE EXISTS ( SELECT *
                  FROM porder1
                 WHERE porder1.order_date = '2022-03-15' -- 22/03/15 
                   AND porder1.customer_id = customer1.customer_id );



-- banana 고객이 주문한 제품의 제품명과 제조업체를 검색
-- 1.
SELECT B.product_name, B.manufacturer
  FROM porder1 A, product1 B
 WHERE A.product_no = B.product_no
   AND A.customer_id = 'banana';

-- 2.
SELECT B.product_name, B.manufacturer
  FROM porder1 A INNER JOIN product1 B ON A.product_no = B.product_no
 WHERE A.customer_id = 'banana';
 

-- 3.
SELECT product_name, manufacturer
  FROM product1
 WHERE product_no IN (SELECT product_no
                       FROM porder
                      WHERE customer_id = 'banana');


-- 4.
SELECT product_name, manufacturer 
  FROM product1
 WHERE EXISTS ( SELECT *
                  FROM porder1
                 WHERE porder1.product_no = product1.product_no
                   AND porder1.customer_id = 'banana');


-- UNION = 합집합
-- UNION은 DISTINCT가 Default 값
-- 집합 연산은 기본적으로 중복을 제거
-- 고객 테이블에서 나이가 아직 입력되지 않은 고객의 이름
-- 고객아이디가 5자인 고객의 고객이름
SELECT customer_name
  FROM customer1
 WHERE age IS NULL
 UNION
SELECT customer_name
  FROM customer1
 WHERE customer_id LIKE '_____';


-- 중복을 제거하지 X
SELECT customer_name
  FROM customer1
 WHERE age IS NULL
 UNION ALL
SELECT customer_name
  FROM customer1
 WHERE customer_id LIKE '_____';

-- UNION과 UNION ALL은 성능차이가 존재
-- ALL은 중복을 제거하지 않으므로, 성능이 더 좋음
-- 따라서 ALL은 값이 절대로 중복되지 않는다는 것을 안다면 사용


-- 데이터 삽입
-- INSERT문에 입력되는 확실한 정보를 보여주는 것
INSERT INTO customer1 (customer_id, customer_name, grade, age, job_title)
VALUES ('strawberry', '최유경', 'gold', 25, 'DBA');


-- 데이터 수정
-- 제품 테이블에서 제품번호가 'p03'인 제품의 제품명을 '통큰파이'로 수정
-- 검색을 먼저하는 것이 좋음

SELECT product_name
  FROM product1 
 WHERE product_no = 'p03';

UPDATE product1
   SET product_name = '통큰파이'
 WHERE product_no = 'p03';


-- 제품의 단가를 10% 인상
UPDATE product1
   SET unit_price = unit_price * 1.1;

SELECT *
  FROM product1;


-- 정소화 고객이 주문한 제품의 주문 수량을 5개로 지정
SELECT B.*
  FROM customer1 A, porder1 B
 WHERE A.customer_id = B.customer_id
   AND A.customer_name = '정소화';

UPDATE porder1
   SET quantity = 5
 WHERE customer_id IN (SELECT customer_id
                         FROM customer1
                        WHERE customer_name = '정소화');


-- 삭제
-- FROM절에는 한가지가 들어가야함.
-- 조건없이 삭제하는 것은 "매 우" 위험함.
-- 주문일자가 2022년 5월 22일인 주문 내역을 삭제하시오.
-- 주문일자는 2022-05-22로 작성해야지 "다른 도구"에서 에러가 발생하지 않음.

DELETE 
  FROM porder1
 WHERE order_date = '2022-05-22';

-- 정소화 고객이 주문한 내역을 삭제
DELETE
  FROM porder1
 WHERE customer_id IN (SELECT customer_id
                         FROM customer1
                        WHERE customer_name = '정소화');











