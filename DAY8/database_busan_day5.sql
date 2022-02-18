/*
상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회하세요 
단, 상품분류코드가 'P101', 'P201','P301'인것에 대해 조회하고 
매입수량이 15개 이상인것들과
'서울'에 살고 있는 회원 중에 생일이 1974년생인 사람들에 대해 조회하시오 
정렬은 회원 아이디를 기준으로 내림차순, 매입수량을 기준으로 내림차순
*/

/* 
사용할 테이블 : prod, cart, buyprod, buyer, lprod, member
조회할 컬럼 : prod_lgu, prod_name, prod_color,
                  buy_qty, cart_qty, buyer_name
관계조건: 
            lprod_gu = prod_lgu, 
            buyer_id = prod_buyer, 
            prod_id =  buy_prod,
            prod_id = cart_prod, 
            mem_id = cart_member                 
일반조건: 
            lprod_gu IN('P101', 'P201', 'P301')
            buy_qty >= 15
            mem_add1 like '서울%'
            TO_CHAR(mem_bir, 'yyyy')= '1974' 
정렬조건: mem_id ASC , buy_qty ASC
*/
SELECT prod_lgu, prod_name, lprod_nm,
                  buy_qty, cart_qty, buyer_name
FROM  lprod  INNER JOIN prod
                    ON( lprod_gu =prod_lgu)
                    INNER JOIN buyer
                    ON( buyer_id =prod_buyer)
                    INNER JOIN buyprod
                    ON(prod_id =  buy_prod)
                    INNER JOIN cart
                    ON(prod_id = cart_prod)
                    INNER JOIN member  
                    ON(mem_id = cart_member)
WHERE lprod_gu IN('P101', 'P201', 'P301')
    AND  buy_qty >= 15
    AND mem_add1 like '서울%'
    AND  TO_CHAR(mem_bir, 'yyyy')= '1974' 
ORDER BY  mem_id DESC, buy_qty DESC;

-- OUTER JOIN 
/* 
두 테이블을 조인할 때 조인 조건식을 만족시키지 못하는 ROW는 
검색에서 빠지게 되는데 누락된 ROW들이 검색되도록 하는 방법
*/
-- 1. 분류테이블 조회 
SELECT * 
FROM lprod;
-- 2. 일반 INNER JOIN
SELECT lprod_gu, lprod_nm,
            COUNT(prod_lgu) 상품자료수
FROM lprod, prod
WHERE lprod_gu = prod_lgu
GROUP BY lprod_gu, lprod_nm;

-- 3. OUTER JOIN 
SELECT * 
FROM lprod;
-- 2. 일반 INNER JOIN
SELECT lprod_gu 분류코드 , lprod_nm 분류명,
          COUNT(prod_lgu) 상품자료수
FROM lprod, prod
WHERE lprod_gu = prod_lgu (+)
GROUP BY lprod_gu, lprod_nm;

--ANSI 표준

SELECT lprod_gu, lprod_nm,
            COUNT(prod_lgu) 상품자료수
FROM lprod
            LEFT OUTER JOIN prod 
            ON(lprod_gu = prod_lgu)
GROUP BY lprod_gu, lprod_nm
ORDER BY lprod_gu;

-- 전체상품의 2005년 1월 입고수량 검색
--  상품코드, 상품명, 입고수량
SELECT  prod_id 상품코드, 
            prod_name 상품명, 
            SUM(buy_qty) 입고수량
FROM prod, buyprod
WHERE prod_id = buy_prod
AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
GROUP BY prod_id, prod_name;

-- ANSI OUTER JOIN
SELECT prod_id 상품코드,
prod_name 상품명,
SUM(NVL(buy_qty,0)) 입고수량
FROM prod LEFT OUTER JOIN buyprod
                    ON(prod_id = buy_prod
                        AND buy_date BETWEEN '2005-01-01' AND '2005-01-01')
GROUP BY prod_id, prod_name
ORDER BY prod_id, prod_name;

-- 일반 조인
-- 전체 회원의 2005년도 4월의 구매현황 조회
-- 회원ID, 성명, 구매수량의 합
-- mem_id = cart_prod
SELECT mem_id, mem_name,
SUM(cart_qty)
FROM member, cart
WHERE  mem_id = cart_member
AND SUBSTR(cart_no,1,6) = '200504'
GROUP BY mem_id, mem_name
ORDER BY mem_id, mem_name;

-- 표준 방식
SELECT mem_id 회원ID, mem_name 회원명,
SUM(cart_qty) 구매수량합
FROM member LEFT OUTER JOIN cart
                        ON(mem_id = cart_member
                        AND SUBSTR(cart_no,1,6) = '200504')
GROUP BY mem_id, mem_name
ORDER BY mem_id, mem_name;

--2005년도 월별 매입 현황을 검색하시오 
-- 매입월, 매입수량, 매입금액(매입수량*상품테이블의 매입가)
SELECT  SUBSTR(cart_no,5,2) as mm,
SUM(cart_qty) as sum_qty,
SUM(cart_qty * prod_sale) as sum_total
FROM  cart, prod
WHERE cart_prod = prod_id
AND SUBSTR(cart_no,1,4) = '2005'
GROUP BY SUBSTR(cart_no,5,2);

-- HAVING 절
-- 상품분류가 컴퓨터제품('P101')인 상품의 2005년도 일자별 판매조회
-- 조건: 판매일, 판매금액(500만원 초과의 경우만), 판매수량
SELECT SUBSTR(cart_no,1,8) "판매일",
            SUM(cart_qty* prod_sale) "판매금액",
            SUM(cart_qty) "판매수량"
FROM prod, cart
WHERE cart_no like '2005%'
            AND prod_id = cart_prod
            AND prod_lgu ='P101'
GROUP BY SUBSTR(cart_no,1,8) 
HAVING SUM(cart_qty* prod_sale) > 5000000
ORDER BY SUBSTR(cart_no,1,8);

-- 서브쿼리
/*
 1. SQL 구문 안에 또 다른 SELECT 구문이 있는 것을 말한다.
 2. 서브쿼리는 괄호로 묶는다.
 3. 연산자와 사용할 경우 오른쪽에 배치한다.
 4. 메인 쿼리와 서브쿼리 사이의 참조성 여부에 따라 연관 또는 비연관 서브쿼리로 구분
* ANY, ALL은 비교연산자와 조합된다
* ANY는 OR의 계념 어떤것이라도 맞으면 TRUE
* ALL은 AND의 계념
*/
