create database customerdb;
use customerdb;

create table country(
	id int primary key auto_increment,
    country_name varchar(100),
    country_name_eng varchar(100),
    country_code varchar(3)
    );

insert into country (country_name,country_name_eng,country_code) values 
('Deutschland', 'Germany', 'DEU'),
('Srbija','Serbia','SRB'),
('Hrvatska','Croatia','HRV'),
('United States of America','United States of America','USA'),
('Ploska','Poland','POL'),
('Espana','Spain','ESP'),
('Rossiya','Russia','RUS');

select * from country;
drop table city;
create table city(
	id int primary key auto_increment,
    city_name varchar(50), 
    lat decimal(8,6),
    `long` double,
    country_id int,
    FOREIGN KEY(country_id) REFERENCES country(id));
    
insert into city (city_name,lat,`long`,country_id) values
('Berlin',52.520008,13.404954,1),
('Belgrade',44.787197,20.457272,2),
('Zagreb',45.815399,15.966568,3),
('New York',40.730610,-73.935242,4),
('Los Angeles',34.052235,-118.243683,4),
('Warsaw',52.237049,21.017532,5);

select * from city;

create table customer(
	id int primary key auto_increment,
    customer_name varchar(20),
    city_id int,
    customer_address varchar(100),
    next_call_date date,
    ts_inserted datetime,
    foreign key(city_id) references city(id));

insert into customer(customer_name,city_id,customer_address,next_call_date,ts_inserted)values 
('Jewelry store',4, 'Long Street 120','2020-01-21','2020-01-09 14:01:20.000'),
('Bakery', 1, 'Kurfurstendamm 25', '2020-02-21','2020-01-09 17:52:15.000'),
('Cafe',1,'Tauentzienstrabe 44', '2020-01-21','2020-01-10 08:02:49.000'),
('Restaurant',3,'Ulica lipa 15','2020-01-21','2020-01-10 09:20:21.000');

select* from country;

-- Task : 1 (join multiple tables using left join)
-- 1.List all Countries and customers related to these countries.
-- For each country displaying its name in English, the name of the city customer is located in as well as the name of the customer.
-- Return even countries without related cities and customers.

SELECT country.country_name_eng, city.city_name, customer.customer_name
FROM customer
LEFT JOIN city ON customer.city_id = city.id
LEFT JOIN country ON city.country_id = country.id;

-- Task : 2 (join multiple tables using both left and inner join)
-- Return the list of all countries that have pairs(exclude countries which are not referenced by any city). For such pairs return all customers.
-- Return even pairs of not having a single customer.

SELECT country.country_name_eng, city.city_name, customer.customer_name
FROM country
INNER JOIN city ON city.country_id = country.id
LEFT JOIN customer ON customer.city_id = city.id;