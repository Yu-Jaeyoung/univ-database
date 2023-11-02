-- 테이블 생성하기

-- 고객 테이블
-- 고객 테이블은 고객아이디, 고객이름, 나이, 등급, 직업, 적립금으로 구성
-- 테이블 생성은 변경이 번거롭기 때문에 신중하게 작성
-- 고객 아이디 속성이 기본키이다.
-- 고객 이름과 등급은 반드시 값이 있어야 한다. -> NOT NULL, 고객 아이디는 기본키라 NOT NULL을 추가해줘야 한다.
-- 적립금 속성은 값을 입력하지 않으면 0이 기본으로 입력됨 -> DEFAULT 0

CREATE TABLE customer (
    customer_id   VARCHAR2(20) NOT NULL,
    customer_name VARCHAR2(10) NOT NULL,
    age           NUMBER,
    grade         VARCHAR2(10) NOT NULL,
    job_title     VARCHAR2(20),
    saved_money   NUMBER DEFAULT 0,
    PRIMARY KEY ( customer_id )
);

-- 제품 테이블
-- 제품 테이블은 제품번호, 제품명, 재고량, 단가, 제조업체로 구성
-- 제품번호 속성이 기본키이다.
-- 재약 조건: 재고량은 0 이상 10,000 이하를 유지함.

CREATE TABLE product (
    product_no   VARCHAR2(5) NOT NULL,
    product_name VARCHAR2(20) NOT NULL,
    stock        NUMBER,
    unit_price   NUMBER,
    manufacturer VARCHAR2(20),
    PRIMARY KEY ( product_no ),
    CHECK ( stock >= 0
            AND stock <= 10000 )
);

-- 주문 테이블
-- 주문 테이블은 주문번호, 주문고객, 주문제품, 수량, 배송지, 주문일자 속성으로 구성됨
-- 주문 번호 속성이 기본 키
-- 주문 고객 속성은 고객 테이블의 고객아이디를 참조하는 외래키이고,
-- 주문 제품 속성은 제품 테이블의 제품번호를 참조하는 외래키

CREATE TABLE porder (
    order_no    VARCHAR2(5) NOT NULL,
    customer_id VARCHAR2(20),
    product_no  VARCHAR2(5),
    quantity    NUMBER,
    destination VARCHAR2(30),
    order_date  DATE,
    PRIMARY KEY ( order_no ),
    FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id ),
    FOREIGN KEY ( product_no )
        REFERENCES product ( product_no )
);

-- 배송업체 테이블
CREATE TABLE shipping_company (
    company_no   VARCHAR2(5) NOT NULL,
    company_name VARCHAR2(20),
    address      VARCHAR2(100),
    telephone    VARCHAR2(20),
    PRIMARY KEY ( company_no )
);

-- 속성추가 / 삭제
ALTER TABLE customer ADD join_date DATE;

ALTER TABLE customer DROP COLUMN join_date;
   
-- 제약 조건 추가 / 삭제
ALTER TABLE customer ADD CONSTRAINT chk_age CHECK ( age >= 18 );

ALTER TABLE customer DROP CONSTRAINT chk_age;

-- 테이블 삭제
-- 참조하는 테이블을 먼저 삭제
-- 삭제는 생성의 역순으로 수행하는 것이 좋다.
DROP TABLE shipping_company;

DROP TABLE porder;

DROP TABLE product;

DROP TABLE customer;

-- 테이블 생성 확인
SELECT *
  FROM customer;

SELECT *
  FROM product;

SELECT *
  FROM porder;

-- 데이터 생성(입력)
INSERT INTO customer VALUES (
    'apple',
    '정소화',
    20,
    'gold',
    '학생',
    1000
);

INSERT INTO product VALUES (
    'p01',
    '그냥만두',
    5000,
    4500,
    '대한식품'
);

-- TO_DATE 사용하는 것이 원칙
INSERT INTO porder VALUES (
    'o01',
    'apple',
    'p01',
    10,
    '대전시 유성구',
    TO_DATE('20231004', 'YYYYMMDD')
);

INSERT INTO porder VALUES (
    'o02',
    'apple',
    'p01',
    10,
    '대전시 유성구',
    '23/10/04'
);


----------------------------------------------------------------------------


DROP TABLE porder;

DROP TABLE product;

DROP TABLE customer;

DROP TABLE shipping_company;


-- -------------------------------------------------------------------------------------
-- ----------------------------------- 테이블 생성 -------------------------------------
-- -------------------------------------------------------------------------------------

-- 고객 테이블은 고객아이디, 고객이름, 나이, 등급, 직업, 적립금 속성으로 구성되고,
-- 고객아이디 속성이 기본키다.
-- 고객이름과 등급 속성은 값을 반드시 입력해야 하고,
-- 적립금 속성은 값을 입력하지 않으면 0이 기본으로 입력된다.

CREATE TABLE customer (
    customer_id   VARCHAR2(20) NOT NULL, -- 고객아이디
    customer_name VARCHAR2(10) NOT NULL, -- 고객이름
    age           NUMBER,                -- 나이
    grade         VARCHAR2(10) NOT NULL, -- 등급
    job_title     VARCHAR2(20),          -- 직업
    saved_money   NUMBER DEFAULT 0,      -- 적립금
    PRIMARY KEY ( customer_id )
);


-- 제품 테이블은 제품번호, 제품명, 재고량, 단가, 제조업체 속성으로 구성되고,
-- 제품번호 속성이 기본키다.
-- 재고량이 항상 0개 이상 10,000개 이하를 유지한다.

CREATE TABLE product (
    product_no   VARCHAR2(5) NOT NULL, -- 제품번호
    product_name VARCHAR2(20),         -- 제품이름
    stock        NUMBER,               -- 재고량
    unit_price   NUMBER,               -- 단가
    manufacturer VARCHAR2(20),         -- 제조업체
    PRIMARY KEY ( product_no ),
    CHECK ( stock >= 0
            AND stock <= 10000 )
);


-- 주문 테이블은 주문번호, 주문고객, 주문제품, 수량, 배송지, 주문일자 속성으로 구성되고,
-- 주문번호 속성이 기본키다.
-- 주문고객 속성이 고객 테이블의 고객아이디 속성을 참조하는 외래키이고,
-- 주문제품 속성이 제품 테이블의 제품번호 속성을 참조하는 외래키이다.

CREATE TABLE porder (
    order_no    VARCHAR2(5) NOT NULL, -- 주문번호
    customer_id VARCHAR2(20),         -- 주문고객
    product_no  VARCHAR2(5),          -- 주문제품
    quantity    NUMBER,               -- 수량
    destination VARCHAR2(30),         -- 배송지
    order_date  DATE,                 -- 주문일자
    PRIMARY KEY ( order_no ),
    FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id ),
    FOREIGN KEY ( product_no )
        REFERENCES product ( product_no )
);


-- -------------------------------------------------------------------------------------
-- --------------------------------- 예제 데이터 생성 ----------------------------------
-- -------------------------------------------------------------------------------------

INSERT INTO customer VALUES (
    'apple',
    '정소화',
    20,
    'gold',
    '학생',
    1000
);

INSERT INTO customer VALUES (
    'banana',
    '김선우',
    25,
    'vip',
    '간호사',
    2500
);

INSERT INTO customer VALUES (
    'carrot',
    '고명석',
    28,
    'gold',
    '교사',
    4500
);

INSERT INTO customer VALUES (
    'orange',
    '김용욱',
    22,
    'silver',
    '학생',
    0
);

INSERT INTO customer VALUES (
    'melon',
    '성원용',
    35,
    'gold',
    '회사원',
    5000
);

INSERT INTO customer VALUES (
    'peach',
    '오형준',
    NULL,
    'silver',
    '의사',
    300
);

INSERT INTO customer VALUES (
    'pear',
    '채광주',
    31,
    'silver',
    '회사원',
    500
);

INSERT INTO product VALUES (
    'p01',
    '그냥만두',
    5000,
    4500,
    '대한식품'
);

INSERT INTO product VALUES (
    'p02',
    '매운쫄면',
    2500,
    5500,
    '민국푸드'
);

INSERT INTO product VALUES (
    'p03',
    '쿵떡파이',
    3600,
    2600,
    '한밭제과'
);

INSERT INTO product VALUES (
    'p04',
    '맛난초콜릿',
    1250,
    2500,
    '한밭제과'
);

INSERT INTO product VALUES (
    'p05',
    '얼큰라면',
    2200,
    1200,
    '대한식품'
);

INSERT INTO product VALUES (
    'p06',
    '통통우동',
    1000,
    1550,
    '민국푸드'
);

INSERT INTO product VALUES (
    'p07',
    '달콤비스킷',
    1650,
    1500,
    '한밭제과'
);

INSERT INTO porder VALUES (
    'o01',
    'apple',
    'p03',
    10,
    '서울시 마포구',
    TO_DATE('20220101', 'YYYYMMDD')
);

INSERT INTO porder VALUES (
    'o02',
    'melon',
    'p01',
    5,
    '인천시 계양구',
    '22/01/10'
);

INSERT INTO porder VALUES (
    'o03',
    'banana',
    'p06',
    45,
    '경기도 부천시',
    '22/01/11'
);

INSERT INTO porder VALUES (
    'o04',
    'carrot',
    'p02',
    8,
    '부산시 금정구',
    '22/02/01'
);

INSERT INTO porder VALUES (
    'o05',
    'melon',
    'p06',
    36,
    '경기도 용인시',
    '22/02/20'
);

INSERT INTO porder VALUES (
    'o06',
    'banana',
    'p01',
    19,
    '충청북도 보은군',
    '22/03/02'
);

INSERT INTO porder VALUES (
    'o07',
    'apple',
    'p03',
    22,
    '서울시 영등포구',
    '22/03/15'
);

INSERT INTO porder VALUES (
    'o08',
    'pear',
    'p02',
    50,
    '강원도 춘천시',
    '22/04/10'
);

INSERT INTO porder VALUES (
    'o09',
    'banana',
    'p04',
    15,
    '전라남도 목포시',
    '22/04/11'
);

INSERT INTO porder VALUES (
    'o10',
    'carrot',
    'p03',
    20,
    '경기도 안양시',
    '22/05/22'
);

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

SELECT
    *
FROM
    customer;

SELECT
    *
FROM
    product;

SELECT
    *
FROM
    porder;

-- 검색 명령(SELECT) --

-- 기본 검색
-- 고객 테이블에서 고객아이디, 고객이름, 등급 속성을 검색하시오.
SELECT
    customer_id,
    customer_name,
    grade
FROM
    customer;

-- 고객 테이블에서 모든 속성을 검색하시오.
SELECT
    customer_id,
    customer_name,
    age,
    grade,
    job_title,
    saved_money
FROM
    customer;

SELECT
    * -- 밑줄은 권장하지 않는다는 의미
FROM
    customer;

-- 제품 테이블에서 제조업체를 검색하시오.
SELECT
    manufacturer -- ALL은 생략 가능
FROM
    product;

SELECT DISTINCT
    manufacturer -- 중복 없이 검색하기, 성능이 떨어질 수 있음 -> 목적이 있을 때 사용한다.
FROM
    product;
 
-- 제품 테이블에서 제품명과 단가를 검색, 단 단가(unit_price)를 가격이라는 이름으로 출력하시오.
-- 큰 따옴표로 묶어주는 것이 띄어쓰기가 포함된 문장에 좋다.
SELECT
    product_name,
    unit_price AS "제품 가격"
FROM
    product;

-- 제품 테이블에서 제품명과 단가 속성을 검색, 단가에 500원을 더해 조정 단가라는 이름으로 출력하시오.
SELECT
    product_name,
    unit_price       AS "가격",
    unit_price + 500 AS "조정 단가"
FROM
    product;
 
-- 조건 검색
-- 한밭제과가 제조한 제품의 제품명, 재고량, 단가를 검색하시오.
-- 관계 대수: 절차가 없다.
SELECT
    product_name,
    stock,
    unit_price
FROM
    product
WHERE
    manufacturer = '한밭제과';

-- apple 고객이 15개 이상 주문한 주문제품, 수량, 주문일자를 검색하시오.
SELECT
    product_no,
    quantity,
    order_date
FROM
    porder
WHERE
        customer_id = 'apple'
    AND quantity >= 15;
 
-- apple 고객이 주문했거나 15개 이상 주문한 주문제품, 수량, 주문일자를 검색하시오.
SELECT
    product_no,
    quantity,
    order_date
FROM
    porder
WHERE
    customer_id = 'apple'
    OR quantity >= 15;
 
-- apple 고객이 아닌 고객이 15개 이상 주문한 주문제품, 수량, 주문일자를 검색하시오.
SELECT
    customer_id,
    product_no,
    quantity,
    order_date
FROM
    porder
WHERE
        customer_id != 'apple'
    AND quantity >= 15;

SELECT *
  FROM porder;
 
-- 제품 테이블에서 단가가 2000원 이상이면서 3000원 이하인 제품의 제품명, 단가, 제조업체를 검색하시오.
SELECT
    product_name,
    unit_price,
    manufacturer
FROM
    product
WHERE
        unit_price >= 2000
    AND unit_price <= 3000;

SELECT
    product_name,
    unit_price,
    manufacturer
FROM
    product
WHERE
    unit_price BETWEEN 2000 AND 3000;
 
-- LIKE를 이용한 검색
-- 김선우 고객에 대한 고객명, 나이, 등급, 적립금을 검색하시오.
SELECT
    customer_name,
    age,
    grade,
    saved_money
FROM
    customer
WHERE
    customer_name = '김선우';

SELECT
    customer_name,
    age,
    grade,
    saved_money
FROM
    customer
WHERE
    customer_name = '김선우'
    OR customer_name = '김용욱';

-- 김씨 성을 가진 고객의 고객명, 나이, 등급, 적립금을 검색하시오.
SELECT
    customer_name,
    age,
    grade,
    saved_money
FROM
    customer
WHERE
    customer_name LIKE '김%';

SELECT
    customer_name,
    age,
    grade,
    saved_money -- 잘못된 예 1
FROM
    customer
WHERE
    customer_name LIKE '김';

SELECT
    customer_name,
    age,
    grade,
    saved_money -- 잘못된 예 2
FROM
    customer
WHERE
    customer_name = '김%';
 
-- 고객 테이블에서 고객아이디가 5글자인 고객의 고객아이디, 고객이름, 등급을 검색하시오.
SELECT
    customer_id,
    customer_name,
    grade
FROM
    customer
WHERE
    customer_id LIKE '_____';

-- 김씨 성을 가진 고객 중 이름이 2글자인 고객명, 나이, 등급, 적립금을 검색하시오.
SELECT
    customer_name,
    age,
    grade,
    saved_money
FROM
    customer
WHERE
    customer_name LIKE '김__';
 
-- NULL을 이용한 검색
SELECT
    *
FROM
    customer;
 
-- 나이가 입력되지 않은 고객의 이름을 검색하시오.
SELECT
    customer_name
FROM
    customer
WHERE
    age IS NULL;  -- = NULL (x)

-- 나이가 입력된 고객의 이름을 검색하시오.
SELECT
    customer_id,
    customer_name
FROM
    customer
WHERE
    age IS NOT NULL;
    
 -- 정렬 검색
 -- 기본적인 검색은 동일.
 -- 고객 테이블에서 이름, 등급, 나이를 검색하시오.
SELECT customer_name AS "이름", grade AS "등급", age AS "나이"
  FROM customer
 ORDER BY age;
 
 
 -- 고객 테이블에서 이름, 등급, 나이를 검색하시오.
 -- 단, 나이의 내림차순으로... -- Descending
SELECT customer_name AS "이름", grade AS "등급", age AS "나이"
  FROM customer
 ORDER BY age DESC;
 
 
 -- 수량이 10개 이상인 주문의 고객아이디, 제품번호, 수량, 주문일자를 검색하시오.
SELECT customer_id, product_no, quantity, order_date
  FROM porder
 WHERE quantity >= 10;

 
 -- 제품번호를 기준으로 정렬 (기본 오름차순 ASC)
SELECT customer_id, product_no, quantity, order_date
 FROM porder
WHERE quantity >= 10
ORDER BY product_no ASC;

 -- 제품번호를 기준으로 정렬 (기본 오름차순 ASC)
 -- 다음으로 수량을 기준으로 내림차순 정렬
 SELECT customer_id, product_no, quantity, order_date
  FROM porder
 WHERE quantity >= 10
 ORDER BY product_no ASC, quantity DESC;
 
 
 -- 집계함수 (aggregate function)
 
 -- 제품 테이블에서 모든 제품의 단가를 검색하시오.

SELECT unit_price
 FROM product; 
 

-- 제품 테이블에서 모든 제품의 평균 단가를 검색하시오.
SELECT AVG(unit_price)
 FROM product;
 
 
-- 한밭제과에서 제조한 제품의 재고량을 검색하시오.
SELECT stock
  FROM product
 WHERE manufacturer = '한밭제과';

  
-- 한밭제과에서 제조한 제품의 재고량 합계를 검색하시오.
SELECT SUM (stock)
  FROM product
 WHERE manufacturer = '한밭제과';
 
   
-- 한밭제과에서 제조한 제품의 재고량 합계를 검색하시오.
SELECT SUM (stock) AS "재고량 합계"
  FROM product
 WHERE manufacturer = '한밭제과';
 
-- COUNT 사용하기
SELECT COUNT(customer_id) AS "고객수"
  FROM customer;

-- "집계 함수"에서는 null은 대상이 아님.
SELECT COUNT(age) AS "고객수"
  FROM customer;

SELECT *
  FROM customer;

-- 전체 DB를 보는 것으로 오래걸리나? 싶지만,
-- 알아서 잘 효율적으로 검색하므로 더 좋은 선택
SELECT COUNT(*) AS "고객수"
  FROM customer;


-- 제조업체이름을 검색하시오. 
SELECT manufacturer
  FROM product;

-- 제조업체 수를 검색하시오. (중복 포함해서 계산됨)
SELECT COUNT(manufacturer)
  FROM product;
  
-- 제조업체 수를 검색하시오. (중복 제거)
SELECT COUNT(DISTINCT manufacturer)
  FROM product;
  
-- 고객들의 평균 나이와, 가장 어린 나이, 가장 많은 나이를 검색하시오.
SELECT AVG(age) AS "평균 나이", 
       MIN(age) AS "최연소", 
       MAX(age) AS "최고령",
       MIN(customer_id)
  FROM customer;
  
-- 주문 테이블에서 주문 수량의 합계를 검색하시오.
SELECT SUM(quantity) AS "주문 수량 합계"
  FROM porder;
  

-- 그룹별 검색
-- 주문 테이블에서 주문 제품별(그룹(group)핑) 주문 수량의 합계를 검색하시오.
SELECT product_no, COUNT(quantity), SUM(quantity) AS "주문 수량 합계"
  FROM porder
 GROUP BY product_no;

-- 제품 테이블에서 제조업체별로 제조한 제품의 개수와 가장 비싼 단가를 검색하시오.
SELECT manufacturer, COUNT(*) AS "제품 수" , max(unit_price) AS "최고가"
  FROM product
 GROUP BY manufacturer;


-- 제조업체별로 제조한 제품의 개수와 가장 단가가 높은 제품의 단가를 검색하시오.
-- 단, 제품을 3개 이상 제조한 제조업체만  
SELECT manufacturer, COUNT(*) AS "제품 수", MAX(unit_price) AS "최고가"
  FROM product
 GROUP BY manufacturer
 HAVING COUNT(*) >= 3;

-- 각 주문고객이 주문한 제품의 총 수량을 주문제품별로 검색하시오.
SELECT customer_id, product_no, COUNT(*) AS "주문 수", SUM(quantity) AS "총주문수량"
  FROM porder
GROUP BY customer_id, product_no
ORDER BY customer_id, product_no;

SELECT product.product_no, product_name
  FROM product, porder
 WHERE product.product_no = porder.product_no; --조인 조건 : 세타조인 -> equijoin

-- banana 고객이 주문한 제품의 이름을 검색하시오.

SELECT product.product_no, product_name
  FROM product, porder
 WHERE product.product_no = porder.product_no --조인 조건 : 세타조인 -> equijoin
       AND customer_id='banana';

-- 나이가 30세 이상인 고객이 주문한 제품의 번호와 주문일자를 검색하시오.
SELECT porder.product_no, porder.order_date
 FROM customer, porder
 WHERE customer.customer_id = porder.customer_id
       AND customer.age >=30;

SELECT product_no, order_date -- 권장하지 않음
 FROM customer, porder
 WHERE customer.customer_id = porder.customer_id
       AND age >=30;      

SELECT PO.product_no, PO.order_date
 FROM customer C, porder PO
 WHERE C.customer_id = PO.customer_id
       AND C.age >=30;
       
-- 고명석 고객이 주문한 제품의 제품명을 검색하시오. 연결된 거 확인 -> *로 확인
SELECT P.product_name
  FROM customer C, porder PO, product P
 WHERE C.customer_id = PO.customer_id
  AND PO.product_no = P.product_no
  AND C.customer_name = '고명석';

-- INNER JOIN을 사용하는 방법
SELECT PO.product_no, PO.order_date
 FROM customer C, porder PO
 WHERE C.customer_id = PO.customer_id
       AND C.age >=30;

SELECT PO.product_no, PO.order_date
  FROM customer C INNER JOIN porder PO ON C.customer_id = PO.customer_id -- 취향대로 사용하기 바란다. 하지만 둘 다 사용하는 방법을 알아야 한다.
 WHERE C.age >=30;
 
-- OUTER JOIN
SELECT C.customer_name, PO.product_no, PO.order_date
  FROM customer C INNER JOIN porder PO ON C.customer_id = PO.customer_id;
 
SELECT C.customer_name, PO.product_no, PO.order_date
  FROM customer C LEFT OUTER JOIN porder PO ON C.customer_id = PO.customer_id;

SELECT C.customer_name, PO.product_no, PO.order_date
  FROM  porder PO RIGHT OUTER JOIN customer C ON C.customer_id = PO.customer_id;
 
SELECT C.customer_name, PO.product_no, PO.order_date
  FROM customer C FULL OUTER JOIN porder PO ON C.customer_id = PO.customer_id;

-- 자체 조인
ALTER TABLE customer
 ADD recommender VARCHAR2(20);
 
ALTER TABLE customer
 ADD CONSTRAINT chk_recommender
    FOREIGN KEY (recommender) REFERENCES customer(customer_id); --자체 참조
   
UPDATE customer
  SET recommender = 'orange'
 WHERE customer_id = 'apple';
 
SELECT *
 FROM customer;
 
-- 자체 조인
-- 고객의 아이디, 고객의 이름, 추천인의 이름을 검색하시오.
-- = 고객과 추천 고객 정보를 검색하시오.
SELECT C.customer_id, C.customer_name AS "고객이름", R.customer_name AS "추천인이름"
  FROM customer C, customer R
 WHERE C.recommender = R.customer_id;
 
-- 테이블 정리 (자체 조인 실습에 추가한 속성을 정리 이후 실습을 위한 것)
ALTER TABLE customer
    DROP CONSTRAINT chk_recommender;

ALTER TABLE customer
    DROP COLUMN recommender;
   
COMMIT;

-- 부속 질의문

-- 달콤 비스킷을 생산한 제조업체가 만든 제품의 제품명과 단가를 검색하시오.

-- 1. 달콤 비스킷을 생산한 제조업체의 이름을 검색하시오.
SELECT manufacturer
  FROM product
 WHERE product_name = '달콤비스킷';
 
-- 2. 한밭제과가 생산한 제품의 제품명, 단가를 검색하시오.
SELECT product_name, unit_price
  FROM product
 WHERE manufacturer = '한밭제과';

-- 부속 질의(subquery) 사용
SELECT product_name, unit_price
  FROM product
 WHERE manufacturer = (SELECT manufacturer
                         FROM product
                        WHERE product_name = '달콤비스킷');

-- 적립금이 가장 많은 고객의 고객이름과 적립금을 검색하시오.
-- 1. 가장 많은 적립금을 검색하시오.
SELECT MAX(saved_money)
  FROM customer;
 
-- 2. 적립금이 5000인 고객의 이름과 적립금을 검색하시오.
SELECT customer_name, saved_money
  FROM customer
 WHERE saved_money = 5000;

-- 부속 질의
SELECT customer_name, saved_money
  FROM customer
 WHERE saved_money = (SELECT MAX(saved_money)
                        FROM customer);

-- banana 고객이 주문한 제품의 번호를 검색하시오.
SELECT product_no
  FROM porder
 WHERE customer_id = 'banana';

-- banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오.
SELECT product_name, manufacturer
  FROM product
 WHERE product_no IN (SELECT product_no
                        FROM porder
                        WHERE customer_id = 'banana');

SELECT product_name, manufacturer
  FROM product
 WHERE product_no IN ('p01', 'p04', 'p06');
 
-- banana 고객이 주문하지 않은 제품의 제품명과 제조업체를 검색하시오.
SELECT product_name, manufacturer
  FROM product
 WHERE product_no NOT IN (SELECT product_no
                        FROM porder
                        WHERE customer_id = 'banana');

-- 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의 제품명, 단가, 제조업체를 검색하시오.
-- 동일한 검색을 다양하게 풀이 가능
-- ALL
-- 1. 대한식품이 제조한 제품들의 단가를 검색하시오.
SELECT unit_price
  FROM product
 WHERE manufacturer = '대한식품';

SELECT product_name, unit_price, manufacturer
  FROM product
 WHERE unit_price > ALL  (SELECT unit_price
                            FROM product
                           WHERE manufacturer = '대한식품');
                       
SELECT customer_name
  FROM customer
 WHERE NOT EXISTS(SELECT *
                FROM porder
                WHERE order_date =  '2022-03-15' 
                  AND porder.customer_id = customer.customer_id);

-- 2022년 3월 15일에 제품을 주문한 고객의 고객이름을 검색하시오.
-- 상관 중첩 질의 (correlated nested query)

-- banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오.의 3가지 방법  
-- 1.
SELECT product_name, manufacturer
  FROM product
 WHERE EXISTS ( SELECT *
                  FROM porder
                 WHERE product.product_no = porder. product_no
                   AND porder.customer_id = 'banana');
-- 2.
SELECT product_name, manufacturer
  FROM product
 WHERE product_no IN (SELECT product_no
                        FROM porder
                        WHERE customer_id = 'banana');

-- 3.
SELECT P.product_name, P.manufacturer
  FROM porder PO, product P
 WHERE PO.product_no = P.product_no AND PO.customer_id = 'banana';

-- 고객 테이블에서 나이가 입력되지 않았거나, 고객 아이디가 5개 자인 고객의 이름을 검색하시오.
SELECT customer_name, customer_id
  FROM customer
 WHERE age IS NULL
UNION -- 합집합
SELECT customer_name, customer_id
  FROM customer
 WHERE customer_id LIKE '_____';

-- 데이터 삽입
INSERT INTO customer
VALUES ('strawberry', '최유경', 30, 'vip', '공무원', 100);

INSERT INTO customer
VALUES ('strawberry2', '최유경2', NULL, 'vip', '공무원', 100);

INSERT INTO customer
VALUES ('strawberry3', '최유경2', NULL, 'silver', NULL, NULL);

INSERT INTO customer (customer_id, customer_name, grade)
VALUES ('tomato', '정은심', 'gold');

INSERT INTO customer (customer_id, customer_name, age, grade, job_title, saved_money)
VALUES ('tomato2', '정은심2', 36, 'gold', '교사', 1000);

SELECT *
  FROM customer;


-- 데이터 수정

-- 제품 테이블에서 제품번호가 'p03'인 제품의 제품명을 통큰파이로 수정하시오.
-- 1. 먼저 검색을 통해 데이터를 확인
-- 제품번호가 'p03'인 제품을 검색하시오.
SELECT *
  FROM product
 WHERE product_no = 'p03';
 
UPDATE product
   SET product_name = '통큰파이'
 WHERE product_no = 'p03';
                       
-- 모든 제품의 단가를 10% 인상하시오.
UPDATE product
   SET unit_price = unit_price*1.1;

-- 정소화 고객이 주문한 제품의 주문수량을 5개로 수정하시오.
UPDATE porder  
   SET quantity = 5
 WHERE customer_id IN (SELECT customer_id
          FROM customer
         WHERE customer_name = '정소화');

-- 정소화 고객이 주문한 제품에 대한 정보를 검색하시오.
SELECT *
  FROM porder
 WHERE customer_id IN (SELECT customer_id
          FROM customer
         WHERE customer_name = '정소화');


-- 데이터 삭제

-- 주문 테이블에서 주문일자 2022년 5월 22일인 주문 내역을 삭제하시오.
-- SELECT를 통해 테이블의 데이터 확인

SELECT *
  FROM porder
 WHERE order_date = '22/05/22';
 
DELETE
  FROM porder
 WHERE order_date = '22/05/22';
 
SELECT *
  FROM porder;

-- 정소화 고객이 주문한 내역을 주문 테이블에서 삭제하시오.
-- 1. 검색 - 정소화 고객이 주문한 내역을 검색하시오.
DELETE
  FROM porder
 WHERE customer_id IN (SELECT customer_id
                         FROM customer
                        WHERE customer_name = '정소화');

