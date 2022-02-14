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
                                                                
                                                                
        


