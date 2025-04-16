-- finish building the contact management database for MarketCo 

create database management ;

use management ;


create table Company (
company_id int primary key,
company_name varchar(45),
street varchar(45),
city varchar(45),
state varchar(2),
zip varchar(10)
);




-- statement to create the Contact table

create table Contact (
contact_id int primary key,
company_id int,
first_name varchar(45),
last_name varchar(45),
street varchar(45),
city varchar(45),
state varchar(2),
zip varchar(10),
isMain boolean,
Email varchar(45),
Phone varchar(10),
CONSTRAINT email_check CHECK (email LIKE '%@%.%'),
CONSTRAINT phone_check CHECK (phone REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'),
foreign key (company_id) references Company(company_id)
);

-- Statement to create the ContactEmployee table 

create table ContactEmployee (
ContactEmployee_id int ,
contact_id int,
Employe_id int,
contact_date date,
description varchar(100),
foreign key (contact_id) references Contact(contact_id),
foreign key (Employe_id) references Employee(Employe_id)
);

-- Statement to create the Employee table

create table Employee(
Employe_id int primary key,
first_name varchar(45),
last_name varchar(45),
salary decimal(10,2),
hiredate date,
jobtitel varchar(25),
Email varchar(45),
Phone varchar(10),
constraint phone check (Phone = '^\d{3}-\d{3}-\d{4}$'),
CONSTRAINT email CHECK (email = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
);


-- In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800 
SET SQL_SAFE_UPDATES = 0;

update employee SET 
Phone = 215-555-8800 
where first_name = 'Lesley' and last_name = 'Bland' ;

-- In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” . 

update company set 
company_name =  " Urban Outfitters, Inc. " 
where company_name = ' Urban Outfitters ' ;

-- In ContactEmployee table, the statement that removes Dianne Connor’s contact  event with Jack Lee (one statement). 
-- HINT: Use the primary key of the ContactEmployee table to specify the correct record to remove.

DELETE ce
FROM ContactEmployee ce
JOIN Employee e1 ON ce.employe_id = e1.employe_id
JOIN Employee e2 ON ce.employe_id = e2.employe_id
WHERE e1.first_name = 'Dianne' AND e1.last_name = 'Connor'
  AND e2.first_name = 'Jack' AND e2.last_name = 'Lee';

-- Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement). Run the SQL SELECT query in
-- MySQL Workbench. Copy the results below as well.

SELECT e.first_name, e.last_name
FROM Employee e
JOIN contactemployee ce ON e.employe_id = ce.employe_id
join contact c ON c.contact_id = ce.contact_id
WHERE ce.company_name = 'Toll Brothers'
   OR ce.contact_with = 'Toll Brothers';
