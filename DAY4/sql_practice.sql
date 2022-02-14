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
                                                                
                                                                
        


