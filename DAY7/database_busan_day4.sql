/*
회원정보 중에 구매내역이 있는 회원에 대한 
회원 아이디, 회원이름, 생일(yyyy-mm-dd)을 조회하시오
생일 기준으로 오름차순 정렬
*/
SELECT mem_id, mem_name, 
            mem_bir, TO_CHAR(mem_bir) as ymd
FROM member
WHERE mem_id IN(
                        SELECT cart_member
                        FROM cart)
ORDER BY ymd ASC;

SELECT prod_id, prod_name, prod_lgu
FROM prod
WHERE EXISTS (SELECT lprod_gu
                        FROM lprod
                        WHERE lprod_gu = prod.prod_lgu
                        AND lprod_gu = 'P301');
                        
SELECT prod_id, prod_name, prod_lgu
FROM prod
WHERE prod_lgu IN( SELECT lprod_gu
                                FROM lprod
                                WHERE lprod_nm = '피혁잡화');

-- JOIN
-- CROSS JOIN
-- 일반방식
SELECT m.mem_id, c.cart_member, p.prod_id
FROM member m, cart c, lprod l, prod p, buyer b;

SELECT COUNT(*)
FROM member m, cart c, lprod l, prod p, buyer b;

-- ANSI표준 방식
SELECT *
FROM member  CROSS JOIN cart
                        CROSS JOIN prod 
                        CROSS JOIN lprod
                        CROSS JOIN buyer;
                        
-- EQUI JOIN (INNER JOIN)
-- 관계조건식이 무조건 들어감 (PK와 FK의 관계)
/*
상품테이블에서 상품코드, 상품명, 분류명을 조회
상품테이블: prod
분류테이블: lprod
*/
-- 일반 방식
SELECT prod.prod_id, prod.prod_name, lprod.lprod_nm
FROM prod, lprod
-- 관계조건식을 제일 먼저 작성
WHERE prod.prod_lgu = lprod.lprod_gu;

--ANSI 국제표준방식
SELECT prod.prod_id, prod.prod_name, lprod.lprod_nm
FROM prod INNER JOIN lprod
                    ON(prod.prod_lgu = lprod.lprod_gu);
                    
--TABLE JOIN 
SELECT  A.prod_id "상품코드",
           A.prod_name "상품명",
           B.lprod_nm "분류명",
           C.buyer_name "거래처명"
FROM prod A, lprod B, buyer C
WHERE A.prod_lgu = B.lprod_gu
AND A.prod_buyer = C.buyer_id;

-- 국제표준 방식
SELECT  A.prod_id , A.prod_name , B.lprod_nm, C.buyer_name 
FROM  prod A INNER JOIN lprod B 
                             ON (A.prod_lgu= B.lprod_gu)
                    INNER JOIN buyer C
                            ON(A.prod_buyer = C.buyer_id);

/*
회원이 구매한 거래처 정보를 조회하려고 한다 
회원 아이디, 회원이름, 상품거래처명,
상품분류명을 조회하시오
*/
-- 사용할 테이블 : member, cart, prod, buyer, lprod
-- 조회할 컬럼 : mem_id, mem_name,, buyer_name, lprod_nm
-- 관계조건 :
-- mem_id = cart_member
-- cart_prod = prod_id
-- prod_buyer= buyer_id
-- prod_lgu = lprdo_gu
SELECT
    mem_id,
    mem_name,
    buyer_name,
    lprod_nm
FROM
    member n,
    cart c,
    prod p,
    buyer b,
    lprod lp
WHERE
        mem_id = cart_member
    AND cart_prod = prod_id
    AND prod_buyer = buyer_id
    AND prod_lgu = lprod_gu;

SELECT
    mem_id,
    mem_name,
    buyer_name,
    lprod_nm
FROM
         member m
    INNER JOIN cart  c ON ( mem_id = cart_member )
    INNER JOIN prod  p ON ( cart_prod = prod_id )
    INNER JOIN buyer b ON ( prod_buyer = buyer_id )
    INNER JOIN lprod lp ON ( prod_lgu = lprod_gu );
    
/*
거래처가 삼성전자인 자료에 대한
상품코드, 상품명, 거래처명을 조회
*/ 
-- 테이블: prod , buyer,
-- 조회 컬럼: prod_id , prod_name, buyer_name   
-- 관계조건: prod_ buyer= buyer_id
-- 일반조건 : buyer_name =  '삼성전자'
-- 일반
SELECT
    prod_id,
    prod_name,
    buyer_name
FROM
    prod,
    buyer
WHERE
        prod_buyer = buyer_id
    AND buyer_name = '삼성전자';
-- 국제표준방법
SELECT
    prod_id,
    prod_name,
    buyer_name
FROM prod
INNER JOIN buyer ON ( prod_buyer = buyer_id
                          AND buyer_name = '삼성전자' );
-- WHERE buyer_name ='삼성전자';       
/*
상품 테이블에서 상품코드, 상품명, 상품분류명, 거래처명,
거래처주소를 조회
*/
-- 테이블: prod , lprod , buyer 
-- 조회 컬럼: prod_id, prod_name, prod_name, buyer_name
-- 관계조건: prod_ lgu= lprod_gu , prod_buyer = buyer_id
-- 일반조건 : prod_sale <= 100000 , buyer_add1 LIKE "부산%"

SELECT prod_id, prod_name, lprod_nm, buyer_name
FROM prod, lprod, buyer
WHERE prod_lgu= lprod_gu
AND prod_buyer = buyer_id
AND prod_sale <= 100000
AND buyer_add1 LIKE '부산%' ;

-- 국제표준

SELECT prod_id, prod_name, prod_name, buyer_name
FROM prod INNER JOIN lprod
                    ON(prod_lgu= lprod_gu)
                 INNER JOIN buyer
                    ON(prod_buyer = buyer_id)
WHERE prod_sale <= 100000
AND buyer_add1 LIKE '부산%';

/*
상품분류코드가 P101 인것에 대한
상품분류명, 상품아이디, 판매가, 거래처담당자, 회원아이디, 주문수량 조회
상품분류명을 기준으로 내림차순 , 상품 아이디를 기준으로 오름차순 정렬
*/
-- 테이블: lprod, prod ,buyer, cart
-- 조회 컬럼: lprod_nm, prod_id, prod_sale, buyer_charger, 
--               cart_member, cart_qty, 
-- 관계조건: lprod_gu = prod_lgu, 
--               prod_id = cart_prod, 
--               prod_buyer = buyer_id
-- 일반조건 : lprod_gu = 'P101'
-- 정렬조건  lprod_nm DESC, prod_id ASC
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, 
            cart_member, cart_qty
FROM   lprod, prod , buyer, cart
WHERE  lprod_gu = prod_lgu
AND  buyer_id = prod_buyer
AND prod_id = cart_prod
AND lprod_gu = 'P101'
ORDER BY lprod_nm DESC, prod_id ASC;

-- 국제표준
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, 
           cart_member, cart_qty 
FROM  lprod INNER JOIN prod
            ON( lprod_gu = prod_lgu)
            INNER JOIN buyer
            ON(buyer_id = prod_buyer)
            INNER JOIN cart
            ON(prod_id = cart_prod)
WHERE lprod_gu = 'P101'
ORDER BY lprod_nm DESC, prod_id ASC;

