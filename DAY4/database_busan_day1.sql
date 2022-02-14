-- ���̺� �����
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
    
-- ��ȸ�ϱ�
SELECT *
FROM  lprod;

--������ �Է��ϱ�.
INSERT INTO lprod(
 lprod_id , lprod_gu, lprod_nm
) Values (
1, 'P101', '��ǻ����ǰ'
);

-- ��ǰ�з��������� ��ǰ�з��ڵ��� ���� 
-- P201�� �����͸� ��ȸ ���ּ���...
SELECT *
FROM lprod
WHERE lprod_gu > 'P201';

-- ��ǰ�з��ڵ尡 P102�� ���ؼ�
-- ��ǰ�з����� ���� ����� ������ �ּ���..(������ �����ϱ�)

SELECT *
FROM lprod
WHERE lprod_gu = 'P102';
-------------------------------------
UPDATE lprod
    SET lprod_nm = '���'
WHERE lprod_gu = 'P102';
-- ��ǰ�з���������
-- ��ǰ�з��ڵ尡 P202�� ���� �����͸� �������ּ���..
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
-- ���̺� �� �ٲٱ� 

 ALTER TABLE buyer
        ADD(CONSTRAINT pk_buyer Primary Key (buyer_id),
                    CONSTRAINT fr_buyer_lprod FOREIGN Key(buyer_lgu)
                                                                REFERENCES lprod(lprod_gu) );

-- ������ ����
/*
lprod :��ǰ�з�����
prod : ��ǰ����
buyer: �ŷ�ó����
member: ȸ������
cart: ��������
buyprod: �԰��ǰ����
remain: ����������
*/

-- Ư�� column�� �˻�

SELECT mem_id, mem_name
FROM member;

-- 1. ���̺� ã��
-- 2. ������ �ִ���?
-- 3. � �÷��� ����ϴ���

-- ��ǰ�ڵ�� ��ǰ���� ��ȸ�Ͻÿ�
SELECT prod_id, prod_name
FROM prod;

-- ������� ����� �˻�
-- ȸ�����̺��� ���ϸ����� 12�� ���� ���� �˻��Ͻÿ�
SELECT * 
FROM member;

SELECT mem_mileage, 
                (mem_mileage /12) as mem_12 
FROM member;
 
 -- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ��� �˻��Ͻÿ�
 
 SELECT prod_id, prod_name, 
                (prod_sale*55) as prod_sale
      FROM prod;
      
-- �ߺ��� row�� ���� 
--SELECT distinct column From ���̺� ��

-- ��ǰ ���̺��� �ŷ�ó �ڵ带 �ߺ����� �ʰ� �˻��Ͻÿ�
SELECT DISTINCT prod_buyer
     FROM prod;
-- ȸ�����̺��� 
-- ȸ�� ID ,ȸ����, ����, ���ϸ��� �˻�
SELECT mem_id, mem_name, mem_bir,
                mem_mileage
FROM member
ORDER BY mem_id ASC;
-- ��Ī ������
SELECT mem_id as id,
                mem_name as nm,
                mem_bir, mem_mileage
FROM member
ORDER BY id ASC;

-- WHERE ��
-- �񱳿����� = , > , <, >=, <=

-- ��ǰ�� �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT prod_name ��ǰ , prod_sale �ǸŰ�
FROM prod
WHERE prod_sale = 170000;

-- ��ǰ �ǸŰ����� 170,000�� �ʰ��ϴ� ��ǰ
SELECT prod_name ��ǰ , prod_sale �ǸŰ�
FROM prod
WHERE prod_sale >170000
ORDER BY prod_sale asc;

-- ��ǰ �߿� ���԰����� 200,000�� ������ ��ǰ�˻�
-- ��ǰ�� ��������

SELECT  prod_id, prod_cost , prod_name 
FROM prod
WHERE prod_sale <=200000
ORDER BY prod_id  DESC;

-- ȸ���߿� 76�⵵ 1��1�� ���Ŀ� �¾
-- ȸ��ID, ȸ���̸�, �ֹε�Ϲ�ȣ ���ڸ� ��ȸ
-- �� ȸ�� ID ��������

SELECT mem_id, mem_name, mem_regno1
      FROM member
      WHERE mem_regno1 >= 760101
      ORDER BY mem_id ASC;
      
-- �������� AND, OR, NOT
-- ��ǰ �� ��ǰ�з��� P201�̰� �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_lgu ��ǰ�з� , prod_sale �ǸŰ�
    FROM prod
WHERE prod_lgu = 'P201'
    AND prod_sale = 170000;

-- ��ǰ �� ��ǰ�з��� p201 �̰ų� �ǸŰ��� 170.000�� �� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_lgu ��ǰ�з� , prod_sale �ǸŰ�
    FROM prod
WHERE prod_lgu = 'P201'
    OR prod_sale = 170000;
    
-- ��ǰ �� ��ǰ�з��� p201�� �ƴϰ�  �ǸŰ��� 170.000���� �ƴ� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_lgu ��ǰ�з� , prod_sale �ǸŰ�
    FROM prod
WHERE prod_lgu  != 'P201'
    AND prod_sale != 170000;
    
-- ��ǰ �� �ǸŰ��� 300,000�� �̻�, 500,000�� ������ ��ǰ�� �˻��Ͻÿ�
SELECT prod_id  , prod_name  , prod_sale 
    FROM prod
WHERE prod_sale >= 300000 
    AND prod_sale <= 500000;
/*
��ǰ �߿� �ǸŰ����� 15����, 17���� , 33������ ��ǰ���� ��ȸ
��ǰ�ڵ�, ��ǰ��, �ǸŰ��� ��ȸ
������ ��ǰ���� �������� ��������
*/
SELECT prod_id  , prod_name  , prod_sale 
    FROM prod
WHERE prod_sale = 150000
    OR prod_sale = 170000
    OR prod_sale = 330000
ORDER BY prod_name DESC;

/*
ȸ�� �߿� ���̵� C001, F001, W001�� ȸ�� ��ȸ 
ȸ�����̵�, ȸ���̸� ��ȸ
������ �ֹι�ȣ ���ڸ� ���� ��������
*/
SELECT mem_id  , mem_name
    FROM member
WHERE mem_id = 'c001'
    OR mem_id = 'f001'
    OR mem_id = 'w001'
ORDER BY mem_regno1  ASC;
