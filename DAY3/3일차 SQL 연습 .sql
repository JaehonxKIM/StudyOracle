--기본 이너조인
SELECT e. ename
            , e. empno
            , e. job
            , TO_CHAR(e. hiredate, ' yyyy-mm-dd ') hiredate
            , e. deptno
            , d. dname  
   FROM emp e 
  INNER JOIN dept d
      ON e. deptno = d. deptno 
  WHERE e.  job = 'SALESMAN' ;

-- PL/SQL 이너조인
SELECT e. ename
            , e. empno
            , e. job
            , TO_CHAR(e. hiredate, ' yyyy-mm-dd ') hiredate
            , e. deptno
            , d. dname  
   FROM emp e, dept d
-- WHERE 1 = 1  ---TIP
 WHERE e. deptno = d. deptno 
      AND e.  job = 'SALESMAN' ;

-- LEFT OUTER JOIN
SELECT e. ename
            , e. empno
            , e. job
            , TO_CHAR(e. hiredate, ' yyyy-mm-dd ') hiredate
            , e. deptno
            , d. dname  
   FROM emp e 
   LEFT OUTER JOIN dept d
      ON e. deptno = d. deptno ; 

--RIGHT OUTER JOIN
SELECT e. empno
            , e. ename
            , e. job
            , TO_CHAR(e. hiredate, ' yyyy-mm-dd ') hiredate
            , e. deptno
            , d. dname
   FROM emp e 
   RIGHT OUTER JOIN dept d
      ON e. deptno = d. deptno ; 
 
 
--left/right outer join      
SELECT e. ename
            , e. empno
            , e. job
            , TO_CHAR(e. hiredate, ' yyyy-mm-dd ') hiredate
            , e. deptno
            , d. dname  
      FROM emp e , dept d
   WHERE e. deptno (+)  = d. deptno; --PL/SQL 형식의 RIGHT OUTER JOIN
-- WHERE e. deptno = d. deptno (+)   --PL/SQL 형식의 LEFT OUTER JOIN

--3개테이블 조인
SELECT e. ename
            , e. empno
            , e. job
            , TO_CHAR(e. hiredate, ' yyyy-mm-dd ') hiredate
            , e. deptno
            , d. dname
            , b. comm
      FROM emp e , dept d , bonus b
   WHERE e. deptno (+) = d. deptno 
      AND  e. ename = b. ename (+) ;


