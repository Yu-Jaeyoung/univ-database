SELECT *
  FROM customer;

CREATE VIEW vip_customer
AS
SELECT customer_id, customer_name, age
  FROM customer
 WHERE grade = 'vip'
WITH CHECK OPTION;

SELECT *
  FROM vip_customer;


CREATE VIEW product_1
AS
SELECT product_no, stock, manufacturer
  FROM product
  WITH CHECK OPTION;
 
SELECT *
  FROM product_1;

INSERT
  INTO product_1
VALUES ('p08', 1000, '신선식품');

CREATE VIEW product_2
AS
SELECT product_name, stock, manufacturer
  FROM product
  WITH CHECK OPTION;

SELECT *
  FROM product_2;

INSERT INTO product_2
VALUES ('시원 냉면', 1000, '신선식품');


-- 뷰는 삽입, 삭제, 수정이 가능할까? 변경이 가능할까?
-- 변경하지 않는 것이 좋다.