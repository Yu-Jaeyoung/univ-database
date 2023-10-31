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
  FROM customer;
SELECT *
  FROM product;
SELECT *
  FROM porder;























