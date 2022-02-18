/*
��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ�ϼ��� 
��, ��ǰ�з��ڵ尡 'P101', 'P201','P301'�ΰͿ� ���� ��ȸ�ϰ� 
���Լ����� 15�� �̻��ΰ͵��
'����'�� ��� �ִ� ȸ�� �߿� ������ 1974����� ����鿡 ���� ��ȸ�Ͻÿ� 
������ ȸ�� ���̵� �������� ��������, ���Լ����� �������� ��������
*/

/* 
����� ���̺� : prod, cart, buyprod, buyer, lprod, member
��ȸ�� �÷� : prod_lgu, prod_name, prod_color,
                  buy_qty, cart_qty, buyer_name
��������: 
            lprod_gu = prod_lgu, 
            buyer_id = prod_buyer, 
            prod_id =  buy_prod,
            prod_id = cart_prod, 
            mem_id = cart_member                 
�Ϲ�����: 
            lprod_gu IN('P101', 'P201', 'P301')
            buy_qty >= 15
            mem_add1 like '����%'
            TO_CHAR(mem_bir, 'yyyy')= '1974' 
��������: mem_id ASC , buy_qty ASC
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
    AND mem_add1 like '����%'
    AND  TO_CHAR(mem_bir, 'yyyy')= '1974' 
ORDER BY  mem_id DESC, buy_qty DESC;

-- OUTER JOIN 
/* 
�� ���̺��� ������ �� ���� ���ǽ��� ������Ű�� ���ϴ� ROW�� 
�˻����� ������ �Ǵµ� ������ ROW���� �˻��ǵ��� �ϴ� ���
*/
-- 1. �з����̺� ��ȸ 
SELECT * 
FROM lprod;
-- 2. �Ϲ� INNER JOIN
SELECT lprod_gu, lprod_nm,
            COUNT(prod_lgu) ��ǰ�ڷ��
FROM lprod, prod
WHERE lprod_gu = prod_lgu
GROUP BY lprod_gu, lprod_nm;

-- 3. OUTER JOIN 
SELECT * 
FROM lprod;
-- 2. �Ϲ� INNER JOIN
SELECT lprod_gu �з��ڵ� , lprod_nm �з���,
          COUNT(prod_lgu) ��ǰ�ڷ��
FROM lprod, prod
WHERE lprod_gu = prod_lgu (+)
GROUP BY lprod_gu, lprod_nm;

--ANSI ǥ��

SELECT lprod_gu, lprod_nm,
            COUNT(prod_lgu) ��ǰ�ڷ��
FROM lprod
            LEFT OUTER JOIN prod 
            ON(lprod_gu = prod_lgu)
GROUP BY lprod_gu, lprod_nm
ORDER BY lprod_gu;

-- ��ü��ǰ�� 2005�� 1�� �԰���� �˻�
--  ��ǰ�ڵ�, ��ǰ��, �԰����
SELECT  prod_id ��ǰ�ڵ�, 
            prod_name ��ǰ��, 
            SUM(buy_qty) �԰����
FROM prod, buyprod
WHERE prod_id = buy_prod
AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
GROUP BY prod_id, prod_name;

-- ANSI OUTER JOIN
SELECT prod_id ��ǰ�ڵ�,
prod_name ��ǰ��,
SUM(NVL(buy_qty,0)) �԰����
FROM prod LEFT OUTER JOIN buyprod
                    ON(prod_id = buy_prod
                        AND buy_date BETWEEN '2005-01-01' AND '2005-01-01')
GROUP BY prod_id, prod_name
ORDER BY prod_id, prod_name;

-- �Ϲ� ����
-- ��ü ȸ���� 2005�⵵ 4���� ������Ȳ ��ȸ
-- ȸ��ID, ����, ���ż����� ��
-- mem_id = cart_prod
SELECT mem_id, mem_name,
SUM(cart_qty)
FROM member, cart
WHERE  mem_id = cart_member
AND SUBSTR(cart_no,1,6) = '200504'
GROUP BY mem_id, mem_name
ORDER BY mem_id, mem_name;

-- ǥ�� ���
SELECT mem_id ȸ��ID, mem_name ȸ����,
SUM(cart_qty) ���ż�����
FROM member LEFT OUTER JOIN cart
                        ON(mem_id = cart_member
                        AND SUBSTR(cart_no,1,6) = '200504')
GROUP BY mem_id, mem_name
ORDER BY mem_id, mem_name;

--2005�⵵ ���� ���� ��Ȳ�� �˻��Ͻÿ� 
-- ���Կ�, ���Լ���, ���Աݾ�(���Լ���*��ǰ���̺��� ���԰�)
SELECT  SUBSTR(cart_no,5,2) as mm,
SUM(cart_qty) as sum_qty,
SUM(cart_qty * prod_sale) as sum_total
FROM  cart, prod
WHERE cart_prod = prod_id
AND SUBSTR(cart_no,1,4) = '2005'
GROUP BY SUBSTR(cart_no,5,2);

-- HAVING ��
-- ��ǰ�з��� ��ǻ����ǰ('P101')�� ��ǰ�� 2005�⵵ ���ں� �Ǹ���ȸ
-- ����: �Ǹ���, �Ǹűݾ�(500���� �ʰ��� ��츸), �Ǹż���
SELECT SUBSTR(cart_no,1,8) "�Ǹ���",
            SUM(cart_qty* prod_sale) "�Ǹűݾ�",
            SUM(cart_qty) "�Ǹż���"
FROM prod, cart
WHERE cart_no like '2005%'
            AND prod_id = cart_prod
            AND prod_lgu ='P101'
GROUP BY SUBSTR(cart_no,1,8) 
HAVING SUM(cart_qty* prod_sale) > 5000000
ORDER BY SUBSTR(cart_no,1,8);

-- ��������
/*
 1. SQL ���� �ȿ� �� �ٸ� SELECT ������ �ִ� ���� ���Ѵ�.
 2. ���������� ��ȣ�� ���´�.
 3. �����ڿ� ����� ��� �����ʿ� ��ġ�Ѵ�.
 4. ���� ������ �������� ������ ������ ���ο� ���� ���� �Ǵ� �񿬰� ���������� ����
* ANY, ALL�� �񱳿����ڿ� ���յȴ�
* ANY�� OR�� ��� ����̶� ������ TRUE
* ALL�� AND�� ���
*/
