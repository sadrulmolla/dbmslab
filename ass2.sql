select DEPT_CODE,MIN(BASIC),MAX(BASIC),AVG(BASIC) from EMP group by DEPT_CODE order by DEPT_CODE;
------------------------------------------------------------------------------------------------------------------------------
select DEPT_CODE,count(*) as FEM_COUNT from EMP where SEX = 'F' group by DEPT_CODE;
------------------------------------------------------------------------------------------------------------------------------
select DEPT_CODE,CITY,count(*) as emp_in_city from EMP group by CITY , DEPT_CODE;
-------------------------------------------------------------------------------------------------------------------------------
select DESIG_code,DEPT_CODE,count(EMP_CODE) AS NO_OF_EMP FROM EMP GROUP BY DESIG_code,DEPT_CODE ORDER BY COUNT(EMP_CODE) DESC;
-------------------------------------------------------------------------------------------------------------------------------
SELECT DEPT_CODE,X.SUM_BASIC FROM EMP E1 LEFT OUTER JOIN
(SELECT DEPT_CODE D ,SUM(BASIC) AS SUM_BASIC FROM EMP WHERE SEX = 'M' GROUP BY DEPT_CODE)
 X ON X.D=E1.DEPT_CODE WHERE X.SUM_BASIC>=50000 GROUP BY DEPT_CODE;
------------------------------------------------------------------------------------------------------------------------------
select EMP.EMP_NAME, DESIGNATION.DESIG_DESC ,EMP.BASIC FROM EMP NATURAL JOIN DESIGNATION;
------------------------------------------------------------------------------------------------------------------------------
select E1.EMP_NAME, DESIGNATION.DESIG_DESC,X.DEPT_NAME,E1.BASIC FROM EMP E1 NATURAL JOIN (SELECT*FROM DEPERMENT D1)X 
NATURAL JOIN DESIGNATION;
------------------------------------------------------------------------------------------------------------------------------
select DEPERMENT.DEPT_NAME from EMP,DEPERMENT where (select count(*) from EMP where EMP.DEPT_CODE=DEPERMENT.DEPT_CODE)=0 
group by DEPERMENT.DEPT_NAME;
-------------------------------------------------------------------------------------------------------------------------------
SELECT X.DEPT_NAME FROM (select count(*) AS CNT ,DEPT_NAME from EMP,DEPERMENT where EMP.DEPT_CODE=DEPERMENT.DEPT_CODE 
	GROUP BY DEPERMENT.DEPT_NAME)X WHERE X.CNT>=10;
-------------------------------------------------------------------------------------------------------------------------------
SELECT DEPT_CODE FROM EMP WHERE  BASIC = (SELECT MAX(BASIC) FROM EMP);
-------------------------------------------------------------------------------------------------------------------------------
SELECT DESIG_DESC FROM DESIGNATION WHERE DESIGNATION.DESIG_code=(SELECT DESIG_CODE FROM EMP WHERE BASIC= (SELECT MAX(BASIC) 
	FROM EMP)); 
--------------------------------------------------------------------------------------------------------------------------------
SELECT EMP.DEPT_CODE,COUNT(*) FROM EMP WHERE DESIG_code=(SELECT DESIG_CODE FROM DESIGNATION D WHERE DESIG_DESC = 'manager') 
GROUP BY DEPT_CODE;
--------------------------------------------------------------------------------------------------------------------------------
SELECT EMP.BASIC FROM EMP WHERE EMP.BASIC>=ALL(SELECT DISTINCT BASIC FROM EMP);
--------------------------------------------------------------------------------------------------------------------------------
SELECT EMP.BASIC FROM EMP WHERE EMP.BASIC<=ALL(SELECT DISTINCT BASIC FROM EMP);
--------------------------------------------------------------------------------------------------------------------------------
SELECT DEPERMENT.DEPT_NAME FROM DEPERMENT WHERE DEPT_CODE = (SELECT EMP.DEPT_CODE FROM EMP 
	WHERE BASIC = (SELECT MAX(BASIC) FROM EMP));
--------------------------------------------------------------------------------------------------------------------------------
 SELECT DEPT_NAME FROM DEPERMENT NATURAL JOIN (SELECT DEPT_CODE,SUM(BASIC) AS SUM_BASIC FROM EMP GROUP BY DEPT_CODE) AS T
  WHERE T.SUM_BASIC=(SELECT MAX(T1.SUM_B) FROM (SELECT SUM(E1.BASIC) AS SUM_B FROM EMP E1 GROUP BY E1.DEPT_CODE) AS T1);
--------------------------------------------------------------------------------------------------------------------------------
SELECT DEPT_NAME FROM DEPERMENT NATURAL JOIN (SELECT DEPT_CODE,AVG(BASIC) AS AVG_BASIC FROM EMP GROUP BY DEPT_CODE) AS T 
WHERE T.AVG_BASIC=(SELECT MAX(T1.AVG_B) FROM (SELECT AVG(E1.BASIC) AS AVG_B FROM EMP E1 GROUP BY E1.DEPT_CODE) AS T1);
--------------------------------------------------------------------------------------------------------------------------------
SELECT DEPT_NAME FROM  DEPERMENT NATURAL JOIN (SELECT DEPT_CODE,COUNT(EMP_CODE) AS NO_EMPLOY FROM EMP GROUP BY DEPT_CODE) AS T 
WHERE T.NO_EMPLOY=(SELECT MAX(T1.N_EMP) FROM (SELECT COUNT(E1.EMP_CODE) AS N_EMP FROM EMP E1 GROUP BY E1.DEPT_CODE) AS T1);
--------------------------------------------------------------------------------------------------------------------------------
INSERT INTO EMP (EMP_CODE,EMP_NAME,DEPT_CODE,DESIG_code,SEX,ADDRESS,CITY,STATE,PIN,BASIC,JN_DT) VALUES  
('e9','dibyendu','dpt2','d6','F','howrah','howrah','west bengal','725234','25000','2025-08-30');
---------------------------------------------------------------------------------------------------------------------------------
INSERT INTO EMP(EMP_CODE,EMP_NAME,DEPT_CODE,DESIG_CODE,SEX,ADDRESS,CITY,STATE,PIN,BASIC,JN_DT) VALUES   
('e10','debaduti','dpt3','d7','M','newtown','kolkata','west bengal','745623','50000','2012-10-10');
---------------------------------------------------------------------------------------------------------------------------------
DELETE FROM EMP WHERE DESIG_code NOT IN (SELECT D.DESIG_CODE FROM DESIGNATION D);
---------------------------------------------------------------------------------------------------------------------------------
SELECT P.EMP_NAME FROM 
( SELECT E.DEPT_CODE,E.EMP_NAME,T.AVG_BASIC,E.BASIC,E.SEX FROM EMP E NATURAL JOIN 
	(SELECT DEPT_CODE,AVG(BASIC) AS AVG_BASIC FROM EMP GROUP BY DEPT_CODE) AS T WHERE E.SEX = 'F' AND E.BASIC>T.AVG_BASIC) AS P;
---------------------------------------------------------------------------------------------------------------------------------
SELECT COUNT(EMP_CODE) FROM EMP WHERE SEX ='F' AND 
DESIG_code=(SELECT D1.DESIG_CODE FROM DESIGNATION D1 WHERE D1.DESIG_DESC = 'manager');
---------------------------------------------------------------------------------------------------------------------------------
