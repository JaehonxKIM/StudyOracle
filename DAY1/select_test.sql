-- 주석, 아래의 select 구문을 실행
SELECT* FROM emp;

--컬럼을 구분해서 select
SELECT ename, job, hiredate 
 FROM emp;
 
 SELECT* FROM EMP;
 
 --부서명만 출력
select distinct deptno
from emp;

--이 경우는 중복제거가 안됨
SELECT DISTINCT empno, deptno
FROM emp;

SELECT DISTINCT job, deptno
FROM emp;

--조건절 where

SELECT* FROM emp;



SELECT * FROM emp
WHERE job = 'CLERK';


--급여가 1500 달러 이상인 사람 조회
SELECT * FROM emp
WHERE sal >1500;


