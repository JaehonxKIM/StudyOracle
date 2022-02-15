--- database_busan_day1에 이어서 

-- 상품분류테이블에서 현재 상품테이블에 존재하는 분류만 검색
-- (분류코드, 분류명)  IN 사용 * 단일컬럼에 다중행 일때 사용할 수 있음
SELECT lprod_gu 분류코드 , lprod_nm 분류명
FROM lprod
WHERE lprod_gu IN(SELECT prod_lgu FROM prod);

-- 상품분류테이블에서 현재 상품테이블에 존재하지 않는 분류만 검색
SELECT lprod_gu 분류코드 , lprod_nm 분류명
FROM lprod
WHERE lprod_gu NOT IN(SELECT prod_lgu FROM prod);

/*
문제
한번도 상품을 구매한 적이 없는 
회원ID, 이름 조회
*/
-- 테이블 찾기 : prod, cart ,member
-- 조회할 컬럼 찾기: mem_id, mem_name
-- 조건 있는지 확인
SELECT mem_id , mem_name
FROM member 
WHERE mem_id  NOT IN(
                                            SELECT cart_member
                                            FROM cart
                                            );
-- 한번도 판매된 적이 없는 상품을 조회
-- 테이블 찾기 : prod, cart
-- 조회할 컬럼 찾기: prod_name
-- 조건 있는지 확인
 SELECT prod_name
FROM  prod
    WHERE prod_id  NOT IN(
                                            SELECT cart_prod
                                            FROM cart);
                                            
-- 회원 중 김은대가 지금까지 구매했던 모든 상품명 조회
-- 테이블 찾기 : prod, member, cart
-- 조회할 컬럼 찾기: prod_name
-- 조건 있는지 확인 회원 이름이 김은대 mem_name = '김은대'
SELECT prod_name
FROM prod
WHERE prod_id IN(
                        SELECT cart_prod
                        FROM cart
                        WHERE cart_member IN(
                                            SELECT mem_id
                                            FROM member
                                            WHERE mem_name= '김은대')                                    
);

/*
상품 중 판매가격이 10만원 이상 30만원 이하인 상품을 조회
판매가격 기준으로 내림차수 
*/
SELECT   prod_name  , prod_sale 
    FROM prod
WHERE prod_sale >= 100000 
    AND prod_sale <= 300000
    ORDER BY prod_sale DESC;

-- BETWEEN 범위 내의 모든 값을 탐색, 두 범위의 한계값을 포함함
SELECT prod_name 상품 , prod_sale 판매가 
FROM prod
WHERE prod_sale BETWEEN 100000 AND 300000;

--회원 중 생일이 1975년 생부터 1976년 생을 조회하시오 
SELECT *
FROM member
WHERE mem_regno1 BETWEEN '75-01-01' AND '76-12-31';

-- 거래처 담당자 강남구씨 가 담당하는 상품을 구매한 회원들을 조회
-- 회원 아이디 조회
-- 조회할 컬럼: mem_id, mem_name
SELECT mem_id, mem_name
FROM  member
WHERE mem_id  IN (
                            SELECT cart_member
                            FROM cart
                            WHERE cart_prod IN (
                                SELECT prod_id
                                FROM prod
                                WHERE prod_lgu IN (
                                    SELECT lprod_gu
                                    FROM lprod
                                    WHERE lprod_gu IN (
                                                SELECT buyer_lgu
                                                FROM buyer
                                                WHERE buyer_charger = '강남구')
)
)
);
/*
상품 중 매입가가 30만원~150만원 이고 판매가가 80만원~200만원인 상품을 검색하시오
상품명 매입가 판매가 
*/
SELECT prod_name 상품명, prod_cost 매입가 , prod_sale 판매가
FROM prod
WHERE prod_cost BETWEEN 300000 AND 1500000
AND prod_sale BETWEEN  800000 AND 2000000;
-- 회원 중 생일이 1975년도 생이 아닌 회원을 검색하시오
SELECT *
FROM member
WHERE  mem_bir  NOT BETWEEN '75-01-01' AND '75-12-31'
ORDER BY mem_bir ASC;

-- LIKE
-- 회원테이블에서 김씨 성을 가진 회원을 검색하시오
SELECT * FROM member
WHERE mem_name  LIKE '김%';

-- 회원테이블의 주민등록번호 앞자리를 검색해 75년생을 제외한 회원을 검색하시오
SELECT *
FROM member
WHERE mem_regno1 NOT LIKE '75%' ;

-- CONCAT 두 문자를 연결하여 반환

SELECT CONCAT('MY Name is'  , mem_name ) FROM member;

-- CHT, ASCII ASCII값을 문자로, 문자를 ASCII값으로 반환

-- LOWER, UPPER, INITCAP
SELECT LOWER( 'DATA manipulation Language') "LOWER",
                UPPER('DATA manipulation Language') "UPPER",
                INITCAP('DATA manipulation Language') "INTICAP"
FROM dual;            

--회원테이블의 회원ID를 대문자로 변환하여 검색하시오 
SELECT mem_id 반환전ID ,UPPER(mem_id) 반환후ID 
FROM member;

-- LPAD, RPAD 
-- 지정된 길이 n 에서  c1을 채우고 남은 공간을 c2로 채워서 반환
-- LTRIM , RTRIM 왼쪽/오른쪽 공백제거 
-- TRIM 공백 모두 제거 
--SUBSTR 문자 일부분을 선택
-- TRANSLATE(c1,c2,c3)
-- REPLACE(c1,c2,[c3])
SELECT REPLACE('SQL Project' , 'SQL', 'SSQQLL') 문자치환1,
                REPLACE('Java Flex Via' ,'a') 문자치환2
FROM dual;                
/*
회원테이블의 회원성명 중 성씨 '이'를 '리로 치환검색하시오 
*/
SELECT CONCAT (REPLACE(SUBSTR(mem_name, 1, 1), '이', '리'),
                SUBSTR(mem_name, 2))
FROM member;

-- INSTR c1 문자열에서 c2 문자가 처음 나타나는 위치를 리턴
-- GREATEST, LEAST 열거된 항목 중 가장 큰값, 작은값 반환
-- ROUND(n,l) 지정된 자리수(l)밑에서 반올림
-- TRUNC(n,l) ROUND와 동일 단, 반올림이 아닌 절삭
-- MOD(c, n) n으로 나눈 나머지 
SELECT MOD(10,3) FROM dual;

SELECT sysdate
FROM dual;

-- ADD_MONTHS
-- NEXT_DAY, LAST_DAY
SELECT NEXT_DAY(SYSDATE, '월요일'),
                LAST_DAY(SYSDATE)
FROM dual;
-- 이번달이 며칠 남았는지 검색하시오 
SELECT LAST_DAY(SYSDATE) - SYSDATE
FROM dual;

-- EXTRACT 날짜에서 필요한 부분만 추출
SELECT EXTRACT(YEAR FROM SYSDATE) "년도",
                 EXTRACT(MONTH FROM SYSDATE) "월",
                  EXTRACT(DAY FROM SYSDATE) "일"
FROM dual;

--회원중에 생일이 3월인 회원을 검색
SELECT mem_bir,
              EXTRACT(MONTH FROM mem_bir) as bir3 
FROM member
WHERE EXTRACT(MONTH FROM mem_bir) ='3';

-- 회원 생일 중 1973년 생이 주로 구매한 상품을 오름차순으로 조회
-- 조회 컬럼: 상품명
-- 단 상품명에 삼성이 포함된 상품만 조회
-- 결과 중복제거 
*/ 
--테이블 : prod, member, cart
-- 조회컬럼: DISTINCT prod_name
-- 정렬 prod_name ASC
-- 조건 : EXTRACT(YEAR FROM mem_bir) = 1973
--            : prod_name LIKE '삼성%'
SELECT DISTINCT prod_name
FROM prod
WHERE prod_id IN (
SELECT cart_prod
FROM cart
WHERE cart_member  IN (
            SELECT mem_id
            FROM  member
            WHERE EXTRACT(YEAR FROM mem_bir) = 1973
            )
)
AND prod_name  LIKE '%삼성%';

-- TO_CHAR: 숫자 문자 날짜를 지정한 형식의 문자열 반환
-- TO_NUMBER: 숫자형식의 문자열을 숫자로 반환
-- TO_DATE: 날짜형식의 문자열을 날짜로 반환

-- TO_CHAR 
SELECT TO_CHAR(CAST('2008-12-25' AS DATE),
                                'YYYY.MM.DD HH24:MI')
FROM dual;          

-- 상품데이터에서 상품입고일을 '2008-09-28' 형식으로 나오게 검색하시오 
---테이블 prod
-- TO_CHAR(CAST (buy_date as DATE), 'YYYY-MM-DD')
SELECT TO_CHAR( buy_date , 
                                'YYYY-MM-DD')
FROM buyprod;
------------------------------------------------------------
SELECT prod_insdate, 
            TO_CHAR  ( 'YYYY-MM-DD')
FROM prod;                                    

-- 회원 이름과 생일로 다음처럼 출력되게 하세요 

SELECT mem_name , mem_bir,
                (
                mem_name || '은(는)' ||
                TO_CHAR(mem_bir, 'yyyy') || '년'||
                 TO_CHAR(mem_bir, 'mon') ||
                 '월 출생이고 태어난 요일은 ' ||
                 TO_CHAR(mem_bir, 'day')  || '입니다.'
                 ) as sumStr
FROM member;

-- 상품테이블에서 상품코드, 상품명, 매입가격, 소비자가격 , 판매가격을 출력하시오
SELECT prod_id , prod_name,
                TO_CHAR(prod_cost, 'L999,999,999') AS prod_cost,
                TO_CHAR(prod_price, 'L999,999,999') AS prod_price,
                TO_CHAR(prod_sale, 'L999,999,999') AS prod_sale
FROM prod;                

-- 회원 테이블에서 이쁜이 회원의 회원 id 2~4 문자열을 숫자형으로 치환한 후 10을 더해 새롭게 만드시오
SELECT mem_id,
            SUBSTR(mem_id, 1,2) | |
            (SUBSTR(mem_id,3, 4) + 10)
FROM  member
WHERE mem_name = '이쁜이';

-- AVG(column) 조회 범위 내 해당 컬럼 들의 평균값
/*
[규칙] 
일반컬럼과 그룹함수를 같이 사용할 경우에는
꼭 GROUP BY절을 넣어야 함
그리고 GROUP BY절에는 일반컬럼이 다 들어가야 한다
*/
SELECT AVG(DISTINCT prod_cost),AVG(All prod_cost),
            AVG(prod_cost) 매입가평균
FROM prod;            

SELECT prod_lgu,
                ROUND(AVG(prod_cost),2) "분류별 매입가격 평균"
FROM prod
GROUP BY prod_lgu ;

-- 상품테이블의 총 판매가격 평균값
SELECT AVG (prod_sale) as avg_sale
FROM prod;
-- 상품테이블의 상품분류별 판매가격 평균값을 구하시오 
SELECT prod_lgu, AVG(prod_sale) as avg_sale
FROM prod
GROUP BY prod_lgu;

-- 장바구니테이블의 회원별 count 집계하시오 

SELECT cart_member, count(cart_member) as mem_count 
FROM cart
GROUP BY cart_member;

/*
문제
구매수량의 전체평균 이상을 구매한 회원들의 아이디와 이름을 조회
*/
SELECT mem_id, mem_name
FROM member
WHERE mem_id IN(
            SELECT cart_member
            FROM cart
            WHERE cart_qty >= (
            SELECT AVG(cart_qty)
            FROM cart
            )
)            
ORDER BY mem_regno1 ASC;


