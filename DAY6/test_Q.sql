/*
1. ��ö�� �� ���� �� TV �� ���峪�� ��ȯ�������� �Ѵ�
��ȯ�������� �ŷ�ó ��ȭ��ȣ�� �̿��ؾ� �Ѵ�.
����ó�� ��ȭ��ȣ�� ��ȸ�Ͻÿ�.
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
                                WHERE mem_name = '��ö��'))
    AND prod_name = '�Ｚ Į�� TV 53��ġ');
/*       
2. ������ ��� 73�����Ŀ� �¾ �ֺε��� 2005��4���� ������ ��ǰ�� ��ȸ�ϰ�, 
�׻�ǰ�� ���ŷ�ó�� �ŷ��ϴ� ������ ���¹�ȣ�� �����ÿ�.
(��, �����-���¹�ȣ)
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
                WHERE mem_add1 LIKE '%����%'
                AND mem_job = '�ֺ�'
                AND mem_regno1 >= 730000)
                AND cart_no LIKE '200504%'));                   
/*
3. ������ ������ ȸ���� �� 5���̻� ������ ȸ���� 4�����Ϸ� ������ ȸ������ ������ �������� �ٸ� ������ ������ �����̴�. 
ȸ������ ����Ƚ���� ����  ������������ �����ϰ�  ȸ������ ȸ��id�� ��ȭ��ȣ(HP)�� ��ȸ�϶�.
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
                


 
 