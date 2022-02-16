-- HAVING (그룹조건== 비교연산)
-- COUNT(*) : 선택된 자료의 수 전체조회 대상 컬럼에서 NULL은 대상 외
-- COUNT(col): 조회 범위 내 해당 컬럼들의 자료 수 
/*
구매내역(장바구니) 정보에서 회원아이디 별로 주문에 대한 평균을 조회하시오 
회원아이디 기준으로 내림차순
*/
SELECT cart_member ,  AVG(cart_qty) as cart_qty
FROM cart
GROUP BY cart_member
ORDER BY cart_member ;

/*
상품정보에서 판매가격의 평균값을 구하시오 
단, 평균값은 소수점 2째자리까지 표현하기
*/

SELECT ROUND(AVG(prod_sale),2) as prod_avg
FROM prod;

/*
상품정보에서 상품분류별 판매가격의 평균값을 구하시오
조회 컬럼은 상품분류코드, 상품분류별 판매가격의 평균
단 평균값은 소수점 둘째자리까지 표현
*/
SELECT  prod_lgu, 
                ROUND(AVG (prod_sale),2) as avg_sale
FROM prod
GROUP BY  prod_lgu;

-- 회원테이블의 취미종류수를 COUNT집계하시오 
SELECT COUNT(DISTINCT mem_like)  취미종류수
FROM member;

-- 회원테이블의 취미별 COUNT집계하시오
SELECT mem_like 취미,
                COUNT(mem_like) 자료수, COUNT(*) "자료수(*)"
FROM member
GROUP BY mem_like;

-- 회원테이블의 직업종류수를 COUNT 집계하시오 
SELECT mem_job 직업,
                COUNT(mem_job) 직업종류수
FROM member
GROUP BY mem_job
ORDER BY 직업종류수 DESC;

/*
회원 전체의 마일리지 평균보다 큰 회원에 대한 
아이디, 이름, 마일리지를 조회하시오 
정렬은 마일리지가 높은순으로 
*/
SELECT mem_id, mem_name, mem_mileage
FROM member
WHERE mem_mileage >= (SELECT AVG(mem_mileage) 
                    FROM member)
ORDER BY mem_mileage DESC;

SELECT *
FROM cart;

-- 장바구니테이블의 회원별 최대구매수량을 검색하시오 
SELECT cart_member,
            MAX(DISTINCT cart_qty) "최대수량(DISTINCT)",            
            MAX(cart_qty) 최대수량,
            MIN(DISTINCT cart_qty) "최소수량(DISTINCT)",
            MIN(cart_qty) 최소수량
FROM cart
GROUP BY cart_member;

-- 오늘이 2005년 7월 11일이라 가정하고 장바구니테이블에 발생될 추가주문번호를 검색하시오
SELECT MAX(cart_no), MAX(cart_no) +1 
FROM cart
WHERE cart_no like '20050711%' ;

/*
구매정보에서 년도별로 판매된 상품의 갯수,
평균구매수량을 조회,
정렬은 년도를 기준으로 내림차순
*/
SELECT SUBSTR (cart_no, 1, 4) as yyyy,
            sum(cart_qty) as sum_qty,
            avg(cart_qty) as avg_qty
FROM cart
GROUP BY SUBSTR (cart_no, 1, 4) 
ORDER BY yyyy DESC; 

/*
구매정보에서 년도별, 상품분류코드별로 상품의 갯수를
조회하려고 한다(상품갯수는 COUNT함수로)
정렬은 년도를 기준으로 내림차순
*/
SELECT SUBSTR(cart_no ,1,4) as yyyy, 
            SUBSTR(cart_prod, 1, 4) as sub_prod,
            COUNT(cart_prod) as cnt_prod
FROM cart
GROUP BY SUBSTR(cart_no ,1,4), 
                SUBSTR(cart_prod, 1, 4) 
ORDER BY yyyy DESC;

-- 장바구니테이블의 상품분류별 판매수량의 합계 값
SELECT SUBSTR(cart_prod, 0, 4) 상품분류,
            SUM(cart_qty) "판매수량 합계"
FROM cart
GROUP BY SUBSTR(cart_prod,0, 4);

-- 회원 테이블의 회원전체의 마일리지 평균, 마일리지 합계, 
-- 최고 마일리지, 최소 마일리지, 인원 수를 검색하시오
-- alias = 마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 인원수)

SELECT ROUND(
            avg(mem_mileage),2) as avg_m,
            sum(mem_mileage) as sum_m,
            max(mem_mileage) as max_m,
            min(mem_mileage) as min_m,
            count(mem_mileage) as cou_m
FROM member;
-- 상품테이블에서 상품분류별 판매가 전체의 
-- 평균, 합계, 최고값, 최소값, 자료수를 구하시오
-- 자료수가 20이상인 것
SELECT  prod_lgu,
            ROUND(avg(prod_sale),2)  as 평균,
            sum(prod_sale) as 합계,
            max(prod_sale) as 최고값,
            min(prod_sale) as 최소값,
            count(prod_sale) as 자료수
FROM prod
GROUP BY prod_lgu
HAVING count(prod_sale) >= 20 ;

-- WHERE절: 일반조건만 사용
-- HAVING절: 그룹조건만 사용(그룹함수를 사용한 조건처리)

-- 회원테이블에서 지역(주소1의 2자리), 생일년도별로 마일리지평균, 마일리지 합계
-- 최고마일리지, 최소 마일리지, 자료수를 검색하시오 
-- ALIAS는 지역, 생일연도, 마일리지평균, 마일리지합계, 최고 마일리지, 최소마일리지, 자료수

SELECT SUBSTR(mem_add1,1, 2) as 지역, 
            TO_CHAR(mem_bir,'yyyy') as 생일연도,
            avg(mem_mileage)  as 마일리지평균,
            sum(mem_mileage) as 마일리지합계,
            max(mem_mileage) as 최고마일리지,
            min(mem_mileage) as 최소마일리지,
            count(mem_mileage) as 자료수
FROM member
GROUP BY SUBSTR(mem_add1,1, 2),
                TO_CHAR(mem_bir,'yyyy');
                
-- NULL 값 처리(오라클은 빈 공백도 NULL로 인식한다.)

-- NULL값 넣기
UPDATE buyer SET buyer_charger = NULL
WHERE buyer_charger LIKE '김%';

-- NULL값 처리하기
UPDATE buyer SET buyer_charger =''
WHERE buyer_charger LIKE '성%';

-- 해당 컬럼이 NULL값 비교조회
SELECT buyer_name 거래처 , buyer_charger 담당자
    FROM buyer
WHERE buyer_charger IS NOT NULL;

-- 해당 컬럼이 NULL일 경우 대신할 문자나 숫자 치환
-- NULL값 포함해서 나타내기
SELECT buyer_name 거래처 , buyer_charger 담당자
    FROM buyer;


-- 회원 마일리지에 100을 더한수치를 검색하시오 NVL사용
SELECT  mem_name, mem_mileage, 
            (NVL(mem_mileage,0) +100) as mileage_100
FROM member;
-- 회원 마일리지가 있으면 '정상회원', null이면 '비정상회원으로 검색하시오
-- nvl2 이용
SELECT  mem_name, mem_mileage, 
            (NVL2(mem_mileage,'정상', '비정상'))  as mileage_null
FROM member;

SELECT DECODE(9,10,'A',9,'B',8,'C','D')
FROM dual;

SELECT DECODE(SUBSTR(prod_lgu,1,2),
                        'P1' ,'컴퓨터/전자 제품',
                        'P2' , '의류',
                        'P3' , '잡화', '기타')
FROM prod;               
/*
상품 분류중 앞의 두 글자가 'P1'이면 판매가를 `10% 인상하고 'P2'이면
판매가를 15% 인상하고 나머지는 동일가로 검색하시오
*/
SELECT prod_name, prod_sale,
            DECODE(SUBSTR(prod_lgu,1,2),
                        'P1' , prod_sale + (prod_sale *(10/100)),
                        'P2' , prod_sale * 1.15)  as new_sale
FROM prod;  

-- 회원정보테이블의 주민등록번호 뒷자리에서 성별구분
SELECT mem_name, 
            (mem_regno1 | | '-'  | | mem_regno2) as regno,
        case
            when SUBSTR( mem_regno2,1,1) = 1
                    THEN '남자'
                ELSE  '여자'
                END AS mf
FROM member;

                    
    


