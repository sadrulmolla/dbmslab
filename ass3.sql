CREATE TABLE DEPARTMENT(DEPT_NAME CHAR(10),DEPT_CODE CHAR(5),PRIMARY KEY(DEPT_CODE));
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE EMP(EMP_CODE CHAR(5) PRIMARY KEY,
	EMP_NAME CHAR(10) CHECK(EMP_NAME=UPPER(EMP_NAME)),
	ADDRESS CHAR(25),DEPT_CODE CHAR(5),CITY CHAR(10),
	BASIC INT CHECK(BASIC>=5000 AND BASIC<=9000),
	JN_DT DATETIME DEFAULT CURRENT_TIMESTAMP,
	GRADE CHAR(1) CHECK(GRADE IN('A','B','C')),
	FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT(DEPT_CODE)
	);
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE LEV_REG(LEV_TYPE CHAR(2) CHECK(LEV_TYPE IN ('CL','EL','ML')),EMP_CODE CHAR(5),FROM_DT DATE,TO_DT DATE,
	PRIMARY KEY(LEV_TYPE,EMP_CODE),FOREIGN KEY(EMP_CODE) REFERENCES EMP (EMP_CODE));
----------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER trig_sd_check BEFORE INSERT ON EMP FOR EACH ROW BEGIN SET NEW.EMP_NAME=UPPER(NEW.EMP_NAME); END$$
DELIMITER ;
-----------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER trig_basic_check BEFORE INSERT ON EMP FOR EACH ROW BEGIN IF NEW.BASIC<5000 OR NEW.BASIC>9000 THEN SIGNAL SQLSTATE '12345' 
SET MESSAGE_TEXT ='check constrain on basic failed'; END IF; END$$
DELIMITER $$
-----------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER trig_grade_check BEFORE INSERT ON EMP FOR EACH ROW BEGIN IF NEW.GRADE !='A' OR NEW.GRADE!='B' OR NEW.GRADE!='C' THEN SIGNAL SQLSTATE '12345' SET MESSAGE_TEXT ='check constrain on GRADE failed'; END IF; END$$
DELIMITER $$
-----------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO DEPARTMENT(DEPT_NAME,DEPT_CODE)VALUES('personnel','dept1');
----------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO DEPARTMENT(DEPT_NAME,DEPT_CODE)VALUES
('production','dept2'),('reserch','dept3'),('finance','dept4'),('purchas','dept5');
----------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO EMP(EMP_CODE,EMP_NAME,ADDRESS,DEPT_CODE,CITY,BASIC,GRADE)VALUES
('emp1','sadrul','jadavput','dept1','kolkata',7500,'A');   //upper case constraint 
+----------+----------+----------+-----------+---------+-------+---------------------+-------+
| EMP_CODE | EMP_NAME | ADDRESS  | DEPT_CODE | CITY    | BASIC | JN_DT               | GRADE |
+----------+----------+----------+-----------+---------+-------+---------------------+-------+
| emp1     | SADRUL   | jadavput | dept1     | kolkata |  7500 | 2020-03-19 17:29:21 | A     |
+----------+----------+----------+-----------+---------+-------+---------------------+-------+
----------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO EMP(EMP_CODE,EMP_NAME,ADDRESS,DEPT_CODE,CITY,BASIC,GRADE)VALUES ('emp2','sahil','jadavpur','dept6','kolkata',8000,'A');
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails 
 (`dbms1`.`EMP`, CONSTRAINT `EMP_ibfk_1` FOREIGN KEY (`DEPT_CODE`) REFERENCES `DEPARTMENT` (`DEPT_CODE`))
----------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO EMP(EMP_CODE,EMP_NAME,ADDRESS,DEPT_CODE,CITY,BASIC,GRADE)VALUES ('emp2','sahil','jadavpur','dept2','kolkata',10000,'A');
ERROR 1644 (12345): check constrain on basic failed
----------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO EMP(EMP_CODE,EMP_NAME,ADDRESS,DEPT_CODE,CITY,BASIC,GRADE)VALUES ('emp2','sahil','jadavpur','dept2','kolkata',8000,'D') ;
ERROR 1644 (12345): check constrain on GRADE failed
----------------------------------------------------------------------------------------------------------------------------------------------
delete from DEPARTMENT WHERE DEPT_CODE='dept1';
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails 
(`dbms1`.`EMP`, CONSTRAINT `EMP_ibfk_1` FOREIGN KEY (`DEPT_CODE`) REFERENCES `DEPARTMENT` (`DEPT_CODE`))
----------------------------------------------------------------------------------------------------------------------------------------------
