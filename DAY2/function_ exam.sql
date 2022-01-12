--문자열 함수

--대문자
SELECT * FROM emp 
WHERE job = UPPER('analyst') ;

 
SELECT UPPER('anayst') FROM dual ;

SELECT LOWER(ename)  ename,  
           INITCAP ( job )  job
 FROM emp
WHERE comm  IS NOT NULL ;

--LENGTH 길이
SELECT ename, LENGTH (ename) 글자수, LENGTH(ename) AS 바이트수
FROM emp ;

--SUBSTING 글자 잘라서 리턴
SELECT SUBSTR('안녕하세요. 한가람IT전문학원 빅테이터반입니다. ', 18, 4) phase FROM dual ;

--REPLACE 글자대체
SELECT REPLACE('안녕하세요. 한가람IT전문학원 빅테이터반입니다. ',  '안녕하세요', '저리가세요')  phase 
FROM dual ;

--CONCAT 함수
SELECT 'A' || 'B' FROM dual ;
SELECT CONCAT('A', 'B') FROM dual;

--TRIM 
SELECT '     안녕하세요.     ' FROM dual;
SELECT LTRIM('     안녕하세요.     ') FROM dual;
SELECT RTRIM('     안녕하세요.     ') FROM dual;
SELECT TRIM('     안녕 하세요.     ') res FROM dual;

--ROUND
SELECT ROUND (15.193, 1) FROM dual;
SELECT TRUNC (15.193, 1) FROM dual;

--SYSDATE 현재 날짜와 시간을 출력
SELECT SYSDATE FROM dual;

--TO_ CHAR 숫자 또는 날짜 데이터를 문자 데이터로 
SELECT ename, TO_CHAR(hiredate, 'YYYY-MM-DD' ) ,
             TO_CHAR(sal) || '$'  
  FROM emp;

--TO_NUMBER 
SELECT TO_NUMBER('2400') + 100 FROM dual;
SELECT TO_NUMBER('이천사백') + 100 FROM dual; (x)
SELECT TO_NUMBER(REPLACE('2400$', '$')) + 100 FROM dual;

--TO_DATE
SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE ('01/12/22') FROM dual;
SELECT TO_DATE ('01/12/22',  'mm/dd/yy') FROM dual;

--NULL 함수
SELECT ename, job, sal, NVL(comm, 0) comm,
             (sal*12) + NVL(comm, 0) AS annsal 
     FROM emp
     ORDER BY sal DESC;
     
--집계함수  SUM COUNT MAX MIN AVG
SELECT sal, NVL(comm, 0) comm FROM EMP;
SELECT SUM(sal) totalsatry FROM emp;  
SELECT SUM(comm) totalcommision FROM emp;
SELECT MAX(sal) FROM emp;
SELECT MIN(sal) FROM emp;
SELECT ROUND(AVG(sal), 0) sal_avg FROM emp;

--GROUP BY, HAVING 함수 
SELECT MAX(sal) 월급최대, SUM(sal) 직업군당급여합계,  job 
  FROM emp
 GROUP BY job 
 HAVING MAX(sal) > 4000;
 
SELECT deptno, job, AVG(sal) , MAX(sal), MIN(sal), SUM(sal), COUNT(*)
 FROM emp
 GROUP BY deptno,  job
 HAVING AVG(sal) >= 1000
 ORDER BY deptno, job;
--ORDER BY는 맨 마지막에 쓴다.

SELECT deptno,   NVL (job, '합계')  JOB,
ROUND(AVG (sal), 2) 급여평균, MAX(sal) 급여최대 , 
SUM(sal) 급여합계 , COUNT(*) 그룹별직원수
 FROM emp
 GROUP BY ROLLUP( deptno,  job) ;
-- HAVING AVG(sal) >= 1000
 

 

