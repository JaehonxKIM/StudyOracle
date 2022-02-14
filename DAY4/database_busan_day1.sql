-- 테이블 만들기
CREATE TABLE buyer
(   buyer_id char(6) Not Null,
    buyer_name  VARCHAR2(40) NOT NULL,
    buyer_lgu CHAR (4) NOT NULL,
    buyer_bank VARCHAR2 (60),
    buyer_bankno VARCHAR2(60),
    buyer_bankname VARCHAR2(15),
    buyer_zip  CHAR (7), 
    buyer_add1  VARCHAR2 (100), 
    buyer_add2  VARCHAR2  (70),
    buyer_comtel VARCHAR2 (14) NOT NULL, 
    buyer_fax VARCHAR2 (20) NOT NULL );
    
-- 조회하기
SELECT *
FROM  lprod;

--데이터 입력하기.
INSERT INTO lprod(
 lprod_id , lprod_gu, lprod_nm
) Values (
1, 'P101', '컴퓨터제품'
);

-- 상품분류정보에서 상품분류코드의 값이 
-- P201인 데이터를 조회 해주세요...
SELECT *
FROM lprod
WHERE lprod_gu > 'P201';

-- 상품분류코드가 P102에 대해서
-- 상품분류명의 값을 향수로 수정해 주세요..(데이터 수정하기)

SELECT *
FROM lprod
WHERE lprod_gu = 'P102';
-------------------------------------
UPDATE lprod
    SET lprod_nm = '향수'
WHERE lprod_gu = 'P102';
-- 상품분류정보에서
-- 상품분류코드가 P202에 대한 데이터를 삭제해주세요..
SELECT *
    FROM lprod
     WHERE lprod_gu = 'P202';

DELETE FROM lprod
    WHERE lprod_gu ='P202';
 -------------------------------------------
 ALTER TABLE buyer ADD( buyer_mail VARCHAR2(60) NOT NULL,
                                                        buyer_charger VARCHAR2(20),
                                                        buyer_telext VARCHAR2(2));
 ALTER TABLE buyer MODIFY(buyer_name VARCHAR2(60) );
-------
-- 테이블 명 바꾸기 

 ALTER TABLE buyer
        ADD(CONSTRAINT pk_buyer Primary Key (buyer_id),
                    CONSTRAINT fr_buyer_lprod FOREIGN Key(buyer_lgu)
                                                                REFERENCES lprod(lprod_gu) );

-- 데이터 정보
/*
lprod :상품분류정보
prod : 상품정보
buyer: 거래처정보
member: 회원정보
cart: 구매정보
buyprod: 입고상품정보
remain: 재고수불정보
*/

-- 특정 column의 검색

SELECT mem_id, mem_name
FROM member;

-- 1. 테이블 찾기
-- 2. 조건이 있는지?
-- 3. 어떤 컬럼을 사용하는지

-- 상품코드와 상품명을 조회하시오
SELECT prod_id, prod_name
FROM prod;

-- 산술식을 사용한 검색
-- 회원테이블의 마일리지를 12로 나눈 값을 검색하시오
SELECT * 
FROM member;

SELECT mem_mileage, 
                (mem_mileage /12) as mem_12 
FROM member;
 
 -- 상품테이블의 상품코드, 상품명, 판매금액을 검색하시오
 
 SELECT prod_id, prod_name, 
                (prod_sale*55) as prod_sale
      FROM prod;
      
-- 중복된 row의 제거 
--SELECT distinct column From 테이블 명

-- 상품 테이블의 거래처 코드를 중복되지 않게 검색하시오
SELECT DISTINCT prod_buyer
     FROM prod;
-- 회원테이블에서 
-- 회원 ID ,회원명, 생일, 마일리지 검색
SELECT mem_id, mem_name, mem_bir,
                mem_mileage
FROM member
ORDER BY mem_id ASC;
-- 별칭 붙히기
SELECT mem_id as id,
                mem_name as nm,
                mem_bir, mem_mileage
FROM member
ORDER BY id ASC;

-- WHERE 절
-- 비교연산자 = , > , <, >=, <=

-- 상품중 판매가가 170,000원인 상품 조회
SELECT prod_name 상품 , prod_sale 판매가
FROM prod
WHERE prod_sale = 170000;

-- 상품 판매가격이 170,000을 초과하는 상품
SELECT prod_name 상품 , prod_sale 판매가
FROM prod
WHERE prod_sale >170000
ORDER BY prod_sale asc;

-- 상품 중에 매입가격이 200,000원 이하인 상품검색
-- 상품명 오름차순

SELECT  prod_id, prod_cost , prod_name 
FROM prod
WHERE prod_sale <=200000
ORDER BY prod_id  DESC;

-- 회원중에 76년도 1월1일 이후에 태어난
-- 회원ID, 회원이름, 주민등록번호 앞자리 조회
-- 단 회원 ID 내림차순

SELECT mem_id, mem_name, mem_regno1
      FROM member
      WHERE mem_regno1 >= 760101
      ORDER BY mem_id ASC;
      
-- 논리연산자 AND, OR, NOT
-- 상품 중 상품분류가 P201이고 판매가가 170,000원인 상품 조회
SELECT prod_name 상품, prod_lgu 상품분류 , prod_sale 판매가
    FROM prod
WHERE prod_lgu = 'P201'
    AND prod_sale = 170000;

-- 상품 중 상품분류가 p201 이거나 판매가가 170.000원 인 상품 조회
SELECT prod_name 상품, prod_lgu 상품분류 , prod_sale 판매가
    FROM prod
WHERE prod_lgu = 'P201'
    OR prod_sale = 170000;
    
-- 상품 중 상품분류가 p201도 아니고  판매가가 170.000원도 아닌 상품 조회
SELECT prod_name 상품, prod_lgu 상품분류 , prod_sale 판매가
    FROM prod
WHERE prod_lgu  != 'P201'
    AND prod_sale != 170000;
    
-- 상품 중 판매가가 300,000원 이상, 500,000원 이하인 상품을 검색하시오
SELECT prod_id  , prod_name  , prod_sale 
    FROM prod
WHERE prod_sale >= 300000 
    AND prod_sale <= 500000;
/*
상품 중에 판매가격이 15만원, 17만원 , 33만원인 상품정보 조회
상품코드, 상품명, 판매가격 조회
정렬은 상품명을 기준으로 오름차순
*/
SELECT prod_id  , prod_name  , prod_sale 
    FROM prod
WHERE prod_sale = 150000
    OR prod_sale = 170000
    OR prod_sale = 330000
ORDER BY prod_name DESC;

/*
회원 중에 아이디가 C001, F001, W001인 회원 조회 
회원아이디, 회원이름 조회
정렬은 주민번호 앞자리 기준 내림차순
*/
SELECT mem_id  , mem_name
    FROM member
WHERE mem_id = 'c001'
    OR mem_id = 'f001'
    OR mem_id = 'w001'
ORDER BY mem_regno1  ASC;
