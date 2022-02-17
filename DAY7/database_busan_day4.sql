/*
ȸ������ �߿� ���ų����� �ִ� ȸ���� ���� 
ȸ�� ���̵�, ȸ���̸�, ����(yyyy-mm-dd)�� ��ȸ�Ͻÿ�
���� �������� �������� ����
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
                                WHERE lprod_nm = '������ȭ');

-- JOIN
-- CROSS JOIN
-- �Ϲݹ��
SELECT m.mem_id, c.cart_member, p.prod_id
FROM member m, cart c, lprod l, prod p, buyer b;

SELECT COUNT(*)
FROM member m, cart c, lprod l, prod p, buyer b;

-- ANSIǥ�� ���
SELECT *
FROM member  CROSS JOIN cart
                        CROSS JOIN prod 
                        CROSS JOIN lprod
                        CROSS JOIN buyer;
                        
-- EQUI JOIN (INNER JOIN)
-- �������ǽ��� ������ �� (PK�� FK�� ����)
/*
��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ
��ǰ���̺�: prod
�з����̺�: lprod
*/
-- �Ϲ� ���
SELECT prod.prod_id, prod.prod_name, lprod.lprod_nm
FROM prod, lprod
-- �������ǽ��� ���� ���� �ۼ�
WHERE prod.prod_lgu = lprod.lprod_gu;

--ANSI ����ǥ�ع��
SELECT prod.prod_id, prod.prod_name, lprod.lprod_nm
FROM prod INNER JOIN lprod
                    ON(prod.prod_lgu = lprod.lprod_gu);
                    
--TABLE JOIN 
SELECT  A.prod_id "��ǰ�ڵ�",
           A.prod_name "��ǰ��",
           B.lprod_nm "�з���",
           C.buyer_name "�ŷ�ó��"
FROM prod A, lprod B, buyer C
WHERE A.prod_lgu = B.lprod_gu
AND A.prod_buyer = C.buyer_id;

-- ����ǥ�� ���
SELECT  A.prod_id , A.prod_name , B.lprod_nm, C.buyer_name 
FROM  prod A INNER JOIN lprod B 
                             ON (A.prod_lgu= B.lprod_gu)
                    INNER JOIN buyer C
                            ON(A.prod_buyer = C.buyer_id);

/*
ȸ���� ������ �ŷ�ó ������ ��ȸ�Ϸ��� �Ѵ� 
ȸ�� ���̵�, ȸ���̸�, ��ǰ�ŷ�ó��,
��ǰ�з����� ��ȸ�Ͻÿ�
*/
-- ����� ���̺� : member, cart, prod, buyer, lprod
-- ��ȸ�� �÷� : mem_id, mem_name,, buyer_name, lprod_nm
-- �������� :
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
�ŷ�ó�� �Ｚ������ �ڷῡ ����
��ǰ�ڵ�, ��ǰ��, �ŷ�ó���� ��ȸ
*/ 
-- ���̺�: prod , buyer,
-- ��ȸ �÷�: prod_id , prod_name, buyer_name   
-- ��������: prod_ buyer= buyer_id
-- �Ϲ����� : buyer_name =  '�Ｚ����'
-- �Ϲ�
SELECT
    prod_id,
    prod_name,
    buyer_name
FROM
    prod,
    buyer
WHERE
        prod_buyer = buyer_id
    AND buyer_name = '�Ｚ����';
-- ����ǥ�ع��
SELECT
    prod_id,
    prod_name,
    buyer_name
FROM prod
INNER JOIN buyer ON ( prod_buyer = buyer_id
                          AND buyer_name = '�Ｚ����' );
-- WHERE buyer_name ='�Ｚ����';       
/*
��ǰ ���̺��� ��ǰ�ڵ�, ��ǰ��, ��ǰ�з���, �ŷ�ó��,
�ŷ�ó�ּҸ� ��ȸ
*/
-- ���̺�: prod , lprod , buyer 
-- ��ȸ �÷�: prod_id, prod_name, prod_name, buyer_name
-- ��������: prod_ lgu= lprod_gu , prod_buyer = buyer_id
-- �Ϲ����� : prod_sale <= 100000 , buyer_add1 LIKE "�λ�%"

SELECT prod_id, prod_name, lprod_nm, buyer_name
FROM prod, lprod, buyer
WHERE prod_lgu= lprod_gu
AND prod_buyer = buyer_id
AND prod_sale <= 100000
AND buyer_add1 LIKE '�λ�%' ;

-- ����ǥ��

SELECT prod_id, prod_name, prod_name, buyer_name
FROM prod INNER JOIN lprod
                    ON(prod_lgu= lprod_gu)
                 INNER JOIN buyer
                    ON(prod_buyer = buyer_id)
WHERE prod_sale <= 100000
AND buyer_add1 LIKE '�λ�%';

/*
��ǰ�з��ڵ尡 P101 �ΰͿ� ����
��ǰ�з���, ��ǰ���̵�, �ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ����� ��ȸ
��ǰ�з����� �������� �������� , ��ǰ ���̵� �������� �������� ����
*/
-- ���̺�: lprod, prod ,buyer, cart
-- ��ȸ �÷�: lprod_nm, prod_id, prod_sale, buyer_charger, 
--               cart_member, cart_qty, 
-- ��������: lprod_gu = prod_lgu, 
--               prod_id = cart_prod, 
--               prod_buyer = buyer_id
-- �Ϲ����� : lprod_gu = 'P101'
-- ��������  lprod_nm DESC, prod_id ASC
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, 
            cart_member, cart_qty
FROM   lprod, prod , buyer, cart
WHERE  lprod_gu = prod_lgu
AND  buyer_id = prod_buyer
AND prod_id = cart_prod
AND lprod_gu = 'P101'
ORDER BY lprod_nm DESC, prod_id ASC;

-- ����ǥ��
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

