--- database_busan_day1�� �̾ 

-- ��ǰ�з����̺��� ���� ��ǰ���̺� �����ϴ� �з��� �˻�
-- (�з��ڵ�, �з���)  IN ��� * �����÷��� ������ �϶� ����� �� ����
SELECT lprod_gu �з��ڵ� , lprod_nm �з���
FROM lprod
WHERE lprod_gu IN(SELECT prod_lgu FROM prod);

-- ��ǰ�з����̺��� ���� ��ǰ���̺� �������� �ʴ� �з��� �˻�
SELECT lprod_gu �з��ڵ� , lprod_nm �з���
FROM lprod
WHERE lprod_gu NOT IN(SELECT prod_lgu FROM prod);

/*
����
�ѹ��� ��ǰ�� ������ ���� ���� 
ȸ��ID, �̸� ��ȸ
*/
-- ���̺� ã�� : prod, cart ,member
-- ��ȸ�� �÷� ã��: mem_id, mem_name
-- ���� �ִ��� Ȯ��
SELECT mem_id , mem_name
FROM member 
WHERE mem_id  NOT IN(
                                            SELECT cart_member
                                            FROM cart
                                            );
-- �ѹ��� �Ǹŵ� ���� ���� ��ǰ�� ��ȸ
-- ���̺� ã�� : prod, cart
-- ��ȸ�� �÷� ã��: prod_name
-- ���� �ִ��� Ȯ��
 SELECT prod_name
FROM  prod
    WHERE prod_id  NOT IN(
                                            SELECT cart_prod
                                            FROM cart);
                                            
-- ȸ�� �� �����밡 ���ݱ��� �����ߴ� ��� ��ǰ�� ��ȸ
-- ���̺� ã�� : prod, member, cart
-- ��ȸ�� �÷� ã��: prod_name
-- ���� �ִ��� Ȯ�� ȸ�� �̸��� ������ mem_name = '������'
SELECT prod_name
FROM prod
WHERE prod_id IN(
                        SELECT cart_prod
                        FROM cart
                        WHERE cart_member IN(
                                            SELECT mem_id
                                            FROM member
                                            WHERE mem_name= '������')                                    
);

/*
��ǰ �� �ǸŰ����� 10���� �̻� 30���� ������ ��ǰ�� ��ȸ
�ǸŰ��� �������� �������� 
*/
SELECT   prod_name  , prod_sale 
    FROM prod
WHERE prod_sale >= 100000 
    AND prod_sale <= 300000
    ORDER BY prod_sale DESC;

-- BETWEEN ���� ���� ��� ���� Ž��, �� ������ �Ѱ谪�� ������
SELECT prod_name ��ǰ , prod_sale �ǸŰ� 
FROM prod
WHERE prod_sale BETWEEN 100000 AND 300000;

--ȸ�� �� ������ 1975�� ������ 1976�� ���� ��ȸ�Ͻÿ� 
SELECT *
FROM member
WHERE mem_regno1 BETWEEN '75-01-01' AND '76-12-31';

-- �ŷ�ó ����� �������� �� ����ϴ� ��ǰ�� ������ ȸ������ ��ȸ
-- ȸ�� ���̵� ��ȸ
-- ��ȸ�� �÷�: mem_id, mem_name
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
                                                WHERE buyer_charger = '������')
)
)
);
/*
��ǰ �� ���԰��� 30����~150���� �̰� �ǸŰ��� 80����~200������ ��ǰ�� �˻��Ͻÿ�
��ǰ�� ���԰� �ǸŰ� 
*/
SELECT prod_name ��ǰ��, prod_cost ���԰� , prod_sale �ǸŰ�
FROM prod
WHERE prod_cost BETWEEN 300000 AND 1500000
AND prod_sale BETWEEN  800000 AND 2000000;
-- ȸ�� �� ������ 1975�⵵ ���� �ƴ� ȸ���� �˻��Ͻÿ�
SELECT *
FROM member
WHERE  mem_bir  NOT BETWEEN '75-01-01' AND '75-12-31'
ORDER BY mem_bir ASC;

-- LIKE
-- ȸ�����̺��� �达 ���� ���� ȸ���� �˻��Ͻÿ�
SELECT * FROM member
WHERE mem_name  LIKE '��%';

-- ȸ�����̺��� �ֹε�Ϲ�ȣ ���ڸ��� �˻��� 75����� ������ ȸ���� �˻��Ͻÿ�
SELECT *
FROM member
WHERE mem_regno1 NOT LIKE '75%' ;

-- CONCAT �� ���ڸ� �����Ͽ� ��ȯ

SELECT CONCAT('MY Name is'  , mem_name ) FROM member;

-- CHT, ASCII ASCII���� ���ڷ�, ���ڸ� ASCII������ ��ȯ

-- LOWER, UPPER, INITCAP
SELECT LOWER( 'DATA manipulation Language') "LOWER",
                UPPER('DATA manipulation Language') "UPPER",
                INITCAP('DATA manipulation Language') "INTICAP"
FROM dual;            

--ȸ�����̺��� ȸ��ID�� �빮�ڷ� ��ȯ�Ͽ� �˻��Ͻÿ� 
SELECT mem_id ��ȯ��ID ,UPPER(mem_id) ��ȯ��ID 
FROM member;

-- LPAD, RPAD 
-- ������ ���� n ����  c1�� ä��� ���� ������ c2�� ä���� ��ȯ
-- LTRIM , RTRIM ����/������ �������� 
-- TRIM ���� ��� ���� 
--SUBSTR ���� �Ϻκ��� ����
-- TRANSLATE(c1,c2,c3)
-- REPLACE(c1,c2,[c3])
SELECT REPLACE('SQL Project' , 'SQL', 'SSQQLL') ����ġȯ1,
                REPLACE('Java Flex Via' ,'a') ����ġȯ2
FROM dual;                
/*
ȸ�����̺��� ȸ������ �� ���� '��'�� '���� ġȯ�˻��Ͻÿ� 
*/
SELECT CONCAT (REPLACE(SUBSTR(mem_name, 1, 1), '��', '��'),
                SUBSTR(mem_name, 2))
FROM member;

-- INSTR c1 ���ڿ����� c2 ���ڰ� ó�� ��Ÿ���� ��ġ�� ����
-- GREATEST, LEAST ���ŵ� �׸� �� ���� ū��, ������ ��ȯ
-- ROUND(n,l) ������ �ڸ���(l)�ؿ��� �ݿø�
-- TRUNC(n,l) ROUND�� ���� ��, �ݿø��� �ƴ� ����
-- MOD(c, n) n���� ���� ������ 
SELECT MOD(10,3) FROM dual;

SELECT sysdate
FROM dual;

-- ADD_MONTHS
-- NEXT_DAY, LAST_DAY
SELECT NEXT_DAY(SYSDATE, '������'),
                LAST_DAY(SYSDATE)
FROM dual;
-- �̹����� ��ĥ ���Ҵ��� �˻��Ͻÿ� 
SELECT LAST_DAY(SYSDATE) - SYSDATE
FROM dual;

-- EXTRACT ��¥���� �ʿ��� �κи� ����
SELECT EXTRACT(YEAR FROM SYSDATE) "�⵵",
                 EXTRACT(MONTH FROM SYSDATE) "��",
                  EXTRACT(DAY FROM SYSDATE) "��"
FROM dual;

--ȸ���߿� ������ 3���� ȸ���� �˻�
SELECT mem_bir,
              EXTRACT(MONTH FROM mem_bir) as bir3 
FROM member
WHERE EXTRACT(MONTH FROM mem_bir) ='3';

-- ȸ�� ���� �� 1973�� ���� �ַ� ������ ��ǰ�� ������������ ��ȸ
-- ��ȸ �÷�: ��ǰ��
-- �� ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ��ȸ
-- ��� �ߺ����� 
*/ 
--���̺� : prod, member, cart
-- ��ȸ�÷�: DISTINCT prod_name
-- ���� prod_name ASC
-- ���� : EXTRACT(YEAR FROM mem_bir) = 1973
--            : prod_name LIKE '�Ｚ%'
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
AND prod_name  LIKE '%�Ｚ%';

-- TO_CHAR: ���� ���� ��¥�� ������ ������ ���ڿ� ��ȯ
-- TO_NUMBER: ���������� ���ڿ��� ���ڷ� ��ȯ
-- TO_DATE: ��¥������ ���ڿ��� ��¥�� ��ȯ

-- TO_CHAR 
SELECT TO_CHAR(CAST('2008-12-25' AS DATE),
                                'YYYY.MM.DD HH24:MI')
FROM dual;          

-- ��ǰ�����Ϳ��� ��ǰ�԰����� '2008-09-28' �������� ������ �˻��Ͻÿ� 
---���̺� prod
-- TO_CHAR(CAST (buy_date as DATE), 'YYYY-MM-DD')
SELECT TO_CHAR( buy_date , 
                                'YYYY-MM-DD')
FROM buyprod;
------------------------------------------------------------
SELECT prod_insdate, 
            TO_CHAR  ( 'YYYY-MM-DD')
FROM prod;                                    

-- ȸ�� �̸��� ���Ϸ� ����ó�� ��µǰ� �ϼ��� 

SELECT mem_name , mem_bir,
                (
                mem_name || '��(��)' ||
                TO_CHAR(mem_bir, 'yyyy') || '��'||
                 TO_CHAR(mem_bir, 'mon') ||
                 '�� ����̰� �¾ ������ ' ||
                 TO_CHAR(mem_bir, 'day')  || '�Դϴ�.'
                 ) as sumStr
FROM member;

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, ���԰���, �Һ��ڰ��� , �ǸŰ����� ����Ͻÿ�
SELECT prod_id , prod_name,
                TO_CHAR(prod_cost, 'L999,999,999') AS prod_cost,
                TO_CHAR(prod_price, 'L999,999,999') AS prod_price,
                TO_CHAR(prod_sale, 'L999,999,999') AS prod_sale
FROM prod;                

-- ȸ�� ���̺��� �̻��� ȸ���� ȸ�� id 2~4 ���ڿ��� ���������� ġȯ�� �� 10�� ���� ���Ӱ� ����ÿ�
SELECT mem_id,
            SUBSTR(mem_id, 1,2) | |
            (SUBSTR(mem_id,3, 4) + 10)
FROM  member
WHERE mem_name = '�̻���';

-- AVG(column) ��ȸ ���� �� �ش� �÷� ���� ��հ�
/*
[��Ģ] 
�Ϲ��÷��� �׷��Լ��� ���� ����� ��쿡��
�� GROUP BY���� �־�� ��
�׸��� GROUP BY������ �Ϲ��÷��� �� ���� �Ѵ�
*/
SELECT AVG(DISTINCT prod_cost),AVG(All prod_cost),
            AVG(prod_cost) ���԰����
FROM prod;            

SELECT prod_lgu,
                ROUND(AVG(prod_cost),2) "�з��� ���԰��� ���"
FROM prod
GROUP BY prod_lgu ;

-- ��ǰ���̺��� �� �ǸŰ��� ��հ�
SELECT AVG (prod_sale) as avg_sale
FROM prod;
-- ��ǰ���̺��� ��ǰ�з��� �ǸŰ��� ��հ��� ���Ͻÿ� 
SELECT prod_lgu, AVG(prod_sale) as avg_sale
FROM prod
GROUP BY prod_lgu;

-- ��ٱ������̺��� ȸ���� count �����Ͻÿ� 

SELECT cart_member, count(cart_member) as mem_count 
FROM cart
GROUP BY cart_member;

/*
����
���ż����� ��ü��� �̻��� ������ ȸ������ ���̵�� �̸��� ��ȸ
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


