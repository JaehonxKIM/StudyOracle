-- �ּ�, �Ʒ��� select ������ ����
SELECT* FROM emp;

--�÷��� �����ؼ� select
SELECT ename, job, hiredate 
 FROM emp;
 
 SELECT* FROM EMP;
 
 --�μ��� ���
select distinct deptno
from emp;

--�� ���� �ߺ����Ű� �ȵ�
SELECT DISTINCT empno, deptno
FROM emp;

SELECT DISTINCT job, deptno
FROM emp;

--������ where

SELECT* FROM emp;



SELECT * FROM emp
WHERE job = 'CLERK';


--�޿��� 1500 �޷� �̻��� ��� ��ȸ
SELECT * FROM emp
WHERE sal >1500;


