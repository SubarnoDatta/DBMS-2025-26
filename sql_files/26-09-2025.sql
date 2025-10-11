use mysql;

create user 'SubarnoDatta' identified by 'password';
grant all privileges on *.* to 'SubarnoDatta';
flush privileges;

create database Insurance_SubarnoDatta;

use Insurance_SubarnoDatta;

create table Person (
	driver_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(20),
    address VARCHAR(30)
);

CREATE TABLE Car (
	reg_num VARCHAR(30) PRIMARY KEY,
    model VARCHAR(30),
    year int
);

create table Accident (
	report_num int PRIMARY KEY,
    accident_date date,
    location VARCHAR(20)
);

create table Owns (
	driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY(driver_id, reg_num),
    FOREIGN KEY(driver_id) REFERENCES Person(driver_id),
    FOREIGN KEY(reg_num) REFERENCES Car(reg_num)
);

CREATE TABLE Participated (
driver_id VARCHAR(10),
reg_num VARCHAR(10),
report_num INT,
damage_amount INT,
PRIMARY KEY(driver_id, reg_num, report_num),
FOREIGN KEY(driver_id) REFERENCES person(driver_id),
FOREIGN KEY(reg_num) REFERENCES car(reg_num),
FOREIGN KEY(report_num) REFERENCES accident(report_num)
);