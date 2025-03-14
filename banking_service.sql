CREATE DATABASE banking_service;

-- 고객 테이블 생성
-- 이름, 이메일, 휴대폰 번호
DROP TABLE IF EXISTS customer;

CREATE TABLE customer
(
  id        SERIAL PRIMARY KEY,
  name      VARCHAR(20)        NOT NULL,
  email     VARCHAR(50) UNIQUE NOT NULL,
  cellphone VARCHAR(20)        NOT NULL
);

SELECT *
  FROM customer;

-- 계좌 테이블 생성
-- 계좌 번호, 잔액
DROP TABLE IF EXISTS account;

CREATE TABLE account
(
  id             SERIAL PRIMARY KEY,
  account_number VARCHAR(20) UNIQUE NOT NULL,
  balance        BIGINT             NOT NULL DEFAULT 0,
  customer_id    INT                NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer (id) ON DELETE CASCADE
);

SELECT *
  FROM account;

-- 샘플 데이터
INSERT
  INTO customer (name, email, cellphone)
VALUES ('Alice Kim', 'alice@example.com', '010-1234-5678')
     , ('Bob Lee', 'bob@example.com', '010-9876-5432')
     , ('Charlie Park', 'charlie@example.com', '010-1111-2222');

INSERT
  INTO account (account_number, balance, customer_id)
VALUES ('1001-0001-1234', 50000, 1)
     , ('1001-0002-5678', 1200000, 1)
     , ('1002-0003-4321', 300000, 2)
     , ('1003-0004-8765', 800000, 3);

INSERT
  INTO customer (name, email, cellphone)
VALUES ('홍길동', 'hong@example.com', '010-1234-5678');

INSERT
  INTO account (account_number, balance, customer_id)
VALUES ('123-456-789', 500000, 1);

-- q1. 모든 고객의 정보를 검색하시오.
SELECT *
  FROM customer;

-- q2. 툭정 이메일이 'alice@example.com' 인 고객을 검색하시오.
SELECT *
  FROM customer
 WHERE email = 'alice@example.com';

-- q3. 고객 id(customer_id)가 1인 고객의 계좌 정보를 검색하시오.
SELECT *
  FROM customer
 WHERE id = 1;

-- q4. 계좌 번호가 '123-456-789'인 계좌 정보를 검색하시오.
SELECT *
  FROM account
 WHERE account_number = '123-456-789';

-- q5. 계좌 잔고가 100,000원 이상인 계좌 정보를 검색하시오.
SELECT *
  FROM account
 WHERE balance >= 100000;

-- q6. 고객과 고객이 소유한 계좌 정보를 검색하시오
SELECT *
  FROM customer c
     , account a
 WHERE c.id = a.customer_id
 ORDER BY c.id;

-- q7. 가장 많은 계좌를 보유한 고객의 ID와 계좌 개수를 검색하시오.
SELECT customer_id, count(*) AS account_count
  FROM account
 GROUP BY customer_id
 ORDER BY 2 DESC -- ORDER BY account_count DESC
 LIMIT 1;

SELECT *
  FROM customer
 WHERE id IN (
   SELECT customer_id
     FROM account a
    GROUP BY customer_id
   HAVING count(*) = (
     SELECT MAX(c)
       FROM (
              SELECT count(*) c
                FROM account
               GROUP BY customer_id
            ) AS max_count
                     )
             );

-- q8. 잔고가 가장 높은 계좌의 고객 정보를 검색하시오.
SELECT c.name, c.email, c.cellphone, a.balance
  FROM account a
     , customer c
 WHERE c.id = a.customer_id
 ORDER BY balance DESC
 LIMIT 1;

-- u1. 고객 id가 2인 고객의 연락처를 '010-5555-6666'으로 변경하시오.
UPDATE customer
   SET cellphone = '010-5555-6666'
 WHERE id = 2;

SELECT *
  FROM customer
 WHERE id = 2;

-- u2. 계좌번호 '123-456-789'의 잔고를 10,000 증가시키시오.
UPDATE account
   SET balance = balance + 10000
 WHERE account_number = '123-456-789';

SELECT *
  FROM account
 WHERE account_number = '123-456-789';

-- d1. id가 2인 고객을 삭제하되 이 고객의 계좌도 함께 삭제되도록 하시오.
DELETE
  FROM customer
 WHERE id = 2;

SELECT *
  FROM customer;

SELECT *
  FROM account
 WHERE customer_id = 2;
