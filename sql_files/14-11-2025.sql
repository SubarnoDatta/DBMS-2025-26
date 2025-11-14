-- Database creation

create database SupplierDatabase;

use SupplierDatabase;

-- Table Creation

CREATE TABLE Supplier (
    sid INT PRIMARY KEY,
    sname VARCHAR(50) NOT NULL,
    city VARCHAR(50)
);

CREATE TABLE Parts (
    pid INT PRIMARY KEY,
    pname VARCHAR(50) NOT NULL,
    color VARCHAR(20)
);

CREATE TABLE Catalog (
    sid INT,
    pid INT,
    cost DECIMAL(10, 2) NOT NULL,
    
    PRIMARY KEY (sid, pid), 

    FOREIGN KEY (sid) REFERENCES Supplier(sid)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
    FOREIGN KEY (pid) REFERENCES Parts(pid)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Data Updating
 
INSERT INTO Supplier VALUES
(100, 'Acme Widget Suppliers', 'Bengaluru'),
(200, 'All-Parts-Supplier', 'Mumbai'),
(300, 'Red-Part-Supplier', 'Delhi'),
(400, 'Blue-Part-Supplier', 'Chennai'),
(500, 'Costly-Supplier', 'Pune');

INSERT INTO Parts VALUES
(1, 'Piston', 'Red'),
(2, 'Crankshaft', 'Blue'),
(3, 'Gear', 'Green'),
(4, 'Widget', 'Red');

INSERT INTO Catalog VALUES
(100, 4, 10.00),
(200, 1, 5.00),
(200, 2, 5.00),
(200, 3, 5.00),
(200, 4, 5.00),
(300, 1, 8.00),
(300, 4, 7.00),
(400, 2, 12.00),
(500, 1, 15.00);

-- Queries

-- 1. Find the pnames of parts for which there is some supplier
SELECT DISTINCT
    P.pname
FROM
    Parts AS P
INNER JOIN
    Catalog AS C ON P.pid = C.pid;

-- 2. Find the snames of suppliers who supply every part

SELECT DISTINCT
    s.sname
FROM Supplier AS s
WHERE NOT EXISTS (
    SELECT * FROM Parts p
    LEFT JOIN Catalog c on p.pid = c.pid and s.sid = c.sid
    WHERE c.pid is NULL
);

-- 3. Find the snames of suppliers who supply every red part

create View RedParts AS
SELECT * FROM Parts WHERE color = 'Red';

SELECT DISTINCT s.sname FROM Supplier s
WHERE NOT EXISTS (
    select * from Redparts p
    left join catalog c on p.pid = c.pid and s.sid = c.sid
    where c.pid is null
);

-- 4. Find the pnames of parts supplied by Acme Widget Suppliers and by no one else.

SELECT P.pname FROM Parts P
INNER JOIN Catalog C ON P.pid = C.pid
INNER JOIN Supplier S ON s.sid = c.sid
WHERE S.sname = 'Acme Widget Suppliers' AND P.pid IN (
    SELECT pid
    FROM Catalog
    GROUP BY pid
    HAVING COUNT(sid) = 1
);

-- 5. Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over all the suppliers who supply that part).

SELECT s.sid, s.sname, c.cost FROM Supplier s
INNER JOIN Catalog c on c.sid = s.sid
WHERE c.cost > (
    SELECT AVG(cx.cost) FROM Catalog cx 
    WHERE cx.pid = c.pid
);

-- 6. For each part, find the sname of the supplier who charges the most for that part.

SELECT s.sid, s.sname, c.pid, c.cost FROM Supplier s
INNER JOIN Catalog c on c.sid = s.sid
WHERE c.cost = (
    SELECT MAX(cx.cost) FROM Catalog cx
    WHERE cx.pid = c.pid
);

