set echo on
set pages 100
set serveroutput on

--make sure old table is deleted
DROP TABLE baseballers PURGE;

--create a table with classic baseball player info
CREATE TABLE baseballers(
	empno VARCHAR2(5),
	ename VARCHAR2(10),
	pos VARCHAR2(12),
	boss VARCHAR2(4),
	hiredate DATE,
	sal NUMBER(6),
	deptno NUMBER(2),
	incentives NUMBER(6));
	
--inserting info

set echo off
	
--insert table info
INSERT INTO baseballers
VALUES('712','rickey','gm',null,'01-January-1998',10000,40,null);
--insert table info
INSERT INTO baseballers
VALUES('735','lasorda','coach','712','10-January-1998',2000,40,null);
--insert table info
INSERT INTO baseballers
VALUES('707','bochy','coach','712','11-January-1998',2000,40,null);
--insert table info
INSERT INTO baseballers
VALUES('798','berra','coach','712','12-January-1998',2000,40,null);
--insert table info
INSERT INTO baseballers
VALUES('782','musial','right field','707','01-February-1998',42000,20,null);
--insert table info
INSERT INTO baseballers
VALUES('763','gehrig','first base','735','11-March-1998',85000,10,null);
--insert table info
INSERT INTO baseballers
VALUES('777','minoso','shortstop','735','05-May-1998',85000,10,6000);
--insert table info
INSERT INTO baseballers
VALUES('721','sandberg','second base','735','28-February-1998',25000,10,null);
--insert table info
INSERT INTO baseballers
VALUES('788','cey','third base','735','10-January-1999',15000,10,8000);
--insert table info
INSERT INTO baseballers
VALUES('720','williams','left field','707','05-January-1999',150000,20,null);
--insert table info
INSERT INTO baseballers
VALUES('755','johnson','pitcher','798','08-November-1998',50000,30,null);
--insert table info
INSERT INTO baseballers
VALUES('744','brown','pitcher','798','18-October-1999',40000,30,4000);
--insert table info
INSERT INTO baseballers
VALUES('730','mays','center field','707','01-January-1998',240000,20,null);
--insert table info
INSERT INTO baseballers
VALUES('799','mungo','pitcher','798','10-March-2000',20000,30,12000);
--insert table info
INSERT INTO baseballers
VALUES('766','rodriguez','catcher','735','16-October-2001',100000,50,null);

set echo on
	
--show a description of the columns for the new table
DESC baseballers

--show the contents of the baseballers table
SELECT * FROM baseballers;

--this procedure will output all of the possible 2-person combinations
--of coaches and infielders (with the gm treated as a coach) from the
--baseballers table
DECLARE

  CURSOR coach_cursor IS
    SELECT ename
    FROM baseballers
    WHERE pos = 'coach' OR pos = 'gm';
  player1 coach_cursor%ROWTYPE;
  
  CURSOR infielder_cursor IS
    SELECT ename
    FROM baseballers
    WHERE pos = 'first base'
    OR pos = 'second base'
    OR pos = 'third base'
    OR pos = 'shortstop';
  player2 infielder_cursor%ROWTYPE;
  
BEGIN  
  DBMS_OUTPUT.PUT_LINE('Here are all of the possible coach+infielder team combinations:');
  OPEN coach_cursor;
  LOOP
    FETCH coach_cursor INTO player1;
    EXIT WHEN coach_cursor%NOTFOUND;
    OPEN infielder_cursor;
    LOOP
      FETCH infielder_cursor INTO player2;
      EXIT WHEN infielder_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(player1.ename||'  '||player2.ename);
    END LOOP;
    CLOSE infielder_cursor;
  END LOOP;  
  CLOSE coach_cursor;
END;
.
/

