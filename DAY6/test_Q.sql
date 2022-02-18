/*
1. 오철희가 산 물건 중 TV 가 고장나서 교환받으려고 한다
교환받으려면 거래처 전화번호를 이용해야 한다.
구매처와 전화번호를 조회하시오.
*/
SELECT buyer_name, buyer_comtel
FROM buyer
WHERE buyer_id IN (
        SELECT prod_buyer
        FROM prod
        WHERE prod_id IN( 
                        SELECT cart_prod
                        FROM cart
                        WHERE cart_member IN(
                                SELECT mem_id
                                FROM member
                                WHERE mem_name = '오철희'))
    AND prod_name = '삼성 칼라 TV 53인치');
/*       
2. 대전에 사는 73년이후에 태어난 주부들중 2005년4월에 구매한 물품을 조회하고, 
그상품의 각거래처의 거래하는 은행명과 계좌번호를 뽑으시오.
(단, 은행명-계좌번호)
*/ 
SELECT buyer_bank
    , buyer_bankno
    FROM buyer
    WHERE buyer_id IN(
        SELECT prod_buyer
        FROM prod
        WHERE prod_id IN(
            SELECT cart_prod
            FROM cart
            WHERE cart_member IN(
                SELECT mem_id
                FROM member
                WHERE mem_add1 LIKE '%대전%'
                AND mem_job = '주부'
                AND mem_regno1 >= 730000)
                AND cart_no LIKE '200504%'));                   
/*
3. 물건을 구매한 회원들 중 5개이상 구매한 회원과 4개이하로 구매한 회원에게 쿠폰을 할인율이 다른 쿠폰을 발행할 예정이다. 
회원들을 구매횟수에 따라  오름차순으로 정렬하고  회원들의 회원id와 전화번호(HP)를 조회하라.
*/

SELECT mem_id, mem_hp,
                ( 
                SELECT sum(cart_qty)
                FROM cart
                WHERE (cart_qty >= 5
                            or cart_qty <= 4)
                    AND cart_member = member.mem_id
                )  as  qty
FROM member
WHERE mem_id IN(
                            SELECT cart_member
                            FROM cart
                            WHERE cart_qty >= 5
                            OR cart_qty<= 4
                            )
ORDER BY qty Asc;                             
                


 
 