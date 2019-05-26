--Query01
--(no index) & Query 3 (clustered index) - 1% selection
INSERT INTO TMP
SELECT * FROM TENKTUP1
WHERE unique2 BETWEEN 0 AND 99

--Query02
--(no index) & Query 4 (clustered index) - 10% selection
INSERT INTO TMP
SELECT * FROM TENKTUP1
WHERE unique2 BETWEEN 792 AND 1791

--Query05
--1% selection via a non-clustered index
INSERT INTO TMP
SELECT * FROM TENKTUP1
WHERE unique1 BETWEEN 0 AND 99

--Query06
--10% selection via a non-clustered index
INSERT INTO TMP
SELECT * FROM TENKTUP1
WHERE unique1 BETWEEN 792 AND 1791

--Query07
--single tuple selection via clustered index to screen
SELECT * FROM TENKTUP1
WHERE unique2 = 2001

--Query08
--1% selection via clustered index to screen
SELECT * FROM TENKTUP1
WHERE unique2 BETWEEN 0 AND 99

--Query09
--(no index) and Query 12 (clustered index) - JoinAselB
INSERT INTO TMP
SELECT * FROM TENKTUP1, TENKTUP2
WHERE (TENKTUP1.unique2 = TENKTUP2.unique2)
AND (TENKTUP2.unique2 < 1000)

--Bprime
--updateQuery to make Bprime relation
INSERT INTO BPRIME
SELECT * FROM TENKTUP2
WHERE TENKTUP2.unique2 < 1000

-- Query10
--(no index) and Query 13 (clustered index) - JoinABprime
INSERT INTO TMP
SELECT * FROM TENKTUP1, BPRIME
WHERE (TENKTUP1.unique2 = BPRIME.unique2)

-- Query11
--(no index) and Query 14 (clustered index) - JoinCselAselB
INSERT INTO TMP
SELECT * FROM ONEKTUP, TENKTUP1
WHERE (ONEKTUP.unique2 = TENKTUP1.unique2)
AND (TENKTUP1.unique2 = TENKTUP2.unique2)
AND (TENKTUP1.unique2 < 1000)

-- Query15
-- (non-clustered index) - JoinAselB
INSERT INTO TMP
SELECT * FROM TENKTUP1, TENKTUP2
WHERE (TENKTUP1.unique1 = TENKTUP2.unique1)
AND (TENKTUP1.unique2 < 1000)

-- Query16
--(non-clustered index) - JoinABprime
INSERT INTO TMP
SELECT * FROM TENKTUP1, BPRIME
WHERE (TENKTUP1.unique1 = BPRIME.unique1)

-- Quer17
--(non-clustered index) - JoinCselAselB
INSERT INTO TMP
SELECT * FROM ONEKTUP, TENKTUP1
WHERE (ONEKTUP.unique1 = TENKTUP1.unique1)
AND (TENKTUP1.unique1 = TENKTUP2.unique1)
AND (TENKTUP1.unique1 < 1000)

-- Query18
--Projection with 1% Projection
INSERT INTO TMP
SELECT DISTINCT two, four, ten, twenty, onePercent, string4
FROM TENKTUP1

--Query19
--Projection with 100% Projection
INSERT INTO TMP
SELECT DISTINCT two, four, ten, twenty, onePercent,
tenPercent, twentyPercent, fiftyPercent, unique3,
evenOnePercent, oddOnePercent, stringu1, stringu2, string4
FROM TENKTUP1

--Query20
--(no index) and Query 23 (with clustered index) Minimum Aggregate Function
INSERT INTO TMP
SELECT MIN (TENKTUP1.unique2) FROM TENKTUP1

-- Query21
--(no index) and Query 24 (with clustered index) Minimum Aggregate Function with 100 Partitions
INSERT INTO TMP
SELECT MIN (TENKTUP1.unique3) FROM TENKTUP1
GROUP BY TENKTUP1.onePercent

-- Query22
--(no index) and Query 25 (with clustered index) Sun Aggregate Function with 100 Partitions
INSERT INTO TMP
SELECT SUM (TENKTUP1.unique3) FROM TENKTUP1
GROUP BY TENKTUP1.onePercent

-- Query26
--(no indices) and Query 29 (with indices) - Insert 1 tuple
INSERT INTO TENKTUP1 VALUES(10001,74,0, 2,0,10,50,688,
1950,4950,9950,1,100,
'MxxxxxxxxxxxxxxxxxxxxxxxxxGxxxxxxxxxxxxxxxxxxxxxxxxC',
'GxxxxxxxxxxxxxxxxxxxxxxxxxCxxxxxxxxxxxxxxxxxxxxxxxxA',
'OxxxxxxxxxxxxxxxxxxxxxxxxxOxxxxxxxxxxxxxxxxxxxxxxxxO')

-- Query27
--(no index) and Query 30 (with indices) - Delete 1 tuple
DELETE FROM TENKTUP1 WHERE unique1=10001

-- Query28--(no indices) and Query 31 (with indices) - Update key attribute
UPDATE TENKTUP1
SET unique2 = 10001 WHERE unique2 = 1491

-- Query32
--(with indices) - Update indexed non-key attribute
UPDATE TENKTUP1
SET unique1 = 10001 WHERE unique1 = 1491