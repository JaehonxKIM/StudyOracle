-- HAVING (�׷�����== �񱳿���)
-- COUNT(*) : ���õ� �ڷ��� �� ��ü��ȸ ��� �÷����� NULL�� ��� ��
-- COUNT(col): ��ȸ ���� �� �ش� �÷����� �ڷ� �� 
/*
���ų���(��ٱ���) �������� ȸ�����̵� ���� �ֹ��� ���� ����� ��ȸ�Ͻÿ� 
ȸ�����̵� �������� ��������
*/
SELECT cart_member ,  AVG(cart_qty) as cart_qty
FROM cart
GROUP BY cart_member
ORDER BY cart_member ;

/*
��ǰ�������� �ǸŰ����� ��հ��� ���Ͻÿ� 
��, ��հ��� �Ҽ��� 2°�ڸ����� ǥ���ϱ�
*/

SELECT ROUND(AVG(prod_sale),2) as prod_avg
FROM prod;

/*
��ǰ�������� ��ǰ�з��� �ǸŰ����� ��հ��� ���Ͻÿ�
��ȸ �÷��� ��ǰ�з��ڵ�, ��ǰ�з��� �ǸŰ����� ���
�� ��հ��� �Ҽ��� ��°�ڸ����� ǥ��
*/
SELECT  prod_lgu, 
                ROUND(AVG (prod_sale),2) as avg_sale
FROM prod
GROUP BY  prod_lgu;

-- ȸ�����̺��� ����������� COUNT�����Ͻÿ� 
SELECT COUNT(DISTINCT mem_like)  ���������
FROM member;

-- ȸ�����̺��� ��̺� COUNT�����Ͻÿ�
SELECT mem_like ���,
                COUNT(mem_like) �ڷ��, COUNT(*) "�ڷ��(*)"
FROM member
GROUP BY mem_like;

-- ȸ�����̺��� ������������ COUNT �����Ͻÿ� 
SELECT mem_job ����,
                COUNT(mem_job) ����������
FROM member
GROUP BY mem_job
ORDER BY ���������� DESC;

/*
ȸ�� ��ü�� ���ϸ��� ��պ��� ū ȸ���� ���� 
���̵�, �̸�, ���ϸ����� ��ȸ�Ͻÿ� 
������ ���ϸ����� ���������� 
*/
SELECT mem_id, mem_name, mem_mileage
FROM member
WHERE mem_mileage >= (SELECT AVG(mem_mileage) 
                    FROM member)
ORDER BY mem_mileage DESC;

SELECT *
FROM cart;

-- ��ٱ������̺��� ȸ���� �ִ뱸�ż����� �˻��Ͻÿ� 
SELECT cart_member,
            MAX(DISTINCT cart_qty) "�ִ����(DISTINCT)",            
            MAX(cart_qty) �ִ����,
            MIN(DISTINCT cart_qty) "�ּҼ���(DISTINCT)",
            MIN(cart_qty) �ּҼ���
FROM cart
GROUP BY cart_member;

-- ������ 2005�� 7�� 11���̶� �����ϰ� ��ٱ������̺� �߻��� �߰��ֹ���ȣ�� �˻��Ͻÿ�
SELECT MAX(cart_no), MAX(cart_no) +1 
FROM cart
WHERE cart_no like '20050711%' ;

/*
������������ �⵵���� �Ǹŵ� ��ǰ�� ����,
��ձ��ż����� ��ȸ,
������ �⵵�� �������� ��������
*/
SELECT SUBSTR (cart_no, 1, 4) as yyyy,
            sum(cart_qty) as sum_qty,
            avg(cart_qty) as avg_qty
FROM cart
GROUP BY SUBSTR (cart_no, 1, 4) 
ORDER BY yyyy DESC; 

/*
������������ �⵵��, ��ǰ�з��ڵ庰�� ��ǰ�� ������
��ȸ�Ϸ��� �Ѵ�(��ǰ������ COUNT�Լ���)
������ �⵵�� �������� ��������
*/
SELECT SUBSTR(cart_no ,1,4) as yyyy, 
            SUBSTR(cart_prod, 1, 4) as sub_prod,
            COUNT(cart_prod) as cnt_prod
FROM cart
GROUP BY SUBSTR(cart_no ,1,4), 
                SUBSTR(cart_prod, 1, 4) 
ORDER BY yyyy DESC;

-- ��ٱ������̺��� ��ǰ�з��� �Ǹż����� �հ� ��
SELECT SUBSTR(cart_prod, 0, 4) ��ǰ�з�,
            SUM(cart_qty) "�Ǹż��� �հ�"
FROM cart
GROUP BY SUBSTR(cart_prod,0, 4);

-- ȸ�� ���̺��� ȸ����ü�� ���ϸ��� ���, ���ϸ��� �հ�, 
-- �ְ� ���ϸ���, �ּ� ���ϸ���, �ο� ���� �˻��Ͻÿ�
-- alias = ���ϸ������, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ο���)

SELECT ROUND(
            avg(mem_mileage),2) as avg_m,
            sum(mem_mileage) as sum_m,
            max(mem_mileage) as max_m,
            min(mem_mileage) as min_m,
            count(mem_mileage) as cou_m
FROM member;
-- ��ǰ���̺��� ��ǰ�з��� �ǸŰ� ��ü�� 
-- ���, �հ�, �ְ�, �ּҰ�, �ڷ���� ���Ͻÿ�
-- �ڷ���� 20�̻��� ��
SELECT  prod_lgu,
            ROUND(avg(prod_sale),2)  as ���,
            sum(prod_sale) as �հ�,
            max(prod_sale) as �ְ�,
            min(prod_sale) as �ּҰ�,
            count(prod_sale) as �ڷ��
FROM prod
GROUP BY prod_lgu
HAVING count(prod_sale) >= 20 ;

-- WHERE��: �Ϲ����Ǹ� ���
-- HAVING��: �׷����Ǹ� ���(�׷��Լ��� ����� ����ó��)

-- ȸ�����̺��� ����(�ּ�1�� 2�ڸ�), ���ϳ⵵���� ���ϸ������, ���ϸ��� �հ�
-- �ְ��ϸ���, �ּ� ���ϸ���, �ڷ���� �˻��Ͻÿ� 
-- ALIAS�� ����, ���Ͽ���, ���ϸ������, ���ϸ����հ�, �ְ� ���ϸ���, �ּҸ��ϸ���, �ڷ��

SELECT SUBSTR(mem_add1,1, 2) as ����, 
            TO_CHAR(mem_bir,'yyyy') as ���Ͽ���,
            avg(mem_mileage)  as ���ϸ������,
            sum(mem_mileage) as ���ϸ����հ�,
            max(mem_mileage) as �ְ��ϸ���,
            min(mem_mileage) as �ּҸ��ϸ���,
            count(mem_mileage) as �ڷ��
FROM member
GROUP BY SUBSTR(mem_add1,1, 2),
                TO_CHAR(mem_bir,'yyyy');
                
-- NULL �� ó��(����Ŭ�� �� ���鵵 NULL�� �ν��Ѵ�.)

-- NULL�� �ֱ�
UPDATE buyer SET buyer_charger = NULL
WHERE buyer_charger LIKE '��%';

-- NULL�� ó���ϱ�
UPDATE buyer SET buyer_charger =''
WHERE buyer_charger LIKE '��%';

-- �ش� �÷��� NULL�� ����ȸ
SELECT buyer_name �ŷ�ó , buyer_charger �����
    FROM buyer
WHERE buyer_charger IS NOT NULL;

-- �ش� �÷��� NULL�� ��� ����� ���ڳ� ���� ġȯ
-- NULL�� �����ؼ� ��Ÿ����
SELECT buyer_name �ŷ�ó , buyer_charger �����
    FROM buyer;


-- ȸ�� ���ϸ����� 100�� ���Ѽ�ġ�� �˻��Ͻÿ� NVL���
SELECT  mem_name, mem_mileage, 
            (NVL(mem_mileage,0) +100) as mileage_100
FROM member;
-- ȸ�� ���ϸ����� ������ '����ȸ��', null�̸� '������ȸ������ �˻��Ͻÿ�
-- nvl2 �̿�
SELECT  mem_name, mem_mileage, 
            (NVL2(mem_mileage,'����', '������'))  as mileage_null
FROM member;

SELECT DECODE(9,10,'A',9,'B',8,'C','D')
FROM dual;

SELECT DECODE(SUBSTR(prod_lgu,1,2),
                        'P1' ,'��ǻ��/���� ��ǰ',
                        'P2' , '�Ƿ�',
                        'P3' , '��ȭ', '��Ÿ')
FROM prod;               
/*
��ǰ �з��� ���� �� ���ڰ� 'P1'�̸� �ǸŰ��� `10% �λ��ϰ� 'P2'�̸�
�ǸŰ��� 15% �λ��ϰ� �������� ���ϰ��� �˻��Ͻÿ�
*/
SELECT prod_name, prod_sale,
            DECODE(SUBSTR(prod_lgu,1,2),
                        'P1' , prod_sale + (prod_sale *(10/100)),
                        'P2' , prod_sale * 1.15)  as new_sale
FROM prod;  

-- ȸ���������̺��� �ֹε�Ϲ�ȣ ���ڸ����� ��������
SELECT mem_name, 
            (mem_regno1 | | '-'  | | mem_regno2) as regno,
        case
            when SUBSTR( mem_regno2,1,1) = 1
                    THEN '����'
                ELSE  '����'
                END AS mf
FROM member;

                    
    


