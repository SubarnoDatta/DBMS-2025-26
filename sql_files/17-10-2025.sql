create database BankAccounting_SubarnoDatta;

use BankAccounting_SubarnoDatta;

create table Branch (
branchname VARCHAR(20) PRIMARY KEY,
branchcity VARCHAR(20),
assets INT
);

create table BankAccount (
accno INT PRIMARY KEY,
branchname VARCHAR(20),
balance INT,
FOREIGN KEY(branchname) REFERENCES Branch(branchname)
);

create table BankCustomer (
customername VARCHAR(20) PRIMARY KEY,
customerstreet VARCHAR(50),
customercity VARCHAR(20)
);

create table Depositer (
customername VARCHAR(20),
accno INT,
FOREIGN KEY(customername) REFERENCES BankCustomer(customername),
FOREIGN KEY(accno) REFERENCES BankAccount(accno)
);

create table Loan (
loannumber INT PRIMARY KEY,
branchname VARCHAR(20),
amount INT,
FOREIGN KEY(branchname) REFERENCES Branch(branchname)
);

insert into Branch values
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParliamentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);

insert into BankAccount values
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParliamentRoad', 9000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_ParliamentRoad', 3000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);

insert into BankCustomer values
('Avinash', 'Bull Temple Road', 'Bangalore'),
('Dinesh', 'Bannerghata Road', 'Bangalore'),
('Mohan', 'National College Road', 'Bangalore'),
('Nikil', 'Akbar Road', 'Delhi'),
('Ravi', 'Prithviraj Road', 'Delhi');

insert into Depositer values
('Avinash', 1),
('Dinesh', 2),
('Nikil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikil', 9),
('Dinesh', 10),
('Nikil', 11);

insert into Loan values
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParliamentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);

select d.customername Customer, count(*) Accounts from Depositer d, BankAccount b where b.accno = d.accno GROUP BY d.customername
HAVING count(*)>1;

select branchname "Branch", assets/100000 "assets in lakhs" from Branch;

create view LoanView AS
select loannumber "No.", branchname "Branch", amount "Amount" from Loan;

select * from LoanView;

select DISTINCT d.customername from BankAccount ac, Depositer d
where d.accno = ac.accno and ac.branchname IN (select b.branchname from Branch b where b.branchcity = 'Delhi');

update BankAccount set balance = balance * 1.05;
select * from BankAccount;