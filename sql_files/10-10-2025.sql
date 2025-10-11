use Insurance_SubarnoDatta;

insert into person values
('A01', 'Richard', 'Srinivas Nagar'),
('A02', 'Pradeep', 'Rajaji nagar'),
('A03', 'Smith', 'Ashok nagar'),
('A04', 'Venu', 'N R Colony'),
('A05', 'Jhon', 'Hanumanth nagar');

insert into car values
('KA052250', 'Indica', 1990),
('KA031181', 'Lancer', 1957),
('KA095477', 'Toyota', 1998),
('KA053408', 'Honda', 2008),
('KA041702', 'Audi', 2005);

insert into owns values
('A01', 'KA052250'),
('A02', 'KA053408'),
('A03', 'KA031181'),
('A04', 'KA095477'),
('A05', 'KA041702');

INSERT INTO accident values
(11, '2003-01-01', 'Mysore Road'),
(12, '2004-04-04', 'South End Circle'),
(13, '2003-01-21', 'Bull Temple Road'),
(14, '2008-02-17', 'Mysore Road'),
(15, '2004-03-04', 'Kanakpura Road');

insert into participated values
('A01', 'KA052250', 11, 10000),
('A02', 'KA053408', 12, 50000),
('A03', 'KA095477', 13, 25000),
('A04', 'KA031181', 14, 3000),
('A05', 'KA041702', 15, 5000);

update Person set name='John' where driver_id = 'A05';

-- query 1: show all accidents (date and location)

select report_num "No.", accident_date "Date", location from Accident;

-- query 2:

select p.name "Name", d.damage_amount "Damages" from Person p, Participated d where (d.driver_id = p.driver_id) and (d.damage_amount >= 25000);

-- query 3

select p.name "Name", c.model "Car" from Person p, Car c, Owns o where (p.driver_id = o.driver_id) and (o.reg_num = c.reg_num);

-- query 4

select p.name "Name", a.accident_date "Date", a.location "Location", d.damage_amount "Damages" from Person p, Accident a, Participated d where (p.driver_id = d.driver_id) and (d.report_num = a.report_num);

-- query 6

select name from Person p, Owns o where (select count(reg_num) from Participated d where d.reg_num = o.reg_num and o.driver_id = p.driver_id) > 1;

select c.model from Car c where NOT EXISTS (select 1 from Participated p where p.reg_num = c.reg_num);

select * from Accident ORDER BY accident_date DESC limit 1;

select p.name, avg(d.damage_amount) "Average Damage" from Person p, Participated d where p.driver_id = d.driver_id group by d.driver_id;

update Participated p, Car c set p.damage_amount = 25000 where p.reg_num = c.reg_num and c.model = 'Audi';
select * from Participated;

select p.name, (d.damage_amount) "Damage" from Person p, Participated d where p.driver_id = d.driver_id order by d.damage_amount DESC limit 1;

select c.model, SUM(p.damage_amount) "Damage" from Car c, Participated p where p.reg_num = c.reg_num GROUP by p.reg_num;

create view ReportDamages AS
select count(*) "Total Accidents", sum(damage_amount) "Total Damage" from Participated;

SELECT * FROM ReportDamages;