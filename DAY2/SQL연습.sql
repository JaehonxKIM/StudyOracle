--�� ������ ��ȸ�ϴ� ������
SELECT * FROM emp
WHERE sal = 5000;

--���ʽ��� NIULL�̰� ������ ANALIST�� ����� ������
SELECT * FROM emp
WHERE comm = 0 OR comm IS NULL AND job = 'ANALIST';

--��������
SELECT empno, ename, deptno
 FROM emp
 WHERE deptno = 30;
 
 -- ����, �� �� �̻��� ���̺��� �ϳ��� ���̺�ó�� ��ȸ�ϴ� ��� (ALIAS ���)
 SELECT e. empno, e. ename, e. hiredate, e. sal, d. deptno, d. dname 
 FROM emp e 
  JOIN dept d
   ON e. deptno = d. deptno;
   
--DISTINCT ����
SELECT DISTINCT job FROM emp;

--��Ī ALIAS
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
  ORDER BY sal DESC; --�������� / DSC ��������
 
 --WHERE
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp 
  WHERE sal*12 >=10000 ;
 
 --����
 SELECT ename, job, sal, sal*12 AS annsal
  FROM emp 
   WHERE sal <> 1000 ; --<>,=! ���� ���� ^= ���� �Ⱦ���
 
 --NOT
 SELECT ename, job, sal, sal*12 AS annsal
  FROM emp 
   WHERE NOT sal = 1000 ; 
 
 --IN --���� �������� ����(OR���� ����ϳ� ���� �ʹ� �����)
 SELECT ename, job, sal, sal*12 AS annsal
  FROM emp 
   WHERE sal IN (800, 1600, 5000) ;
 
 -- BETWEEN A AND B
 SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
   WHERE sal >=1600 AND sal <=2975;
 
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
  WHERE sal BETWEEN 1600 AND 2975;
  
--LIKE
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE ename LIKE '__RD' ; --J%, %ER, %E%, __RD(������ ���ڼ��� ~�� ������ ���)
 
 --NULL �Լ��� NVL( ) ���߿� TO BE CONTINUED..
 SELECT ename, job, sal, comm
  FROM emp
   WHERE comm IS NOT NULL ;
 
 --���� UNION 
SELECT empno, ename, job FROM emp
WHERE comm IS NOT NULL
UNION ALL
SELECT deptno, dname, loc FROM dept ;


 
 
 
 

