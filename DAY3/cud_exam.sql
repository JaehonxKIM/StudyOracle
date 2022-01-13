--데이터 입력 INSERT
INSERT INTO bonus
        ( ename , job , sal , comm)
VALUES
       ( 'JACK' , 'SALESMAN' , 4000 , NULL) ;

COMMIT;  --완전저장
ROLLBACK; --취소

--TEST 테이븧 입력쿼리
INSERT INTO test
            ( idx, title, descs )
VALUES
            ( 1, '내용증명' , NULL ) ;
            
INSERT INTO test
            ( idx, title, descs )
VALUES
            ( 2, '내용증명2' , '내용내용' ) ;
            
 INSERT INTO test
            ( idx, title, descs, regdate)
VALUES
            ( 3, '내용증명3' , '내용내용3', SYSDATE) ;      
    
 INSERT INTO test
            ( idx, title, descs, regdate)

VALUES
            ( 4, '내용증명4' , '내용내용4', TO_DATE('2021-12-31', 'yyyy-mm-dd')) ; 

--시퀀스
SELECT SEQ_TEST.CURRVAL FROM dual;
SELECT SEQ_TEST.NEXTVAL FROM dual;


 INSERT INTO test
            ( idx, title, descs, regdate)
VALUES
            ( 5, '내용증명5' , '내용내용5', SYSDATE) ;      

 INSERT INTO test
            ( idx, title, descs, regdate)
VALUES
            ( 6, '내용증명6' , '내용내용6', SYSDATE) ;         

 INSERT INTO test
            ( idx, title, descs, regdate)
VALUES
            ( 104, '내용증명104' , '내용내용104', SYSDATE) ;  
            

COMMIT;  --완전저장
ROLLBACK; --취소

SELECT SEQ_STR.CURRVAL FROM dual;
SELECT SEQ_STR.NEXTVAL FROM dual;

--UPDATE (수정) --DELETE는 무조건 WHERE 절 사용
UPDATE test
        SET title =  '내용증명요?'
             , descs = '내용이 변경됩니다.'
         WHERE idx = 100;
         
--DELETE
DELETE FROM test
 WHERE idx = 100;
 
 
 
 --서브쿼리
SELECT  ROWNUM , su. ename ,su.  job, su. sal, su. comm FROM  (
       SELECT ename, job, sal, comm FROM emp
         ORDER BY sal DESC
 ) su
   WHERE ROWNUM <=1;

SELECT ROWNUM, idx, title FROM test;