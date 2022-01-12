--행 단위로 조회하는 셀렉션
SELECT * FROM emp
WHERE sal = 5000;

--보너스가 NIULL이고 직업이 ANALIST인 사람만 셀렉션
SELECT * FROM emp
WHERE comm = 0 OR comm IS NULL AND job = 'ANALIST';

--프로젝션
SELECT empno, ename, deptno
 FROM emp
 WHERE deptno = 30;
 
 -- 조인, 두 개 이상의 테이블을 하나의 테이블처럼 조회하는 방법 (ALIAS 사용)
 SELECT e. empno, e. ename, e. hiredate, e. sal, d. deptno, d. dname 
 FROM emp e 
  JOIN dept d
   ON e. deptno = d. deptno;
   
--DISTINCT 복습
SELECT DISTINCT job FROM emp;

--별칭 ALIAS
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
  ORDER BY sal DESC; --오름차순 / DSC 내림차순
 
 --WHERE
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp 
  WHERE sal*12 >=10000 ;
 
 --등가계산
 SELECT ename, job, sal, sal*12 AS annsal
  FROM emp 
   WHERE sal <> 1000 ; --<>,=! 많이 쓰임 ^= 거의 안쓰임
 
 --NOT
 SELECT ename, job, sal, sal*12 AS annsal
  FROM emp 
   WHERE NOT sal = 1000 ; 
 
 --IN --많이 쓰이지는 않음(OR절과 비슷하나 식이 너무 길어짐)
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
 WHERE ename LIKE '__RD' ; --J%, %ER, %E%, __RD(동일한 글자수에 ~로 끝나는 경우)
 
 --NULL 함수명 NVL( ) 나중에 TO BE CONTINUED..
 SELECT ename, job, sal, comm
  FROM emp
   WHERE comm IS NOT NULL ;
 
 --집합 UNION 
SELECT empno, ename, job FROM emp
WHERE comm IS NOT NULL
UNION ALL
SELECT deptno, dname, loc FROM dept ;


 
 
 
 

